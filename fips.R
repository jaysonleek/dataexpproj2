rm(list = ls())

fipscode <- readxl::read_xlsx("C:/Users/jayso/Downloads/all-geocodes-v2017.xlsx")

headers <- c("summary", "statecode", "countycode", "subcode", "placecode", "consocode", "areaname")

names(fipscode) <- headers 

fipscode <- fipscode[-(1:4), ]

fipsState <- fipscode[grep("040", fipscode$summary), ]

fipsState <- fipsState %>% 
  select(statecode, state = areaname)

fipsCounty <- fipscode[grep("050", fipscode$summary), ]

fipsCounty$fips <- paste0(fipsCounty$statecode, fipsCounty$countycode)

fipsCounty <- left_join(fipsCounty, fipsState)

fipsCounty <- fipsCounty %>% 
  select(fips, county = areaname, state)

