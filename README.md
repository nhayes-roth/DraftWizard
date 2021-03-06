DraftWizard
--
This package uses standard z-scores to rank baseball players's fantasy value. Projections are read from .csv files into R data-frames; relevant statistics are calculated and added to the data; and the updated data is output to new .csv files.

Instructions to run
--
Compile the program: 

`make`

Execute the program:

`make run`

*Note: this program requires Java and R to be installed on your machine.*

What's next?
--
1. GenerateRankings.R
- Pitchers
- Factor in kept players
2. DraftWizard.py
- Automatically download data from web
- Select data source(s)
3. Rankings.xlsx
- Automatically populate from resulting .csv file(s)
- Actual draft day functions (assign to team, remove from pop, etc.)
4. README.md
- Add explanation of statistical techniques 