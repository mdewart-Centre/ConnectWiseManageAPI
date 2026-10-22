function Update-CWMServiceTemplateResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('resourceId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable[]]$PatchOperations
    )

    $Endpoint = "/service/templates/$($parentId)/resources/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}
