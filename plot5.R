# Jayson Leek

# Coursera Exploratory Data Project2

# Plot5

Vehicles <- PM25[PM25$type == "ON-ROAD" & PM25$fips == "24510", ]

# aggregate the data by year

VehiclesGroup <- Vehicles %>% 
  group_by(year) %>% 
  summarize(total = sum(Emissions))

with(VehiclesGroup,
     plot(x = year,
          y = total,
          xlab = "Year", 
          ylab = "Vehicle PM25 Pollution in Tons", 
          main = "Total Annual PM25 Emissions from Vehicles in Baltimore by Year",
          col = "navyblue", 
          lwd = 4))

dev.copy(png, file = "plot5.png")
dev.off()

