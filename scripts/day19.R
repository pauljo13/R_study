# Day 19
library(tidyverse)
x <- data.frame(id=1:3, name = letters[1:3]); x
y <- data.frame(id=2:4, addr = LETTERS[2:4]); y

### Filtering join
semi_join(x,y)
anti_join(x,y)

##### merge()
merge(x,y)
merge(x,y, all.x = TRUE)
merge(x,y, all.y = TRUE)
merge(x,y, all = TRUE)

# tidyr packages
table4a
ggplot(table4a, aes(country, `1999`)) + geom_col()
table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases") %>%
  ggplot(aes(country, cases, fill=year)) + geom_col()
table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases") %>%
  ggplot(aes(year, cases, fill=country)) + geom_col()


na_table4a <- table4a
na_table4a$`2000`[3] <- NA
na_table4a
na_table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
na_table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases", values_drop_na = T)

table4a %>%
  gather(`1999`, `2000`, key = "year", value ="cases")

##### pivot_wider
table2
table2 %>%
  pivot_wider(names_from = type, values_from = count)
table2 %>%
  pivot_wider(names_from = type, values_from = count) %>%
  group_by(country) %>%
  summarise(totol_case = sum(cases), mean_pop = mean(population))
table2 %>%
  pivot_wider(names_from = type, values_from = count) %>% 
  mutate(cases_per_capita = cases / population)

na_long_table4a <- na_table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases", values_drop_na = T)
na_long_table4a
na_long_table4a %>%
  pivot_wider(names_from = year, values_from = cases)
na_long_table4a %>%
  pivot_wider(names_from = year, values_from = cases, values_fill=0)

##### spread()
table2 %>% 
  spread(key = type, value = count)

##### separate()
table3
table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

##### unite()
table5
table5 %>%
  unite(c(century, year), col ="year", sep = "")

##### parse_datetime()
games = tribble(
  ~date, ~audience,
  "2023/10/12", "8,456",
  "2023/10/19", "13,412",
  "2023/10/25", "3,671",
  "2023/12/12", "12,460",
  "2023/12/18", "10,021"
)
games
games = mutate(games,
               audience = parse_number(audience, locale = locale(grouping_mark = ",")))
games
games = mutate(games,
               date = parse_datetime(date, format = "%Y/%m/%d"))
games
ggplot(games, aes(date, audience)) + geom_line()


# Chapter 10
## R Conditional statement
x <- 4
if(x >= 4) y <- 1 else y <- -1
y
x <- sample(1:6, size = 1)
if(x >= 4) y <- 1 else y <- -1
y
x <- sample(1:6, size = 1);if (x >= 4) {
  y <- 1
  cat("손님이 이겼습니다.\n")
} else {
  y <- -1
  cat("딜러가 이겼습니다.\n")
} ;cat("주사위 눈금:", x, "\n") ;cat("손익:",y, "\n")

n <- 0
x <- sample(1:6, size = 1);
  if (x >= 4) n <- n + 1 ;
  cat("x:", x, ", n:", n ,"\n")

x <- sample(1:6, size=1);
if (x>=5) {
  cat("손님이 이겼습니다.\n")
  y <- 1
} else if ( x >=3 ) {
  cat("무승부입니다.\n")
  y <- 0
} else {
  cat("딜러가 이겼습니다.\n")
  y <- -1
};
cat("주사위 눈금:", x, "\n");
cat("손익:", y, "\n")

