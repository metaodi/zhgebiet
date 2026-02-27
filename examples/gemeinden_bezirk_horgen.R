# Example: Query all Gemeinden (municipalities) in Bezirk Horgen
#
# This script demonstrates how to use the zhgebiet package to retrieve
# all municipalities in a specific district (Bezirk).

library(zhgebiet)

# Search for the Bezirk Horgen to get all municipalities in that district
# The search function returns all municipalities that belong to the matching district
result <- zh_bezirke_suche("Horgen")

# Display the results
print(result)

# The result contains columns:
# - gemeinde_code: The municipality code
# - gemeinde_name: The municipality name
# - bezirk_code: The district code
# - bezirk_name: The district name (should all be "Horgen")
# - raumplanungsregion_code: The spatial planning region code
# - raumplanungsregion_name: The spatial planning region name

# You can also filter or select specific columns using dplyr
library(dplyr)

result |>
  select(gemeinde_code, gemeinde_name, bezirk_name) |>
  arrange(gemeinde_name)
