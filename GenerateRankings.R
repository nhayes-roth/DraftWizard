# Nathan Hayes-Roth
# Fantasy Baseball Draft 2014

######################
# Setup
######################
rm(list = ls())
setwd('/Users/nhayes-roth/Dropbox/Workspace/DraftWizard/')

######################
# Class Variables
######################
POSITIONS = c('c', 'b1', 'b2', 'b3', 'ss', 'of')
STATS_B = c('R', 'HR', 'RBI', 'SB', 'AVG', 'OPS')
STATS_P = c('K', 'W', 'SV', 'BAA', 'ERA', 'WHIP')
MIN_AB = 250	# limit the data to relevant players
WORKING_DIRECTORY = getwd()
PROJECTIONS_DIRECTORY = paste(WORKING_DIRECTORY, sep='/', "Projections/")
source(paste(WORKING_DIRECTORY, sep='/', 'Functions.R'))

######################
# Load projections from .csv
######################
c = read.csv(paste(PROJECTIONS_DIRECTORY, sep='', 'c.csv'))
b1 = read.csv(paste(PROJECTIONS_DIRECTORY, sep='', 'b1.csv'))
b2 = read.csv(paste(PROJECTIONS_DIRECTORY, sep='', 'b2.csv'))
b3 = read.csv(paste(PROJECTIONS_DIRECTORY, sep='', 'b3.csv'))
ss = read.csv(paste(PROJECTIONS_DIRECTORY, sep='', 'ss.csv'))
of = read.csv(paste(PROJECTIONS_DIRECTORY, sep='', 'of.csv'))

######################
# Limit the batters based on AB
######################
c = c[c$AB>MIN_AB,]
b1 = b1[b1$AB>MIN_AB,]
b2 = b2[b2$AB>MIN_AB,]
b3 = b3[b3$AB>MIN_AB,]
ss = ss[ss$AB>MIN_AB,]
of = of[of$AB>MIN_AB,]

######################
# Add position column to each
######################
c  = cbind( c, Position = 'c')
b1 = cbind(b1, Position = 'b1')
b2 = cbind(b2, Position = 'b2')
b3 = cbind(b3, Position = 'b3')
ss = cbind(ss, Position = 'ss')
of = cbind(of, Position = 'of')

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
write.csv(util, file='batters.csv')