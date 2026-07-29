# ABC Fixed Bid Program — Power BI Build Pack
Generated for automated dataset creation and Power Automate workflow.

## Contents
1. data/ - Clean CSV datasets (Fact_Project, Fact_MonthlyTrend, Fact_MonthlyByGroup, Fact_BusinessUnit, Fact_AssessmentKPI, Dim_Census, Dim_MarginBasis)
2. PowerQuery_M_Queries.pq - Power Query scripts ready for Power BI Advanced Editor
3. DAX_Measure_Library.dax - Complete DAX calculated tables, columns, and 80+ measures
4. ABC_FixedBid_Program_Theme.json - Custom Power BI color theme
5. automation/ - PowerShell, Python & Power Automate flow JSON definitions to trigger automatic refresh on CSV updates.

## Quick Start
1. Place CSV files from data/ into a local folder or OneDrive / SharePoint folder.
2. In Power BI Desktop: Home -> Get Data -> Blank Query -> Advanced Editor -> Paste the M query.
3. Apply DAX measures from DAX_Measure_Library.dax.
4. Import ABC_FixedBid_Program_Theme.json via View -> Themes -> Browse for themes.
5. Set up Power Automate or python/powershell scripts in automation/ for automated refresh!
