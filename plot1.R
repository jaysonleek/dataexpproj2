# Jayson Leek

# Coursera Exploratory Data Project2

# Plot1

# Aggregate and summarize the data to get the yearly total emissions. I used 
# the group_by and summarize functions from dplyr

library(dplyr)

pmgroup <- PM25 %>% 
  group_by(year) %>% 
  summarize(total = sum(Emissions))

# set some reasonable marks for the axis ticks
axismarks <- c(4000000, 5000000, 6000000, 7000000, options(scipen = 10))

# plot the plot
with(pmgroup, 
     plot(x = year, 
          y = total, 
          xlab = "Year", 
          ylab = "PM25 Pollution in Tons", 
          main = "Total Annual PM25 Emissions (All Sources) USA by Year",
          col = "navyblue", 
          lwd = 4))

# add those axis ticks
axis(2, at = axismarks, labels = axismarks)

# write the png
dev.copy(png, file = "plot1.png")
dev.off()

