#hash can be used to write a note

library("tidyverse")

gapminder<- read_csv(file = "Data/gapminder-FiveYearData.csv") 

gapminder
# select the data, + means it continues in the following line
# define what is x and y
ggplot(data = gapminder)+
  geom_point(mapping=aes(x=gdpPercap,y=lifeExp))
# copy the same thing and add a 3rd one, color
ggplot(data = gapminder)+
  geom_jitter(mapping=aes(x=gdpPercap,y=lifeExp, color=continent))

ggplot(data = gapminder)+
  geom_point(mapping=aes(x=log(gdpPercap),y=lifeExp, color=continent, size=pop))


ggplot(data = gapminder)+
  geom_line(mapping=aes(x=log(gdpPercap),y=lifeExp, group=country, color=continent))

ggplot(data = gapminder)+
  geom_line(mapping=aes(x=year,y=lifeExp, group=country, color=continent))

ggplot(data = gapminder)+
  geom_boxplot(mapping=aes(x=continent,y=lifeExp))
# don't forget the additional +, it matters which line comes first, possible to switch order of jitter and boxplot
ggplot(data = gapminder)+
  geom_jitter(mapping=aes(x=continent,y=lifeExp, color=continent))+
  geom_boxplot(mapping=aes(x=continent,y=lifeExp,color=continent))
#copy the stuff in () into the first line, so that it appears in the main function. then I dont need to repeat the sam ething again
ggplot(data = gapminder,
       mapping=aes(x=continent,y=lifeExp, color=continent))+
  geom_jitter()+
  geom_boxplot()
#lm means it is a linear model, playing around with alpa, from 0.5 to 0.1 changes the size of the dots
ggplot(data = gapminder,
       mapping=aes(x=log(gdpPercap),y=lifeExp, color=continent))+
  geom_jitter(alpha=0.1)+
  geom_smooth(method = "lm")
#hide the colour of the continent, remove it from main line, add it to the sub-line, add also mapping aes
ggplot(data = gapminder,
       mapping=aes(x=log(gdpPercap),y=lifeExp))+
  geom_jitter(mapping=aes(color=continent),alpha=0.1)+
  geom_smooth(method = "lm")

ggplot(data = gapminder,
       mapping=aes(x=year,y=lifeExp))+
  geom_jitter(mapping=aes(color=continent),alpha=0.1)+
  geom_smooth(method = "lm")
ggplot(data = gapminder,
       mapping=aes(x=year,y=lifeExp, color=continent))+
  geom_boxplot))
#challenge 6
ggplot(data=gapminder)+
  geom_boxplot(mapping=aes(x=as.character(year), y=lifeExp))

ggplot(data=gapminder)+
  geom_density2d(mapping=aes(x=lifeExp, y=log(gdpPercap)))
# facet wrap means it splits up the continents into single plots, ~ splits it up
ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp))+
  geom_point()+
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~continent)

#challenge7
ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp))+
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~year)

ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp))+
  geom_point()+
  geom_smooth(method = "lm")+
  scale_x_log10()+
  facet_wrap(~continent)

#now we look only at 2007
filter(gapminder, year==2007)

ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping=aes(x=continent))
#R made the y axis by itself, it puts count there, it comes with geom_bar

ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping=aes(x=continent), stat="count")

# to further filter the datasets, add continent
filter(gapminder, year==2007, continent=="Oceania")

#identity means do not do anything to my data
ggplot(data=filter(gapminder, year==2007,continent=="Oceania"))+
  geom_bar(mapping=aes(x=country, y=pop), stat="identity")

ggplot(data=filter(gapminder, year==2007,continent=="Asia"))+
  geom_col(mapping=aes(x=country, y=pop))+
  coord_flip()

ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp, color=continent, size=pop/10^6))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)

#adding labels, labs, it adds a title to the chart
ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp, color=continent, size=pop/10^6))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)+
  labs(title="Life Expectancy vs GDP per capita over time")

#add subtitle, add caption
ggplot(data=gapminder,mapping=aes(x=gdpPercap, y=lifeExp, color=continent, size=pop/10^6))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)+
  labs(title="Life Expectancy vs GDP per capita over time", 
       subtitle="In the last 50 years, life exp has inproved in most countries", 
       caption="Source:gapminder",
       x="GDP per capita, in 000 USD",
       y="life Exp in years",
       color="Continent",
       size="Population, in millions")

#to save the plot, with ggsave

ggsave("my_fancy_plot.png")

#how to get help, ? down there, or in Help menu in the rigght lower window






