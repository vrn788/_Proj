# Digital Divide and Economic Dynamics

## Brief Description
This project explores the intricate relationships between internet usage, educational disparities, and economic growth across various regions. Utilizing World Bank data, I aim to understand how digital access and educational attainment influence economic development, with a focus on identifying actionable insights for policy-making.

## Author Information and Contact
- **Name: Varun Ramakrishnan
- **Email:** ramakr_v1@denison.edu
- **GitHub Username:** vrn788

## Prerequisites
- **Software Needed:**
  - Python (version 3.8 or later) or R (version 4.0 or later).
- **Libraries/Packages:**
  - Python: pandas, scikit-learn, statsmodels, matplotlib, seaborn.
  - R: ggplot2, plm, lme4, dplyr, tidyr.


## Data
The analysis is based on data from the World Bank, focusing on indicators related to internet usage, educational attainment, and GDP growth. Key variables include:
- GDP growth (annual %)
- Internet use (% of population)
- Primary completion rate, total (% of relevant age group)

**Data Citations/URLs:**
- World Bank Open Data: https://data.worldbank.org/




```markdown
# Economic Development and Digital Divide Analysis

  
### Installation
1. **Install R and RStudio**: Ensure you have R and RStudio installed on your computer. If not, download and install them from [CRAN](https://cran.r-project.org/) and [RStudio](https://www.rstudio.com/products/rstudio/download/), respectively.
2. **Clone the Repository**: Clone this GitHub repository to your local machine using `git clone <repository-url>`.
3. **Install Required R Packages**: Open RStudio, set your working directory to the cloned repository, and run the following command to install the necessary packages:
   ```r
   install.packages(c("WDI", "tidyverse"))
   ```

## Data
The analysis leverages publicly available data from the World Bank, focusing on indicators like GDP growth, internet usage, education expenditure, literacy rate, and access to electricity. The raw data is downloaded and processed through scripts available in the repository.

- **Source**: [World Bank Open Data](https://data.worldbank.org/)

## Repository Structure
- `raw_data/`: Directory for storing the raw data files.
- `processed_data/`: Contains cleaned and transformed data ready for analysis.
- `scripts/`:
  - `01_data_download.R`: Downloads datasets from the World Bank.
  - `02_data_cleaning.R`: Cleans the raw data.
  - `03_data_transformation.R`: Transforms the cleaned data for analysis.
  - `04_exploratory_data_analysis.Rmd`: Conducts exploratory data analysis.
  - `05_statistical_analysis.R`: Performs statistical testing and modeling.
- `outputs/figures/`: Stores generated plots and graphs.
- `outputs/models/`: Saves serialized models.

## Running the Analysis
To replicate the analysis:
1. Run `01_data_download.R` to fetch the raw data.
2. Execute `02_data_cleaning.R` followed by `03_data_transformation.R` for data preprocessing.
3. Open and run `04_exploratory_data_analysis.Rmd` and `05_statistical_analysis.R` for the main analysis.

## Contributing
Contributions to this project are welcome. Please refer to CONTRIBUTING.md for guidelines.

## License

```

Be sure to replace placeholders like `[Your Name]`, `[your.email@example.com]`, and `[GitHub Repository URL]` with your actual information. This README template provides a comprehensive guide to your project, making it accessible for others to understand your research and replicate your analysis.
