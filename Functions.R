# Nathan Hayes-Roth
# Fantasy Baseball Draft 2014

calculateBatterValue = function(data, replacement_level){
	# z-scores
	data = cbind(data, zR  		=(data$runs   - mean(data$runs))   / sd(data$runs))
	data = cbind(data, zhrs 	=(data$hrs  - mean(data$hrs))  / sd(data$hrs))
	data = cbind(data, zrbi		=(data$rbi - mean(data$rbi)) / sd(data$rbi))
	data = cbind(data, zsb 		=(data$sb  - mean(data$sb))  / sd(data$sb))
	data = cbind(data, zave 	=(data$ave - mean(data$ave)) / sd(data$ave))
	data = cbind(data, zops 	=(data$ops - mean(data$ops)) / sd(data$ops))
	# weighted ave and ops
	data = cbind(data, wave=(data$zave*data$ab))
	data = cbind(data, wops		=(data$zops*data$ab))
	data = cbind(data, zwave	=(data$wave - mean(data$wave)) / sd(data$wave))
	data = cbind(data, zwops	=(data$wops - mean(data$wops)) / sd(data$wops))
	# value
	data = cbind(Val=(data$zR+data$zhrs+data$zrbi+data$zsb+data$zwave+data$zwops), data)
	# sort by Value
	data = data[order(-data$Val),]
	# adjust by replacement value
	data$Val = data$Val - data$Val[replacement_level]
	return(data)
}

# note: baa isn't a stat so multiply whip x 2
# note: discount by weight
rankPitchers = function(data, replacement_level, weight){
	# z scores
	data = cbind(data, zk 		= (data$k - mean(data$k))/sd(data$k))
	data = cbind(data, zw 		= (data$w - mean(data$w))/sd(data$w))
	data = cbind(data, zsv 		= (data$sv - mean(data$sv))/sd(data$sv))
	data = cbind(data, zera 	= (data$era - mean(data$era))/sd(data$era))
	data = cbind(data, zwhip 	= (data$whip - mean(data$whip))/sd(data$whip))
	# weighted era and whip
	data = cbind(data, wera		=(data$zera*data$ip))
	data = cbind(data, wwhip	=(data$zwhip*data$ip))
	data = cbind(data, zwera	=(data$wera - mean(data$wera)) / sd(data$wera))
	data = cbind(data, zwwhip	=(data$wwhip - mean(data$wwhip)) / sd(data$wwhip))
	# add val column
	data = cbind(Val=weight*(data$zk+data$zw+data$zsv-data$zwera-2*data$zwwhip), data)
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