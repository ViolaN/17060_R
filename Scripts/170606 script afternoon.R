library(tidyverse)
gapminder<- read_csv("Data/gapminder-FiveYearData.csv")
head(gapminder)

rep("This is an example",times=3)

# shift ctrl M is the pipe command
"This is an example" %>% rep(times=3)

#to only chose 3 columns, use select
year_country_gdp<-select(gapminder,year,country,gdpPercap)
year_country_gdp

# to show the head of the table use the head function, shows the first 6 lines 
head(year_country_gdp)

year_country_gdp<-gapminder %>% 
 
head(yea select(year, country, gdpPercap)r_country_gdp)

#filter command
gapminder %>% 
  filter(year==2002) %>% 
  ggplot(mapping=aes(x=continent, y=pop))+
  geom_boxplot()

year_country_gdp_euro<- gapminder %>% 
  filter(continent=="Europe") %>% 
  select(year,country,gdpPercap)

country_lifeExp_Norway<-gapminder %>% 
  filter(country=="Norway") %>% 
  select(year,lifeExp,gdpPercap)
country_lifeExp_Norway

gapminder %>% 
  group_by(continent)

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

# or is the vertical bar
gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  filter(mean_lifeExp==min(mean_lifeExp)|mean_lifeExp==max(mean_lifeExp))

gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  ggplot(mapping=aes(x=country, y=mean_lifeExp))+
  geom_point()+
  order()+
  coord_flip()

#mutate function, an existing variable to create a new one
gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>% 
  group_by(continent,year) %>% 
  summarize(mean_gdp_billion=mean(gdp_billion))

gapminder_country_summary<-gapminder %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp))



library(maps)

map_data("world") %>% 
  head()gapminder_country_summary
#in this data set it is used region instead of country, use rename, then merge these data with gapminder data


map_data("world") %>% 
  rename(country=region) %>% 
  left_join(gapminder_country_summary,by="country") %>% 
  ggplot()+
  geom_polygon(aes(x=long, y=lat, group=group, fill=mean_lifeExp))+
  scale_fill_gradient(low="blue", high="red")+
  coord_equal()

ggsave("lifeExp_worldwide.png")
