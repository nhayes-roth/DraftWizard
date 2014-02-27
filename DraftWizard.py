"""
DraftWizard, 2014
By Nathan Hayes-Roth
"""
#############################
# import statements
#############################
import subprocess
import mechanize

#############################
# default variable values
#############################
player_type = 'bat'
position	= 'all'
source		= 'steamer'

#############################
# welcome the user
#############################
print "\n**********************"
print "Welcome to DraftWizard"
print "**********************\n"
user_input = ''
while True:
	user_input = raw_input("Would you like to choose custom settings? (yes or no)")
	#  empty response => continue
	if not user_input:
		break
	elif user_input[0].lower()=='y':
		print "Sorry, that isn't implemented yet. Check back soon."
		break
	elif user_input[0].lower()=='n':
		print "Got it, we'll use our standard settings."
		break

# create mechanize browser
b = mechanize.Browser()
b.open('http://www.fangraphs.com/projections.aspx?pos=all&stats=bat&type=steamer&team=0&players=0')

# run the R script as a subprocess
subprocess.call("Rscript GenerateRankings.R --args arg1 arg2", shell=True)
