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
WEIGHTS_B = c(1, 1, 1, 1, 1, 1)
WEIGHTS_P = c(1, 1, 1, 1, 1, 1)
MIN_AB = 250	# limit the data to relevant players
WORKING_DIRECTORY = getwd()
PROJECTIONS_DIRECTORY = paste(WORKING_DIRECTORY, sep='/', "Projections/")
# source(paste(WORKING_DIRECTORY, sep='/', 'Functions.R'))

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
# Build utility data frame
######################
util = merge(b2, b1, all=TRUE)
util = merge(util, c, all=TRUE)
util = merge(util, b3, all=TRUE)
util = merge(util, ss, all=TRUE)
util = merge(util, of, all=TRUE)

##################################################################
# Calculate values
##################################################################
stats = matrix(nrow=length(STATS_B), ncol=2, 
			   dimnames=list(STATS_B, c("Mean", "SD")))

######################
# Catcher
######################
replacement = 13
# mean
stats[1,1] = mean(c$R)
stats[2,1] = mean(c$HR)
stats[3,1] = mean(c$RBI)
stats[4,1] = mean(c$SB)
stats[5,1] = mean(c$AVG)
stats[6,1] = mean(c$OPS)
# standard deviation
stats[1,2] = sd(c$R)
stats[2,2] = sd(c$HR)
stats[3,2] = sd(c$RBI)
stats[4,2] = sd(c$SB)
stats[5,2] = sd(c$AVG)
stats[6,2] = sd(c$OPS)
# z-scores
c = cbind(c, zR  =(c$R  -stats[1,1])/stats[1,2])
c = cbind(c, zHR =(c$HR -stats[2,1])/stats[2,2])
c = cbind(c, zRBI=(c$RBI-stats[3,1])/stats[3,2])
c = cbind(c, zSB =(c$SB -stats[4,1])/stats[4,2])
c = cbind(c, zAVG=(c$AVG-stats[5,1])/stats[5,2])
c = cbind(c, zOPS=(c$OPS-stats[6,1])/stats[6,2])
# weighing AVG and OPS

# first
replacement = 24
# second
replacement = 19
# third
replacement = 18
# shortstop
replacement = 17
# outfield
replacement = 63
# starting pitcher
replacement = 63
# relief pitcher
replacement = 37

######################
# Cleanup
######################

######################
# Add VAR for each position
######################
# capture.output('test', file='test.txt')
# capture.output(commandArgs(trailingOnly = TRUE)[1], file='pwd.txt')

