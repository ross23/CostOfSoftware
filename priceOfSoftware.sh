#!/bin/bash  

clear
echo -e "\n========================================================================================"
echo -e "\n============================================================================">>head.txt
echo "                                         Welcome"
echo "                                 Price of the Software"
echo "Price of the Software">>head.txt
echo "    Usage: sh priceOfSoftware [path of the folder name] [Per employee salary per month]" 
echo "                Note: Change the salary on line 18 of projectCost.cpp"
echo "                       Example: sh priceOfSoftware reciepe 100000"
echo "============================================================================">>head.txt
echo "========================================================================================"

echo "Name of the Software: ">>head.txt
stat --printf=%n $1>>name.txt
sed 's,/, ,g' name.txt>>name1.txt
echo -e "$(awk '{print $5;}' name1.txt)\n">>head.txt
echo -e "\n"
echo

#counting total number of lines in a folder 
cloc --report-file=lines.txt $1


#total number of lines in the source code
a=`grep -a "SUM" lines.txt|(awk '{print $5;}';)`

echo "">>cost.txt
echo -e "\nRESULTS">>cost.txt
echo "***************************************************************************">>cost.txt

#http://www.dis.uniroma1.it/~pingsw/ping0506/doc/COCOMOIIManual.pdf
#http://yunus.hun.edu.tr/~sencer/cocomo.html
#formula E=ab * ((KLOC)^bb)
#Formula: KLOC -->expressed in thousands
echo -e "\nEffort Applied:">>cost.txt
KLOC=`echo "($a / 1000)" |bc`
E=$(awk "BEGIN{print 2.4 * ($KLOC ** 1.05 )}")
echo "$E Person-months">>cost.txt

#Formula: cb*((Effort Applied)^db)
echo -e "\nDevelopment Time:">>cost.txt
D=$(awk "BEGIN{print 2.5 * ($E ** 0.38 )}")
echo "$D Months">>cost.txt

#Formula: Effort Applied / Development Time [count]
echo -e "\nPeople required:">>cost.txt
echo "$E / $D "|bc -l>>cost.txt

echo -e "\nSoftware Size: Source Lines of Code:">>cost.txt
echo "$a SLOC">>cost.txt

echo -e "\nSoftware Labor Rates">>cost.txt
echo "Cost per Person-Month (taka):">>cost.txt
echo "$2 taka">>cost.txt

#http://www.softstarsystems.com/cdtable.htm
#http://www.academia.edu/5890544/Measuring_Effectiveness_of_COCOMO_I_and_COCOMO_II_Using_a_Case_Study
#https://www.academia.edu/7591659/COCOMO_II_Model_Parameter_Optimization_using_PSO_and_Effort_Estimation


#Calculating the total cost of the software
g++ projectCost.cpp -o p
./p


cat costoftheproject.txt| tr ' ' '\n' | tail -1>>java-costoftheproject.txt
#http://www.coderanch.com/t/589409/java/java/Check-Writing-System
javac costInWords.java
java costInWords

sed '1d' lines.txt>>lines1.txt
cat head.txt lines1.txt cost.txt costoftheproject.txt costInWords.txt>>totalPrice.txt

libreoffice --headless --convert-to odt totalPrice.txt
libreoffice --headless --convert-to pdf totalPrice.odt

echo "================================================"
echo "              Opening the results"
echo "================================================"
export $(dbus-launch)
okular totalPrice.pdf

#clear
#removing the files
rm -rf lines.txt head.txt totalPrice.txt cost.txt totalPrice.odt p costoftheproject.txt name.txt name1.txt lines1.txt java-costoftheproject.txt costInWords.txt costInWords.class



echo "========================================================================================"
echo "                                 Say thanks all the authors"
echo "========================================================================================"
