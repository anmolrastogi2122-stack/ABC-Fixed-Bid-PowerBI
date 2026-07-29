# ABC Fixed Bid Program — Power BI Build Pack

A complete **Power BI Project (PBIP)** for tracking a portfolio of fixed-bid
engagements: budget vs. actual burn, delivery status, and assessment/risk
posture, across the program's lifecycle, YTD, actual and future-backlog
views.

> **Why this repo doesn't contain a raw `.pbix` binary.** A `.pbix` file
> embeds a compiled, compressed Analysis Services (Vertipaq) data model —
> that binary can only be produced by Power BI Desktop itself (or the AS
> engine it embeds), not authored directly by a script. The Power BI
> Project format below (`.pbip` + TMDL + PBIR) *is* the source code for
> that model and report; opening it in Power BI Desktop and using
> **File → Save As → Power BI file (\*.pbix)** compiles it into the
> binary. This is also the Microsoft-recommended way to keep a Power BI
> report under source control, since `.pbix` itself doesn't diff or
> merge usefully in git.

## Contents

| Path | What it is |
|---|---|
| `ABC_Fixed_Bid_Portfolio.pbip` | Project pointer file — open this in Power BI Desktop |
| `ABC_Fixed_Bid_Portfolio.Dataset/` | Semantic model as TMSL (`model.bim`): tables, measures, relationships, Power Query |
| `ABC_Fixed_Bid_Portfolio.Report/` | Report layout (`report.json`): 2 pages, 11 visuals |
| `Data/` | Source CSVs the model imports (see below) |
| `PowerQuery_M_Queries.pq` | Reference copy of the M queries used by each table's partition |
| `DAX_Measure_Library.dax` | Reference copy of every measure defined in the model |
| `ABC_FixedBid_Program_Theme.json` | Power BI report theme (also embedded in the Report's StaticResources) |
| `automation/` | PowerShell / Python / Power Automate definitions to trigger a dataset refresh when the CSVs change |

## Data model

Star-ish schema, six tables:

- **Fact_Project** — one row per project/WBS: status, business unit,
  program stage, and Lifecycle / Actual / YTD / Future revenue & cost.
- **Fact_MonthlyTrend** — monthly Revenue/Cost/Margin% for four
  portfolio populations (Jan–Jun 2026).
- **Fact_BusinessUnit** — revenue/cost/margin rollup per business unit.
- **Fact_AssessmentKPI** — per-project risk score, work-acceptance gap,
  unbilled effort, and net program score from the fixed-bid assessment.
- **Dim_Census** — the four population segments used in
  `Fact_MonthlyTrend`, with display order.
- **Dim_MarginBasis** — a *disconnected* slicer table (`Lifecycle`,
  `YTD`, `Actual`, `Future`) that drives the `Selected Revenue` /
  `Selected Cost` / `Selected Margin %` measures via `SELECTEDVALUE` +
  `SWITCH`, so one set of visuals can flip between margin bases.

Relationships: `Fact_Project[BusinessUnit]` and
`Fact_AssessmentKPI[BusinessUnit]` → `Fact_BusinessUnit[BusinessUnit]`;
`Fact_MonthlyTrend[Population]` → `Dim_Census[Population]`.

## Report

- **Portfolio Overview** — margin-basis slicer, KPI cards (Total /
  Active Projects, Selected Revenue, Selected Margin %), a monthly
  revenue/cost trend line chart split by population, and actual revenue
  by business unit.
- **Delivery & Risk** — project detail table (stage, status, business
  unit, lifecycle revenue/cost) plus average risk score by business
  unit and program-level risk/assessment cards.

## Quick start

1. Open `ABC_Fixed_Bid_Portfolio.pbip` in Power BI Desktop.
2. Set the `TargetFolder` parameter to the full path of this project's
   `Data` folder: **Home → Transform data → Edit parameters**. (Its
   default assumes the project sits in your `Downloads` folder; if you
   extracted it elsewhere, point it at the right `...\Data` path.)
3. **Home → Refresh**.
4. Optionally apply the theme: **View → Themes → Browse for themes →**
   `ABC_FixedBid_Program_Theme.json`.
5. **File → Save As → Power BI file (\*.pbix)** to produce the binary
   deliverable.
6. Optionally wire up `automation/` (PowerShell, Python, or the Power
   Automate flow JSON) to trigger a Power BI Service dataset refresh
   whenever the CSVs are updated.

### Format note

This project uses the **classic** PBIP layout — a TMSL `model.bim`
semantic model and a classic `report.json` report layout. Power BI
Desktop's newer TMDL and PBIR (enhanced metadata) formats are gated
behind preview toggles under *Options → Preview features*, so the
classic layout is used here to keep the project openable on a default
Desktop install.

### Units

All revenue and cost figures are expressed in **millions**, e.g. a
`LifecycleRevenue` of `4.09` means $4.09M.
