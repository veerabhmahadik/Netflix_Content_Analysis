# Streaming Analytics: A Deep Dive Using SQL![image](https://github.com/user-attachments/assets/12a4989b-638a-425d-a3d2-069575ce0673)


## 📌 Project Overview
This project focuses on analyzing Netflix's movie and TV show dataset using **PostgreSQL 17**. The objectives include:
- **Cleaning and structuring data** for better query performance.
- **Understanding content distribution** by country, genre, and release year.
- **Identifying top actors and directors** based on content production.


## 🛠️ Software Requirements
To run this project, you need:
- **PostgreSQL 17**
- **pgAdmin 4** (for query execution and database management)
- **SQL Shell (psql)** (optional)

---

The dataset was downloaded from **Kaggle**:  
🔗 [Netflix Dataset - Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

Refer to Schemas.sql for the table schema.

---

# 🧹 Data Cleaning Process

To ensure **data consistency, accuracy, and better query performance**, the following transformations were applied:

- **Standardizing `date_added` column** → Reformatted dates to maintain uniformity.
- **Fixing incorrect `rating` values** → Removed invalid ratings that were mistakenly recorded as duration.
- **Cleaning `listed_in` (Genre) column** → Removed unnecessary trailing commas to improve filtering.
- **Removing special characters from `description`** → Ensured better text processing for content categorization.
- **Handling inconsistent `country` names** → Removed leading/trailing commas to avoid duplicate country names.

By performing these **data cleaning** steps, the dataset became more **structured, accurate, and easier to query for insights**.

---
# 📊 Data Analysis Insights

This analysis provides a **holistic understanding** of Netflix’s content trends and helps improve its recommendation system. The key insights extracted include:

## 📌 Understanding Netflix's Content Library
- Examining the distribution of **movies vs. TV shows**.
- Analyzing the most common **content ratings**.
- Identifying **top content-producing countries**.

## 🎭 Actor and Director Popularity
- Finding the **top actors** with the most appearances in Netflix's content library.
- Ranking **directors** based on their contributions to Netflix’s catalog.

## 🔍 Enhancing Content Recommendations
- Categorizing content based on **violent or sensitive keywords** to enhance **content filtering and parental controls**.
- Analyzing **content trends over the years** to understand **which genres are gaining popularity**.
- **Identifying key actors** in specific countries, helping Netflix **localize recommendations**.

By leveraging these insights, Netflix can **better structure its content offerings, improve user engagement, and enhance its recommendation engine**.

---

# 🎯 How This Analysis Improves Netflix Recommendations

By leveraging insights from this analysis, Netflix can enhance its recommendation system in the following ways:

## ✅ Better Personalization  
Understanding **which actors, genres, and countries** drive the most content helps **improve recommendation algorithms** by suggesting content that aligns with users’ interests.

## 🏷️ Improved Content Tagging  
By categorizing content based on **themes (e.g., violent keywords, romantic comedies, psychological thrillers, etc.)**, Netflix can **better label content** to personalize recommendations.

## 🌍 Market Expansion Strategies  
Identifying **top-producing countries and directors** helps Netflix **invest in future productions strategically**, ensuring content localization for different markets.

## 👨‍👩‍👧‍👦 Enhanced Parental Controls  
Filtering content based on **potentially sensitive descriptions** allows for **better age-based restrictions** and **safer content recommendations** for younger audiences.

By implementing these insights, **Netflix can improve user engagement, increase content discoverability, and optimize content strategies for a global audience**.

