## PART 2 - Finding the best hospital in a state

## Write a function called `best` that take two arguments: 
## - a 2-character abbreviated name of a state,
## - an outcome name

## Returns a character vector with the name of the hospital that 
## has the best (i.e. lowest) 30-day mortality for a specied outcome
## in that state. 

## The outcomes can be one of: heart attack, heart failure, or pneumonia. 

## Hospitals with no data on a particular outcome should be excluded
## from the set of hospitals when deciding the rankings.

## If there is a tie for the best hospital for a given outcome, 
## then the hospital names should be sorted in alphabetically. The 
## first hospital in that set should be chosen.


## Set working directory
setwd("C:/DennisFiles/Coursera/R-workdir/ProgAssignment3-data")


best <- function(state, outcome) {

    ## Read "outcome-of-care-measures.csv" to return a character vector. Also
    ## identify what NA values exist in the CSV file.
    outcomes <- read.csv("outcome-of-care-measures.csv", 
        colClasses = "character", na.strings="Not Available")

    ## Check that 'state' and 'outcome' are valid.

        ## If an invalid 'outcome' value is passed, use the 'stop'
        ## function to display the message "invalid outcome".

        validOutcomes = c("heart attack","heart failure","pneumonia")
        if (!outcome %in% validOutcomes) { stop("invalid outcome")}
  

        ## If an invalid 'state' value is passed to `best`, use the
        ## stop function to display the message "invalid state". A 
        ## unique list is created to test against.

        validStates = unique(outcomes[,7]) 
        if (!state %in% validStates) stop("invalid state")

    ## Return hospital name in that state with lowest 30-day death rate

        ## Create a subset of the 'outcomes' with the desired state
        sub_outcomes <- subset(outcomes, State == state)
        
        ## Check the desired column from the data file and assign it's value  
        ## to 'outcome_values'. The CSV columns tested are as follows: 
        ##  - Hospital 30-Day Death (Mortality) Rates from Heart Attack (Column 11)
        ##    is checked for "heart attack"
        ##  - Hospital 30-Day Death (Mortality) Rates from Heart Failure (Column 17)
        ##    is checked for "heart failure"
        ##  - Hospital 30-Day Death (Mortality) Rates from Pneumonia (Column 23)
        ##    is checked for "pneumonia"

        if (outcome == "heart attack") {
                outcome_values <- 11
        }
        else if (outcome == "heart failure") {
                outcome_values <- 17
        }
        else {
                outcome_values <- 23
        }
        
        ## Prepare the required columns and remove NA cases ("not_avail") 
        ## in the identified outcome column. 

        columns_needed <- as.numeric(sub_outcomes[,outcome_values])
        not_avail <- is.na(columns_needed)
        evaluation_list <- sub_outcomes[!not_avail, ]
        
        ## Return the name of hospital(s) in the requested state with 
        ## the lowest 30-day death rate

        cases_collected <- as.numeric(evaluation_list[, outcome_values])
        lowest_deathrates <- which(cases_collected == min(cases_collected))
        evaluated_hospitals <- evaluation_list[lowest_deathrates, 2]
        
        ## If there are multiple hospitals with the same minimum outcome value, then
        ## print the name of the first hospital from an alphabetically sorted list

        if (length(evaluated_hospitals) > 1) {
                hospital_sortlist <- sort(evaluated_hospitals)
                hospital_sortlist[1]
        }
        else {
                evaluated_hospitals
        }
}