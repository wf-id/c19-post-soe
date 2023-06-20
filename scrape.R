if(!dir.exists("data")) dir.create("data")

slugify_date <- function(x){
  x <- stringi::stri_replace_all_regex(x,"[^\\P{P}-]","")
  x <- gsub(x, pattern = " ", replacement = "-")
  x
}

ping_time <- slugify_date(Sys.time())

url <- "https://covid.cdc.gov/covid-data-tracker/COVIDData/getAjaxData?id=hospitals_county_latest"

dat <- jsonlite::read_json(url, simplifyVector =  TRUE)


dat <- dat[[2]]

dat$county <- NULL

str(dat)

data.table::fwrite(dat, here::here("data-raw", paste0(ping_time,"-","hosp.csv")))

data.table::fwrite(dat, here::here("data", "latest-hosp.csv"))