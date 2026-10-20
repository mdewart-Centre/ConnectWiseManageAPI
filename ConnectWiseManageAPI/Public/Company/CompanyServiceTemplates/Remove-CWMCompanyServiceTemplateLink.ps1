function Remove-CWMCompanyServiceTemplateLink {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)/unlink"
    Invoke-CWMActionMaster -Endpoint $Endpoint
}
