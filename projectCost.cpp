#include <iostream>
#include <fstream>
#include <iomanip>

using namespace std;

int main () 
{

  ofstream outputFile("costoftheproject.txt",ios::app);

  int OP=0;
  int NOP=0;
  int E=0;
  double totalCost=0.0;
  
  //Enter the labour rate per month here
  double labourRate=100000;
  
  //Enter Estimate Count
  int EC_screens=14;
  int EC_reports=6;
  int EC_components=10;
  

  //Enter Complex factor: Simple
  int simple_screens=1;
  int simple_reports=2;
  int simple_components=1;
  
  //Enter Complex factor: complex
  int complex_screens=3;
  int complex_reports=8;
  int complex_components=10;
  
  //Complex factor: Average
  int average_screens=(simple_screens+complex_screens)/2;
  int average_reports=(simple_reports+complex_reports)/2;
  int average_components=(simple_components+complex_components)/2;
  
  //cout<<average_screens<<endl;
  //cout<<average_reports<<endl;
  //cout<<average_components<<endl;
  
  //Choose the Environment Maturity
  int EM_veryLow=4;
  int EM_low=7;
  int EM_nominal=13;
  int EM_high=25;
  int EM_veryHigh=50;
  
  //Enter the reusability of the source code
  int reusePercentage=0;
  
  //Object point (OP) calculation
  //Formula, OP = Summation of (EC x CF_average)
  OP=(EC_screens * average_screens) + (EC_reports * average_reports) + (EC_components * average_components);
  //cout<<"OP "<<OP<<endl;
  
  //New Object point (NOP) calculation
  //Formula: NOP = OP x ((100 - reusePercentage)/100)
  NOP = OP * (100 - reusePercentage)/100;
  //cout<<"NOP "<<NOP<<endl;

  //setting the precision  
  outputFile<<setprecision(2)<<std::fixed;

  //effort_man_per_month calculation
  //Formula: effort_man_per_month,E= NOP/EM 
  E=NOP/EM_nominal;
  outputFile<<"\nThe new effort: man per month will be: "<<E<<endl;
  
  //Cost of the project
  //Formula: cost=(labour rate / EM) x NOP
  //http://sunset.usc.edu/research/COCOMOII/Docs/modelman.pdf	
  totalCost=(labourRate / EM_nominal) * NOP;
  outputFile<<"\nCost of the project will be: \n"<<totalCost;
  
outputFile.close();

return 0;
}
