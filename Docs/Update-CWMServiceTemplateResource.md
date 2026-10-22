---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMServiceTemplateResource

## SYNOPSIS
Applies patch operations to a service template resource assignment.

## SYNTAX

```powershell
Update-CWMServiceTemplateResource -parentId <Int32> -id <Int32> -PatchOperations <Hashtable[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sends an array of patch operations to `/service/templates/{parentId}/resources/{id}` using PATCH. This updates selected assignment properties rather than submitting a replacement representation.

## EXAMPLES

### Example 1
```powershell
Update-CWMServiceTemplateResource -templateId 123 -resourceId 456 -PatchOperations @(
    @{ op = 'replace'; path = '/member'; value = @{ id = 15 } }
    @{ op = 'replace'; path = '/hours'; value = 2 }
)
```

Changes the assigned member and hours on assignment 456.

## PARAMETERS

### -parentId
Required template ID. Alias: `templateId`.

### -id
Required assignment ID, not the member ID. Alias: `resourceId`.

### -PatchOperations
Required nonempty array of patch-operation hashtables with the API's `op`, `path`, and applicable `value` fields.

### -WhatIf
Shows the request without sending it.

### -Confirm
Prompts before sending the request.
