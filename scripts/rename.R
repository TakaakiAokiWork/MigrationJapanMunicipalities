library(tidyverse)
args <- commandArgs(trailingOnly = T)
df = read_csv(args[1], col_types=list( .default="c"))

time = as.numeric(substr(unique(df["@time"]), 1,4))
time

# rename after 2019
if (time >= 2019){
  df = df %>% rename(origin="@area", dest = "@cat01", age = "@cat02", sex="@cat03", trips = "$")  %>% select(-"@tab",-"@unit", - "@time")
} else { # before 2018
  df = df %>% rename(dest="@area", origin = "@cat01", age = "@cat02", sex="@cat03", trips = "$")  %>% select(-"@tab",-"@unit", - "@time")
}

if ("@cat04" %in% colnames(df)){
  df = df %>% select(-"@cat04")
}
write_csv(df, args[2])
