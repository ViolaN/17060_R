# GAPMINDER PLUS 
download.file(url = "https://raw.githubusercontent.com/dmi3kno/SWC-tidyverse/master/data/gapminder_plus.csv", 
              destfile = "Data/gapminder_plus.csv")

#erst muss man das package tidyverse aufmachen, dann kann man seinen file suchen
#read in a csv file

library("tidyverse")


gapminder_plus<-read_csv(file="Data/gapminder_plus.csv")

gapminder_plus

#filter for africa
#babies death are in ratios, mutate
#filter for 2007 only, 7 observations long, 1 column wide
#join dataset to main gapminder

filter(gapminder_plus, year==2007, continent=="Africa")

gapminder_plus %>% 
  filter(continent=="Africa", year=="2007") %>% 
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(-continent) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3) %>%
  gather(key=variables,value=values, c(fert,infantMort, babiesDead, gdpPercap, pop, lifeExp))

gapminder_plus %>% 
  filter(continent=="Africa", year==2007) %>% 
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3, 
         gdp_bln=gdpPercap*pop/1e9,
         pop_mln=pop/1e6) %>%
  select(-c(continent,pop,babiesDead)) %>% 
  gather(key=variables, value=values, -c(country, year)) %>% 
  ggplot()+
  geom_text(data=. %>% filter(year==2007) %>% group_by(variables) %>% 
              mutate(max_value=max(values)) %>% 
                       filter(values==max_value),
            aes(x=year, y=values, label=country,color=country))+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~ variables, scales="free_y")+
  labs(title="khjk",
       subtitle="hjka",
       caption="jsksj",
       y=NULL,
       X="Year")+
  theme_bw()+
  theme(legend.position = "none")

