---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Set-CWMServiceTemplateResource

## SYNOPSIS
Replaces a service template resource assignment.

## SYNTAX

```powershell
Set-CWMServiceTemplateResource -parentId <Int32> -id <Int32> [-serviceTemplate <Hashtable>]
 [-member <Hashtable>] [-startDateTime <String>] [-endDateTime <String>] [-hours <Double>]
 [-scheduleStatus <Hashtable>] [-location <Hashtable>] [-reminderFlag <Boolean>]
 [-reminderMinutes <Int32>] [-isTicketOwner <Boolean>] [-timeZone <Hashtable>] [-endAfter <Int32>]
 [-recurrence <Hashtable>] [-_info <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sends a `ServiceTemplateResource` representation using PUT `/service/templates/{parentId}/resources/{id}`. Use Update-CWMServiceTemplateResource for targeted property changes instead of submitting a replacement representation. The schema declares no mandatory body properties; the API may impose additional runtime requirements.

## EXAMPLES

### Example 1
```powershell
Set-CWMServiceTemplateResource -templateId 123 -resourceId 456 -member @{ id = 15 } -hours 2 -isTicketOwner $true
```

Submits a replacement for assignment 456 with member 15. Include any other assignment settings that must be retained.

## PARAMETERS

### -parentId
Required template ID used in the URL. Alias: `templateId`.

### -id
Required assignment ID, not the member ID. Alias: `resourceId`.

### -serviceTemplate
Service template reference supplied as a hashtable.

### -member
Member reference supplied as a hashtable, such as `@{ id = 15 }`.

### -startDateTime
Start date/time in ISO 8601 format.

### -endDateTime
End date/time in ISO 8601 format.

### -hours
Hours allocated to the assignment.

### -scheduleStatus
Schedule status reference supplied as a hashtable.

### -location
Service location reference supplied as a hashtable.

### -reminderFlag
Whether reminders are enabled.

### -reminderMinutes
Reminder interval in minutes.

### -isTicketOwner
Whether the assigned member is the ticket owner.

### -timeZone
Time zone reference supplied as a hashtable.

### -endAfter
Value of the API's `endAfter` recurrence setting.

### -recurrence
Service template recurrence reference supplied as a hashtable.

### -_info
Additional API metadata supplied as a hashtable.

### -WhatIf
Shows the request without sending it.

### -Confirm
Prompts before sending the request.

## NOTES
Route `parentId` and `id` parameters are omitted from the JSON payload. The schema's corresponding body fields are not exposed separately.
