---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Set-CWMCompanyServiceTemplate

## SYNOPSIS
Replaces a company service template.

## DESCRIPTION
Replaces a service template using the OpenAPI `ServiceTemplate` request schema. `name`, `board`, `status`, and `summary` are required. Reference properties are supplied as hashtables.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-CWMCompanyServiceTemplate -companyId 123 -templateId 456 -name 'Onboarding' -board @{ id = 1 } -status @{ id = 2 } -summary 'Updated onboarding'
```

Replaces template 456 for company 123.

## PARAMETERS

### -parentId, -id
Company and template IDs. Aliases: `companyId` and `templateId`.

### -name, -board, -status, -summary
Required properties from the `ServiceTemplate` request schema.

### Other schema properties
Optional properties follow the OpenAPI `ServiceTemplate` request schema, including service references, billing settings, estimates, and email flags.
