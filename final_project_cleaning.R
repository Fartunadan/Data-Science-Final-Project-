# Final Project
# Data Cleaning and Preparation Script
# Authors: Daija, Fartun, Kaela

library(tidyverse)
library(tidymodels)
library(rpart.plot)
library(vip)
library(haven)

data <- read_dta("data/ACS_extract.dta")
acs2023 <- data |>
  filter(ownershpd == 22 & hhincome > 0) |> #keep those who rent "with cash" and those with positive household income
  select(-cbserial, -year, -sample, -gq, -ownershp, -ownershpd, -multgend, -perwt, -related, -raced, -hispand, -empstatd, -strata, -cluster) |> #drop unnecessary variables
  filter(statefip == 12) # filter to Florida

#creating new household level variables based on household composition, broken up for ease of processing

acs2023 <- acs2023 |>
  group_by(serial) |>
  mutate(prop_female = mean(sex == 2, na.rm = TRUE),
         mean_age = mean(age, na.rm = TRUE),
         prop_adult = mean(age >= 18, na.rm = TRUE),
         prop_healthcare = mean(hcovany == 2, na.rm = TRUE))|>
  ungroup()

acs2023 <- acs2023 |>
  group_by(serial) |>
  mutate(prop_white = mean(race == 1, na.rm = TRUE),
         prop_black = mean(race == 2, na.rm = TRUE),
         prop_ai_an = mean(race == 3, na.rm = TRUE),
         prop_asian = mean(race == 4| race == 5| race == 6, na.rm = TRUE)) |>
  ungroup()

acs2023 <- acs2023 |>
  group_by(serial) |>
  mutate(prop_hispanic = mean(hispan >0 & hispan < 9, na.rm = TRUE),
         prop_citizen = mean(citizen == 0 | citizen == 1| citizen == 2, na.rm = TRUE),
         prop_hsgrad = sum(educd >= 62 & age >= 18, na.rm = TRUE) / sum(age >=18), 
         prop_colgrad = sum(educd >= 101 & age >= 18, na.rm = TRUE) / sum(age >=18)) |>
  ungroup()

acs2023 <- acs2023 |>
  group_by(serial) |>
  mutate(prop_empstat = sum (empstat == 1  & age >= 16, na.rm = TRUE)/ sum(age >=16),
         total_hrs = sum(uhrswork, na.rm = TRUE)) |>
  ungroup()

# getting the data to the household level and creating rent burden variables

acs_household <- acs2023 |>
  filter(relate == 1) |>
  select(-relate, -sex, -age, -race, -hispan, -citizen, -hcovany, -empstat, -uhrswork) |>
  mutate(rent_income = (rentgrs*12)/hhincome,
         rent_burden = if_else(rent_income > .3, 1, 0),
         rent_burdend = case_when(
           rent_income > .5 ~ "severely rent burdened",
           rent_income > .3 ~ "rent burdened",
           rent_income <= .3 ~ "not rent burdened"
         ))

# removing variables used to generate our outcome
acs_florida <- acs_household |>
  select(-rent_income, -rentgrs, -hhincome)

#exporting the final data set
write_csv(acs_florida, "data/acs_florida.csv")
