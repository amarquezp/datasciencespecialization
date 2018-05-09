
rankhospital <- function(state, outcome, num){
	
	# Read outcome data as a text file on all columns (colClasses=character)
	outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses="character")
	
	# Setting column indexes for the different outcomes
	heartAttackColumnIdx   <- 11
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
	validateNumRank(num)
	
	orderedHospitalsDf <- subsetHospitalsByRank(outcomedata, state, outcome)
	
	
	if ( num == "best" ) num = 1
	if (num == "worst" ) num = nrow(orderedHospitalsDf)
	
	orderedHospitalsDf[which(orderedHospitalsDf$Rank == num), ]
	
}

subsetHospitalsByRank <- function(hospitalsDataFrame, state, outcome){
	
	# Setting column indexes for the different outcomes
	heartAttackColumnIdx   <- 11 # 13 before
	heartFailureColumnIdx  <- 17
	pneumoniaColumnIdx     <- 23
	
	# outcome index: calculated based on the outcome parameter
	outcomeIdx <- -1
	
	
	# Setting Hospital Name index
	hospitalNameIdx <- 2
	
	if ( outcome == 'heart attack') outcomeIdx <- heartAttackColumnIdx
	else if ( outcome == 'heart failure' ) outcomeIdx <- heartFailureColumnIdx
	else if ( outcome == 'pneumonia' ) outcomeIdx <- pneumoniaColumnIdx
	
	print(paste("outcomeIdx ", outcomeIdx))
	
	# subset the hospitals data frame according our indexes
	hospitalsByState <- unique(hospitalsDataFrame[which(hospitalsDataFrame$State == state) ,c(hospitalNameIdx,outcomeIdx)])
	hospitalsByState$rank <- NA
	
	#change the name to the columns to be more readable
	names(hospitalsByState) <- c('Name', 'LowestDeathRate', 'Rank')
	
	#order.lowestRate <- order(hospitalsByState$LowestDeathRate)
	#hospitalsByState$Rank[order.lowestRate] <- 1:nrow(hospitalsByState)
	
	# hospitalsByState <- transform(hospitalsByState, Rank = ave(hospitalsByState$LowestDeathRate, hospitalsByState$LowestDeathRate,
	# 											 FUN = function(x) rank(-x, ties.method = "first"  )))
	
	hospitalsByState <- transform(hospitalsByState, Rank = rank(hospitalsByState$LowestDeathRate, ties.method = "last"  ))
	
	hospitalsByState <- hospitalsByState[with(hospitalsByState, order(Rank, Name)), ]
	
	hospitalsByState <- na.omit(hospitalsByState)
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

validateNumRank <- function(num){
	
	if ( !is.numeric(num) ){
		
		if ( ! (num %in% c("best", "worst")) ){
			
			stop(paste("the input 'num': ", num, " is not valid"))
		}
	}
}
