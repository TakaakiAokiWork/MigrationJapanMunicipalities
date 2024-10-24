library(tidyverse)
args <- commandArgs(trailingOnly = T)
df = read_csv(args[1], col_types=list( .default="c"))
municipalities = read_csv(args[2], col_types=list( .default="c"))

# filter the migration only between minicalities
df = df %>% filter(origin %in% municipalities$code) %>% filter(dest %in% municipalities$code)
write_csv(df, args[3])
