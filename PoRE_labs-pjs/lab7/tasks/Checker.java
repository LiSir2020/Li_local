import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;

public class Checker{

    byte[] secret = {0x70, 0x64, 0x64, 0x44, 0x1f, 0x5, 0x72, 0x78};

    private static byte charToBytesAscii(char c) {
        return (byte) c;
    }

    private boolean checkStr1(String s){
        int v2 = s.length();
        for(int v0 = 0; v0 < v2; v0++){
            byte cc2 = Checker.charToBytesAscii(s.charAt(v0));

            byte value = (byte) (11 * v0);
            cc2 =(byte) (cc2 ^ value);

            byte v3 = secret[v0];
            if(cc2 != v3) return false;
        }
        return true;
    }

    private boolean checkStr2(String s){
        int v1 = Integer.valueOf(s).intValue();
        try{
            int v2 = v1;
            if(v2 < 0x3e8) return false;//1000 == 0x3e8
            else{
                v2 = v2 % 16;
                if(v2 % 16 == 0 || v2 % 27 == 0) return true;
                else{
                    if(v1 % 10 == 8) return true;
                    else    return false;
                }
            }
        }
        catch(Exception e){
            return false;
        }
    }

    public boolean check(String s){
        int v1 = s.length();
        if(v1 != 12) return false;
        if(!checkStr1(s.substring(0, 8))) return false;
        else if(!checkStr2(s.substring(8, 12))) return false;
        else return true;

    }

}