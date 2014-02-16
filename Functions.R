# Nathan Hayes-Roth
# Fantasy Baseball Draft 2014

calculateBatterValue = function(data, replacement_level){
	# z-scores
	data = cbind(data, zR  =(data$R   - mean(data$R))   / sd(data$R))
	data = cbind(data, zHR =(data$HR  - mean(data$HR))  / sd(data$HR))
	data = cbind(data, zRBI=(data$RBI - mean(data$RBI)) / sd(data$RBI))
	data = cbind(data, zSB =(data$SB  - mean(data$SB))  / sd(data$SB))
	data = cbind(data, zAVG=(data$AVG - mean(data$AVG)) / sd(data$AVG))
	data = cbind(data, zOPS=(data$OPS - mean(data$OPS)) / sd(data$OPS))
	# weighted AVG and OPS
	data = cbind(data, wAVG=(data$zAVG*data$AB))
	data = cbind(data, wOPS=(data$zOPS*data$AB))
	data = cbind(data, zwAVG=(data$wAVG - mean(data$wAVG)) / sd(data$wAVG))
	data = cbind(data, zwOPS=(data$wOPS - mean(data$wOPS)) / sd(data$wOPS))
	# value
	data = cbind(Val=(data$zR+data$zHR+data$zRBI+data$zSB+data$zwAVG+data$zwOPS), data)
	# sort by Value
	data = data[order(-data$Val),]
	# adjust by replacement value
	data$Val = data$Val - data$Val[replacement_level]
	return(data)
}

# applyToEach(list, func)
# 	Takes a list of items and a function
# 	and applies the provided function on each
applyToEach = function(list, func){
	for (item in list){
		func(item)
	}
}

# loadData(position)
# 	Loads the provided positional data from a .csv file
# TODO: this doesn't work
# loadData = function(position){
# 	print(position)
# 	projections = 
# 		rbind(projections, read.csv(paste(PROJECTIONS_DIRECTORY, position, '.csv', sep='')))
# }