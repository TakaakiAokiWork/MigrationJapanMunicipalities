library(tidyverse)
library(reporttools)

args <- commandArgs(trailingOnly = T)
df = read_csv(args[1], col_types=cols(trips="n", .default="c")) %>% mutate(age = as_factor(age), sex = as_factor(sex))
summary(df)

library(ggplot2,quietly=T)
library(ggsci,quietly=T)
library(scales,quietly=T)
library(urbnthemes)
library(patchwork)
set_urbn_defaults(style = "print")


sum_age = df %>% group_by(age) %>% summarize(trips = sum(trips))
g = ggplot(sum_age, aes(x=age,y=trips) ) + geom_bar(stat= "identity") + geom_text(aes(label=number(trips,scale_cut=cut_short_scale()), hjust=1)) + coord_flip() + labs(x="Age", y="trips [persons]") 
g = g + scale_y_continuous( labels = label_number(scale_cut = cut_short_scale()))

ggsave(g, file=sprintf("tmp/%s-byage.pdf", tools::file_path_sans_ext(basename(args[1]))) , units="cm", width=10,height=6, device=cairo_pdf)


sum_sex = df %>% group_by(sex) %>% summarize(trips = sum(trips))
g = ggplot(sum_sex, aes(x=sex,y=trips) ) + geom_bar(stat= "identity") + geom_text(aes(label=number(trips,scale_cut=cut_short_scale()), hjust=1)) + coord_flip() + labs(x="sex", y="trips [persons]") 
g = g + scale_y_continuous( labels = label_number(scale_cut = cut_short_scale()))

ggsave(g, file=sprintf("tmp/%s-bysex.pdf", tools::file_path_sans_ext(basename(args[1]))) , units="cm", width=10,height=6, device=cairo_pdf)

df_filtered = df %>% filter(sex == "総数" & age == "総数")
g = ggplot(df_filtered, aes(x=log10(trips))) + geom_histogram()
g = g +  labs(subtitle = sprintf("min. = %d, max=%d ", min(df_filtered$trips), max(df_filtered$trips) ) )
ggsave(g, file=sprintf("tmp/%s-hist.pdf", tools::file_path_sans_ext(basename(args[1]))) , units="cm", width=10,height=6, device=cairo_pdf)

#suppressPackageStartupMessages(library(stargazer))
#stargazer(as.data.frame(df_filtered), title=args[1], out=sprintf("tmp/%s-desc.tex", tools::file_path_sans_ext(basename(args[1]))) )

