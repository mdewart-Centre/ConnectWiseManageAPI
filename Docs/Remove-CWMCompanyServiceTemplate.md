---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMCompanyServiceTemplate

## SYNOPSIS
Deletes a company service template.

## DESCRIPTION
Deletes the specified service template from a company.

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-CWMCompanyServiceTemplate -companyId 123 -templateId 456
```

Deletes template 456 for company 123.

## PARAMETERS

### -parentId, -id
Company and template IDs. Aliases: `companyId` and `templateId`.
