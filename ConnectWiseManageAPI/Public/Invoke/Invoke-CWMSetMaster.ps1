function Invoke-CWMSetMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint
    )

    $Skip = @('Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable', 'WhatIf', 'Confirm', 'Version', 'VersionAutomatic', 'grandparentId', 'parentId', 'id')
    $Body = @{}

    foreach ($Item in $Arguments.GetEnumerator()) {
        if ($Skip -notcontains $Item.Key) {
            $Body.Add($Item.Key, $Item.Value)
        }
    }

    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Put'
        ContentType = 'application/json'
        Body        = $Body
    }

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMSetMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result
}
