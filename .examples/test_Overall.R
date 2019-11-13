################

devtools::unload("tableone")
devtools::load_all(path = here::here())


devtools::check(pkg = here::here())


library(survival)
data(pbc)

## Make categorical variables factors
varsToFactor <- c("status","trt","ascites","hepato","spiders","edema","stage")
pbc[varsToFactor] <- lapply(pbc[varsToFactor], factor)

## Create a variable list
dput(names(pbc))
vars <- c("time","status","age","sex","ascites","hepato",
           "spiders","edema","bili","chol","albumin",
           "copper","alk.phos","ast","trig","platelet",
           "protime","stage")

## Create Table 1 stratified by trt
tableOne_cat <- CreateTableOne(vars = varsToFactor,strata = c("trt"),#vars, #strata = c("trt"), 
                           data = pbc)

tableOne <- CreateTableOne(vars = vars, strata = c("trt"), data = pbc)

print(tableOne, nonnormal = c("bili","chol","copper","alk.phos","trig"),
       exact = c("status","stage"), cramVars = "hepato", smd = TRUE)

print(tableOne_old, nonnormal = c("bili","chol","copper","alk.phos","trig"),
      exact = c("status","stage"), cramVars = "hepato", smd = TRUE)

print(tableOne_cat, exact = c("status","stage"), cramVars = "hepato", smd = TRUE)
