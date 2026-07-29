# ============================================================================
# PowerShell Script: Auto-Trigger Power BI Dataset Refresh via REST API
# Prerequisite: Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser
# ============================================================================

param (
    [string]$WorkspaceId = "YOUR_WORKSPACE_GUID",
    [string]$DatasetId = "YOUR_DATASET_GUID"
)

# Connect to Power BI Service (Interactively or via Service Principal)
Connect-PowerBIServiceAccount

# Trigger Refresh Request via REST API
$Uri = "https://api.powerbi.com/v1.0/myorg/groups/$WorkspaceId/datasets/$DatasetId/refreshes"
$Response = Invoke-PowerBIRestMethod -Url $Uri -Method Post

Write-Host "Dataset refresh initiated successfully." -ForegroundColor Green
Write-Host "Response:" ($Response | ConvertTo-Json)
