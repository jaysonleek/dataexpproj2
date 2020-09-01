# Jayson Leek

# Coursera Exploratory Data Project2

# Plot6

library(dplyr)
library(ggplot2)

# subset for vehicle pollution from Baltimore or LA
BaltLAVehicles <- PM25[PM25$type == "ON-ROAD" & (PM25$fips == "06037" | PM25$fips == "24510"), ]

# aggregate data by year and location
BLAVGroup <- BaltLAVehicles %>% 
  group_by(year, fips) %>% 
  summarize(total = sum(Emissions))


# plot the data
ggplot(data = BLAVGroup, aes(year, total)) +
  geom_point(color = "darkred",
             size = 8,
             alpha = 3/4) + 
  facet_grid(. ~ fips) +
  xlab("Year") +
  ylab("Vehicle PM25 Pollution in tons") +
  theme_bw()+
  ggtitle("Total Annual PM25 Vehicle Emissions for Los Angeles (06037) and Baltimore (24510)")


# write the png

dev.copy(png, file = "plot6.png")
dev.off()
