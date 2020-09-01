# Jayson Leek

# Coursera Exploratory Data Project2

# Plot2

# Subset the data to Baltimore

Baltimore <- PM25[PM25$fips == "24510",]

# Aggregate the data for yearly totals

library(dplyr)

BaltiGroup <- Baltimore %>% 
  group_by(year) %>% 
  summarize(total = sum(Emissions))

BaltiGroup

with(BaltiGroup, 
     plot(x = BaltiGroup$year, 
          y = total, 
          xlab = "Year", 
          ylab = "PM25 Pollution in Tons", 
          main = "Total Annual PM25 Emissions (All Sources) Baltimore by Year",
          col = "navyblue",
          lwd = 4))

# write the png
dev.copy(png, file = "plot2.png")
dev.off()

