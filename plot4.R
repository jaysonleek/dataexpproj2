# Jayson Leek

# Coursera Exploratory Data Project2

# Plot4

library(dplyr)

# build a coal list from the SCC document
coal <- SCC[grepl("Coal|coal", SCC$Short.Name), ]

# match emissions records to coal list
PMcoal <- PM25[PM25$SCC %in% coal$SCC, ]

PMcoalGroup <- PMcoal %>% 
  group_by(year) %>% 
  summarize(total = sum(Emissions))

with(PMcoalGroup,
     plot(x = year,
          y = total,
          xlab = "Year", 
          ylab = "Coal PM25 Pollution in Tons", 
          main = "Total Annual PM25 Emissions from Coal in USA by Year",
          col = "navyblue", 
          lwd = 4))

dev.copy(png, file = "plot4.png")
dev.off()
