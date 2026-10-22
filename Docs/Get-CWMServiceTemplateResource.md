---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMServiceTemplateResource

## SYNOPSIS
Gets resource assignments for a service template.

## SYNTAX

```powershell
Get-CWMServiceTemplateResource -parentId <Int32> [-id <Int32>] [-count] [-condition <String>]
 [-orderBy <String>] [-childConditions <String>] [-customFieldConditions <String>] [-page <Int32>]
 [-pageSize <Int32>] [-fields <String[]>] [-pageId <Int32>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Lists assignments under `/service/templates/{parentId}/resources`, retrieves an assignment by resource ID, or returns the matching count. A resource ID identifies an assignment, not the assigned member.

## EXAMPLES

### Example 1
```powershell
Get-CWMServiceTemplateResource -templateId 123 -condition 'member/id=12'
```

Finds assignments for member 12 on template 123.

### Example 2
```powershell
Get-CWMServiceTemplateResource -templateId 123 -resourceId 456
Get-CWMServiceTemplateResource -templateId 123 -count
```

Retrieves assignment 456 and counts assignments for template 123.

## PARAMETERS

### -parentId
Required service template ID. Alias: `templateId`.

### -id
Optional resource-assignment ID. Alias: `resourceId`.

### -count
Returns the count of matching assignments instead of assignment objects.

### -condition
API conditions used to filter assignments.

### -orderBy
Field and direction used to order results, such as `id asc`.

### -childConditions
API conditions used to filter child collections.

### -customFieldConditions
API conditions used to filter custom fields.

### -page
Page number to retrieve.

### -pageSize
Number of results per page.

### -fields
Fields to include in the response.

### -pageId
Forward-only pagination cursor passed to the API.

### -all
Retrieves all pages using server-provided pagination links.

## NOTES
Use a service template ID accepted by the `/service/templates` API. Compatibility with IDs returned by company-scoped template operations has not been verified against a live instance.
