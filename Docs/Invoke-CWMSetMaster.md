---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMSetMaster

## SYNOPSIS
Replaces a ConnectWise Manage resource with a PUT request.

## DESCRIPTION
Builds a JSON request body from the supplied arguments, excluding route IDs and common PowerShell parameters, and sends it using HTTP PUT. Supports `ShouldProcess`.

## PARAMETERS

### -Arguments
Bound resource properties used to build the JSON request body.

### -Endpoint
The API endpoint for the resource.
