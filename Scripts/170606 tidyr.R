download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

#how to read excel files

library("readxl")

raw_fert<-read_excel(path="Data/indicator undata total_fertility.xlsx", sheet="Data")
raw_infantMort<-read_excel(path="Data/indicator gapminder infant_mortality.xlsx")

#possible to define a data sheet in excel

gapminder

#long vs wide format, gapminder data is neither wide nor long, is in the tidy format

raw_fert
#is in wide format
#tidyr function gather, copy the Anführungststriche
#3 parameters are needed

library("tidyverse")

fert<-raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather(key=year,value=fert,-country) %>% 
  mutate(year=as.integer(year))

fert

#if I don't want something, then indicate it with a minus

