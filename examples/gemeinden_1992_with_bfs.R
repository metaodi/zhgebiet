# Example: Query all Gemeinden (municipalities) in 1992 with ID and BFS number
#
# This script demonstrates how to use the zhgebiet package to retrieve
# historical municipality data for a specific year, showing both the
# municipality ID (gemeinde_code) and BFS number.
#
# Note: The gemeinde_code represents the BFS (Bundesamt für Statistik /
# Swiss Federal Statistical Office) number for the municipality.

library(zhgebiet)

# Query all municipalities for the year 1992
# This uses the zh_gemeindenhist_jahr() function for historical data
result <- zh_gemeindenhist_jahr(1992)

# Display the results
print(result)

# The result contains columns:
# - gebietstyp_code: The area type code
# - gemeinde_code: The municipality code (this is the BFS number)
# - gemeinde_name: The municipality name
# - jahr: The year

# For clarity, we can select and rename columns to show that gemeinde_code is the BFS number
library(dplyr)

result_with_bfs <- result |>
  select(
    gemeinde_id = gemeinde_code,      # Municipality ID (also BFS number)
    bfs_number = gemeinde_code,        # BFS (Federal Statistical Office) number
    gemeinde_name,                     # Municipality name
    jahr                               # Year
  )

print(result_with_bfs)

# You can also sort by BFS number
result |>
  select(gemeinde_code, gemeinde_name, jahr) |>
  arrange(gemeinde_code) |>
  print()

# Summary information
cat("\nTotal municipalities in 1992:", nrow(result), "\n")
