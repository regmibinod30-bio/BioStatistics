/* Calculating relative risk of getting cancer among smokers and non smokers
The data for this demo was taken from sas inbuilt data library */


data diseasetest;
	attrib result length = $10;
	input result $ disease $ weight;
	datalines;
	positive present 240
	positive absent 40
	negative present 60
	negative absent 160
	;
proc freq data = diseasetest order = freq;
	tables result * disease;
	weight weight;
	
Data attributable;
	set sashelp.heart;
	
/* proc print data=sashelp.heart; */
	if ageatstart < 36 then agegroup = "28-35";
		else if ageatstart < 46 then agegroup = "36-45";
		else if ageatstart < 56 then agegroup = "46-55";
		else if ageatstart > 55 then agegroup = "56-62";
		
	if missing (smoking_status) = 0 and (smoking_status) NE "Non-smoker"
		then smoker = "YES";
		else if missing(smoking_status) = 0 then smoker = "_NO";
	if deathcause = "Cancer" then cancer = "Yes";
		else cancer = "_NO" ;
	if cancer = "" or smoker = "" or agegroup = "" then delete;
	
proc freq data = attributable;
	tables smoker*cancer / RELRISK RISKDIFF;
		
proc logistic data=attributable;
model cancer=smoker;





	