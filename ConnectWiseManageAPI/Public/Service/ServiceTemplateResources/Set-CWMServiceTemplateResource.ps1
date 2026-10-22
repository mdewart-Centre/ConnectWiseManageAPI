function Set-CWMServiceTemplateResource {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('resourceId')]
        [int]$id,
        [hashtable]$serviceTemplate,
        [hashtable]$member,
        [string]$startDateTime,
        [string]$endDateTime,
        [double]$hours,
        [hashtable]$scheduleStatus,
        [hashtable]$location,
        [bool]$reminderFlag,
        [int]$reminderMinutes,
        [bool]$isTicketOwner,
        [hashtable]$timeZone,
        [int]$endAfter,
        [hashtable]$recurrence,
        [hashtable]$_info
    )

    $Endpoint = "/service/templates/$($parentId)/resources/$($id)"
    Invoke-CWMSetMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}
