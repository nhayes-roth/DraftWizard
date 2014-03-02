# Nathan Hayes-Roth
# Fantasy Baseball Draft 2014
 	 
 	 

######################
# Setup
######################
rm(list = ls())																# cleanup whatever's there
setwd('/Users/nhayes-roth/Dropbox/Workspace/DraftWizard/')					# set the working directory
POSITIONS = c('c', 'b1', 'b2', 'b3', 'ss', 'of')							# positions of interest TODO: pass in as command line arguments
STATS_B = c('R', 'HR', 'RBI', 'SB', 'AVG', 'OPS')							# statistics of interest TODO: "	"	"	"	"	"	"
STATS_P = c('K', 'W', 'SV', 'BAA', 'ERA', 'WHIP')							# ditto
MIN_AB = 250																# limit the data to relevant players
WORKING_DIRECTORY = getwd()													# working 		directory shortcut
PROJECTIONS_DIRECTORY = paste(WORKING_DIRECTORY, sep='/', "Projections/")	# projections 	directory shortcut
RESULTS_DIRECTORY = paste(WORKING_DIRECTORY, sep='/', "Results/")			# results 		directory shortcut
source(paste(WORKING_DIRECTORY, sep='/', 'Functions.R'))					# load helper functions from other file

######################
# Load projections from .csv
######################
# hitters
content = readLines(paste(PROJECTIONS_DIRECTORY, sep='', 'projections-hitters.csv'))
content = content[-1]
content = content[-1]
content = content[-1]
content = content[-1]
hitters = read.csv(textConnection(content), sep='\t')
rownames(hitters) = hitters[,1]

# pitchers
content = readLines(paste(PROJECTIONS_DIRECTORY, sep='', 'projections-pitchers.csv'))
content = content[-1]
content = content[-1]
content = content[-1]
content = content[-1]
pitchers = read.csv(textConnection(content), sep='\t')
rownames(pitchers) = pitchers[,1]

######################
# Separate by position for calculations
######################
# catchers
c = hitters[grepl("C", hitters$Position),]
c = c[!grepl("CF", c$Position),]
# 1st base
b1 = hitters[grepl("1B", hitters$Position),]
# 2nd base
b2 = hitters[grepl("2B", hitters$Position),]
# 3rd base
b3 = hitters[grepl("3B", hitters$Position),]
# short stop
ss = hitters[grepl("SS", hitters$Position),]
# outfield
of = hitters[grepl("OF", hitters$Position) | grepl("LF", hitters$Position) | grepl("CF", hitters$Position) | grepl("RF", hitters$Position),]

######################
# Limit the batters based on AB
######################
c = c[c$ab>MIN_AB,]
b1 = b1[b1$ab>MIN_AB,]
b2 = b2[b2$ab>MIN_AB,]
b3 = b3[b3$ab>MIN_AB,]
ss = ss[ss$ab>MIN_AB,]
of = of[of$ab>MIN_AB,]

######################
# Calculate values
######################
c = calculateBatterValue(c, 13)
b1 = calculateBatterValue(b1, 24)
b2 = calculateBatterValue(b2, 19)
b3 = calculateBatterValue(b3, 18)
ss = calculateBatterValue(ss, 17)
of = calculateBatterValue(of, 63)

# TODO: pitchers
# starting pitcher
replacement = 63
# relief pitcher
replacement = 37

######################
# Rank all hiters
######################


######################
# Cleanup
######################

######################
# Write results to csv file(s)
######################
util = merge(b2, b1, all=TRUE)
util = merge(util, c, all=TRUE)
util = merge(util, b3, all=TRUE)
util = merge(util, ss, all=TRUE)
util = merge(util, of, all=TRUE)
util = util[order(-util$Val),]
write.csv(util, file=paste(RESULTS_DIRECTORY, sep="", 'batter-rankings.csv'))