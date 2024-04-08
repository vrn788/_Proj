# Load necessary libraries
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
library(ggridges)
library(plotly)
library(readr) 
library(tidyverse)
library(RColorBrewer)

install.packages("GGally")
library(GGally)


# Load the data
internet_usage <- read_excel("internetuse.xls")
head(internet_usage)

# Clean the data - assuming the first three columns are country info and the rest are years
internet_usage_long <- internet_usage %>%
  pivot_longer(cols = -c(CountryName, CountryCode, IndicatorName), names_to = "Year", values_to = "Internet_Usage") %>%
  mutate(Year = as.numeric(Year)) # Convert Year to numeric if it's not already

# Compute summary statistics
summary_stats <- internet_usage_long %>%
  group_by(CountryName) %>%
  filter(!is.na(Internet_Usage)) %>% # Ensure NA values are removed before computation
  summarise(Mean_Usage = mean(Internet_Usage),
            SD_Usage = sd(Internet_Usage),
            CAGR = (last(Internet_Usage) / first(Internet_Usage))^(1/(max(Year)-min(Year))) - 1)
head(summary_stats)
head(internet_usage)
print(summary_stats)

# Trend analysis for each country - the group_by should refer to 'CountryName'
cagr_by_country <- internet_usage_long %>%
  group_by(CountryName) %>%
  filter(!is.na(Internet_Usage)) %>% #ensuring NA values are removed before computation
  summarise(CAGR = (last(Internet_Usage) / first(Internet_Usage))^(1/(max(Year)-min(Year))) - 1)

# Visualization of internet usage trends for a given country
ggplot(data = internet_usage_long %>% filter(CountryName == "India"), 
       aes(x = Year, y = Internet_Usage)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = "Internet Usage Worldwide", x = "Year", y = "Internet Usage (%)")


# Filter the data for the countries of interest
filtered_data <- internet_usage_long %>% 
  filter(CountryName %in% countries_of_interest)

print(internet_usage_long)

Guyana_data <- internet_usage_long %>% 
  filter(CountryName == "Guyana")
sum(is.na(Guyana_data$internet_usage))


# Set the Internet Usage values for the specific years
guyana_data$internet_usage[Guyana_data$Year == 2018] <- 34.50

sum(is.na(Guyana_data$internet_usage))

ggplot(Guyana_data, aes(x = Year, y = Internet_Usage)) +
  geom_line() +
  geom_point() +
  labs(title = "Internet Usage in Guyana", x = "Year", y = "Internet Usage (%)")
print(internet_usage)
mean_value <- mean(Guyana_data$Internet_Usage[Guyana_data$year == 2018], na.rm = TRUE)




countries_of_interest <- c("Guyana", "Ethiopia", "France","China","India","United Kingdom") 


print(internet_usage)


ggplot(data = filtered_data, aes(x = Year, y = internet_Usage, color = CountryName)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = "Internet Usage Trend for Selected Countries", x = "Year", y = "internet Usage (%)")


# Assuming combined_data contains GDP, Income, and Internet_Usage columns
cor_results <- cor(combined_data[, c("GDP", "Income", "Internet_Usage")], use="complete.obs")
cor_results


# Multiple linear regression with GDP as the dependent variable
lm_results <- lm(GDP ~ Income + Internet_Usage, data=combined_data)
summary(lm_results)



p1 <- ggplot(combined_data, aes(x = Income, y = GDP)) +
  geom_point(alpha = 0.5) +  # Alpha for transparency if points overlap
  geom_smooth(method = "lm", color = "blue") +  # Add linear regression line
  labs(title = "GDP vs. Income",
       x = "Income",
       y = "GDP") +
  theme_minimal()

# Scatter plot for GDP vs. Internet Usage
p2 <- ggplot(combined_data, aes(x = Internet_Usage, y = GDP)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "red") +  # Add linear regression line
  labs(title = "GDP vs. Internet Usage",
       x = "Internet Usage",
       y = "GDP") +
  theme_minimal()

# Print the plots
print(p1)
print(p2)






# 3D scatter plot for GDP, Income, and Internet Usage
plot_ly(combined_data, x = ~Income, y = ~Internet_Usage, z = ~GDP, type = 'scatter3d', mode = 'markers') %>%
  layout(title = "3D Scatter Plot of GDP, Income, and Internet Usage",
         scene = list(xaxis = list(title = 'Income'),
                      yaxis = list(title = 'Internet Usage (%)'),
                      zaxis = list(title = 'GDP')))


# Merge the datasets on 'CountryName' and 'Year'
combined_data <- gdp_data_long %>%
  inner_join(income_data_long, by = c("CountryName", "Year")) %>%
  inner_join(internet_usage_long, by = c("CountryName", "Year"))

# Create a 3D scatter plot with country labels
plot_ly(combined_data, x = ~Income, y = ~Internet_Usage, z = ~GDP, 
        type = 'scatter3d', mode = 'markers', 
        text = ~CountryName,  # Add country names as hover text
        marker = list(size = 5)) %>%
  layout(title = "3D Scatter Plot of GDP, Income, and Internet Usage with Country Labels",
         scene = list(xaxis = list(title = 'Income'),
                      yaxis = list(title = 'Internet Usage'),
                      zaxis = list(title = 'GDP')))


# Define the countries of interest
countries_of_interest <- c("Guyana", "Ethiopia", "France", "China", "India", "United Kingdom")

# Assuming you've already merged the datasets into combined_data as before
combined_data <- combined_data %>%
  filter(CountryName %in% countries_of_interest)

# Now create a 3D scatter plot for these countries
plot_ly(combined_data, x = ~Income, y = ~Internet_Usage, z = ~GDP, 
        type = 'scatter3d', mode = 'markers', 
        text = ~CountryName,  # Add country names as hover text
        marker = list(size = 5)) %>%
  layout(title = "3D Scatter Plot of GDP, Income, and Internet Usage for Selected Countries",
         scene = list(xaxis = list(title = 'Income'),
                      yaxis = list(title = 'Internet Usage'),
                      zaxis = list(title = 'GDP')))






# Read in the GDP data
gdp_data <- read_csv("gdp.csv")

# Check the column names
names(gdp_data)



# Specify the countries of interest
countries_of_interest <- c("Guyana", "Ethiopia", "France", "China", "India", "United Kingdom")

# Filter the data to only include the countries of interest
filtered_data <- gdp_data %>%
  filter(CountryName %in% countries_of_interest)

# Convert the data to long format
data_long <- filtered_data %>%
  pivot_longer(cols = -c(CountryName, CountryCode), names_to = "Year", values_to = "Value")

# Convert the Year column to numeric
data_long$Year <- as.numeric(gsub("X", "", data_long$Year))

# Create the plot
ggplot(data = data_long, aes(x = Year, y = Value, color = CountryName)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = " GDP Trend for Selected Countries",
       x = "Year",
       y = "Value",
       color = "Country")





# Convert the data from wide to long format
gdp_data_long <- gdp_data %>%
  pivot_longer(
    cols = -c(CountryName, CountryCode), # Exclude the country name and code columns
    names_to = "Year",
    values_to = "GDP"
  ) %>%
  mutate(
    Year = as.numeric(Year), # Ensure Year is numeric for plotting
    GDP = as.numeric(GDP) # Ensure GDP is numeric for plotting
  )

# Plotting GDP trends for all countries
ggplot(data = gdp_data_long, aes(x = Year, y = GDP, color = CountryName)) +
  geom_line() + # Add lines to connect points for each country
  geom_point() + # Add points to mark the actual data points
  theme_minimal() +
  labs(title = "GDP Trend for All Countries",
       x = "Year",
       y = "GDP (in USD)",
       color = "Country") +
  theme(legend.position = "none") # Hide the legend to avoid clutter


# Assuming your GDP data is already loaded and in long format
gdp_data_long <- read_csv("gdp.csv") %>%
  pivot_longer(cols = -c(CountryName, CountryCode), names_to = "Year", values_to = "GDP") %>%
  mutate(Year = as.numeric(Year), GDP = as.numeric(GDP))

# Get a list of unique countries
country_names <- unique(gdp_data_long$CountryName)

# Generate a color palette
num_colors <- length(country_names)
colors <- brewer.pal(min(num_colors, 12), "Set3")  # 'Set3' is chosen for distinct colors, max is 12 for Set3

# If there are more countries than colors in the palette, use a different approach to generate enough colors
if (num_colors > 12) {
  colors <- colorRampPalette(brewer.pal(12, "Set3"))(num_colors)
}

# Plotting GDP trends for all countries with the generated color palette
ggplot(data = gdp_data_long, aes(x = Year, y = GDP, color = CountryName)) +
  geom_line() +
  geom_point() +
  scale_color_manual(values = colors) +
  theme_minimal() +
  labs(title = "GDP Trend for All Countries",
       x = "Year",
       y = "GDP (in USD)",
       color = "Country") +
  theme(legend.position = "none") 


gdp_plot <- ggplot(gdp_data_long, aes(x = Year, y = GDP, color = CountryName)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = "GDP Trend for All Countries", x = "Year", y = "GDP($B)", color = "Country")

# Convert the ggplot object to a plotly object for interactivity
gdp_plotly <- ggplotly(gdp_plot)

# Display the plotly object
gdp_plotly


# Determine the minimum GDP value to set the lower limit appropriately
min_gdp <- min(gdp_data_long$GDP, na.rm = TRUE)

# Create the ggplot object with adjusted y-axis limits
gdp_plot <- ggplot(gdp_data_long, aes(x = Year, y = GDP, color = CountryName)) +
  geom_line() +
  geom_point() +
  expand_limits(y = min_gdp * 0.9) +  # Slightly expand the lower limit for better visibility
  theme_minimal() +
  labs(title = "GDP Trend for All Countries", x = "Year", y = "GDP", color = "Country")

# Convert to plotly for interactivity
gdp_plotly <- ggplotly(gdp_plot)

# Display the plotly object
gdp_plotly



ggplot(internet_usage_long, aes(x = Internet_Usage, y = factor(Year), fill = factor(Year))) +
  geom_density_ridges() +
  scale_fill_viridis_d() +
  labs(title = "Distribution of Internet Usage Over Time", x = "Internet Usage (%)", y = "Year") +
  theme_ridges()

library(ggridges)

# Adjust the scale argument to increase space between ridges
ggplot(internet_usage_long, aes(x = Internet_Usage, y = factor(Year), fill = factor(Year))) +
  geom_density_ridges(scale = 0.9) +  # Try different values for scale to reduce overlap
  scale_fill_viridis_d() +
  labs(title = "Distribution of Internet Usage Over Time", x = "Internet Usage (%)", y = "Year") +
  theme_ridges(grid = TRUE) + # You can turn on or off the grid for betterx readability
  theme(legend.position = "none") # Optionally hide the legend if not needed


# Load and prepare the data
internet_usage <- read_excel("internetuse.xls")
internet_usage_long <- internet_usage %>%
  pivot_longer(cols = -c(CountryName, CountryCode, IndicatorName), names_to = "Year", values_to = "Internet_Usage") %>%
  mutate(Year = as.numeric(Year))

# Compute summary statistics
summary_stats <- internet_usage_long %>%
  group_by(CountryName) %>%
  filter(!is.na(Internet_Usage)) %>%
  summarise(
    Mean_Usage = mean(Internet_Usage),
    SD_Usage = sd(Internet_Usage),
    CAGR = (last(Internet_Usage) / first(Internet_Usage))^(1/(max(Year)-min(Year))) - 1
  )

# Visualize trends with linear regression lines for selected countries
countries_of_interest <- c("Guyana", "Ethiopia", "Ghana", "China", "Japan", "United Kingdom")
filtered_data <- internet_usage_long %>%
  filter(CountryName %in% countries_of_interest)

ggplot(filtered_data, aes(x = Year, y = Internet_Usage, color = CountryName)) +
  geom_line() +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +  # Add linear trend lines
  theme_minimal() +
  labs(title = "Internet Usage Trend for Selected Countries with Trend Lines", x = "Year", y = "Internet Usage (%)")



# Import the GDP data from the CSV file
gdp_data <- read_csv("GDP.csv")

# Convert the data from wide to long format
gdp_data_long <- gdp_data %>%
  pivot_longer(
    cols = -c(CountryName, CountryCode), # Exclude the country name and code columns
    names_to = "Year",
    values_to = "GDP"
  ) %>%
  mutate(
    Year = as.numeric(Year),
    GDP = as.numeric(GDP)
  )

# Calculate CAGR for each country
gdp_cagr <- gdp_data_long %>%
  group_by(CountryName) %>%
  filter(!is.na(GDP)) %>% # Ensure NA values are removed before computation
  summarise(
    Start_GDP = first(GDP),
    End_GDP = last(GDP),
    Years = n(),
    CAGR = (End_GDP/Start_GDP)^(1/(Years-1)) - 1
  ) %>%
  ungroup() %>%
  arrange(desc(CAGR))

# Top performers
top_performers <- gdp_cagr %>%
  top_n(15, CAGR)

# Worst performers
worst_performers <- gdp_cagr %>%
  top_n(-15, CAGR)

# Output the top and worst performers
print(top_performers)
print(worst_performers)


# Calculate CAGR for each country
gdp_cagr <- gdp_data_long %>%
  group_by(CountryName) %>%
  summarise(
    Start_GDP = first(GDP, order_by = Year),
    End_GDP = last(GDP, order_by = Year),
    Years = max(Year) - min(Year),
    CAGR = (End_GDP / Start_GDP)^(1/Years) - 1
  ) %>%
  ungroup() %>%
  arrange(desc(CAGR))

print(cagr_by_country)


print(gdp_cagr, n = Inf)

# Select top and worst performers
top_performers <- gdp_cagr %>%
  top_n(10, CAGR)

worst_performers <- gdp_cagr %>%
  top_n(-10, CAGR)

# Combine top and worst performers
performers <- bind_rows(
  top_performers %>%
    mutate(Category = "Top Performers"),
  worst_performers %>%
    mutate(Category = "Worst Performers")
)

# Plotting the CAGR using ggplot2
ggplot(performers, aes(x = reorder(CountryName, CAGR), y = CAGR, fill = Category)) +
  geom_col() +
  coord_flip() + # Flips the x and y axes
  theme_minimal() +
  labs(
    title = "Top and Worst Performing Countries by GDP CAGR",
    x = "Country",
    y = "CAGR",
    fill = "Category"
  ) +
  scale_fill_manual(values = c("Top Performers" = "blue", "Worst Performers" = "red"))







# Read the income data
income_data <- read_csv("income.csv")



income_data_long <- income_data %>%
  pivot_longer(cols = -c(CountryName, CountryCode), names_to = "Year", values_to = "Income") %>%
  mutate(Year = as.numeric(Year), Income = as.numeric(Income))

# Check the structure of the resulting long data
print(head(income_data_long))

ggplot(income_data_long, aes(x = Year, y = Income, group = CountryName)) +
  geom_line() +
  scale_y_continuous(limits = c(min_income_value, max_income_value)) +
  labs(title = "Income Over Time", x = "Year", y = "Income") +
  theme_minimal()
# Filtering for specific countries to inspect their trends
specific_countries <- c("Guyana", "Ethiopia", "Ghana", "China", "Japan", "United Kingdom") # Replace with actual country names
filtered_data <- income_data_long %>% 
  filter(CountryName %in% specific_countries)

# Plotting the filtered data
ggplot(filtered_data, aes(x = Year, y = Income, color = CountryName)) +
  geom_line() +
  labs(title = "Income Trends for Specific Countries", x = "Year", y = "Income($)") +
  theme_minimal()



# Read in the education expenditure data
education_data <- read_csv("educationspend.csv")

# Convert education data from wide to long format
education_long <- education_data %>%
  pivot_longer(cols = -c(CountryName, CountryCode), # Excluding 'CountryName' and 'CountryCode'
               names_to = "Year", 
               values_to = "EducationExpenditure") %>%
  # Convert the 'Year' column to numeric
  mutate(Year = as.numeric(Year))

# Merge education data with the combined_data
# Assuming combined_data is your previously merged data with 'CountryName' and 'Year'
full_data <- combined_data %>%
  inner_join(education_long, by = c("CountryName", "Year"))

# Check the head of the full_data to ensure it's merged correctly
head(full_data)
print(full_data)


full_data <- combined_data %>%
  inner_join(education_long, by = c("CountryName", "Year"))

# Conduct a correlation analysis on the combined dataset
correlation_matrix <- full_data %>%
  select(GDP, Income, Internet_Usage, EducationExpenditure) %>%
  cor(use = "complete.obs")

# Perform a multiple regression analysis including all predictors
multivar_regression <- lm(GDP ~ Income + Internet_Usage + EducationExpenditure, data = full_data)
regression_summary <- summary(multivar_regression)

# Visualize the relationships using a pairs plot
pairs_plot <- ggpairs(full_data, 
                      columns = c("GDP", "Income", "Internet_Usage", "EducationExpenditure"), 
                      title = "Pairs Plot of GDP, Income, Internet Usage, and Education Expenditure")

# Compare the mean EducationExpenditure for the countries of interest
education_comparison <- full_data %>%
  filter(CountryName %in% countries_of_interest) %>%
  group_by(CountryName) %>%
  summarize(MeanEducationExpenditure = mean(EducationExpenditure, na.rm = TRUE))

# Bar plot for comparison
education_bar_plot <- ggplot(education_comparison, aes(x = CountryName, y = MeanEducationExpenditure, fill = CountryName)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "Mean Education Expenditure by Country", x = "Country", y = "Mean Education Expenditure (%)")

# Print the results and plots
print(correlation_matrix)
print(regression_summary)
print(pairs_plot)
print(education_bar_plot)



# Assuming the literacy rate data is saved as literacy_rate.csv
# Replace 'path_to_your_literacy_data.csv' with the actual path to the literacy rate CSV file
literacy_data <- read_csv("litgap.csv")

# Merge the literacy rate data with the combined dataset
# Make sure that the 'Year' column in both datasets is of the same data type (numeric)
full_data <- full_data %>%
  inner_join(literacy_data, by = c("CountryName" = "Country Name", "Year"))

# Now full_data contains GDP, Income, Internet Usage, EducationExpenditure, and literacy rates
# Conduct correlation analysis with the new literacy rate data
correlation_matrix <- full_data %>%
  select(GDP, Income, Internet_Usage, EducationExpenditure, female, male) %>%
  cor(use = "complete.obs")

# You might also want to look at gender differences in literacy rates
# For example, calculate the gender gap in literacy rates
full_data <- full_data %>%
  mutate(LiteracyRateGap = male - female)

# Compare literacy rates by country
literacy_comparison <- full_data %>%
  select(CountryName, female, male, LiteracyRateGap) %>%
  pivot_longer(cols = c(female, male), names_to = "Gender", values_to = "LiteracyRate")

# Print the results and plots
print(correlation_matrix)





