$ModuleName = 'ConnectWiseManageAPI'
$ModulePath = Join-Path $PSScriptRoot '..\ConnectWiseManageAPI\ConnectWiseManageAPI.psm1'
Import-Module $ModulePath -Force

Describe 'Get-CWMCompanyServiceTemplate' {
    InModuleScope $ModuleName {
        It 'routes the parent, item, and pageId to the GET master' {
            Mock Invoke-CWMGetMaster {
                [pscustomobject]@{
                    Arguments = $Arguments
                    Endpoint  = $Endpoint
                }
            }

            $Result = Get-CWMCompanyServiceTemplate -parentId 123 -templateId 456 -pageId 789

            $Result.Endpoint | Should -Be '/company/companies/123/serviceTemplates'
            $Result.Arguments.id | Should -Be 456
            $Result.Arguments.pageId | Should -Be 789
        }

        It 'routes count requests with the supplied conditions' {
            Mock Invoke-CWMGetMaster { [pscustomobject]@{ Arguments = $Arguments; Endpoint = $Endpoint } }

            $Result = Get-CWMCompanyServiceTemplate -companyId 123 -count -condition "name contains 'Onboarding'"

            $Result.Endpoint | Should -Be '/company/companies/123/serviceTemplates'
            $Result.Arguments.count.IsPresent | Should -BeTrue
            $Result.Arguments.condition | Should -Be "name contains 'Onboarding'"
        }
    }
}

Describe 'Company service-template command routing' {
    InModuleScope $ModuleName {
        It 'routes create requests to the collection endpoint' {
            Mock Invoke-CWMNewMaster { [pscustomobject]@{ Arguments = $Arguments; Endpoint = $Endpoint } }

            $Result = New-CWMCompanyServiceTemplate -companyId 123 -Name 'Onboarding' -board @{ id = 1 } -status @{ id = 2 } -summary 'New customer onboarding'

            $Result.Endpoint | Should -Be '/company/companies/123/serviceTemplates'
            $Result.Arguments.parentId | Should -Be 123
            $Result.Arguments.name | Should -Be 'Onboarding'
        }

        It 'routes full replacements to the item endpoint' {
            Mock Invoke-CWMSetMaster { [pscustomobject]@{ Arguments = $Arguments; Endpoint = $Endpoint } }

            $Result = Set-CWMCompanyServiceTemplate -companyId 123 -templateId 456 -Name 'Onboarding' -board @{ id = 1 } -status @{ id = 2 } -summary 'Updated onboarding'

            $Result.Endpoint | Should -Be '/company/companies/123/serviceTemplates/456'
            $Result.Arguments.id | Should -Be 456
        }

        It 'routes patch arrays to the item endpoint' {
            Mock Invoke-CWMUpdateMaster { [pscustomobject]@{ Arguments = $Arguments; Endpoint = $Endpoint } }
            $PatchOperations = @(@{ op = 'replace'; path = '/summary'; value = 'Updated' })

            $Result = Update-CWMCompanyServiceTemplate -companyId 123 -templateId 456 -PatchOperations $PatchOperations

            $Result.Endpoint | Should -Be '/company/companies/123/serviceTemplates/456'
            $Result.Arguments.PatchOperations.Count | Should -Be 1
        }

        It 'passes the item ID and pageId into the GET request' {
            Mock New-CWMUrl {
                $script:CapturedEndpoint = $Endpoint
                "https://manage.test$Endpoint$URLParameters"
            }
            Mock Invoke-CWMWebRequest {
                $script:CapturedRequest = $Arguments
                [pscustomobject]@{ content = '[]' }
            }

            Invoke-CWMGetMaster -Endpoint '/company/companies/123/serviceTemplates' -Arguments @{
                id     = 456
                pageId = 789
            }

            $script:CapturedEndpoint | Should -Be '/company/companies/123/serviceTemplates/456'
            $script:CapturedRequest.Uri | Should -Match 'pageId=789'
        }

        It 'routes count requests to the count endpoint' {
            Mock New-CWMUrl {
                $script:CapturedEndpoint = $Endpoint
                "https://manage.test$Endpoint$URLParameters"
            }
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ content = '{"count":3}' } }

            $Count = Invoke-CWMGetMaster -Endpoint '/company/companies/123/serviceTemplates' -Arguments @{
                count = [switch]$true
            }

            $script:CapturedEndpoint | Should -Be '/company/companies/123/serviceTemplates/count'
            $Count | Should -Be 3
        }

        It 'routes deletes to the item endpoint' {
            Mock Invoke-CWMRemoveMaster { $Endpoint }

            Remove-CWMCompanyServiceTemplate -companyId 123 -templateId 456 | Should -Be '/company/companies/123/serviceTemplates/456'
        }

        It 'routes the copy action' {
            Mock Invoke-CWMActionMaster { $Endpoint }

            Copy-CWMCompanyServiceTemplate -companyId 123 -templateId 456 | Should -Be '/company/companies/123/serviceTemplates/456/copy'
        }

        It 'routes the generate action and excludes route IDs from its body' {
            Mock Invoke-CWMNewMaster { [pscustomobject]@{ Arguments = $Arguments; Endpoint = $Endpoint; Skip = $Skip } }

            $Result = Invoke-CWMCompanyServiceTemplateGenerate -companyId 123 -templateId 456 -generateAllRecordsFlag $true

            $Result.Endpoint | Should -Be '/company/companies/123/serviceTemplates/456/generate'
            $Result.Arguments.generateAllRecordsFlag | Should -Be $true
            $Result.Skip | Should -Contain 'id'
        }

        It 'routes link and unlink actions' {
            Mock Invoke-CWMActionMaster { $Endpoint }

            Add-CWMCompanyServiceTemplateLink -companyId 123 -templateId 456 | Should -Be '/company/companies/123/serviceTemplates/456/link'
            Remove-CWMCompanyServiceTemplateLink -companyId 123 -templateId 456 | Should -Be '/company/companies/123/serviceTemplates/456/unlink'
        }
    }
}

Describe 'Company service-template request helpers' {
    InModuleScope $ModuleName {
        It 'sends PUT JSON without parent or item route IDs' {
            Mock New-CWMUrl { $Endpoint }
            Mock Invoke-CWMWebRequest {
                $script:CapturedRequest = $Arguments
                [pscustomobject]@{ content = '{"id":456}' }
            }

            Invoke-CWMSetMaster -Endpoint '/company/companies/123/serviceTemplates/456' -Arguments @{
                parentId = 123
                id       = 456
                name     = 'Onboarding'
                board    = @{ id = 1 }
            }

            $script:CapturedRequest.Method | Should -Be 'Put'
            $Body = $script:CapturedRequest.Body | ConvertFrom-Json
            $Body.name | Should -Be 'Onboarding'
            $Body.PSObject.Properties.Name | Should -Not -Contain 'parentId'
            $Body.PSObject.Properties.Name | Should -Not -Contain 'id'
        }

        It 'sends create properties as POST JSON without the parent route ID' {
            Mock New-CWMUrl { $Endpoint }
            Mock Invoke-CWMWebRequest {
                $script:CapturedRequest = $Arguments
                [pscustomobject]@{ content = '{"id":456}' }
            }

            Invoke-CWMNewMaster -Endpoint '/company/companies/123/serviceTemplates' -Arguments @{
                parentId = 123
                name     = 'Onboarding'
                board    = @{ id = 1 }
                status   = @{ id = 2 }
                summary  = 'New customer onboarding'
            }

            $script:CapturedRequest.Method | Should -Be 'Post'
            $Body = $script:CapturedRequest.Body | ConvertFrom-Json
            $Body.name | Should -Be 'Onboarding'
            $Body.board.id | Should -Be 1
            $Body.PSObject.Properties.Name | Should -Not -Contain 'parentId'
        }

        It 'sends bodyless actions as POST without a body' {
            Mock New-CWMUrl { $Endpoint }
            Mock Invoke-CWMWebRequest {
                $script:CapturedRequest = $Arguments
                [pscustomobject]@{ content = '{"id":456}' }
            }

            Invoke-CWMActionMaster -Endpoint '/company/companies/123/serviceTemplates/456/copy'

            $script:CapturedRequest.Method | Should -Be 'Post'
            $script:CapturedRequest.ContainsKey('Body') | Should -BeFalse
        }

        It 'serializes patch-operation arrays' {
            Mock New-CWMUrl { $Endpoint }
            Mock Invoke-CWMWebRequest {
                $script:CapturedRequest = $Arguments
                [pscustomobject]@{ content = '{"id":456}' }
            }

            Invoke-CWMUpdateMaster -Endpoint '/company/companies/123/serviceTemplates/456' -Arguments @{
                PatchOperations = @(@{ op = 'replace'; path = '/summary'; value = 'Updated' })
            }

            $script:CapturedRequest.Method | Should -Be 'Patch'
            $Body = $script:CapturedRequest.Body | ConvertFrom-Json
            $Body.Count | Should -Be 1
            $Body[0].op | Should -Be 'replace'
            $Body[0].path | Should -Be '/summary'
        }
    }
}

Describe 'Company service-template exports' {
    It 'exports the public command family from the manifest' {
        $ManifestPath = Join-Path $PSScriptRoot '..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1'
        $Manifest = Test-ModuleManifest -Path $ManifestPath
        $CommandNames = @(
            'Get-CWMCompanyServiceTemplate',
            'New-CWMCompanyServiceTemplate',
            'Set-CWMCompanyServiceTemplate',
            'Update-CWMCompanyServiceTemplate',
            'Remove-CWMCompanyServiceTemplate',
            'Copy-CWMCompanyServiceTemplate',
            'Invoke-CWMCompanyServiceTemplateGenerate',
            'Add-CWMCompanyServiceTemplateLink',
            'Remove-CWMCompanyServiceTemplateLink'
        )

        foreach ($CommandName in $CommandNames) {
            Get-Command -name $CommandName -Module $ModuleName | Should -Not -BeNullOrEmpty
            $Manifest.ExportedFunctions.Keys | Should -Contain $CommandName
        }
    }
}
