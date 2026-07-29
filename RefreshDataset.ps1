table Fact_Project
	lineageTag: 1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d

	column ProjectKey
		dataType: string
		lineageTag: col-1
		sourceColumn: ProjectKey

	column WBS_ID
		dataType: string
		lineageTag: col-2
		sourceColumn: WBS_ID

	column ProjectName
		dataType: string
		lineageTag: col-3
		sourceColumn: ProjectName

	column Status
		dataType: string
		lineageTag: col-4
		sourceColumn: Status

	column RevenueGroup
		dataType: string
		lineageTag: col-5
		sourceColumn: RevenueGroup

	column BusinessUnit
		dataType: string
		lineageTag: col-6
		sourceColumn: BusinessUnit

	column LifecycleRevenue
		dataType: double
		lineageTag: col-7
		sourceColumn: LifecycleRevenue

	column LifecycleCost
		dataType: double
		lineageTag: col-8
		sourceColumn: LifecycleCost

	measure 'Total Projects' = COUNTROWS('Fact_Project')
		lineageTag: m-1

	measure 'Lifecycle Margin %' = 
		VAR Rev = SUM('Fact_Project'[LifecycleRevenue])
		VAR Cost = SUM('Fact_Project'[LifecycleCost])
		RETURN DIVIDE(Rev - Cost, Rev, 0)
		formatString: 0.0%
		lineageTag: m-2

	partition Fact_Project = m
		mode: import
		source = 
			let
			    Source = Csv.Document(File.Contents(TargetFolder & "\Fact_Project.csv"),[Delimiter=",", Columns=21, Encoding=65001, QuoteStyle=QuoteStyle.None]),
			    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true])
			in
			    #"Promoted Headers"
