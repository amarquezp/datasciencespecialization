best <- function(state, outcome) {
  
  # Read outcome data as a text file on all columns (colClasses=character)
  outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  
  # Setting column indexes for the different outcomes
  heartAttackColumnIdx   <- 13
  heartFailureColumnIdx  <- 17
  pneumoniaColumnIdx     <- 23
  
  # coerce to numeric the "Hospital 30-Day Death (Mortality) Rates from Heart Attack" column
  outcomedata[, heartAttackColumnIdx] <- as.numeric(outcomedata[, heartAttackColumnIdx])
  
  # coerce to numeric the "Hospital 30-Day Death (Mortality) Rates from Heart Failure" column
  outcomedata[, heartFailureColumnIdx] <- as.numeric(outcomedata[, heartFailureColumnIdx])
  
  # coerce to numeric the "Hospital 30-Day Death (Mortality) Rates from Pneumonia" column
  outcomedata[, pneumoniaColumnIdx] <- as.numeric(outcomedata[, pneumoniaColumnIdx])
  
  # get the list of valid states, to validate state input param is valid
  listValidStates <- unique(outcomedata$State)
  
  #
  validateState(state, listValidStates)
  validateOutcome(outcome)
  
  # get a subset of list of hospitals from a state
  hospitalsByState <- subsetHospitalsByOutcomeAndState( outcomedata, state, outcome )
  
  hospitalsByState <- minColumn(hospitalsByState)
  
  hospitalsByState$Name
  ## Pending for heart failure and pneumonia
}

subsetHospitalsByOutcomeAndState <- function(hospitalsDataFrame, state, outcome){
	
	# Setting column indexes for the different outcomes
	heartAttackColumnIdx   <- 13
	heartFailureColumnIdx  <- 17
	pneumoniaColumnIdx     <- 23
	
	# outcome index: calculated based on the outcome parameter
	outcomeIdx <- -1
	
	
	# Setting Hospital Name index
	hospitalNameIdx <- 2
	
	if ( outcome == 'heart attack') outcomeIdx <- heartAttackColumnIdx
	else if ( outcome == 'heart failure' ) outcomeIdx <- heartFailureColumnIdx
	else if ( outcome == 'pneumonia' ) outcomeIdx <- pneumoniaColumnIdx
	
	# subset the hospitals data frame according our indexes
	hospitalsByState <- unique(hospitalsDataFrame[which(hospitalsDataFrame$State == state) ,c(hospitalNameIdx,outcomeIdx)])
	
	#change the name to the columns to be more readable
	names(hospitalsByState) <- c('Name', 'LowestDeathRate')
	
	# return the subset
	hospitalsByState[order(hospitalsByState$LowestDeathRate), ]
}


# Funtion: minColumn: Obtains the minimum value of a numeric column
# params: data - data.frame object. For this case, data.frame has the following format:
#		__________________________
# 		| Name | LowestDeathRate |
#		--------------------------
# result: a subset of data with the minimum row 
minColumn <- function(data) {
  
  data[which.min(data$LowestDeathRate), ]

}

# Funtion: validateState. Validates a state against a list of valid states. 
#          This is a helper function to separate validation from core data processing
# params: state - character object of the state to be validated
#         listValidStates - list object to which the 'state' will be validated against
# result: none, stops execution in case of validation error
validateState <- function(state, listValidStates) {
  
  if ( !is.element(state, listValidStates) ){
    stop(paste("the input state: ", state, " is not valid"))
    
  }
  
}

validateOutcome <- function(outcome) {
  # build the valid outcomes:
  listValidOutcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if ( is.null(outcome) ){
    stop(paste("the input outcome: NULL is not valid"))
  }
  
  if ( !is.element(outcome, listValidOutcomes) ){
    stop(paste("the input outcome: ", outcome, " is not valid"))
    
  }
  
}

