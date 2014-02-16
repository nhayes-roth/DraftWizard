import java.io.*;

class DraftWizard {

	/* class variables */

	/* main function */
	public static void main(String[] args){
		downloadProjections();
		generateRankings();
	}

	/* 
	 * downloadProjections()
	 * Download Steamer projections from Fangraphs
	 */
	private static void downloadProjections(){

	}

	/* 
	 * generateRankings()
	 * Call script to generate rankings.
	 */
	private static void generateRankings(){
		String pwd = System.getProperty("user.dir");
		try {
			Runtime.getRuntime().exec("Rscript generateRankings.R " + pwd);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}