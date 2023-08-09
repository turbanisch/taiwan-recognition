library(tidyverse)
library(rvest)

# download Taiwan relations using permalink
url <- "https://en.wikipedia.org/w/index.php?title=Foreign_relations_of_Taiwan&oldid=1169329629"

# scrape table of countries that currrently recognize Taiwan
table_current_recognizers <- read_html(url) |> 
  html_element(xpath = "/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/table[2]") |> 
  html_table()

current_recognizers <- table_current_recognizers |> 
  mutate(across(everything(), \(s) str_remove_all(s, "\\[.*\\]"))) |> 
  select(country = State, period = `Relations established`) |> 
  separate_longer_delim(period, delim = regex(",\\s+")) |> 
  separate_wider_delim(
    period, 
    delim = "–", 
    names = c("start", "end"),
    too_few = "align_start"
  ) |> 
  mutate(across(c(start, end), as.integer))

# scrape changes of diplomatic recognition with former recognizers
table_former_recognizers <- read_html(url) |> 
  html_element(xpath = "/html/body/div[2]/div/div[3]/main/div[3]/div[3]/div[1]/table[5]") |>
  html_table() |> 
  rename(country = 1, start = 2, end = 3) |> 
  filter(row_number() != 1L)

former_recognizers <- table_former_recognizers |> 
  mutate(across(everything(), \(s) str_remove_all(s, "\\[.*\\]"))) |> 
  separate_longer_delim(c(start, end), delim = regex("\\s")) |> 
  filter(if_all(c(start, end), \(x) str_detect(x, "\\d{4}"))) |> 
  mutate(across(c(start, end), as.integer))

# combine and save
all_recognizers <- bind_rows(current_recognizers, former_recognizers) |>
  arrange(country)

write_csv(all_recognizers, "taiwan-recognition.csv")
