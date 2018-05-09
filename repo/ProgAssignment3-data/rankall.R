
rankall <- function(outcome, num = "best"){
	
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
	
	#
	validateOutcome(outcome)
	validateNumRank(num)
	
	# get the list of valid states, to validate state input param is valid
	listOfStates <- unique(outcomedata$State)
	ranking.all.States <- data.frame(c('Name','State', 'LowestDeathRate', 'Rank'))[0,]
	#ranking.all.States <- ranking.all.States[0, ]
	
	for ( state in listOfStates ){
		
		rankedHospitalsByState <- rankHospitalByState(outcomedata, state, outcome, num)
		
		if ( nrow(rankedHospitalsByState) > 0 ){
			
			ranking.all.States <- rbind(ranking.all.States, rankedHospitalsByState)
			
		} 
	}

	
	ranking.all.States <- ranking.all.States[with(ranking.all.States, order(State, Name)), ]
	
	ranking.all.States
}



rankHospitalByState <- function(outcomedata, state, outcome, num){
	
	#prank <- num
	rankedHospitalsByState <- subsetHospitalsByRank(outcomedata, state, outcome, num)
	
	if ( num == "best" ) num = 1
	else if (num == "worst" ) num = nrow(rankedHospitalsByState)
	#else prank = num
	
	
	rankedHospitalsByState[which(rankedHospitalsByState$Rank == num), ]
	
}


subsetHospitalsByRank <- function(hospitalsDataFrame, state, outcome, prank){
	
	# Setting column indexes for the different outcomes
	heartAttackColumnIdx   <- 11
	heartFailureColumnIdx  <- 17
	pneumoniaColumnIdx     <- 23
	
	# outcome index: calculated based on the outcome parameter
	outcomeIdx <- -1
	
	
	# Setting Hospital Name index
	hospitalNameIdx <- 2
	hospitalState <- 7
	
	if ( outcome == 'heart attack') outcomeIdx <- heartAttackColumnIdx
	else if ( outcome == 'heart failure' ) outcomeIdx <- heartFailureColumnIdx
	else if ( outcome == 'pneumonia' ) outcomeIdx <- pneumoniaColumnIdx
	
	
	
	# subset the hospitals data frame according our indexes
	hospitalsByState <- unique(hospitalsDataFrame[which(hospitalsDataFrame$State == state) ,c(hospitalNameIdx, hospitalState, outcomeIdx)])
	
	hospitalsByState <- na.omit(hospitalsByState)
	
	hospitalsByState$Rank <- NA
	
	#change the name to the columns to be more readable
	names(hospitalsByState) <- c('Name','State', 'LowestDeathRate', 'Rank')
	
	if ( prank == "best" ) prank = 1
	else if (prank == "worst" ) prank = nrow(hospitalsByState)
	
	
	
	if ( prank > nrow(hospitalsByState) ){
		hospitalsByState = data.frame(Name=NA, State=state, LowestDeathRate=NA, Rank=prank)
	}
	else{
		hospitalsByState <- hospitalsByState[with(hospitalsByState, order(State, Name)), ]
		#hospitalsByState <- transform(hospitalsByState, Rank = rank(hospitalsByState$LowestDeathRate, ties.method = "first", na.last = NA  ))
		hospitalsByState$Rank <- rank(hospitalsByState$LowestDeathRate, ties.method = "first", na.last = NA  )
	}
	
	hospitalsByState
	#hospitalsByState <- na.omit(hospitalsByState)
}



# Funtion: validateState. Validates a state against a list of valid states. 
#          This is a helper function to separate validation from core data processing
# params: state - character object of the state to be validated
#         listValidStates - list object to which the 'state' will be validated against
# result: none, stops execution in case of validation error
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
