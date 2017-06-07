x<-5*6
x

is.vector(x)
length(x)

x[2]<-31
x
x[5]<-44
x
x[11]
x[0]
#integer values from 1 to 4:
x<-1:4
x
y<-x^2
y
x<-1:5

y<-3:7
x
y
x+y

z<-y[-5]
z

x+z

z<-1:10

x+z

z^x

x

y<-x[-5]
y[5]<-NA
y
x+y

str(c("Hello","workshop", "participants"))

str(c(9:11,200,x))

str(c(2:4,pi>3))

str(c(2L:4L,pi>3))

w<-rnorm(10)
seq_along(w)
w
which(w<0)
w[w<0]
w<0

w

#drop position 2 and 5 in the vector
w[-c(2,5)]

#insead of c, type list:
str(list("something", pi, 2:4, pi>3))

x<-list(vegetable="cabbage",
     number=pi,
     series=2:4,
     telling=pi>3)
str(x)

str(x$vegetable)

str(x[1])

x<-list(vegetable=list("cabbage", "carrot", "spinach"),
        number=list(c(pi,0,2.14, NA)),
        series=list(list(2:4),(3:5)),
        telling=pi>3)
str(x)


mod<-lm(lifeExp ~ gdpPercap,data=gapminder_plus)
mod
str(mod)

#extract dg.residual from the list
str(mod[[8]])
str(mod[["df.residual"]])

#get qr -41
mod$qr$qr[1,1]


gapminder_plus %>% group_by(continent) %>% 
  summarize(mean_le=mean(lifeExp),
            min_le=min(lifeExp),
            max_le=max(lifeEXp))


gapminder_plus %>%
  ggplot()+
  geom_line(mapping=aes(x=year,y=lifeExp, color=continent, group=country))+
  geom_smooth(mapping=aes(x=year,y=lifeExp),method="lm",color="black")+
  facet_wrap(~continent)

#now to see which points are the outlyers 

by_country<-gapminder_plus %>% group_by(continent,country) %>% 
  nest()
by_country$data[[1]]

by_country

#map(list,function)

map(1:3,sqrt)

by_country

library(purrr)

by_country %>% 
  mutate(model=map(data,~lm(lifeExp~year, data=.x)))

model_by_country<-

by_country %>% 
  mutate(model=purrr::map(data,~lm(lifeExp~year,data=.x))) %>%
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  ggplot()+
  geom_jitter(mapping=aes(x=continent,y=r.squared)) %>% 
  filter(r.squared<0.6)by_country

by_country %>% 
  mutate(model=purrr::map(data,~lm(lifeExp~year,data=.x))) %>%
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  filter(r.squared<0.3) %>%
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year,y=lifeExp, color=country, group=country))

#visualize lifeExp by gdpPercap using geom point

gapminder_plus %>% ggplot()+
  geom_line(mapping=aes(x=log(gdpPercap),y=lifeExp,color=continent,group=country))

by_country %>% 
  mutate(model=purrr::map(data,~lm(lifeExp~year,data=.x))) %>%
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  filter(r.squared<0.3) %>%
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  ggplot()+
  geom_line(mapping=aes(x=log(gdpPercap),y=lifeExp, color=country, group=country))

#lifeE~gdpPerc
by_country %>% 
  mutate(model=purrr::map(data,~lm(lifeExp~log(gdpPercap),data=.x))) %>%
  mutate(summr=map(model, broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  filter(r.squared<0.1) %>%
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  ggplot()+
  geom_point(mapping=aes(x=log(gdpPercap),y=lifeExp, color=country, group=country))


saveRDS(by_country,"by_country_tibble.rds")
my_fresh_by_country<-readRDS("by_country_tibble.rds")
my_fresh_by_country

write_csv(gapminder_plus,"gapminder_plus_for_professor.csv")
