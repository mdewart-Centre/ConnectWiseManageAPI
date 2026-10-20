---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMCompanyServiceTemplateGenerate

## SYNOPSIS
Generates services from a company service template.

## DESCRIPTION
Runs the template generate action. The optional `generateAllRecordsFlag` is sent in the OpenAPI `TemplateGenerate` request body.

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-CWMCompanyServiceTemplateGenerate -companyId 123 -templateId 456 -generateAllRecordsFlag $true
```

Generates services from template 456 for company 123.

## PARAMETERS

### -parentId, -id
Company and template IDs. Aliases: `companyId` and `templateId`.

### -generateAllRecordsFlag
Controls whether to generate all records.
