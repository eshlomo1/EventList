﻿function Get-BaselineNameFromDB {

<#
    .SYNOPSIS
    Gets all the names of the baselines, stored in the database.

    .DESCRIPTION
    Gets all the names of the baselines, stored in the database.

    .PARAMETER BaselineName
    Prompts you for the Baseline Name that should be checked against the database.

    .EXAMPLE
    Get-BaselineNameFromDB

    Gets all the names of the baselines, stored in the database.

#>

	[CmdletBinding()]
	param (
        [string]$BaselineName
    )

    if ($BaselineName){
        $tmpStr = " where name = '" + (ConvertTo-PSSQLStringArray($BaselineName)) + "'"
    }

    $query = "select name from baseline_main" + $tmpStr + ";"

    $baselineNames = Invoke-SqliteQuery -Query $query -DataSource $database | Select-Object -ExpandProperty name

    if ($baselineNames) {
        $baselineNames = ConvertFrom-PSSQLStringArray -Text $baselineNames
    }
    
    return $baselineNames
}