library(ggplot2)
library(dplyr)
library(hms)

df1 <- read.csv("/Users/GreenTea/Projects/garmin-run-data/data/Run Summary Data.csv", header = TRUE, stringsAsFactors = FALSE)

# Filter activities to running, trail running, and treadmill running
df1 %>% filter(Activity.Type == c("Running","Trail Running","Treadmill Running"))

# Format Date and Time to true date/time
df1$Date <- as.Date(df1$Date)
df1$Time <- as_hms(df1$Time)

# Format Elev.Gain to numeric
df1$Elev.Gain <- as.numeric(df1$Elev.Gain)

# Format Avg.Pace to POSIXct
df1$Avg.Pace <- as.POSIXct(strptime(df1$Avg.Pace, format = "%M:%S"))
df1 %>% mutate(df1, elev_gain_per_mile = Elev.Gain / Distance)
str(df1$elev_gain_per_mile) #Need to remove or skip NA's

# Create box and whisker plots for HR and Avg.Pace by Activity.Type
df1 %>% ggplot(aes(x = Activity.Type, y = Avg.HR)) + geom_boxplot()

# Create scatter plot of HR vs. Pace, colored by type of run
df1 %>% ggplot(aes(x = Avg.Pace, y = Avg.HR, color = Activity.Type)) + geom_jitter() + scale_x_datetime(date_labels = "%M:%S")
#how do I change the x-axis to be cleaner?
#pace is discrete currently, can I change to continuous? 

# Commented out bar plot for now
 df1 %>% ggplot(aes(x = Activity.Type, y = elev_gain_per_mile)) + geom_bar()
