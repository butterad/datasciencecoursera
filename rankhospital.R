## Part 3 - Ranking hospitals by outcome in a state (rankhospital.R)

## The `rankhospital` function takes three arguments: 
##  
##    state   - the 2-character abbreviated name of a state, 
##    outcome - an outcome, and 
##    num     - ranking of a hospital in that state for that outcome (num). 
##              NOTE: This argument can take values "best", "worst", or 
##              an integer indicating the ranking. If the number given 
##              is larger than the number of hospitals in that state, then 
##              the function returns NA

## The function reads the 'outcome-of-care-measures.csv' file and returns 
## a character vector with the name of the hospital that has the ranking 
## specified by the 'num' argument. 

## Example:
##
##      rankhospital("MD", "heart failure", 5)
##
## returns a character vector containing the name of the hospital 
## with the 5th lowest 30-day death rate for heart failure. 

## Hospitals with no data on a particular outcome are excluded from 
## the set of hospitals when deciding the rankings.

## In the cases where multiple hospitals have the same 30-day mortality rate
## for a given cause of death, ties are resolved by sorting on the hospital 
## name and printing the first hospital in the list.


## Set working directory
setwd("C:/DennisFiles/Coursera/R-workdir/ProgAssignment3-data")


## If no ranking value (num) is provided, "best" is used.

rankhospital <- function(state, outcome, num = "best") {

    ## Read "outcome-of-care-measures.csv" to return a character vector. Also
    ## identify what NA values exist in the CSV file.

    collectRank_data <- read.csv("outcome-of-care-measures.csv", 
        colClasses = "character", na.strings="Not Available")
        
    ## Check that 'state' and 'outcome' are valid.

        ## If an invalid 'outcome' value is passed, use the 'stop'
        ## function to display the message "invalid outcome".

        validOutcomes <- c("heart attack", "heart failure", "pneumonia")
        if (!outcome %in% validOutcomes) { stop("invalid outcome")}

        ## If an invalid 'state' value is passed, use the 'stop'
        ## function to display the message "invalid state". A 
        ## unique list is created to test against.

        validStates <- unique(collectRank_data[ , 7])
        if (!state %in% validStates) stop("invalid state")
       

    ## Return hospital name(s) in that state with the given rank of 30-day death rate

        ## Create a subset of the 'collectRank_data' with the desired state
        sub_collectRank_data <- subset(collectRank_data, State == state)

        ## Check the desired column from the data file and assign it's value  
        ## to 'outcome_values'. The CSV columns tested are as follows:
        ## 
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
        
        ## Check if the ranking value ('num') provided is greater than
        ## the number of hospitals in the requested 'state'. If so, 
        ## return "NA".

        if (is.numeric(num) == TRUE) {
                if (length(collectRank_data[,2]) < num) {
                        return(NA)
                }
        }

        ## Prepare the required columns and remove NA cases ("Not Available") 
        ## in the identified outcome column. 

        sub_collectRank_data[, outcome_values] <- 
            as.numeric(sub_collectRank_data[,outcome_values])
        not_avail <- is.na(sub_collectRank_data[,outcome_values])
        evaluation_list <- sub_collectRank_data[!not_avail, ]

        ## Return the name of hospitals ('hospital_list')in the requested
        ## state with the 30-day death rates ('cases_collected'). 

        cases_collected <- names(evaluation_list)[outcome_values]        
        hospital_list <- names(evaluation_list)[2]

        ## Arrange the result list in ascending order of the outcome values.

        index <- with(evaluation_list, order(evaluation_list[cases_collected],
                      evaluation_list[hospital_list]))
        ordered_evaluation_list <- evaluation_list[index, ]

        ## Check if the ranking value ('num') provided is either "best" or
        ## "worst". The value needs to be interpretted into a corresponding
        ## integer value ('1' for "best", or for "worst", the number
        ## reflecting the total cases in the list) indicating the ranking.

        if (is.character(num) == TRUE) {
                if (num == "best") {
                        num = 1
                }
                else if (num == "worst") {
                        num = length(evaluation_list[, outcome_values])
                }
        }

        ## Print the hospital name with the outcome ranking of num
        ordered_evaluation_list[num, 2]
}
