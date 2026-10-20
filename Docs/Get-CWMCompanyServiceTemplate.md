---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMCompanyServiceTemplate

## SYNOPSIS
Gets company service templates.

## DESCRIPTION
Lists service templates for a company, retrieves one template by ID, or returns the matching count. Supports the collection filters and paging parameters accepted by the ConnectWise Manage API.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-CWMCompanyServiceTemplate -companyId 123
```

Lists service templates for company 123.

### EXAMPLE 2
```powershell
Get-CWMCompanyServiceTemplate -parentId 123 -templateId 456
```

Gets template 456 for company 123.

## PARAMETERS

### -parentId
The company ID. Alias: `companyId`.

### -id
Optional template ID. Alias: `templateId`.

### -count
Returns the count for the supplied filters.

### -condition, -orderBy, -childConditions, -customFieldConditions
Collection filtering and ordering parameters.

### -page, -pageSize, -pageId, -fields, -all
Paging, field selection, and all-results parameters.
