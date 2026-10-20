function Add-CWMCompanyServiceTemplateLink {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)/link"
    Invoke-CWMActionMaster -Endpoint $Endpoint
}
