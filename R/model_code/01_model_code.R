require(data.table) # data.table allows fast aggregation of large data (for model output file)

# This section of code creates the lookup function for the death rate of neutered dogs -----------
x.stock <- seq(0, 20000, by = 2000)
y.rate <- c(0.019, 0.0192, 0.0194, 0.0196, 0.0199, 0.0202, 0.0204, 0.0208, 0.022, 0.026, 0.032)
my_death_rate_function <- approxfun(x=x.stock, y=y.rate, rule = 2)
plot(seq(0,20000,0.1), my_death_rate_function(seq(0,20000,0.1)), type="l")

# function defining the systems model -----------
dogs_m <- function(t, y, p)
{
  with(as.list(c(y,p)), {
    
    # functions allowing the sheltering, culling and catch-neuter-release intervention to be applied during intervention months (i.e., bi-annually, or continuously)
    sheltering_I <- sheltering_on_fun(t) 
    culling_I <- culling_on_fun(t)
    CNR_I <- CNR_on_fun(t)
    
    # rate neutered dogs are removed through deaths
    my_death_rate_function <- approxfun(x=x.stock, y=y.rate, rule = 2)
    
    # differential equations describing the flows between the street, shelter, and owned dog populations
    dSt_dt <- r_st*St*(1 - (St+Ne)/K_st) + abandonment_rate*Ow - st_adoption*St - (sheltering_I * sheltering * St) - (culling_I * cull_rate * St) - (CNR_I * neuter_rate * St) # equation for intact street dog population
    dSh_dt <- relinquish_rate*Ow - shelter_adoption_rate*Sh - shelter_death*Sh + (sheltering_I * sheltering * St) # equation for shelter dog population
    dOw_dt <- r_ow*Ow*(1 - Ow/K_ow) + shelter_adoption_rate*Sh + st_adoption*St - abandonment_rate*Ow - relinquish_rate*Ow # equation for owned dog population
    dNe_dt <- - my_death_rate_function(Ne+St) * Ne - st_adoption*Ne + (CNR_I * neuter_rate * St) # equation for neutered street dog population
    
    return(list(c(dSt_dt, dSh_dt, dOw_dt, dNe_dt),
                sheltering_I = sheltering_I,
                culling_I = culling_I,
                CNR_I = CNR_I
    )
    )
  })
}

# Input parameters ---------------
# state = c(St = 20000, Sh = 3750, Ow = 100492, Ne=0) # input parameters for running BASELINE simulation - uses intial values for St, Sh, Ow, Ne
state = c(St = 23650.84, Sh = 2086.381, Ow = 98357.98, Ne=0) # input parameters for intact street (St), shelter (Sh), owned (Ow), and neutered street (Ne) dog populations
times = seq(0, 840, by = 0.01) # lenght of simulation, running between 0 and 840 time steps (months) by 0.01 time step intervals 

# list of input parameters for the above systems model
parameters = list(r_st = 0.03, # Maximum growth rate of street dog population
                  r_ow = 0.07,# Maximum growth rate of owned dog population
                  K_st=20000, # Carrying capacity of street dog population
                  K_ow=100492, # Carrying capacity of owned dog population
                  abandonment_rate = 0.003, # Abandonment rate of owned dogs to street dog population
                  st_adoption = 0.007, # Adoption rate of street dogs to owned dog population
                  shelter_adoption_rate = 0.025, # Adoption rate of shelter dogs to owned dog popualation
                  relinquish_rate = 0.0007, # Relinquishment rate of owned dogs to shelter population
                  shelter_death = 0.008, # Death rate of shelter dogs
                  sheltering =   0, # Rate dogs are moved from street to shelter dog population (sheltering intervention) 
                  cull_rate = 0, # Rate street dogs are removed through culling intervention
                  neuter_rate =  0.35) # Rate intact street dogs are moved to neutered street dog population (neutering intervention)

# Simulations ------------------

### Baseline ####
# sheltering, culling and CNR interventions are not applied during the baseline simulation; sheltering_times, culling_times, and CNR_times = 0.
sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0)

culling_times <- data.frame(
  times = times,
  culling_on = 0)

CNR_times <- data.frame(
  times = times,
  CNR_on = 0)

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe called baseline.
baseline <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

# writes the simulation output file.
fwrite(x = baseline, file = "baseline.csv", row.names = FALSE)

### SHELTERING ####

# continuous (i.e., monthly applied) sheltering intervention ------------
sheltering_times <- data.frame( 
  times = times,
  sheltering_on = ifelse(times > 0, 1, 0)) # sheltering times set to 1 (i.e., on) for every timestep above 0 as a continuous sheltering intervention is applied

culling_times <- data.frame( 
  times = times,
  culling_on = 0) # culling times set to 0 (i.e., off) for every timestep as culling intervention not applied

CNR_times <- data.frame( 
  times = times,
  CNR_on = 0) # CNR times set to 0 (i.e., off) for every timestep as CNR intervention not applied

sheltering_on_fun <- approxfun(sheltering_times, rule = 2) # The 'rule 2' part of the function specifies that if the function is given an x value outside the range in approxfun(), it'll default to the highest/lowest y value.
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe called run_sheltering_continuous
run_sheltering_continuous <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
               )
)

# writes the simulation output file.
fwrite(x = run_sheltering_continuous, file = "run_sheltering_continuous.csv", row.names = FALSE)


### annual sheltering intervention ----------

shelter_pulse <- seq(0, 840, by=13) # specifies a sequence of values between 0 and 840 by 13 months to allow an annual (or pulsed) intervention to run 
                                    # (sheltering intervention is applied for one month every 13 months)

sheltering_times <- data.frame(
  times = times,
  sheltering_on = ifelse( floor(times) %in% shelter_pulse, 1, 0) # sets sheltering intervention to be applied for one month every 13 months to simulate annual intervention
)

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = 0) # no CNR intervention

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_sheltering_pulse <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)


# writes the simulation output file.
fwrite(x = run_sheltering_pulse, file = "run_sheltering_pulse.csv", row.names = FALSE)

### CULLING ####
# continuous (i.e., monthly applied) culling intervention --------
sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0) # no sheltering intervention

culling_times <- data.frame(
  times = times,
  culling_on = ifelse(times > 0, 1, 0)) # culling intervention applied for all time steps

CNR_times <- data.frame(
  times = times,
  CNR_on = 0) # no CNR intervention

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_culling_continuous <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

fwrite(x = run_culling_continuous, file = "run_culling_continuous.csv", row.names = FALSE)


### annual culling intervention --------

culling_pulse <- seq(0, 840, by=13) # specifies a sequence of values between 0 and 840 by 13 months to allow an annual (or pulsed) intervention to run 
                                    # (culling intervention is applied for one month every 13 months)

sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0) # no sheltering intervention

culling_times <- data.frame(
  times = times,
  culling_on = ifelse( floor(times) %in% culling_pulse, 1, 0)) #  sets culling intervention to be applied for one month every 13 months to simulate annual intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = 0) # no CNR intervention

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_culling_pulse <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

# writes the simulation output file.
fwrite(x = run_culling_pulse, file = "HIGH_run_culling_pulse.csv", row.names = FALSE)

### CNR ####
# continuous (i.e., monthly applied) CNR intervention ----------
sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0) # no sheltering intervention

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = ifelse(times > 0, 1, 0)) # CNR intervention applied for all time steps

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_CNR_continuous <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

run_CNR_continuous[, "FRD"] <- run_CNR_continuous$St + run_CNR_continuous$Ne # creates a new column for the total street dog populatin (intact street + neutered street)

# writes the simulation output file.
fwrite(x = run_CNR_continuous, file = "run_CNR_continuous.csv", row.names = FALSE)

### annual CNR ----------

CNR_pulse <- seq(0, 840, by=13) # specifies a sequence of values between 0 and 840 by 13 months to allow an annual (or pulsed) intervention to run 
                                # (CNR intervention is applied for one month every 13 months)

sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0) # no sheltering intervention

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = ifelse( floor(times) %in% CNR_pulse, 1, 0)) #  sets CNR intervention to be applied for one month every 13 months to simulate annual intervention

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_CNR_pulse <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

run_CNR_pulse[, "FRD"] <- run_CNR_pulse$St+ run_CNR_pulse$Ne  # creates a new column for the total street dog populatin (intact street + neutered street)

# writes the simulation output file.
fwrite(x = run_CNR_pulse, file = "run_CNR_pulse.csv", row.names = FALSE)

### Combined CNR and sheltering ####
# continuously applied CNR & sheltering intervention ----------
sheltering_times <- data.frame(
  times = times,
  sheltering_on = ifelse(times > 0, 1, 0)) # applies sheltering intervention every month (continuously) 

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling interveniton

CNR_times <- data.frame(
  times = times,
  CNR_on = ifelse(times > 0, 1, 0)) # applies CNR intervention every month (continuously)

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_CNR_SHEL_continuous <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

run_CNR_SHEL_continuous[, "FRD"] <- run_CNR_SHEL_continuous$St + run_CNR_SHEL_continuous$Ne # creates a new column for the total street dog populatin (intact street + neutered street)

# writes the simulation output file.
fwrite(x = run_CNR_SHEL_continuous, file = "run_CNR_SHEL_continuous.csv", row.names = FALSE)

### annual CNR and sheltering  ---------

CNR_pulse <- seq(0, 840, by=13) # specifies a sequence of values between 0 and 840 by 13 months to allow an annual (or pulsed) intervention to run 
                                # (CNR intervention is applied for one month every 13 months)

shelter_pulse <- seq(0, 840, by=13) # specifies a sequence of values between 0 and 840 by 13 months to allow an annual (or pulsed) intervention to run 
                                    # (culling intervention is applied for one month every 13 months)

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = ifelse( floor(times) %in% CNR_pulse, 1, 0)) # applies CNR intervention for one month annually

sheltering_times <- data.frame(
  times = times,
  sheltering_on = ifelse( floor(times) %in% shelter_pulse, 1, 0) # applies sheltering intervention for one month annually
)

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_CNR_SHEL_pulse <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

run_CNR_SHEL_pulse[, "FRD"] <- run_CNR_SHEL_pulse$St + run_CNR_SHEL_pulse$Ne # creates a new column for the total street dog populatin (intact street + neutered street)

# writes the simulation output file.
fwrite(x = run_CNR_SHEL_pulse, file = "run_CNR_SHEL_pulse.csv", row.names = FALSE)

### Responsible ownership ####

# responsible ownership intervention is the same as the baseline simulation, parameter values are changed above to simulate responsible ownership intervention.

sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0)

culling_times <- data.frame(
  times = times,
  culling_on = 0)

CNR_times <- data.frame(
  times = times,
  CNR_on = 0)

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
responsible_own <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

# writes the simulation output file.
fwrite(x = responsible_own, file = "responsible_own.csv", row.names = FALSE)

### Combined CNR and responsible ownership intervention ####
# continuous CNR and responsible ownership intervention --------------
sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0) # no sheltering intervention

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = ifelse(times > 0, 1, 0)) # CNR intervention applied every month (continuously)

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# As with the responsible ownership intervention above, parameter variables are changed to simulation impact of responsible ownership interventions

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_CNR_RO_continuous <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

run_CNR_RO_continuous[, "FRD"] <- run_CNR_RO_continuous$St + run_CNR_RO_continuous$Ne# creates a new column for the total street dog populatin (intact street + neutered street)

# writes the simulation output file.
fwrite(x = run_CNR_RO_continuous, file = "MED_run_CNR_RO.csv", row.names = FALSE)


### Annual CNR and responsible ownership intervention ----------

CNR_pulse <- seq(0, 840, by=13) # specifies a sequence of values between 0 and 840 by 13 months to allow an annual (or pulsed) intervention to run 
                                # (CNR intervention is applied for one month every 13 months)

sheltering_times <- data.frame(
  times = times,
  sheltering_on = 0) # no sheltering intervention

culling_times <- data.frame(
  times = times,
  culling_on = 0) # no culling intervention

CNR_times <- data.frame(
  times = times,
  CNR_on = ifelse( floor(times) %in% CNR_pulse, 1, 0)) # applies CNR intervention for one month annually

sheltering_on_fun <- approxfun(sheltering_times, rule = 2)
culling_on_fun <- approxfun(culling_times, rule = 2)
CNR_on_fun <- approxfun(CNR_times, rule = 2)

# runs the ordinary differential equations using package deSolve and saves as a dataframe
run_CNR_RO_pulse <- as.data.frame(
  deSolve::ode(y = state, times = times,
               func = dogs_m,
               parms = parameters, 
               method = "rk4"
  )
)

run_CNR_RO_pulse[, "FRD"] <- run_CNR_RO_pulse$St+ run_CNR_RO_pulse$Ne # creates a new column for the total street dog populatin (intact street + neutered street)

# writes the simulation output file.
fwrite(x = run_CNR_RO_pulse, file = "HIGH_run_CNR_RO_pulse.csv", row.names = FALSE)
