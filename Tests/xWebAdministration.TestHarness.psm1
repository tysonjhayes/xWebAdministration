function Invoke-xWebAdministrationTest
{
    param
    (
        [Parameter(Mandatory = $false)]
        [System.String] $TestResultsFile,
        
        [Parameter(Mandatory = $false)]
        [System.String] $DscTestsPath
    )

    Write-Verbose 'Commencing xWebAdministration unit tests'

    $repoDir = Join-Path $PSScriptRoot '..' -Resolve

    $testCoverageFiles = @()
    Get-ChildItem "$repoDir\DSCResources\**\*.psm1" -Recurse | ForEach-Object { 
        if ($_.FullName -notlike '*\DSCResource.Tests\*') {
            $testCoverageFiles += $_.FullName    
        }
    }

    $testResultSettings = @{ }
    if ([String]::IsNullOrEmpty($TestResultsFile) -eq $false) {
        $testResultSettings.Add('OutputFormat', 'NUnitXml' )
        $testResultSettings.Add('OutputFile', $TestResultsFile)
    }
    
    Import-Module "$repoDir\xWebAdministration.psd1"

    # Helper tests

    $unitTests = (Get-ChildItem (Join-Path $repoDir '\Tests\Helper\')).Name
    
    $testsToRun = @()
    $unitTests | ForEach-Object {
        $testsToRun += @(@{
                'Path' = "$repoDir\Tests\Helper\$_"
        })
    }

    # Run Unit Tests
    $unitTests = (Get-ChildItem (Join-Path $repoDir '\Tests\Unit\')).Name
    
    $testsToRun = @()
    $unitTests | ForEach-Object {
        $testsToRun += @(@{
                'Path' = "$repoDir\Tests\Unit\$_"
        })
    }
    
    # Integration Tests
    $integrationTests = (Get-ChildItem (Join-Path $repoDir '\Tests\Integration\')).Name
    
    $testsToRun = @()
    $integrationTests | ForEach-Object {
        $testsToRun += @(@{
                'Path' = "$repoDir\Tests\Integration\$_"
        })
    }

    # DSC Common Tests
    if ($PSBoundParameters.ContainsKey('DscTestsPath') -eq $true) {
        $testsToRun += @{
            'Path' = $DscTestsPath
        }
    }

    $results = Invoke-Pester -Script $testsToRun `
        -CodeCoverage $testCoverageFiles `
        -PassThru @testResultSettings

    return $results

}

function Invoke-xWebAdministrationUnitTest
{
    param
    (
        [Parameter(Mandatory = $false)]
        [System.String] $TestResultsFile,
        
        [Parameter(Mandatory = $false)]
        [System.String] $DscTestsPath
    )

    Write-Verbose 'Commencing xWebAdministration unit tests'

    $repoDir = Join-Path $PSScriptRoot '..' -Resolve

    $testCoverageFiles = @()
    Get-ChildItem "$repoDir\DSCResources\**\*.psm1" -Recurse | ForEach-Object { 
        if ($_.FullName -notlike '*\DSCResource.Tests\*') {
            $testCoverageFiles += $_.FullName    
        }
    }

    $testResultSettings = @{ }
    if ([String]::IsNullOrEmpty($TestResultsFile) -eq $false) {
        $testResultSettings.Add('OutputFormat', 'NUnitXml' )
        $testResultSettings.Add('OutputFile', $TestResultsFile)
    }
    
    Import-Module "$repoDir\xWebAdministration.psd1"
    
    $versionsToTest = (Get-ChildItem (Join-Path $repoDir '\Tests\Unit\')).Name
    
    $testsToRun = @()
    $versionsToTest | ForEach-Object {
        $testsToRun += @(@{
                'Path' = "$repoDir\Tests\Unit\$_"
        })
    }
    
    if ($PSBoundParameters.ContainsKey('DscTestsPath') -eq $true) {
        $testsToRun += @{
            'Path' = $DscTestsPath
        }
    }

    $results = Invoke-Pester -Script $testsToRun -CodeCoverage $testCoverageFiles -PassThru @testResultSettings

    return $results

}

function Invoke-xWebAdministrationIntegrationTest
{
    param
    (
        [Parameter(Mandatory = $false)]
        [System.String] $TestResultsFile,
        
        [Parameter(Mandatory = $false)]
        [System.String] $DscTestsPath
    )

    Write-Verbose 'Commencing xWebAdministration unit tests'

    $repoDir = Join-Path $PSScriptRoot '..' -Resolve

    $testCoverageFiles = @()
    Get-ChildItem "$repoDir\DSCResources\**\*.psm1" -Recurse | ForEach-Object { 
        if ($_.FullName -notlike '*\DSCResource.Tests\*') {
            $testCoverageFiles += $_.FullName    
        }
    }

    $testResultSettings = @{ }
    if ([String]::IsNullOrEmpty($TestResultsFile) -eq $false) {
        $testResultSettings.Add('OutputFormat', 'NUnitXml' )
        $testResultSettings.Add('OutputFile', $TestResultsFile)
    }
    
    Import-Module "$repoDir\xWebAdministration.psd1"
    
    $versionsToTest = (Get-ChildItem (Join-Path $repoDir '\Tests\Integration\')).Name
    
    $testsToRun = @()
    $versionsToTest | ForEach-Object {
        $testsToRun += @(@{
                'Path' = "$repoDir\Tests\Integration\$_"
        })
    }
    
    if ($PSBoundParameters.ContainsKey('DscTestsPath') -eq $true) {
        $testsToRun += @{
            'Path' = $DscTestsPath
        }
    }

    $results = Invoke-Pester -Script $testsToRun -CodeCoverage $testCoverageFiles -PassThru @testResultSettings

    return $results

}
