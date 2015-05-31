## Part 4 - Ranking hospitals in all states (rankall.R)

## The 'rankall' function takes two arguments: 
##
##    outcome - an outcome name, and
##    num     - a hospital ranking 

## The function reads the 'outcome-of-care-measures.csv' file and returns 
## a 2-column data frame containing the hospital in each state that has 
## the ranking specified by the 'num' argument. 

## Example 
##
##      rankall("heart attack", "best") 
##
## returns a data frame containing the names of the hospitals that are the 
## best in their respective states for 30-day heart attack death rates. 

## A value for every state (some may be NA) is returned. The data frame should conmtain: 
##
##     'hospital' - first column which contains the hospital name, and 
##     'state'    - the second column which contains the 2-character abbreviation for 
##                  the state name. 

## Hospitals that do not have data on a particular outcome will be excluded 
## from the set of hospitals when deciding the rankings. 

## In the cases where multiple hospitals have the same 30-day mortality rates
## for a given cause of death, ties are resolved by sorting on the hospital 
## name and printing the first hospital in the list.


## Set working directory
setwd("C:/DennisFiles/Coursera/R-workdir/ProgAssignment3-data")


## If no ranking value (num) is provided, "best" is used.

rankall <- function(outcome, num = "best") {

    ## Read "outcome-of-care-measures.csv" to return a character vector. Also
    ## identify what NA values exist in the CSV file.

    RankAll_data <- read.csv("outcome-of-care-measures.csv", 
        colClasses = "character", na.strings="Not Available")
        
    ## Check that 'state' and 'outcome' are valid.

        ## If an invalid 'outcome' value is passed, use the 'stop'
        ## function to display the message "invalid outcome".

        validOutcomes <- c("heart attack", "heart failure", "pneumonia")
        if (!outcome %in% validOutcomes) { stop("invalid outcome")}

        ## If an invalid 'state' value is passed, use the 'stop'
        ## function to display the message "invalid state". A 
        ## unique list is created to test against.

        ## validStates <- unique(RankAll_data[ , 7])
        ## if (!state %in% validStates) stop("invalid state")

    ## For each state, find the hospital of the given rank

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


    ## For each state, find the hospital of the given rank

        ## Create a data frame with the hospital names, the state name, and outcome values

	hospitalNames <- RankAll_data$Hospital.Name
	stateLocation <- RankAll_data$State
	outcome <- RankAll_data[,outcome_values]
	hospitalList <- cbind(stateLocation, hospitalNames, outcome)

        ## Return a data frame without hospitals that do not have data on an outcome 

	hospitalListclean <- subset(hospitalList, hospitalList[,3] != "Not Available")

	## Create an ordered list of data alphabetically by hospital names (second column).
	orderHospitals <- hospitalListclean[order(hospitalListclean[,2]),]

	## Now re-populate the 'hospitalList' with cases ordered on mortality rate (column 3) 
	hospitalList <- orderHospitals[order(as.numeric(orderHospitals[,3])),]

	States <- sort(unique(hospitalList[,1]))
	hospitals <- vector()
	for (state in States) {
		orderHospitals <- subset(hospitalList, hospitalList[,1] == state)

		if (num != "best" && num != "worst" && num > nrow(orderHospitals)) {
			hospitalName <- "<NA>"
		} else {
			if (num == "best") {
				hospitalName <- orderHospitals[[1,2]]
			} else if (num == "worst") {
				hospitalName <- orderHospitals[[nrow(orderHospitals),2]]
			} else {
				hospitalName <- orderHospitals[[num,2]]
			}
		}
		hospitals <- append(hospitals, hospitalName)
	}

	hospitalResultList <- data.frame(hospital=hospitals, state=States)
	return(hospitalResultList)
}