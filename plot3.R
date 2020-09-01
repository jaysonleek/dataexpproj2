# Jayson Leek

# Coursera Exploratory Data Project2

# Plot3

library(dplyr)
library(ggplot2)

# aggregate by data type

BaltiGroup2 <- Baltimore %>%
  group_by(year, type) %>% 
  summarize(total = sum(Emissions))

# plot the data grouped by type of emitter

ggplot(data = BaltiGroup2, aes(year, total)) +
  geom_point(color = "navyblue",
             size = 8,
             alpha = 1/2) + 
  facet_grid(. ~ type) +
  xlab("Year") +
  ylab("PM25 Pollution in tons") +
  theme_bw()+
  ggtitle("Total Annual PM25 Emissions in Baltimore by source")


# write the png
dev.copy(png, file = "plot3.png")
dev.off()

