# zhgebiet

R package für die API der Gebietsstammdaten des Kantons Zürich.

<!-- badges: start -->
<!-- badges: end -->

`zhgebiet` provides a tidyverse-friendly client for the
[Gebietsstammdaten REST API](https://gebietsstammdaten.statistik.zh.ch)
of the Canton of Zurich. All functions return a
[`tibble`](https://tibble.tidyverse.org/) so results integrate naturally
with `dplyr` pipelines.

## Installation

Install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("metaodi/zhgebiet")
```

## Usage

```r
library(zhgebiet)
library(dplyr)

# List all municipalities and filter by name
zh_gemeinden() |>
  filter(grepl("^Z", gemeinde_name))

# Get a single municipality
zh_gemeinde(261)

# Search municipalities by (partial) name
zh_gemeinden_suche("Tha")

# Include the search term as a column
zh_gemeinden_suche("Tha", .include_query = TRUE)

# List all districts
zh_bezirke()

# Get a single district
zh_bezirk(101)

# Search districts
zh_bezirke_suche("Affoltern", .include_query = TRUE)

# List all spatial planning regions
zh_raumplanungsregionen()

# Get a single spatial planning region
zh_raumplanungsregion(101)

# Search regions
zh_raumplanungsregionen_suche("Zürich")

# Full municipality assignment table
zh_gemeindezuweisungen()

# Assignment for a single municipality
zh_gemeindezuweisung(261) |>
  select(gemeinde_name, bezirk_name, raumplanungsregion_name)

# API health check
zh_health()
```

## Return shapes

| Function | Rows | Key columns |
|---|---|---|
| `zh_gemeinden()` | one per municipality | `gemeinde_code`, `gemeinde_name` |
| `zh_gemeinde(code)` | 1 | `gemeinde_code`, `gemeinde_name` |
| `zh_gemeinden_suche(name)` | one per hit | `gemeinde_code`, `gemeinde_name`, `bezirk_*`, `raumplanungsregion_*` |
| `zh_bezirke()` | one per district | `bezirk_code`, `bezirk_name` |
| `zh_bezirk(code)` | 1 | `bezirk_code`, `bezirk_name` |
| `zh_bezirke_suche(name)` | one per hit | same as search above |
| `zh_raumplanungsregionen()` | one per region | `raumplanungsregion_code`, `raumplanungsregion_name` |
| `zh_raumplanungsregion(code)` | 1 | `raumplanungsregion_code`, `raumplanungsregion_name` |
| `zh_raumplanungsregionen_suche(name)` | one per hit | same as search above |
| `zh_gemeindezuweisungen()` | one per municipality | all 6 code+name columns |
| `zh_gemeindezuweisung(code)` | 1 | all 6 code+name columns |
| `zh_health()` | 1 | API health fields |

Search functions accept `.include_query = TRUE` to prepend a `query`
column containing the original search term.

## Configuration

Override the default base URL via an R option (useful for testing):

```r
options(zhgebiet.base_url = "http://localhost:8080")
```

## License

MIT © Stefan Oderbolz

---

Vibe coded during the Open Data Beer presentation of the API der Gebietsstammdaten des Kantons Zürich
