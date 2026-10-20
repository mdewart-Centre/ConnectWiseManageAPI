function Invoke-CWMActionMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]$Endpoint
    )

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri    = $URI
        Method = 'Post'
    }

    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, 'Invoke-CWMActionMaster')) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result
}
