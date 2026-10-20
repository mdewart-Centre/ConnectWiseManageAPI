---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Add-CWMCompanyServiceTemplateLink

## SYNOPSIS
Links a company service template.

## DESCRIPTION
Invokes the ConnectWise Manage link action for the specified company service template. The endpoint does not define a request body.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-CWMCompanyServiceTemplateLink -companyId 123 -templateId 456
```

Links template 456 for company 123.

## PARAMETERS

### -parentId, -id
Company and template IDs. Aliases: `companyId` and `templateId`.
