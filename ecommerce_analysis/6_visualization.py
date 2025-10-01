# RFM Segments Plot
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load RFM data
rfm_data = pd.DataFrame([
    {"customer_segment": "Others", "num_customers": 3605, "revenue": 7927521.74, "pct_revenue": 88.96},
    {"customer_segment": "Loyal Customers", "num_customers": 295, "revenue": 548319.92, "pct_revenue": 6.15},
    {"customer_segment": "Big Spenders", "num_customers": 157, "revenue": 348650.12, "pct_revenue": 3.91},
    {"customer_segment": "At Risk / Lost", "num_customers": 276, "revenue": 64809.49, "pct_revenue": 0.73},
    {"customer_segment": "Champions", "num_customers": 5, "revenue": 22106.63, "pct_revenue": 0.25},
])

# Plot RFM Segments by Revenue Contribution
plt.figure(figsize=(8,5))
sns.barplot(x="customer_segment", y="pct_revenue", data=rfm_data, palette="viridis")
plt.title("Revenue Contribution by Customer Segment (RFM)", fontsize=14)
plt.ylabel("% of Revenue")
plt.xlabel("Customer Segment")
plt.xticks(rotation=30, ha="right")
plt.tight_layout()
plt.show()

# Customer Retention Heatmap
import matplotlib.pyplot as plt
import seaborn as sns

from google.colab import files
import pandas as pd

# Load Dataset
uploaded = files.upload()

df = pd.read_csv("5_retention_data.csv")
df.head()


# Pivot table for retention heatmap
cohort_pivot = df.pivot_table(
    index="cohort_month",
    columns="cohort_index",
    values="retention_rate"
)

# Plot heatmap
plt.figure(figsize=(12, 8))
sns.heatmap(cohort_pivot, annot=True, fmt=".1f", cmap="Blues", cbar_kws={'label': 'Retention Rate (%)'})
plt.title("Customer Retention by Cohort (Monthly)", fontsize=14)
plt.xlabel("Cohort Index (Months Since First Purchase)")
plt.ylabel("Cohort Month")
plt.tight_layout()
plt.show()