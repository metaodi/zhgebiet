# Examples

This directory contains example scripts demonstrating how to use the `zhgebiet` package to query Swiss Canton of Zurich geographic data.

## Available Examples

### 1. gemeinden_bezirk_horgen.R

This example shows how to query all municipalities (Gemeinden) within a specific district (Bezirk). It uses the `zh_bezirke_suche()` function to find all municipalities in the Bezirk Horgen.

**Usage:**
```r
source("examples/gemeinden_bezirk_horgen.R")
```

**Key Functions Used:**
- `zh_bezirke_suche()` - Search for municipalities by district name

### 2. gemeinden_1992_with_bfs.R

This example demonstrates how to retrieve historical municipality data for a specific year (1992), showing both the municipality ID and BFS (Bundesamt für Statistik / Swiss Federal Statistical Office) number.

**Usage:**
```r
source("examples/gemeinden_1992_with_bfs.R")
```

**Key Functions Used:**
- `zh_gemeindenhist_jahr(1992)` - Query historical municipalities for a specific year

**Note:** The `gemeinde_code` field represents the BFS number.

## Running the Examples

To run any of these examples, you need to have the `zhgebiet` package installed:

```r
# Install from GitHub
remotes::install_github("metaodi/zhgebiet")

# Load the package
library(zhgebiet)

# Run an example
source("examples/gemeinden_bezirk_horgen.R")
```

## Requirements

- R >= 3.5.0
- zhgebiet package
- dplyr package (for data manipulation in examples)
