BeforeAll {
    $ModulePath = Join-Path $PSScriptRoot '..\ConnectWiseManageAPI\ConnectWiseManageAPI.psm1'
    Import-Module $ModulePath -Force
}

Describe 'Service template resource requests' {
    BeforeAll {
        Mock New-CWMUrl { "https://manage.test$Endpoint$URLParameters" } -ModuleName ConnectWiseManageAPI
        Mock Invoke-CWMWebRequest {
            [pscustomobject]@{ content = (ConvertTo-Json -InputObject $Arguments -Depth 100) }
        } -ModuleName ConnectWiseManageAPI
    }

    It 'assigns a member with POST and excludes route parameters from JSON' {
        $Request = New-CWMServiceTemplateResource -templateId 123 -member @{ id = 12 } -reminderFlag $false -hours 0
        $Body = $Request.Body | ConvertFrom-Json

        $Request.Uri | Should -Be 'https://manage.test/service/templates/123/resources'
        $Request.Method | Should -Be 'Post'
        $Body.member.id | Should -Be 12
        $Body.reminderFlag | Should -BeFalse
        $Body.hours | Should -Be 0
        $Body.PSObject.Properties.Name | Should -Not -Contain 'parentId'
    }

    It 'lists resources with encoded filters and paging' {
        $Request = Get-CWMServiceTemplateResource -templateId 123 -condition 'member/id=12' -fields @('id', 'member') -page 2 -pageSize 10 -pageId 789

        $Request.Method | Should -Be 'GET'
        $Request.Uri | Should -Match '/service/templates/123/resources&conditions=member%2fid%3d12'
        $Request.Uri | Should -Match 'fields=id%2cmember'
        $Request.Uri | Should -Match 'pageId=789'
        $Request.Uri | Should -Match 'pageSize=10'
        $Request.Uri | Should -Match 'page=2'
    }

    It 'gets an assignment using its resource ID rather than its member ID' {
        $Request = Get-CWMServiceTemplateResource -templateId 123 -resourceId 456

        $Request.Uri | Should -Be 'https://manage.test/service/templates/123/resources/456'
    }

    It 'returns the resource count' {
        Mock Invoke-CWMWebRequest { [pscustomobject]@{ content = '{"count":3}' } } -ModuleName ConnectWiseManageAPI -ParameterFilter {
            $Arguments.Uri -eq 'https://manage.test/service/templates/123/resources/count'
        }

        Get-CWMServiceTemplateResource -templateId 123 -count | Should -Be 3
        Should -Invoke Invoke-CWMWebRequest -ModuleName ConnectWiseManageAPI -Exactly 1 -ParameterFilter {
            $Arguments.Uri -eq 'https://manage.test/service/templates/123/resources/count'
        }
    }

    It 'delegates all-results requests with their pageId' {
        Mock Invoke-CWMAllResult { $Arguments.Uri } -ModuleName ConnectWiseManageAPI

        Get-CWMServiceTemplateResource -templateId 123 -all -pageId 789 | Should -Be 'https://manage.test/service/templates/123/resources&pageId=789'
        Should -Invoke Invoke-CWMAllResult -ModuleName ConnectWiseManageAPI -Exactly 1
    }

    It 'replaces an assignment with PUT and excludes both route IDs' {
        $Request = Set-CWMServiceTemplateResource -templateId 123 -resourceId 456 -member @{ id = 12 } -isTicketOwner $true -hours 1.5
        $Body = $Request.Body | ConvertFrom-Json

        $Request.Uri | Should -Be 'https://manage.test/service/templates/123/resources/456'
        $Request.Method | Should -Be 'Put'
        $Body.member.id | Should -Be 12
        $Body.isTicketOwner | Should -BeTrue
        $Body.hours | Should -Be 1.5
        $Body.PSObject.Properties.Name | Should -Not -Contain 'parentId'
        $Body.PSObject.Properties.Name | Should -Not -Contain 'id'
    }

    It 'sends multiple patch operations in an array' {
        $Request = Update-CWMServiceTemplateResource -templateId 123 -resourceId 456 -PatchOperations @(
            @{ op = 'replace'; path = '/member'; value = @{ id = 15 } }
            @{ op = 'replace'; path = '/hours'; value = 2 }
        )
        $Body = $Request.Body | ConvertFrom-Json

        $Request.Uri | Should -Be 'https://manage.test/service/templates/123/resources/456'
        $Request.Method | Should -Be 'Patch'
        $Body | Should -HaveCount 2
        $Body[0].value.id | Should -Be 15
        $Body[1].value | Should -Be 2
    }

    It 'keeps a single patch operation wrapped in an array' {
        $Request = Update-CWMServiceTemplateResource -templateId 123 -resourceId 456 -PatchOperations @(
            @{ op = 'replace'; path = '/hours'; value = 2 }
        )

        $Request.Body.TrimStart().StartsWith('[') | Should -BeTrue
    }

    It 'does not send write requests under WhatIf' {
        New-CWMServiceTemplateResource -templateId 123 -member @{ id = 12 } -WhatIf
        Set-CWMServiceTemplateResource -templateId 123 -resourceId 456 -member @{ id = 12 } -WhatIf
        Update-CWMServiceTemplateResource -templateId 123 -resourceId 456 -PatchOperations @(
            @{ op = 'replace'; path = '/hours'; value = 2 }
        ) -WhatIf

        Should -Invoke Invoke-CWMWebRequest -ModuleName ConnectWiseManageAPI -Exactly 0
    }
}

Describe 'Service template resource exports' {
    It 'exports all four commands through the loader and manifest' {
        $ManifestPath = Join-Path $PSScriptRoot '..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1'
        $Manifest = Test-ModuleManifest -Path $ManifestPath

        foreach ($CommandName in @('Get-CWMServiceTemplateResource', 'New-CWMServiceTemplateResource', 'Set-CWMServiceTemplateResource', 'Update-CWMServiceTemplateResource')) {
            Get-Command -name $CommandName -Module ConnectWiseManageAPI | Should -Not -BeNullOrEmpty
            $Manifest.ExportedFunctions.Keys | Should -Contain $CommandName
        }
    }
}
