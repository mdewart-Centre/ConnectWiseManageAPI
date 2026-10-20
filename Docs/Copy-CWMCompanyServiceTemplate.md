---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Copy-CWMCompanyServiceTemplate

## SYNOPSIS
Copies a company service template.

## DESCRIPTION
Invokes the ConnectWise Manage copy action for the specified company service template.

## EXAMPLES

### EXAMPLE 1
```powershell
Copy-CWMCompanyServiceTemplate -companyId 123 -templateId 456
```

Copies template 456 for company 123.

## PARAMETERS

### -parentId, -id
Company and template IDs. Aliases: `companyId` and `templateId`.
