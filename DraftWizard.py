"""
DraftWizard, 2014
By Nathan Hayes-Roth
"""
#############################
# import statements
#############################
import requests
import subprocess
import mechanize
import urllib
import urllib2
import csv


#############################
# default variable values
#############################
url_prefix	= 'http://www.fantasypros.com/mlb/projections/'
url_suffix 	= '.php?export=xls'
positions	= set(['hitters', 'pitchers', '1b', '2b', '3b', 'ss', 'c', 'of', 'sp', 'rp', 'dh'])
hitters		= set(['1b', '2b', '3b', 'ss', 'of', 'c'])
pitchers	= set(['sp', 'rp'])
chosen		= set(['hitters', 'pitchers'])

#############################
# welcome the user
#############################
def setup():
	print "\n**********************"
	print "Welcome to DraftWizard"
	print "**********************\n"
	while True:
		user_input = raw_input("Would you like to choose custom settings? (yes or no)")
		#  empty response or no => continue
		if not user_input or user_input[0].lower() == 'n':
			break
		elif user_input[0].lower()=='y':
			choosePositions()
			break

def choosePositions():
	global chosen
	# choose your options
	chosen.clear()
	print "Please choose positions (hitters, pitchers, 1b, 2b, 3b, ss, of, sp, rp)."
	print "\t(append -r to remove positions.)"
	print "\t(press return to continue.)\n"
	while True:
		# simplify if possible
		simplify('pitchers', pitchers)
		simplify('hitters', hitters)
		# print chosen positions at this point
		printChosenPositions()
		# read new positions from user
		if not getNewPosition():
			break
	# catch empty choices
	if len(chosen) == 0:
		print "No choice defaults to 'hitters' and 'pitchers'."
		chosen = set(['hitters', 'pitchers'])

def simplify(position, category):
	global chosen
	if position in chosen or chosen.issuperset(category):
		chosen.add(position)
		for pos in category:
			chosen.discard(pos)

def printChosenPositions():
	# print the currently chosen positions
	psf = ""
	for pos in sorted(chosen):
		psf = psf + pos + " "
	print "\nPositions so far:", psf

# get a new position from the user
# 		- return true to continue
# 		- return false to exit
def getNewPosition():
	global chosen
	user_input = raw_input()
	if not user_input:
		return False
	elif user_input in positions:
		chosen.add(user_input)
		return True
	# remove elements
	elif user_input[-2:] == '-r':
		removePosition(user_input[:-3])
		return True
		
	else:
		print "Sorry,", user_input, "isn't a position."
		print "Please choose positions (hitters, pitchers, 1b, 2b, 3b, ss, of, sp, rp)."
		print "\t(append -r to remove positions.)"
		print "\t(press return to continue.)\n"
		return True

def removePosition(position):
	global chosen
	# replace hitters with each position
	if position in hitters and 'hitters' in chosen:
		chosen.discard('hitters')
		for pos in hitters:
			chosen.add(pos)
		chosen.discard(position)
	# replace pitchers with each type
	elif position in pitchers and 'pitchers' in chosen:
		chosen.discard('pitchers')
		for pos in pitchers:
			chosen.add(pos)
		chosen.discard(position)
	else:
		chosen.discard(position)

def main():
	setup()
	for pos in chosen:
		urllib.urlretrieve(url_prefix+pos+url_suffix, './projections/projection-'+pos+'.csv')
	# run the R script as a subprocess
	subprocess.call("Rscript GenerateRankings.R --args arg1 arg2", shell=True)
	print "success"

if __name__ == '__main__':
    main()