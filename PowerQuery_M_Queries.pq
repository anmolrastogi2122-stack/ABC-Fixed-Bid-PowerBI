// ============================================================================
// ABC Fixed Bid Program — Power Query M Reference
// Reference copy of the M queries defined in ABC_Fixed_Bid_Portfolio.Dataset.
// Every table shares one text parameter, TargetFolder, that points at the
// folder holding the CSVs in /Data. Change it in Power BI Desktop's
// Transform Data > Manage Parameters once, and every query below follows.
// ============================================================================

// ---- Parameter --------------------------------------------------------------
// TargetFolder = "C:\PowerBI\ABC_FixedBid\Data"

// ---- Fact_Project ------------------------------------------------------------
let
    Source = Csv.Document(File.Contents(TargetFolder & "\Fact_Project.csv"),[Delimiter=",", Columns=21, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ProjectKey", type text}, {"WBS_ID", type text}, {"ProjectName", type text}, {"Status", type text}, {"RevenueGroup", type text}, {"MultiWBS", type text}, {"BusinessUnit", type text}, {"AllBUs", type text}, {"Account", type text}, {"CCS", type text}, {"PECO", type text}, {"Program_Onboarded", type text}, {"ProgramStage", type text}, {"LifecycleRevenue", type number}, {"LifecycleCost", type number}, {"ActualRevenue", type number}, {"ActualCost", type number}, {"YTDRevenue", type number}, {"YTDCost", type number}, {"FutureRevenue", type number}, {"FutureCost", type number}})
in
    #"Changed Type"

// ---- Fact_MonthlyTrend --------------------------------------------------------
let
    Source = Csv.Document(File.Contents(TargetFolder & "\Fact_MonthlyTrend.csv"),[Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Population", type text}, {"MonthLabel", type text}, {"MonthDate", type date}, {"Revenue", type number}, {"Cost", type number}, {"MarginPct", type number}})
in
    #"Changed Type"

// ---- Fact_BusinessUnit ---------------------------------------------------------
let
    Source = Csv.Document(File.Contents(TargetFolder & "\Fact_BusinessUnit.csv"),[Delimiter=",", Columns=11, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"BusinessUnit", type text}, {"RevenueContributionPct", type number}, {"YTDMarginPct", type number}, {"YTDRevenue", type number}, {"YTDCost", type number}, {"LifecycleMarginPct", type number}, {"LifecycleRevenue", type number}, {"LifecycleCost", type number}, {"ActualMarginPct", type number}, {"ActualRevenue", type number}, {"ActualCost", type number}})
in
    #"Changed Type"

// ---- Fact_AssessmentKPI ---------------------------------------------------------
let
    Source = Csv.Document(File.Contents(TargetFolder & "\Fact_AssessmentKPI.csv"),[Delimiter=",", Columns=10, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"SrNo", Int64.Type}, {"ProjectName", type text}, {"RevenueGroup", type text}, {"BusinessUnit", type text}, {"LifecycleMarginPct", type number}, {"YTDMarginPct", type number}, {"RiskScore", type number}, {"WorkAcceptanceGapPct", type number}, {"UnbilledEffortPct", type number}, {"NetProgramScore", type number}})
in
    #"Changed Type"

// ---- Dim_Census -------------------------------------------------------------------
let
    Source = Csv.Document(File.Contents(TargetFolder & "\Dim_Census.csv"),[Delimiter=",", Columns=3, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Population", type text}, {"SortOrder", Int64.Type}, {"Description", type text}})
in
    #"Changed Type"

// ---- Dim_MarginBasis ---------------------------------------------------------------
let
    Source = Csv.Document(File.Contents(TargetFolder & "\Dim_MarginBasis.csv"),[Delimiter=",", Columns=2, Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"MarginBasis", type text}, {"SortOrder", Int64.Type}})
in
    #"Changed Type"
