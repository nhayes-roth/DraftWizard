# import statements
import subprocess

# run the R script as a subprocess
subprocess.call("Rscript GenerateRankings.R --args arg1 arg2", shell=True)
