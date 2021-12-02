require(ggplot2)
require(ggpubr)
library(lubridate)
require(RColorBrewer)

# the following code reads in the files and cleans for merging

###Interventions applied for full length of simulation
### HIGH continuous ####
HIGH_CNR_FRD <- read.csv("HIGH_run_CNR.csv") # CNR
HIGH_shel_FRD <- read.csv("HIGH_run_sheltering.csv") # sheltering
HIGH_cull_FRD <- read.csv("HIGH_run_culling.csv") # culling
HIGH_RO_FRD <- read.csv("HIGH_responsible_own.csv") # Responsible ownership
HIGH_CNR_SHEL_FRD <- read.csv("HIGH_run_CNR_SHEL.csv") # Combined sheltering and CNR
HIGH_CNR_RO_FRD <- read.csv("HIGH_run_CNR_RO.csv") # Combined responsible ownership and CNR

HIGH_CNR_FRD$Ow <- NULL
HIGH_CNR_FRD$Sh <- NULL
HIGH_CNR_FRD$St <- NULL
HIGH_CNR_FRD$Ne <- NULL
HIGH_CNR_FRD$sheltering_I <- NULL
HIGH_CNR_FRD$culling_I <- NULL
HIGH_CNR_FRD$CNR_I <- NULL

HIGH_cull_FRD$Ow <- NULL
HIGH_cull_FRD$Sh <- NULL
HIGH_cull_FRD$Ne <- NULL
HIGH_cull_FRD$sheltering_I <- NULL
HIGH_cull_FRD$culling_I <- NULL
HIGH_cull_FRD$CNR_I <- NULL
names(HIGH_cull_FRD)[2] <- "FRD"

HIGH_shel_FRD$Ow <- NULL
HIGH_shel_FRD$Sh <- NULL
HIGH_shel_FRD$Ne <- NULL
HIGH_shel_FRD$sheltering_I <- NULL
HIGH_shel_FRD$culling_I <- NULL
HIGH_shel_FRD$CNR_I <- NULL
names(HIGH_shel_FRD)[2] <- "FRD"

HIGH_RO_FRD$Ow <- NULL
HIGH_RO_FRD$Sh <- NULL
HIGH_RO_FRD$Ne <- NULL
HIGH_RO_FRD$sheltering_I <- NULL
HIGH_RO_FRD$culling_I <- NULL
HIGH_RO_FRD$CNR_I <- NULL
names(HIGH_RO_FRD)[2] <- "FRD"

HIGH_CNR_SHEL_FRD$Ow <- NULL
HIGH_CNR_SHEL_FRD$Sh <- NULL
HIGH_CNR_SHEL_FRD$Ne <- NULL
HIGH_CNR_SHEL_FRD$St <- NULL
HIGH_CNR_SHEL_FRD$sheltering_I <- NULL
HIGH_CNR_SHEL_FRD$culling_I <- NULL
HIGH_CNR_SHEL_FRD$CNR_I <- NULL

HIGH_CNR_RO_FRD$Ow <- NULL
HIGH_CNR_RO_FRD$Sh <- NULL
HIGH_CNR_RO_FRD$Ne <- NULL
HIGH_CNR_RO_FRD$St <- NULL
HIGH_CNR_RO_FRD$sheltering_I <- NULL
HIGH_CNR_RO_FRD$culling_I <- NULL
HIGH_CNR_RO_FRD$CNR_I <- NULL

HIGH_CNR_FRD[, "Intervention"] <- "CNR"
HIGH_cull_FRD[, "Intervention"] <- "Culling"
HIGH_shel_FRD[, "Intervention"] <- "Sheltering"
HIGH_RO_FRD[, "Intervention"] <- "Responsible ownership"
HIGH_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
HIGH_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

# Combine all datasets

HIGH_full_data <- rbind(HIGH_CNR_FRD, HIGH_cull_FRD, HIGH_shel_FRD, HIGH_RO_FRD, HIGH_CNR_SHEL_FRD, HIGH_CNR_RO_FRD)
# remove files
rm(HIGH_CNR_FRD)
rm(HIGH_CNR_RO_FRD)
rm(HIGH_CNR_SHEL_FRD)
rm(HIGH_cull_FRD)
rm(HIGH_RO_FRD)
rm(HIGH_shel_FRD)

### MED continuous####
MED_CNR_FRD <- read.csv("MED_run_CNR.csv")
MED_shel_FRD <- read.csv("MED_run_sheltering.csv")
MED_cull_FRD <- read.csv("MED_run_culling.csv")
MED_RO_FRD <- read.csv("MED_responsible_own.csv") # Responsible ownership
MED_CNR_SHEL_FRD <- read.csv("MED_run_CNR_SHEL.csv") # Combined sheltering and CNR
MED_CNR_RO_FRD <- read.csv("MED_run_CNR_RO.csv") # Combined responsible ownership and CNR

MED_CNR_FRD$Ow <- NULL
MED_CNR_FRD$Sh <- NULL
MED_CNR_FRD$St <- NULL
MED_CNR_FRD$Ne <- NULL
MED_CNR_FRD$sheltering_I <- NULL
MED_CNR_FRD$culling_I <- NULL
MED_CNR_FRD$CNR_I <- NULL

MED_cull_FRD$Ow <- NULL
MED_cull_FRD$Sh <- NULL
MED_cull_FRD$Ne <- NULL
MED_cull_FRD$sheltering_I <- NULL
MED_cull_FRD$culling_I <- NULL
MED_cull_FRD$CNR_I <- NULL
names(MED_cull_FRD)[2] <- "FRD"

MED_shel_FRD$Ow <- NULL
MED_shel_FRD$Sh <- NULL
MED_shel_FRD$Ne <- NULL
MED_shel_FRD$sheltering_I <- NULL
MED_shel_FRD$culling_I <- NULL
MED_shel_FRD$CNR_I <- NULL
names(MED_shel_FRD)[2] <- "FRD"

MED_RO_FRD$Ow <- NULL
MED_RO_FRD$Sh <- NULL
MED_RO_FRD$Ne <- NULL
MED_RO_FRD$sheltering_I <- NULL
MED_RO_FRD$culling_I <- NULL
MED_RO_FRD$CNR_I <- NULL
names(MED_RO_FRD)[2] <- "FRD"

MED_CNR_SHEL_FRD$Ow <- NULL
MED_CNR_SHEL_FRD$Sh <- NULL
MED_CNR_SHEL_FRD$Ne <- NULL
MED_CNR_SHEL_FRD$St <- NULL
MED_CNR_SHEL_FRD$sheltering_I <- NULL
MED_CNR_SHEL_FRD$culling_I <- NULL
MED_CNR_SHEL_FRD$CNR_I <- NULL

MED_CNR_RO_FRD$Ow <- NULL
MED_CNR_RO_FRD$Sh <- NULL
MED_CNR_RO_FRD$Ne <- NULL
MED_CNR_RO_FRD$St <- NULL
MED_CNR_RO_FRD$sheltering_I <- NULL
MED_CNR_RO_FRD$culling_I <- NULL
MED_CNR_RO_FRD$CNR_I <- NULL

MED_CNR_FRD[, "Intervention"] <- "CNR"
MED_cull_FRD[, "Intervention"] <- "Culling"
MED_shel_FRD[, "Intervention"] <- "Sheltering"
MED_RO_FRD[, "Intervention"] <- "Responsible ownership"
MED_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
MED_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

# Combine all datasets

MED_full_data <- rbind(MED_CNR_FRD, MED_cull_FRD, MED_shel_FRD, MED_RO_FRD, MED_CNR_SHEL_FRD, MED_CNR_RO_FRD)
rm(MED_CNR_FRD)
rm(MED_CNR_RO_FRD)
rm(MED_CNR_SHEL_FRD)
rm(MED_cull_FRD)
rm(MED_RO_FRD)
rm(MED_shel_FRD)

### LOW continuous####
LOW_CNR_FRD <- read.csv("LOW_run_CNR.csv")
LOW_shel_FRD <- read.csv("LOW_run_sheltering.csv")
LOW_cull_FRD <- read.csv("LOW_run_culling.csv")
LOW_RO_FRD <- read.csv("LOW_responsible_own.csv") # Responsible ownership
LOW_CNR_SHEL_FRD <- read.csv("LOW_run_CNR_SHEL.csv") # Combined sheltering and CNR
LOW_CNR_RO_FRD <- read.csv("LOW_run_CNR_RO.csv") # Combined responsible ownership and CNR

LOW_CNR_FRD$Ow <- NULL
LOW_CNR_FRD$Sh <- NULL
LOW_CNR_FRD$St <- NULL
LOW_CNR_FRD$Ne <- NULL
LOW_CNR_FRD$sheltering_I <- NULL
LOW_CNR_FRD$culling_I <- NULL
LOW_CNR_FRD$CNR_I <- NULL

LOW_cull_FRD$Ow <- NULL
LOW_cull_FRD$Sh <- NULL
LOW_cull_FRD$Ne <- NULL
LOW_cull_FRD$sheltering_I <- NULL
LOW_cull_FRD$culling_I <- NULL
LOW_cull_FRD$CNR_I <- NULL
names(LOW_cull_FRD)[2] <- "FRD"

LOW_shel_FRD$Ow <- NULL
LOW_shel_FRD$Sh <- NULL
LOW_shel_FRD$Ne <- NULL
LOW_shel_FRD$sheltering_I <- NULL
LOW_shel_FRD$culling_I <- NULL
LOW_shel_FRD$CNR_I <- NULL
names(LOW_shel_FRD)[2] <- "FRD"

LOW_RO_FRD$Ow <- NULL
LOW_RO_FRD$Sh <- NULL
LOW_RO_FRD$Ne <- NULL
LOW_RO_FRD$sheltering_I <- NULL
LOW_RO_FRD$culling_I <- NULL
LOW_RO_FRD$CNR_I <- NULL
names(LOW_RO_FRD)[2] <- "FRD"

LOW_CNR_SHEL_FRD$Ow <- NULL
LOW_CNR_SHEL_FRD$Sh <- NULL
LOW_CNR_SHEL_FRD$Ne <- NULL
LOW_CNR_SHEL_FRD$St <- NULL
LOW_CNR_SHEL_FRD$sheltering_I <- NULL
LOW_CNR_SHEL_FRD$culling_I <- NULL
LOW_CNR_SHEL_FRD$CNR_I <- NULL

LOW_CNR_RO_FRD$Ow <- NULL
LOW_CNR_RO_FRD$Sh <- NULL
LOW_CNR_RO_FRD$Ne <- NULL
LOW_CNR_RO_FRD$St <- NULL
LOW_CNR_RO_FRD$sheltering_I <- NULL
LOW_CNR_RO_FRD$culling_I <- NULL
LOW_CNR_RO_FRD$CNR_I <- NULL

LOW_CNR_FRD[, "Intervention"] <- "CNR"
LOW_cull_FRD[, "Intervention"] <- "Culling"
LOW_shel_FRD[, "Intervention"] <- "Sheltering"
LOW_RO_FRD[, "Intervention"] <- "Responsible ownership"
LOW_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
LOW_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

# Combine all datasets

LOW_full_data <- rbind(LOW_CNR_FRD, LOW_cull_FRD, LOW_shel_FRD, LOW_RO_FRD, LOW_CNR_SHEL_FRD, LOW_CNR_RO_FRD)
rm(LOW_CNR_FRD)
rm(LOW_CNR_RO_FRD)
rm(LOW_CNR_SHEL_FRD)
rm(LOW_cull_FRD)
rm(LOW_RO_FRD)
rm(LOW_shel_FRD)

HIGH_full_data[, "Coverage"] <- "High"
MED_full_data[, "Coverage"] <- "Medium"
LOW_full_data[, "Coverage"] <- "Low"

continuous_df <- rbind(HIGH_full_data, MED_full_data, LOW_full_data)

rm(HIGH_full_data)
rm(MED_full_data)
rm(LOW_full_data)

### HIGH annual ####
pulse_HIGH_CNR_FRD <- read.csv("HIGH_run_CNR_pulse.csv")
pulse_HIGH_shel_FRD <- read.csv("HIGH_run_sheltering_pulse.csv")
pulse_HIGH_cull_FRD <- read.csv("HIGH_run_culling_pulse.csv")
pulse_HIGH_RO_FRD <- read.csv("HIGH_responsible_own.csv") # Responsible ownership
pulse_HIGH_CNR_SHEL_FRD <- read.csv("HIGH_run_CNR_SHEL_pulse.csv") # Combined sheltering and CNR
pulse_HIGH_CNR_RO_FRD <- read.csv("HIGH_run_CNR_RO_pulse.csv") # Combined responsible ownership and CNR

pulse_HIGH_CNR_FRD$Ow <- NULL
pulse_HIGH_CNR_FRD$Sh <- NULL
pulse_HIGH_CNR_FRD$St <- NULL
pulse_HIGH_CNR_FRD$Ne <- NULL
pulse_HIGH_CNR_FRD$sheltering_I <- NULL
pulse_HIGH_CNR_FRD$culling_I <- NULL
pulse_HIGH_CNR_FRD$CNR_I <- NULL

pulse_HIGH_cull_FRD$Ow <- NULL
pulse_HIGH_cull_FRD$Sh <- NULL
pulse_HIGH_cull_FRD$Ne <- NULL
pulse_HIGH_cull_FRD$sheltering_I <- NULL
pulse_HIGH_cull_FRD$culling_I <- NULL
pulse_HIGH_cull_FRD$CNR_I <- NULL
names(pulse_HIGH_cull_FRD)[2] <- "FRD"

pulse_HIGH_shel_FRD$Ow <- NULL
pulse_HIGH_shel_FRD$Sh <- NULL
pulse_HIGH_shel_FRD$Ne <- NULL
pulse_HIGH_shel_FRD$sheltering_I <- NULL
pulse_HIGH_shel_FRD$culling_I <- NULL
pulse_HIGH_shel_FRD$CNR_I <- NULL
names(pulse_HIGH_shel_FRD)[2] <- "FRD"

pulse_HIGH_RO_FRD$Ow <- NULL
pulse_HIGH_RO_FRD$Sh <- NULL
pulse_HIGH_RO_FRD$Ne <- NULL
pulse_HIGH_RO_FRD$sheltering_I <- NULL
pulse_HIGH_RO_FRD$culling_I <- NULL
pulse_HIGH_RO_FRD$CNR_I <- NULL
names(pulse_HIGH_RO_FRD)[2] <- "FRD"

pulse_HIGH_CNR_SHEL_FRD$Ow <- NULL
pulse_HIGH_CNR_SHEL_FRD$Sh <- NULL
pulse_HIGH_CNR_SHEL_FRD$Ne <- NULL
pulse_HIGH_CNR_SHEL_FRD$St <- NULL
pulse_HIGH_CNR_SHEL_FRD$sheltering_I <- NULL
pulse_HIGH_CNR_SHEL_FRD$culling_I <- NULL
pulse_HIGH_CNR_SHEL_FRD$CNR_I <- NULL

pulse_HIGH_CNR_RO_FRD$Ow <- NULL
pulse_HIGH_CNR_RO_FRD$Sh <- NULL
pulse_HIGH_CNR_RO_FRD$Ne <- NULL
pulse_HIGH_CNR_RO_FRD$St <- NULL
pulse_HIGH_CNR_RO_FRD$sheltering_I <- NULL
pulse_HIGH_CNR_RO_FRD$culling_I <- NULL
pulse_HIGH_CNR_RO_FRD$CNR_I <- NULL

pulse_HIGH_CNR_FRD[, "Intervention"] <- "CNR"
pulse_HIGH_cull_FRD[, "Intervention"] <- "Culling"
pulse_HIGH_shel_FRD[, "Intervention"] <- "Sheltering"
pulse_HIGH_RO_FRD[, "Intervention"] <- "Responsible ownership"
pulse_HIGH_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
pulse_HIGH_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

pulse_HIGH_full_data <- rbind(pulse_HIGH_CNR_FRD, pulse_HIGH_cull_FRD, pulse_HIGH_shel_FRD, pulse_HIGH_RO_FRD, pulse_HIGH_CNR_SHEL_FRD, pulse_HIGH_CNR_RO_FRD)

rm(pulse_HIGH_CNR_FRD)
rm(pulse_HIGH_CNR_RO_FRD)
rm(pulse_HIGH_CNR_SHEL_FRD)
rm(pulse_HIGH_cull_FRD)
rm(pulse_HIGH_RO_FRD)
rm(pulse_HIGH_shel_FRD)

### MED annual ####
pulse_MED_CNR_FRD <- read.csv("MED_run_CNR_pulse.csv")
pulse_MED_shel_FRD <- read.csv("MED_run_sheltering_pulse.csv")
pulse_MED_cull_FRD <- read.csv("MED_run_culling_pulse.csv")
pulse_MED_RO_FRD <- read.csv("MED_responsible_own.csv") # Responsible ownership
pulse_MED_CNR_SHEL_FRD <- read.csv("MED_run_CNR_SHEL_pulse.csv") # Combined sheltering and CNR
pulse_MED_CNR_RO_FRD <- read.csv("MED_run_CNR_RO_pulse.csv") # Combined responsible ownership and CNR

pulse_MED_CNR_FRD$Ow <- NULL
pulse_MED_CNR_FRD$Sh <- NULL
pulse_MED_CNR_FRD$St <- NULL
pulse_MED_CNR_FRD$Ne <- NULL
pulse_MED_CNR_FRD$sheltering_I <- NULL
pulse_MED_CNR_FRD$culling_I <- NULL
pulse_MED_CNR_FRD$CNR_I <- NULL

pulse_MED_cull_FRD$Ow <- NULL
pulse_MED_cull_FRD$Sh <- NULL
pulse_MED_cull_FRD$Ne <- NULL
pulse_MED_cull_FRD$sheltering_I <- NULL
pulse_MED_cull_FRD$culling_I <- NULL
pulse_MED_cull_FRD$CNR_I <- NULL
names(pulse_MED_cull_FRD)[2] <- "FRD"

pulse_MED_shel_FRD$Ow <- NULL
pulse_MED_shel_FRD$Sh <- NULL
pulse_MED_shel_FRD$Ne <- NULL
pulse_MED_shel_FRD$sheltering_I <- NULL
pulse_MED_shel_FRD$culling_I <- NULL
pulse_MED_shel_FRD$CNR_I <- NULL
names(pulse_MED_shel_FRD)[2] <- "FRD"

pulse_MED_RO_FRD$Ow <- NULL
pulse_MED_RO_FRD$Sh <- NULL
pulse_MED_RO_FRD$Ne <- NULL
pulse_MED_RO_FRD$sheltering_I <- NULL
pulse_MED_RO_FRD$culling_I <- NULL
pulse_MED_RO_FRD$CNR_I <- NULL
names(pulse_MED_RO_FRD)[2] <- "FRD"

pulse_MED_CNR_SHEL_FRD$Ow <- NULL
pulse_MED_CNR_SHEL_FRD$Sh <- NULL
pulse_MED_CNR_SHEL_FRD$Ne <- NULL
pulse_MED_CNR_SHEL_FRD$St <- NULL
pulse_MED_CNR_SHEL_FRD$sheltering_I <- NULL
pulse_MED_CNR_SHEL_FRD$culling_I <- NULL
pulse_MED_CNR_SHEL_FRD$CNR_I <- NULL

pulse_MED_CNR_RO_FRD$Ow <- NULL
pulse_MED_CNR_RO_FRD$Sh <- NULL
pulse_MED_CNR_RO_FRD$Ne <- NULL
pulse_MED_CNR_RO_FRD$St <- NULL
pulse_MED_CNR_RO_FRD$sheltering_I <- NULL
pulse_MED_CNR_RO_FRD$culling_I <- NULL
pulse_MED_CNR_RO_FRD$CNR_I <- NULL

pulse_MED_CNR_FRD[, "Intervention"] <- "CNR"
pulse_MED_cull_FRD[, "Intervention"] <- "Culling"
pulse_MED_shel_FRD[, "Intervention"] <- "Sheltering"
pulse_MED_RO_FRD[, "Intervention"] <- "Responsible ownership"
pulse_MED_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
pulse_MED_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

pulse_MED_full_data <- rbind(pulse_MED_CNR_FRD, pulse_MED_cull_FRD, pulse_MED_shel_FRD, pulse_MED_RO_FRD, pulse_MED_CNR_SHEL_FRD, pulse_MED_CNR_RO_FRD)
rm(pulse_MED_CNR_FRD)
rm(pulse_MED_CNR_RO_FRD)
rm(pulse_MED_CNR_SHEL_FRD)
rm(pulse_MED_cull_FRD)
rm(pulse_MED_RO_FRD)
rm(pulse_MED_shel_FRD)

### LOW annual ####
pulse_LOW_CNR_FRD <- read.csv("LOW_run_CNR_pulse.csv")
pulse_LOW_shel_FRD <- read.csv("LOW_run_sheltering_pulse.csv")
pulse_LOW_cull_FRD <- read.csv("LOW_run_culling_pulse.csv")
pulse_LOW_RO_FRD <- read.csv("LOW_responsible_own.csv") # Responsible ownership
pulse_LOW_CNR_SHEL_FRD <- read.csv("LOW_run_CNR_SHEL_pulse.csv") # Combined sheltering and CNR
pulse_LOW_CNR_RO_FRD <- read.csv("LOW_run_CNR_RO_pulse.csv") # Combined responsible ownership and CNR

pulse_LOW_CNR_FRD$Ow <- NULL
pulse_LOW_CNR_FRD$Sh <- NULL
pulse_LOW_CNR_FRD$St <- NULL
pulse_LOW_CNR_FRD$Ne <- NULL
pulse_LOW_CNR_FRD$sheltering_I <- NULL
pulse_LOW_CNR_FRD$culling_I <- NULL
pulse_LOW_CNR_FRD$CNR_I <- NULL

pulse_LOW_cull_FRD$Ow <- NULL
pulse_LOW_cull_FRD$Sh <- NULL
pulse_LOW_cull_FRD$Ne <- NULL
pulse_LOW_cull_FRD$sheltering_I <- NULL
pulse_LOW_cull_FRD$culling_I <- NULL
pulse_LOW_cull_FRD$CNR_I <- NULL
names(pulse_LOW_cull_FRD)[2] <- "FRD"

pulse_LOW_shel_FRD$Ow <- NULL
pulse_LOW_shel_FRD$Sh <- NULL
pulse_LOW_shel_FRD$Ne <- NULL
pulse_LOW_shel_FRD$sheltering_I <- NULL
pulse_LOW_shel_FRD$culling_I <- NULL
pulse_LOW_shel_FRD$CNR_I <- NULL
names(pulse_LOW_shel_FRD)[2] <- "FRD"

pulse_LOW_RO_FRD$Ow <- NULL
pulse_LOW_RO_FRD$Sh <- NULL
pulse_LOW_RO_FRD$Ne <- NULL
pulse_LOW_RO_FRD$sheltering_I <- NULL
pulse_LOW_RO_FRD$culling_I <- NULL
pulse_LOW_RO_FRD$CNR_I <- NULL
names(pulse_LOW_RO_FRD)[2] <- "FRD"

pulse_LOW_CNR_SHEL_FRD$Ow <- NULL
pulse_LOW_CNR_SHEL_FRD$Sh <- NULL
pulse_LOW_CNR_SHEL_FRD$Ne <- NULL
pulse_LOW_CNR_SHEL_FRD$St <- NULL
pulse_LOW_CNR_SHEL_FRD$sheltering_I <- NULL
pulse_LOW_CNR_SHEL_FRD$culling_I <- NULL
pulse_LOW_CNR_SHEL_FRD$CNR_I <- NULL

pulse_LOW_CNR_RO_FRD$Ow <- NULL
pulse_LOW_CNR_RO_FRD$Sh <- NULL
pulse_LOW_CNR_RO_FRD$Ne <- NULL
pulse_LOW_CNR_RO_FRD$St <- NULL
pulse_LOW_CNR_RO_FRD$sheltering_I <- NULL
pulse_LOW_CNR_RO_FRD$culling_I <- NULL
pulse_LOW_CNR_RO_FRD$CNR_I <- NULL

pulse_LOW_CNR_FRD[, "Intervention"] <- "CNR"
pulse_LOW_cull_FRD[, "Intervention"] <- "Culling"
pulse_LOW_shel_FRD[, "Intervention"] <- "Sheltering"
pulse_LOW_RO_FRD[, "Intervention"] <- "Responsible ownership"
pulse_LOW_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
pulse_LOW_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

pulse_LOW_full_data <- rbind(pulse_LOW_CNR_FRD, pulse_LOW_cull_FRD, pulse_LOW_shel_FRD, pulse_LOW_RO_FRD, pulse_LOW_CNR_SHEL_FRD, pulse_LOW_CNR_RO_FRD)
rm(pulse_LOW_CNR_FRD,pulse_LOW_CNR_RO_FRD,pulse_LOW_CNR_SHEL_FRD, pulse_LOW_cull_FRD, pulse_LOW_RO_FRD, pulse_LOW_shel_FRD)

pulse_HIGH_full_data[, "Coverage"] <- "High"
pulse_MED_full_data[, "Coverage"] <- "Medium"
pulse_LOW_full_data[, "Coverage"] <- "Low"

annual_df <- rbind(pulse_HIGH_full_data, pulse_MED_full_data, pulse_LOW_full_data)

rm(pulse_HIGH_full_data, pulse_MED_full_data, pulse_LOW_full_data)

annual_df[, "Periodicity"] <- "Annual"
continuous_df[, "Periodicity"] <- "Continuous"

df_full <- rbind(annual_df, continuous_df)
df_full[, "Duration"] <- "Full simulation"

rm(annual_df, continuous_df)

###Interventions applied for only 5 years ####
### HIGH continuous ####
five_year_HIGH_CNR_FRD <- read.csv("HIGH_run_CNR_five_year.csv")
five_year_HIGH_shel_FRD <- read.csv("HIGH_run_sheltering_five_year.csv")
five_year_HIGH_cull_FRD <- read.csv("HIGH_run_culling_five_year.csv")
five_year_HIGH_RO_FRD <- read.csv("HIGH_responsible_own_five_year.csv") # Responsible ownership
five_year_HIGH_CNR_SHEL_FRD <- read.csv("HIGH_run_CNR_SHEL_five_year.csv") # Combined sheltering and CNR
five_year_HIGH_CNR_RO_FRD <- read.csv("HIGH_run_CNR_RO_five_year.csv") # Combined responsible ownership and CNR

five_year_HIGH_CNR_FRD$Ow <- NULL
five_year_HIGH_CNR_FRD$Sh <- NULL
five_year_HIGH_CNR_FRD$St <- NULL
five_year_HIGH_CNR_FRD$Ne <- NULL
five_year_HIGH_CNR_FRD$sheltering_I <- NULL
five_year_HIGH_CNR_FRD$culling_I <- NULL
five_year_HIGH_CNR_FRD$CNR_I <- NULL

five_year_HIGH_cull_FRD$Ow <- NULL
five_year_HIGH_cull_FRD$Sh <- NULL
five_year_HIGH_cull_FRD$Ne <- NULL
five_year_HIGH_cull_FRD$sheltering_I <- NULL
five_year_HIGH_cull_FRD$culling_I <- NULL
five_year_HIGH_cull_FRD$CNR_I <- NULL
names(five_year_HIGH_cull_FRD)[2] <- "FRD"

five_year_HIGH_shel_FRD$Ow <- NULL
five_year_HIGH_shel_FRD$Sh <- NULL
five_year_HIGH_shel_FRD$Ne <- NULL
five_year_HIGH_shel_FRD$sheltering_I <- NULL
five_year_HIGH_shel_FRD$culling_I <- NULL
five_year_HIGH_shel_FRD$CNR_I <- NULL
names(five_year_HIGH_shel_FRD)[2] <- "FRD"

five_year_HIGH_RO_FRD$Ow <- NULL
five_year_HIGH_RO_FRD$Sh <- NULL
five_year_HIGH_RO_FRD$Ne <- NULL
five_year_HIGH_RO_FRD$sheltering_I <- NULL
five_year_HIGH_RO_FRD$culling_I <- NULL
five_year_HIGH_RO_FRD$CNR_I <- NULL
five_year_HIGH_RO_FRD$abandon_I <- NULL
five_year_HIGH_RO_FRD$abandon_RO_I <- NULL
five_year_HIGH_RO_FRD$adoption_I <- NULL
five_year_HIGH_RO_FRD$adoption_RO_I <- NULL
names(five_year_HIGH_RO_FRD)[2] <- "FRD"

five_year_HIGH_CNR_SHEL_FRD$Ow <- NULL
five_year_HIGH_CNR_SHEL_FRD$Sh <- NULL
five_year_HIGH_CNR_SHEL_FRD$Ne <- NULL
five_year_HIGH_CNR_SHEL_FRD$St <- NULL
five_year_HIGH_CNR_SHEL_FRD$sheltering_I <- NULL
five_year_HIGH_CNR_SHEL_FRD$culling_I <- NULL
five_year_HIGH_CNR_SHEL_FRD$CNR_I <- NULL

five_year_HIGH_CNR_RO_FRD$Ow <- NULL
five_year_HIGH_CNR_RO_FRD$Sh <- NULL
five_year_HIGH_CNR_RO_FRD$Ne <- NULL
five_year_HIGH_CNR_RO_FRD$St <- NULL
five_year_HIGH_CNR_RO_FRD$sheltering_I <- NULL
five_year_HIGH_CNR_RO_FRD$culling_I <- NULL
five_year_HIGH_CNR_RO_FRD$CNR_I <- NULL
five_year_HIGH_CNR_RO_FRD$abandon_I <- NULL
five_year_HIGH_CNR_RO_FRD$abandon_RO_I <- NULL
five_year_HIGH_CNR_RO_FRD$adoption_I <- NULL
five_year_HIGH_CNR_RO_FRD$adoption_RO_I <- NULL

five_year_HIGH_CNR_FRD[, "Intervention"] <- "CNR"
five_year_HIGH_cull_FRD[, "Intervention"] <- "Culling"
five_year_HIGH_shel_FRD[, "Intervention"] <- "Sheltering"
five_year_HIGH_RO_FRD[, "Intervention"] <- "Responsible ownership"
five_year_HIGH_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
five_year_HIGH_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

# Combine all datasets

HIGH_continuous_five_year <- rbind(five_year_HIGH_CNR_FRD, five_year_HIGH_cull_FRD, five_year_HIGH_RO_FRD, 
                                   five_year_HIGH_shel_FRD, five_year_HIGH_CNR_SHEL_FRD, five_year_HIGH_CNR_RO_FRD)

rm(five_year_HIGH_CNR_FRD, five_year_HIGH_CNR_RO_FRD, five_year_HIGH_CNR_SHEL_FRD, five_year_HIGH_cull_FRD,
   five_year_HIGH_RO_FRD, five_year_HIGH_shel_FRD)

HIGH_continuous_five_year[, "Coverage"] <- "High"

### MED continuous ####
five_year_MED_CNR_FRD <- read.csv("MED_run_CNR_five_year.csv")
five_year_MED_shel_FRD <- read.csv("MED_run_sheltering_five_year.csv")
five_year_MED_cull_FRD <- read.csv("MED_run_culling_five_year.csv")
five_year_MED_RO_FRD <- read.csv("MED_responsible_own_five_year.csv") # Responsible ownership
five_year_MED_CNR_SHEL_FRD <- read.csv("MED_run_CNR_SHEL_five_year.csv") # Combined sheltering and CNR
five_year_MED_CNR_RO_FRD <- read.csv("MED_run_CNR_RO_five_year.csv") # Combined responsible ownership and CNR

five_year_MED_CNR_FRD$Ow <- NULL
five_year_MED_CNR_FRD$Sh <- NULL
five_year_MED_CNR_FRD$St <- NULL
five_year_MED_CNR_FRD$Ne <- NULL
five_year_MED_CNR_FRD$sheltering_I <- NULL
five_year_MED_CNR_FRD$culling_I <- NULL
five_year_MED_CNR_FRD$CNR_I <- NULL

five_year_MED_cull_FRD$Ow <- NULL
five_year_MED_cull_FRD$Sh <- NULL
five_year_MED_cull_FRD$Ne <- NULL
five_year_MED_cull_FRD$sheltering_I <- NULL
five_year_MED_cull_FRD$culling_I <- NULL
five_year_MED_cull_FRD$CNR_I <- NULL
names(five_year_MED_cull_FRD)[2] <- "FRD"

five_year_MED_shel_FRD$Ow <- NULL
five_year_MED_shel_FRD$Sh <- NULL
five_year_MED_shel_FRD$Ne <- NULL
five_year_MED_shel_FRD$sheltering_I <- NULL
five_year_MED_shel_FRD$culling_I <- NULL
five_year_MED_shel_FRD$CNR_I <- NULL
names(five_year_MED_shel_FRD)[2] <- "FRD"

five_year_MED_RO_FRD$Ow <- NULL
five_year_MED_RO_FRD$Sh <- NULL
five_year_MED_RO_FRD$Ne <- NULL
five_year_MED_RO_FRD$sheltering_I <- NULL
five_year_MED_RO_FRD$culling_I <- NULL
five_year_MED_RO_FRD$CNR_I <- NULL
five_year_MED_RO_FRD$abandon_I <- NULL
five_year_MED_RO_FRD$abandon_RO_I <- NULL
five_year_MED_RO_FRD$adoption_I <- NULL
five_year_MED_RO_FRD$adoption_RO_I <- NULL
names(five_year_MED_RO_FRD)[2] <- "FRD"

five_year_MED_CNR_SHEL_FRD$Ow <- NULL
five_year_MED_CNR_SHEL_FRD$Sh <- NULL
five_year_MED_CNR_SHEL_FRD$Ne <- NULL
five_year_MED_CNR_SHEL_FRD$St <- NULL
five_year_MED_CNR_SHEL_FRD$sheltering_I <- NULL
five_year_MED_CNR_SHEL_FRD$culling_I <- NULL
five_year_MED_CNR_SHEL_FRD$CNR_I <- NULL

five_year_MED_CNR_RO_FRD$Ow <- NULL
five_year_MED_CNR_RO_FRD$Sh <- NULL
five_year_MED_CNR_RO_FRD$Ne <- NULL
five_year_MED_CNR_RO_FRD$St <- NULL
five_year_MED_CNR_RO_FRD$sheltering_I <- NULL
five_year_MED_CNR_RO_FRD$culling_I <- NULL
five_year_MED_CNR_RO_FRD$CNR_I <- NULL
five_year_MED_CNR_RO_FRD$abandon_I <- NULL
five_year_MED_CNR_RO_FRD$abandon_RO_I <- NULL
five_year_MED_CNR_RO_FRD$adoption_I <- NULL
five_year_MED_CNR_RO_FRD$adoption_RO_I <- NULL

five_year_MED_CNR_FRD[, "Intervention"] <- "CNR"
five_year_MED_cull_FRD[, "Intervention"] <- "Culling"
five_year_MED_shel_FRD[, "Intervention"] <- "Sheltering"
five_year_MED_RO_FRD[, "Intervention"] <- "Responsible ownership"
five_year_MED_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
five_year_MED_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

MED_continuous_five_year <- rbind(five_year_MED_CNR_FRD, five_year_MED_cull_FRD, five_year_MED_RO_FRD, 
                                  five_year_MED_shel_FRD, five_year_MED_CNR_SHEL_FRD, five_year_MED_CNR_RO_FRD)

rm(five_year_MED_CNR_FRD, five_year_MED_CNR_RO_FRD, five_year_MED_CNR_SHEL_FRD, five_year_MED_cull_FRD,
   five_year_MED_RO_FRD, five_year_MED_shel_FRD)

MED_continuous_five_year[, "Coverage"] <- "Medium"

### LOW continuous ####
five_year_LOW_CNR_FRD <- read.csv("LOW_run_CNR_five_year.csv")
five_year_LOW_shel_FRD <- read.csv("LOW_run_sheltering_five_year.csv")
five_year_LOW_cull_FRD <- read.csv("LOW_run_culling_five_year.csv")
five_year_LOW_RO_FRD <- read.csv("LOW_responsible_own_five_year.csv") # Responsible ownership
five_year_LOW_CNR_SHEL_FRD <- read.csv("LOW_run_CNR_SHEL_five_year.csv") # Combined sheltering and CNR
five_year_LOW_CNR_RO_FRD <- read.csv("LOW_run_CNR_RO_five_year.csv") # Combined responsible ownership and CNR

five_year_LOW_CNR_FRD$Ow <- NULL
five_year_LOW_CNR_FRD$Sh <- NULL
five_year_LOW_CNR_FRD$St <- NULL
five_year_LOW_CNR_FRD$Ne <- NULL
five_year_LOW_CNR_FRD$sheltering_I <- NULL
five_year_LOW_CNR_FRD$culling_I <- NULL
five_year_LOW_CNR_FRD$CNR_I <- NULL

five_year_LOW_cull_FRD$Ow <- NULL
five_year_LOW_cull_FRD$Sh <- NULL
five_year_LOW_cull_FRD$Ne <- NULL
five_year_LOW_cull_FRD$sheltering_I <- NULL
five_year_LOW_cull_FRD$culling_I <- NULL
five_year_LOW_cull_FRD$CNR_I <- NULL
names(five_year_LOW_cull_FRD)[2] <- "FRD"

five_year_LOW_shel_FRD$Ow <- NULL
five_year_LOW_shel_FRD$Sh <- NULL
five_year_LOW_shel_FRD$Ne <- NULL
five_year_LOW_shel_FRD$sheltering_I <- NULL
five_year_LOW_shel_FRD$culling_I <- NULL
five_year_LOW_shel_FRD$CNR_I <- NULL
names(five_year_LOW_shel_FRD)[2] <- "FRD"

five_year_LOW_RO_FRD$Ow <- NULL
five_year_LOW_RO_FRD$Sh <- NULL
five_year_LOW_RO_FRD$Ne <- NULL
five_year_LOW_RO_FRD$sheltering_I <- NULL
five_year_LOW_RO_FRD$culling_I <- NULL
five_year_LOW_RO_FRD$CNR_I <- NULL
five_year_LOW_RO_FRD$abandon_I <- NULL
five_year_LOW_RO_FRD$abandon_RO_I <- NULL
five_year_LOW_RO_FRD$adoption_I <- NULL
five_year_LOW_RO_FRD$adoption_RO_I <- NULL
names(five_year_LOW_RO_FRD)[2] <- "FRD"

five_year_LOW_CNR_SHEL_FRD$Ow <- NULL
five_year_LOW_CNR_SHEL_FRD$Sh <- NULL
five_year_LOW_CNR_SHEL_FRD$Ne <- NULL
five_year_LOW_CNR_SHEL_FRD$St <- NULL
five_year_LOW_CNR_SHEL_FRD$sheltering_I <- NULL
five_year_LOW_CNR_SHEL_FRD$culling_I <- NULL
five_year_LOW_CNR_SHEL_FRD$CNR_I <- NULL

five_year_LOW_CNR_RO_FRD$Ow <- NULL
five_year_LOW_CNR_RO_FRD$Sh <- NULL
five_year_LOW_CNR_RO_FRD$Ne <- NULL
five_year_LOW_CNR_RO_FRD$St <- NULL
five_year_LOW_CNR_RO_FRD$sheltering_I <- NULL
five_year_LOW_CNR_RO_FRD$culling_I <- NULL
five_year_LOW_CNR_RO_FRD$CNR_I <- NULL
five_year_LOW_CNR_RO_FRD$abandon_I <- NULL
five_year_LOW_CNR_RO_FRD$abandon_RO_I <- NULL
five_year_LOW_CNR_RO_FRD$adoption_I <- NULL
five_year_LOW_CNR_RO_FRD$adoption_RO_I <- NULL

five_year_LOW_CNR_FRD[, "Intervention"] <- "CNR"
five_year_LOW_cull_FRD[, "Intervention"] <- "Culling"
five_year_LOW_shel_FRD[, "Intervention"] <- "Sheltering"
five_year_LOW_RO_FRD[, "Intervention"] <- "Responsible ownership"
five_year_LOW_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
five_year_LOW_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"

LOW_continuous_five_year <- rbind(five_year_LOW_CNR_FRD, five_year_LOW_cull_FRD, five_year_LOW_RO_FRD,
                                  five_year_LOW_shel_FRD, five_year_LOW_CNR_SHEL_FRD, five_year_LOW_CNR_RO_FRD)

rm(five_year_LOW_CNR_FRD, five_year_LOW_CNR_RO_FRD, five_year_LOW_CNR_SHEL_FRD, five_year_LOW_cull_FRD,
   five_year_LOW_RO_FRD, five_year_LOW_shel_FRD)

LOW_continuous_five_year[, "Coverage"] <- "Low"

df_continuous <- rbind(HIGH_continuous_five_year, MED_continuous_five_year, LOW_continuous_five_year)
rm(HIGH_continuous_five_year, MED_continuous_five_year, LOW_continuous_five_year)
df_continuous[, "Periodicity"] <- "Continuous"

### HIGH annual ####
five_year_pulse_HIGH_CNR_FRD <- read.csv("HIGH_run_CNR_pulse_five_year.csv")
five_year_pulse_HIGH_shel_FRD <- read.csv("HIGH_run_sheltering_pulse_five_year.csv")
five_year_pulse_HIGH_cull_FRD <- read.csv("HIGH_run_culling_pulse_five_year.csv")
five_year_pulse_HIGH_RO_FRD <- read.csv("HIGH_responsible_own_five_year.csv") # Responsible ownership
five_year_pulse_HIGH_CNR_SHEL_FRD <- read.csv("HIGH_run_CNR_SHEL_pulse_five_year.csv") # Combined sheltering and CNR
five_year_pulse_HIGH_CNR_RO_FRD <- read.csv("HIGH_run_CNR_RO_pulse_five_year.csv") # Combined responsible ownership and CNR

five_year_pulse_HIGH_CNR_FRD$Ow <- NULL
five_year_pulse_HIGH_CNR_FRD$Sh <- NULL
five_year_pulse_HIGH_CNR_FRD$St <- NULL
five_year_pulse_HIGH_CNR_FRD$Ne <- NULL
five_year_pulse_HIGH_CNR_FRD$sheltering_I <- NULL
five_year_pulse_HIGH_CNR_FRD$culling_I <- NULL
five_year_pulse_HIGH_CNR_FRD$CNR_I <- NULL

five_year_pulse_HIGH_cull_FRD$Ow <- NULL
five_year_pulse_HIGH_cull_FRD$Sh <- NULL
five_year_pulse_HIGH_cull_FRD$Ne <- NULL
five_year_pulse_HIGH_cull_FRD$sheltering_I <- NULL
five_year_pulse_HIGH_cull_FRD$culling_I <- NULL
five_year_pulse_HIGH_cull_FRD$CNR_I <- NULL
names(five_year_pulse_HIGH_cull_FRD)[2] <- "FRD"

five_year_pulse_HIGH_shel_FRD$Ow <- NULL
five_year_pulse_HIGH_shel_FRD$Sh <- NULL
five_year_pulse_HIGH_shel_FRD$Ne <- NULL
five_year_pulse_HIGH_shel_FRD$sheltering_I <- NULL
five_year_pulse_HIGH_shel_FRD$culling_I <- NULL
five_year_pulse_HIGH_shel_FRD$CNR_I <- NULL
names(five_year_pulse_HIGH_shel_FRD)[2] <- "FRD"

five_year_pulse_HIGH_RO_FRD$Ow <- NULL
five_year_pulse_HIGH_RO_FRD$Sh <- NULL
five_year_pulse_HIGH_RO_FRD$Ne <- NULL
five_year_pulse_HIGH_RO_FRD$sheltering_I <- NULL
five_year_pulse_HIGH_RO_FRD$culling_I <- NULL
five_year_pulse_HIGH_RO_FRD$CNR_I <- NULL
five_year_pulse_HIGH_RO_FRD$abandon_I <- NULL
five_year_pulse_HIGH_RO_FRD$abandon_RO_I <- NULL
five_year_pulse_HIGH_RO_FRD$adoption_I <- NULL
five_year_pulse_HIGH_RO_FRD$adoption_RO_I <- NULL
names(five_year_pulse_HIGH_RO_FRD)[2] <- "FRD"

five_year_pulse_HIGH_CNR_SHEL_FRD$Ow <- NULL
five_year_pulse_HIGH_CNR_SHEL_FRD$Sh <- NULL
five_year_pulse_HIGH_CNR_SHEL_FRD$Ne <- NULL
five_year_pulse_HIGH_CNR_SHEL_FRD$St <- NULL
five_year_pulse_HIGH_CNR_SHEL_FRD$sheltering_I <- NULL
five_year_pulse_HIGH_CNR_SHEL_FRD$culling_I <- NULL
five_year_pulse_HIGH_CNR_SHEL_FRD$CNR_I <- NULL

five_year_pulse_HIGH_CNR_RO_FRD$Ow <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$Sh <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$Ne <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$St <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$sheltering_I <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$culling_I <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$CNR_I <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$abandon_I <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$abandon_RO_I <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$adoption_I <- NULL
five_year_pulse_HIGH_CNR_RO_FRD$adoption_RO_I <- NULL

five_year_pulse_HIGH_CNR_FRD[, "Intervention"] <- "CNR"
five_year_pulse_HIGH_cull_FRD[, "Intervention"] <- "Culling"
five_year_pulse_HIGH_shel_FRD[, "Intervention"] <- "Sheltering"
five_year_pulse_HIGH_RO_FRD[, "Intervention"] <- "Responsible ownership"
five_year_pulse_HIGH_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
five_year_pulse_HIGH_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"


five_year_pulse_HIGH <- rbind(five_year_pulse_HIGH_CNR_FRD, five_year_pulse_HIGH_cull_FRD, five_year_pulse_HIGH_shel_FRD, five_year_pulse_HIGH_RO_FRD, five_year_pulse_HIGH_CNR_SHEL_FRD, five_year_pulse_HIGH_CNR_RO_FRD)
rm(five_year_pulse_HIGH_CNR_FRD, five_year_pulse_HIGH_cull_FRD, five_year_pulse_HIGH_shel_FRD, five_year_pulse_HIGH_RO_FRD, five_year_pulse_HIGH_CNR_SHEL_FRD, five_year_pulse_HIGH_CNR_RO_FRD)
five_year_pulse_HIGH[, "Coverage"] <- "High"

### MED annual ####
five_year_pulse_MED_CNR_FRD <- read.csv("MED_run_CNR_pulse_five_year.csv")
five_year_pulse_MED_shel_FRD <- read.csv("MED_run_sheltering_pulse_five_year.csv")
five_year_pulse_MED_cull_FRD <- read.csv("MED_run_culling_pulse_five_year.csv")
five_year_pulse_MED_RO_FRD <- read.csv("MED_responsible_own_five_year.csv") # Responsible ownership
five_year_pulse_MED_CNR_SHEL_FRD <- read.csv("MED_run_CNR_SHEL_pulse_five_year.csv") # Combined sheltering and CNR
five_year_pulse_MED_CNR_RO_FRD <- read.csv("MED_run_CNR_RO_pulse_five_year.csv") # Combined responsible ownership and CNR

five_year_pulse_MED_CNR_FRD$Ow <- NULL
five_year_pulse_MED_CNR_FRD$Sh <- NULL
five_year_pulse_MED_CNR_FRD$St <- NULL
five_year_pulse_MED_CNR_FRD$Ne <- NULL
five_year_pulse_MED_CNR_FRD$sheltering_I <- NULL
five_year_pulse_MED_CNR_FRD$culling_I <- NULL
five_year_pulse_MED_CNR_FRD$CNR_I <- NULL

five_year_pulse_MED_cull_FRD$Ow <- NULL
five_year_pulse_MED_cull_FRD$Sh <- NULL
five_year_pulse_MED_cull_FRD$Ne <- NULL
five_year_pulse_MED_cull_FRD$sheltering_I <- NULL
five_year_pulse_MED_cull_FRD$culling_I <- NULL
five_year_pulse_MED_cull_FRD$CNR_I <- NULL
names(five_year_pulse_MED_cull_FRD)[2] <- "FRD"

five_year_pulse_MED_shel_FRD$Ow <- NULL
five_year_pulse_MED_shel_FRD$Sh <- NULL
five_year_pulse_MED_shel_FRD$Ne <- NULL
five_year_pulse_MED_shel_FRD$sheltering_I <- NULL
five_year_pulse_MED_shel_FRD$culling_I <- NULL
five_year_pulse_MED_shel_FRD$CNR_I <- NULL
names(five_year_pulse_MED_shel_FRD)[2] <- "FRD"

five_year_pulse_MED_RO_FRD$Ow <- NULL
five_year_pulse_MED_RO_FRD$Sh <- NULL
five_year_pulse_MED_RO_FRD$Ne <- NULL
five_year_pulse_MED_RO_FRD$sheltering_I <- NULL
five_year_pulse_MED_RO_FRD$culling_I <- NULL
five_year_pulse_MED_RO_FRD$CNR_I <- NULL
five_year_pulse_MED_RO_FRD$abandon_I <- NULL
five_year_pulse_MED_RO_FRD$abandon_RO_I <- NULL
five_year_pulse_MED_RO_FRD$adoption_I <- NULL
five_year_pulse_MED_RO_FRD$adoption_RO_I <- NULL
names(five_year_pulse_MED_RO_FRD)[2] <- "FRD"

five_year_pulse_MED_CNR_SHEL_FRD$Ow <- NULL
five_year_pulse_MED_CNR_SHEL_FRD$Sh <- NULL
five_year_pulse_MED_CNR_SHEL_FRD$Ne <- NULL
five_year_pulse_MED_CNR_SHEL_FRD$St <- NULL
five_year_pulse_MED_CNR_SHEL_FRD$sheltering_I <- NULL
five_year_pulse_MED_CNR_SHEL_FRD$culling_I <- NULL
five_year_pulse_MED_CNR_SHEL_FRD$CNR_I <- NULL

five_year_pulse_MED_CNR_RO_FRD$Ow <- NULL
five_year_pulse_MED_CNR_RO_FRD$Sh <- NULL
five_year_pulse_MED_CNR_RO_FRD$Ne <- NULL
five_year_pulse_MED_CNR_RO_FRD$St <- NULL
five_year_pulse_MED_CNR_RO_FRD$sheltering_I <- NULL
five_year_pulse_MED_CNR_RO_FRD$culling_I <- NULL
five_year_pulse_MED_CNR_RO_FRD$CNR_I <- NULL
five_year_pulse_MED_CNR_RO_FRD$abandon_I <- NULL
five_year_pulse_MED_CNR_RO_FRD$abandon_RO_I <- NULL
five_year_pulse_MED_CNR_RO_FRD$adoption_I <- NULL
five_year_pulse_MED_CNR_RO_FRD$adoption_RO_I <- NULL

five_year_pulse_MED_CNR_FRD[, "Intervention"] <- "CNR"
five_year_pulse_MED_cull_FRD[, "Intervention"] <- "Culling"
five_year_pulse_MED_shel_FRD[, "Intervention"] <- "Sheltering"
five_year_pulse_MED_RO_FRD[, "Intervention"] <- "Responsible ownership"
five_year_pulse_MED_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
five_year_pulse_MED_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"


five_year_pulse_MED <- rbind(five_year_pulse_MED_CNR_FRD, five_year_pulse_MED_cull_FRD, five_year_pulse_MED_shel_FRD, five_year_pulse_MED_RO_FRD, five_year_pulse_MED_CNR_SHEL_FRD, five_year_pulse_MED_CNR_RO_FRD)
rm(five_year_pulse_MED_CNR_FRD, five_year_pulse_MED_cull_FRD, five_year_pulse_MED_shel_FRD, five_year_pulse_MED_RO_FRD, five_year_pulse_MED_CNR_SHEL_FRD, five_year_pulse_MED_CNR_RO_FRD)
five_year_pulse_MED[, "Coverage"] <- "Medium"


### LOW annual ####
five_year_pulse_LOW_CNR_FRD <- read.csv("LOW_run_CNR_pulse_five_year.csv")
five_year_pulse_LOW_shel_FRD <- read.csv("LOW_run_sheltering_pulse_five_year.csv")
five_year_pulse_LOW_cull_FRD <- read.csv("LOW_run_culling_pulse_five_year.csv")
five_year_pulse_LOW_RO_FRD <- read.csv("LOW_responsible_own_five_year.csv") # Responsible ownership
five_year_pulse_LOW_CNR_SHEL_FRD <- read.csv("LOW_run_CNR_SHEL_pulse_five_year.csv") # Combined sheltering and CNR
five_year_pulse_LOW_CNR_RO_FRD <- read.csv("LOW_run_CNR_RO_pulse_five_year.csv") # Combined responsible ownership and CNR

five_year_pulse_LOW_CNR_FRD$Ow <- NULL
five_year_pulse_LOW_CNR_FRD$Sh <- NULL
five_year_pulse_LOW_CNR_FRD$St <- NULL
five_year_pulse_LOW_CNR_FRD$Ne <- NULL
five_year_pulse_LOW_CNR_FRD$sheltering_I <- NULL
five_year_pulse_LOW_CNR_FRD$culling_I <- NULL
five_year_pulse_LOW_CNR_FRD$CNR_I <- NULL

five_year_pulse_LOW_cull_FRD$Ow <- NULL
five_year_pulse_LOW_cull_FRD$Sh <- NULL
five_year_pulse_LOW_cull_FRD$Ne <- NULL
five_year_pulse_LOW_cull_FRD$sheltering_I <- NULL
five_year_pulse_LOW_cull_FRD$culling_I <- NULL
five_year_pulse_LOW_cull_FRD$CNR_I <- NULL
names(five_year_pulse_LOW_cull_FRD)[2] <- "FRD"

five_year_pulse_LOW_shel_FRD$Ow <- NULL
five_year_pulse_LOW_shel_FRD$Sh <- NULL
five_year_pulse_LOW_shel_FRD$Ne <- NULL
five_year_pulse_LOW_shel_FRD$sheltering_I <- NULL
five_year_pulse_LOW_shel_FRD$culling_I <- NULL
five_year_pulse_LOW_shel_FRD$CNR_I <- NULL
names(five_year_pulse_LOW_shel_FRD)[2] <- "FRD"

five_year_pulse_LOW_RO_FRD$Ow <- NULL
five_year_pulse_LOW_RO_FRD$Sh <- NULL
five_year_pulse_LOW_RO_FRD$Ne <- NULL
five_year_pulse_LOW_RO_FRD$sheltering_I <- NULL
five_year_pulse_LOW_RO_FRD$culling_I <- NULL
five_year_pulse_LOW_RO_FRD$CNR_I <- NULL
five_year_pulse_LOW_RO_FRD$abandon_I <- NULL
five_year_pulse_LOW_RO_FRD$abandon_RO_I <- NULL
five_year_pulse_LOW_RO_FRD$adoption_I <- NULL
five_year_pulse_LOW_RO_FRD$adoption_RO_I <- NULL
names(five_year_pulse_LOW_RO_FRD)[2] <- "FRD"

five_year_pulse_LOW_CNR_SHEL_FRD$Ow <- NULL
five_year_pulse_LOW_CNR_SHEL_FRD$Sh <- NULL
five_year_pulse_LOW_CNR_SHEL_FRD$Ne <- NULL
five_year_pulse_LOW_CNR_SHEL_FRD$St <- NULL
five_year_pulse_LOW_CNR_SHEL_FRD$sheltering_I <- NULL
five_year_pulse_LOW_CNR_SHEL_FRD$culling_I <- NULL
five_year_pulse_LOW_CNR_SHEL_FRD$CNR_I <- NULL

five_year_pulse_LOW_CNR_RO_FRD$Ow <- NULL
five_year_pulse_LOW_CNR_RO_FRD$Sh <- NULL
five_year_pulse_LOW_CNR_RO_FRD$Ne <- NULL
five_year_pulse_LOW_CNR_RO_FRD$St <- NULL
five_year_pulse_LOW_CNR_RO_FRD$sheltering_I <- NULL
five_year_pulse_LOW_CNR_RO_FRD$culling_I <- NULL
five_year_pulse_LOW_CNR_RO_FRD$CNR_I <- NULL
five_year_pulse_LOW_CNR_RO_FRD$abandon_I <- NULL
five_year_pulse_LOW_CNR_RO_FRD$abandon_RO_I <- NULL
five_year_pulse_LOW_CNR_RO_FRD$adoption_I <- NULL
five_year_pulse_LOW_CNR_RO_FRD$adoption_RO_I <- NULL

five_year_pulse_LOW_CNR_FRD[, "Intervention"] <- "CNR"
five_year_pulse_LOW_cull_FRD[, "Intervention"] <- "Culling"
five_year_pulse_LOW_shel_FRD[, "Intervention"] <- "Sheltering"
five_year_pulse_LOW_RO_FRD[, "Intervention"] <- "Responsible ownership"
five_year_pulse_LOW_CNR_SHEL_FRD[, "Intervention"] <- "Sheltering & CNR"
five_year_pulse_LOW_CNR_RO_FRD[, "Intervention"] <- "Responsible ownership & CNR"


five_year_pulse_LOW <- rbind(five_year_pulse_LOW_CNR_FRD, five_year_pulse_LOW_cull_FRD, five_year_pulse_LOW_shel_FRD, five_year_pulse_LOW_RO_FRD, five_year_pulse_LOW_CNR_SHEL_FRD, five_year_pulse_LOW_CNR_RO_FRD)
rm(five_year_pulse_LOW_CNR_FRD, five_year_pulse_LOW_cull_FRD, five_year_pulse_LOW_shel_FRD, five_year_pulse_LOW_RO_FRD, five_year_pulse_LOW_CNR_SHEL_FRD, five_year_pulse_LOW_CNR_RO_FRD)
five_year_pulse_LOW[, "Coverage"] <- "Low"
df_annual <- rbind(five_year_pulse_HIGH, five_year_pulse_MED, five_year_pulse_LOW)
df_annual[, "Periodicity"] <- "Annual"
rm(five_year_pulse_HIGH, five_year_pulse_MED, five_year_pulse_LOW)
df_five_year <- rbind(df_annual, df_continuous)
rm(df_annual, df_continuous)
df_five_year[, "Duration"] <- "Five years"

df <- rbind(df_five_year, df_full)
df$time <- df$time/12 # converts time to yearly from monthly
rm(df_five_year, df_full)

df$Coverage = factor(df$Coverage, levels = c("Low", "Medium", "High"), ordered = TRUE)

panel_graph <- ggplot(df, aes(x=time, y=FRD)) +
  theme_bw() +
  geom_line(aes(color=Intervention)) +
  xlab("Time (years)") +
  ylab("Street dog population size") +
  scale_color_brewer(palette = "Dark2") +
  ylim(0, 25000) +
  facet_grid(Periodicity ~ Duration ~ Coverage, scales = "free_y")


