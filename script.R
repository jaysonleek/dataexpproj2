rm(list = ls())

setwd("C:/Users/jayso/Documents/dataexpproj2")
path <- getwd()

packages <- c("dplyr", "ggplot2", "readxl")

invisible(lapply(packages, library, character.only = TRUE))

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(url = fileURL, destfile = paste(path, "data", "PM.zip", sep = "/"))

unzip(zipfile = "./data/PM.zip", exdir = "./data/PM")

SCC <- readRDS("./data/PM/Source_Classification_Code.rds")

PM25 <- readRDS("./data/PM/summarySCC_PM25.rds")

# fipscode <- read_xlsx("C:/Users/jayso/Downloads/all-geocodes-v2017.xlsx")
# 
# names(fipscode) <- c("summary", "statecode", "countycode", "subcode", 
#                      "placecode", "consocode", "areaname")
# 
# fipscode <- fipscode[-(1:4), ]
# 
# fipsState <- fipscode[grep("040", fipscode$summary), ]
# 
# fipsState <- fipsState %>% 
#   select(statecode, state = areaname)
# 
# fipsCounty <- fipscode[grep("050", fipscode$summary), ]
# 
# fipsCounty$fips <- paste0(fipsCounty$statecode, fipsCounty$countycode)
# 
# fipsCounty <- merge(fipsCounty, 
#                     fipsState, 
#                     by = "statecode", 
#                     all.x = TRUE, 
#                     all.y = FALSE)
# 
# fipsCounty <- fipsCounty %>% 
#   select(fips, county = areaname, state)
# 
# PM25 <- readRDS("./data/summarySCC_PM25.rds")
# 
# PM25 <- PM25[grep("[0-9]", PM25$fips, ignore.case = FALSE), ]
# 
# fips <- unique(PM25$fips)
# 
# fips <- as.data.frame(fips)
# 
# combfips <- merge(fips, fipsCounty, by = "fips", all.x = TRUE, all.y = FALSE)
# 
# PM25 <- merge(PM25, combfips, by = "fips", all.x = TRUE, all.y = FALSE)

# rm(list = c("combfips", "fips", "fipscode", "fipsCounty", "fipsState", 
#             "packages"))

# PM25 <- PM25[PM25$fips != "00000", ]
# 
# PM25 <- PM25[!is.na(PM25$county) | !is.na(PM25$state), ]
# 

PM25$type <- as.factor(PM25$type)
PM25$year <- as.factor(PM25$year)
# PM25$state <- as.factor(PM25$state)
PM25$fips <- as.factor(PM25$fips)
PM25$SCC <- as.factor(PM25$SCC)
PM25$Pollutant <- as.factor(PM25$Pollutant)




pmgroup <- PM25 %>% 
  group_by(year) %>% 
  summarize(total = sum(Emissions), mean = mean(Emissions), median = median(Emissions))

pmgroup

axismarks <- c(4000000, 5000000, 6000000, 7000000, options(scipen = 10))

with(pmgroup, 
     plot(x = year, 
          y = total, 
          xlab = "Year", 
          ylab = "Total Annual Emissions (tons)", 
          main = "Total Annual Emissions in the United States each Year",
          col = "navyblue", 
          lwd = 4))
axis(2, at = axismarks, labels = axismarks)
dev.copy(png, file = "plot1.png")
dev.off()




pmgroup2 <- PM25[PM25$state == "Puerto Rico" | PM25$state == "District of Columbia", ]

pmgroup2$year <- as.Date(as.character(pmgroup2$year), "%Y")

plot(pmgroup2$year, log10(pmgroup2$Emissions), col = pmgroup2$state)


library(ggplot2)
qplot(pmgroup2$year, log10(pmgroup2$Emissions))

library(lattice)
p <- xy


plot(log10(Emissions) ~ state, data = pmgroup2)


abline(h = mean(log10(pmgroup2$Emissions)))

par(mfrow = c(1, 1))

baltimore <- PM25[PM25$fips == "24510", ]

boxplot(log10(Emissions) ~ year, data = baltimore)

par(mfrow = c(2, 2))

baltigroup <- baltimore %>% 
  group_by(type, year) %>% 
  summarize(mean = mean(Emissions))

baltigroup

levelBG <- levels(baltigroup$type)

baltigroup$year <- as.Date(as.character(baltigroup$year), "%Y")

with(baltigroup, plot(mean ~ year + type, col = year))
legend("topright", levelBG)

par(mfrow = c(2, 2))
with(baltigroup[baltigroup$type == "NON-ROAD", ], plot(mean ~ year))
with(baltigroup[baltigroup$type == "NONPOINT", ], plot(mean ~ year))
with(baltigroup[baltigroup$type == "ON-ROAD", ], plot(mean ~ year))
with(baltigroup[baltigroup$type == "POINT", ], plot(mean ~ year))

PM25$year <- as.Date(as.character(PM25$year), "%Y")
PM25$year <- as.factor(PM25$year)

par(mfrow = c(1, 1))
with(PM25[PM25$fips == "24510", ], plot(Emissions ~ year, col = PM25$type, pch = 19))
legend("topright", levels(PM25$type), pch = 19)


with(baltimore, plot(log10(Emissions) ~ year, col = type))

boxplot(log10(Emissions) ~ year)

missing <- baltigroup[baltigroup$type == "NON-POINT",]

head(missing)

levelBG
