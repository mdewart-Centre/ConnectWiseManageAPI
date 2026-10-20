---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMCompanyServiceTemplate

## SYNOPSIS
Applies patch operations to a company service template.

## DESCRIPTION
Sends an array of ConnectWise Manage patch operations to a company service template.

## EXAMPLES

### EXAMPLE 1
```powershell
Update-CWMCompanyServiceTemplate -companyId 123 -templateId 456 -PatchOperations @(@{ op = 'replace'; path = '/summary'; value = 'Updated onboarding' })
```

Replaces the template summary.

## PARAMETERS

### -parentId, -id
Company and template IDs. Aliases: `companyId` and `templateId`.

### -PatchOperations
Required array of patch operation hashtables with `op`, `path`, and `value` properties.
