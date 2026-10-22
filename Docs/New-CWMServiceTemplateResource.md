---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMServiceTemplateResource

## SYNOPSIS
Assigns a member to a service template.

## SYNTAX

```powershell
New-CWMServiceTemplateResource -parentId <Int32> [-serviceTemplate <Hashtable>] [-member <Hashtable>]
 [-startDateTime <String>] [-endDateTime <String>] [-hours <Double>] [-scheduleStatus <Hashtable>]
 [-location <Hashtable>] [-reminderFlag <Boolean>] [-reminderMinutes <Int32>] [-isTicketOwner <Boolean>]
 [-timeZone <Hashtable>] [-endAfter <Int32>] [-recurrence <Hashtable>] [-_info <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a resource assignment using POST `/service/templates/{parentId}/resources`. Payload fields follow the OpenAPI `ServiceTemplateResource` request schema, which declares no mandatory body properties. Supply `member` to assign a user; the API may impose additional runtime requirements.

## EXAMPLES

### Example 1
```powershell
New-CWMServiceTemplateResource -templateId 123 -member @{ id = 12 } -hours 1 -isTicketOwner $true
```

Assigns member 12 to template 123 with one hour and the ticket-owner flag.

## PARAMETERS

### -parentId
Required template ID used in the URL. Alias: `templateId`.

### -serviceTemplate
Service template reference supplied as a hashtable.

### -member
Member reference supplied as a hashtable, such as `@{ id = 12 }`.

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
The schema's body `id` and `parentId` fields are not exposed as payload properties. The `parentId` parameter selects the URL only. No DELETE operation is defined in this OpenAPI resource family, so no Remove command is provided. Compatibility with company-scoped template IDs requires live verification.
