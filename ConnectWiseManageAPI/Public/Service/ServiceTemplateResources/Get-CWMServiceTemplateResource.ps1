function Get-CWMServiceTemplateResource {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$parentId,
        [Alias('resourceId')]
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [int]$pageId,
        [switch]$all
    )

    $Endpoint = "/service/templates/$($parentId)/resources"
    Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}
