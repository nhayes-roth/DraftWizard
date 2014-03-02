# Nathan Hayes-Roth
# Fantasy Baseball Draft 2014

calculateBatterValue = function(data, replacement_level){
	# z-scores
	data = cbind(data, zR  =(data$runs   - mean(data$runs))   / sd(data$runs))
	data = cbind(data, zhrs =(data$hrs  - mean(data$hrs))  / sd(data$hrs))
	data = cbind(data, zrbi=(data$rbi - mean(data$rbi)) / sd(data$rbi))
	data = cbind(data, zsb =(data$sb  - mean(data$sb))  / sd(data$sb))
	data = cbind(data, zave=(data$ave - mean(data$ave)) / sd(data$ave))
	data = cbind(data, zops=(data$ops - mean(data$ops)) / sd(data$ops))
	# weighted ave and ops
	data = cbind(data, wave=(data$zave*data$ab))
	data = cbind(data, wops=(data$zops*data$ab))
	data = cbind(data, zwave=(data$wave - mean(data$wave)) / sd(data$wave))
	data = cbind(data, zwops=(data$wops - mean(data$wops)) / sd(data$wops))
	# value
	data = cbind(Val=(data$zR+data$zhrs+data$zrbi+data$zsb+data$zwave+data$zwops), data)
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