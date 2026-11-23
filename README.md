# Evidence-aware Fisheries MCP

This prototype helps an AI assistant find and understand **public NOAA
fisheries data**. It is read-only and runs locally; it does not access a
private database.

The fixed snapshot covers Atlantic cod and haddock in spring 2021-2025. It is
not a live feed or an official stock assessment.

## Quick start

Install [uv](https://docs.astral.sh/uv/), then from the repository root:

```powershell
uv sync --locked --group dev
uv run fisheries-mcp
```

The included `data\spring.sqlite` is a public-only snapshot. To rebuild it from
the checksum-pinned NOAA archive:

```powershell
uv run fisheries-prepare --download
```

The server uses stdio; it is not a chat interface. To connect an MCP client,
see [QUICKSTART.md](QUICKSTART.md). Queries run offline and read-only.

For a reproducible demonstration without a model:

```powershell
uv run python submission\demo.py
```

This script calls the real MCP server. Its calls are scripted, not selected by
an AI. With an existing Windows virtual environment, you can instead run
`.\.venv\Scripts\python.exe submission\demo.py`.

## What makes it useful

For example: **"Compare cod and haddock catch from 2021 to 2025, and check
the survey coverage."**

| Tool | Goal |
| --- | --- |
| `search_species` | Find published common/scientific names in this snapshot |
| `get_spring_catch_summary` | Retrieve one species' catch and sampling context |
| `compare_spring_catch` | Compare distinct species with identical scope |
| `get_spring_survey_coverage` | Inspect station coverage independently of catch |
| `get_spring_report_context` | Read a curated, cited NOAA context card for 2023 or 2025 |

The report cards are curated summaries, not live report retrieval. The server
also provides a data dictionary and a comparison prompt. It does not expose
arbitrary SQL.

## Important limits

- Catch totals are **not population estimates** and are not standardized for
  survey effort.
- No catch record means unknown, not measured zero. Station records are not
  automatically valid hauls.
- NOAA's linked metadata does not specify the weight unit. Do not assume one.
- Survey changes make comparisons harder; they do not prove why catch changed.
- A scientist has not approved the answers.

## What we tested

- **Scripted checks:** 36 of 36 passed against independently calculated NOAA
  CSV values. These test the tools, not the AI's reasoning.
- **AI trials:** 45 MCP trials completed. All 80 recorded tool calls returned
  without errors.
- **Data access:** For eight questions tried three times each, the AI supplied
  the requested result in 24 of 24 MCP trials and 0 of 24 no-tool trials. The
  no-tool version did not have the underlying records.
- **Answer review:** A partial AI-assisted review found at least eight answers
  with unsupported claims. The other 37 are unverified, not passes. Scientific
  review remains **UNVERIFIED**.

The comparison tests data access, not an MCP advantage over equally informed SQL
or files. It is not an overall accuracy score.

## Submission materials

- [Slide deck](submission/release/fisheries-deck.pptx)
- [Evaluation document](submission/release/fisheries-evaluation.docx)
- [Six slides for recording](submission/release/fisheries-video-deck.pptx)
- [Short video script](submission/VIDEO.md)
- [Current evaluation details](eval/results/hardened-agent-evaluation.json)
- [Technical evidence and rubric map](submission/README.md)

The earlier agent results and their limitations are preserved separately in the
[candidate-v7 manifest](eval/results/candidate-v7-agent-evaluation.json).

```powershell
uv run pytest tests -q
uv run ruff check .
uv run ruff format --check .
```

See [evaluation details](eval/README.md), the
[Databricks runbook](deploy/databricks/README.md) and
[CONTRIBUTING.md](CONTRIBUTING.md) for technical reproduction.

## Structure

`src\fisheries_mcp` contains the thin app, models, read-only data layer, public
importer, and one file per tool. `tests` uses invented records, not restricted
data. `eval` computes reference answers independently of application queries.
`data` contains only the selected official public extract.

## Source and attribution

- [NOAA Spring Bottom Trawl Survey metadata and downloads](https://www.fisheries.noaa.gov/inport/item/22561)
- [Catch field metadata](https://www.fisheries.noaa.gov/inport/item/33608)
- [Station field metadata](https://www.fisheries.noaa.gov/inport/item/33610)

Acknowledgement: NOAA/NMFS/NEFSC. This independent prototype is not an official
NOAA or Department of Commerce assessment or endorsement. See
[SECURITY.md](SECURITY.md) and the [MIT license](LICENSE).
