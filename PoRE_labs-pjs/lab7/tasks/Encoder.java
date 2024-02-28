import java.util.Random;

import static java.lang.Integer.parseInt;
import static java.lang.Integer.toHexString;


public class Encoder {
    public Encoder(){}
    private  String convertHexToString(String paramString) {
        StringBuilder stringBuilder = new StringBuilder();
        for (byte b = 0; b < paramString.length() - 1; b += 2)
            stringBuilder.append((char)(Integer.parseInt(paramString.substring(b, b + 2), 0x10) ^ 0xFF));
        return stringBuilder.toString();
    }
//    private static String convertHexToString(String paramString) {
//        StringBuilder stringBuilder = new StringBuilder();
//        for (byte b = 0; b < paramString.length() - 1; b += 2)
//            stringBuilder.append((char)(Integer.parseInt(paramString.substring(b, b + 2), 16) ^ 0xFF));
//        return stringBuilder.toString();
//    }
//    private static String convertHexToString(String p1){
//        StringBuilder v1 = new StringBuilder();
//        int   temp;
//        char c;
//        for(int i = 0 ; i < p1.length()-1 ; i = i+2){
//            String str = p1.substring(i,i+2);
//            temp = parseInt(str,(0x10));
//            temp = ((temp) ^ (0xff));
//            c = (char)temp;
//            v1.append(c);
//           // v1 = v1+c;
//        }
//
//
//        return v1.toString();
//
//    }

    public  String convertStringToHex(String p1){
        char v1[] = p1.toCharArray();
        StringBuffer v2 = new StringBuffer();
        for(int v0 = 0;v0<v1.length;v0 = v0+1){
            char temp = v1[v0];
            int  x = (temp ^ 0xff);
            v2.append(Integer.toHexString(x));
        }

        return v2.toString();
    }

    private byte[] getSalt(){

        byte[] v1 = new byte[6];
        for(int c=0;c<6;c++)v1[c] = 0;

        Random v2 = new Random();
        for(int v0 = 0;v0<v1.length;v0++){
            int v3 = 0xf;
            v3 = v2.nextInt(v3);
            byte temp = (byte)v3;
            v1[v0] = temp;
        }
        return v1;
    }
//    public static String decode(String p1){
//        if(p1.length() == 0)return "";
//        StringBuffer v2 = new StringBuffer();
//
//
//
//        for(int i = 0;i < p1.length(); i = i + 5){
//            String str1 = p1.substring(i,i+1);
//            int v3 = Integer.parseInt(str1,0x10);
//            v3 = v3 % 4;
//            v3 = 0x4 - v3;
//            StringBuilder v4 = new StringBuilder();
//            int v5 = i+0x1+v3 , v6 = i + 0x5;
//            String str2 = p1.substring(v5,v6);
//            v4.append(str2);
//            String str3 = p1.substring(i+1,i+1+v3);
//            v4.append(str3);
//            String str4 = v4.toString();
//            v2.append(  str4 );
//        }
//
//        String v0 = v2.toString();
//        v0 = convertHexToString(v0);
//        return v0.substring(0,0xb);
//
//    }
public  String decode(String paramString) {
    if (paramString.length() == 0)
        return "";
    StringBuffer stringBuffer = new StringBuffer();

    for (byte b = 0; b < paramString.length(); b += 5) {
        int i = 4 - (Integer.parseInt(paramString.substring(b, b + 1), 0x10) % 4 );
        stringBuffer.append(paramString.substring(b + 1 + i, b + 5) + paramString.substring(b + 1, i + b + 1));
    }
    return (convertHexToString(stringBuffer.toString())).substring(0, 0xb);
}
    public  String encode(String p1){
        if(p1.length()!=0xb){
            System.out.println("input error");
            System.out.println("");
            return "";
        }
        StringBuilder v0 = new StringBuilder() ;
        v0.append(p1);v0.append("a");
        String str = v0.toString();
        byte [] v1 = getSalt();
        String v2 = convertStringToHex(str);
        StringBuffer v3 = new StringBuffer();

        for(int i = 0 ;i < v2.length(); i = i+4){
            int tempInt = i/4;
            byte By = v1[tempInt];          //v4
            tempInt = By%4;                 //v5
            v3.append(Integer.toHexString(By));
            StringBuilder v4 = new StringBuilder();
            int v6 = tempInt + i;
            String tempstr1 = v2.substring(v6 ,i+0x4);
            v4.append(tempstr1);
            tempInt = tempInt + i;
            String str2 = (v2.substring(i,tempInt) );
            v4.append( str2);
            String str3 = (v4.toString());
            v3.append(str3);

        }
        return v3.toString();
    }
    

}
