import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.*;
import java.util.*;

public class costInWords{

final private  static String[] units ={"Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen",
    "Sixteen","Seventeen","Eighteen","Nineteen"};
final private static String[] tens = {"","","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"};

public static void main(String[] args){ 

	//Need to read the file and write the output in a file
	double i=0.0;
	
	BufferedReader br = null;
 
		try {
 
			String sCurrentLine;
 
			br = new BufferedReader(new FileReader("java-costoftheproject.txt"));
 
			while ((sCurrentLine = br.readLine()) != null) {
				//System.out.println(sCurrentLine);
				i=Double.parseDouble(sCurrentLine);
				
			}
 
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		
	try {
            BufferedWriter out = new BufferedWriter(new FileWriter("costInWords.txt"));
            //out.write("In words:");
            out.write("\n[ Only "+convert((int)i)+" Taka & ");
            out.write(convert(i)+" ]");
            out.close();
        }
        catch (IOException e)
        {
            System.out.println("Exception ");       
        }

	//System.out.print("Only "+convert((int)i)+" Taka");
	//System.out.print(" & "+convert(i));
}

public static String convert(Integer i) {
	if( i < 20)  return units[i];
	if( i < 100) return tens[i/10] + ((i % 10 > 0)? " " + convert(i % 10):"");
	if( i < 1000) return units[i/100] + " Hundred" + ((i % 100 > 0)?" and " + convert(i % 100):"");
	if( i < 1000000) return convert(i / 1000) + " Thousand " + ((i % 1000 > 0)? " " + convert(i % 1000):"") ;
return convert(i / 1000000) + " Million " + ((i % 1000000 > 0)? " " + convert(i % 1000000):"") ;
}

public static String convert(Double i) {
	int cents;
  	cents = (int)Math.round(i * 100 % 100);

	String result = convert(cents);
return result+" poisha";
}

}
