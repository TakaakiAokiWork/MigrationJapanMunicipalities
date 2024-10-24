library(tidyverse)
library(ggplot2,quietly=T)
library(ggsci,quietly=T)
library(scales,quietly=T)

args <- commandArgs(trailingOnly = T)
df = read_csv(args[1], col_types=cols(trips="n", .default="c")) %>% mutate(age = as_factor(age), sex = as_factor(sex))
summary(df)


theme_set(theme_light())

sum_age = df %>% group_by(age) %>% summarize(trips = sum(trips))
g = ggplot(sum_age, aes(x=age,y=trips) ) + geom_bar(stat= "identity") + 
  #geom_text(aes(label=number(trips,scale_cut=cut_short_scale()), hjust=1)) + 
  coord_flip() + 
  labs(x="Age", y="trips [persons]") + 
   scale_y_continuous( labels = label_number(scale_cut = cut_short_scale()))

ggsave(g, file=sprintf("%s-byage.pdf", args[2]) , units="cm", width=10,height=6, device=cairo_pdf)

sum_sex = df %>% group_by(sex) %>% summarize(trips = sum(trips))
g = ggplot(sum_sex, aes(x=sex,y=trips) ) + geom_bar(stat= "identity") + 
  geom_text(aes(label=number(trips,scale_cut=cut_short_scale()), hjust=1)) + coord_flip() +
  labs(x="sex", y="trips [persons]")  +
  scale_y_continuous( labels = label_number(scale_cut = cut_short_scale()))

ggsave(g, file=sprintf("%s-bysex.pdf", args[2]) , units="cm", width=10,height=6, device=cairo_pdf)

df_filtered = df %>% filter(sex == "総数" & age == "総数")
g = ggplot(df_filtered, aes(x=log10(trips))) + geom_histogram()  +
  labs(subtitle = sprintf("min. = %d, max=%d ", min(df_filtered$trips), max(df_filtered$trips) ) )
ggsave(g, file=sprintf("%s-hist.pdf", args[2]) , units="cm", width=10,height=6, device=cairo_pdf)

