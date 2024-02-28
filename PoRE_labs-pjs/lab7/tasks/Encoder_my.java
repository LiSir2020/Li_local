import java.util.Random;

public class Encoder{



    private String convertHexToString(String s){
        StringBuilder v1 = new StringBuilder();
        int v0 = 0;
        int v2 = s.length() - 1;
        while(v0 < v2){
            String vv2 = s.substring(v0, v0 + 2);
            int vvv2 = Integer.parseInt(vv2, 0x10);
            vvv2 = vvv2 ^ 0xff;
            v1.append((char) vvv2);
            v0 = v0 + 2;
        }
        return v1.toString();
    }

    private String convertStringToHex(String s){
        char[] v1 = s.toCharArray();
        StringBuffer v2 = new StringBuffer();
        for(int v0 = 0; v0 < s.length(); v0++){
            int vv3 = (int) ((byte) (v1[v0])) ^ 0xff;
            v2.append(Integer.toHexString(vv3));
        }
        return v2.toString();
    }

    private Byte[] getSalt(){
        Byte[] v1 = {0x0,0x0,0x0,0x0,0x0,0x0};
        Random v2 = new Random();
        for(int v0 = 0; v0 < v1.length; v0++){
            v1[v0] = (byte) v2.nextInt(0xf);
        }
        return v1;
    }

    public String decode(String s){
        if(s.length() == 0) return "";
        StringBuffer v2 = new StringBuffer();
        for(int v0 = 0; v0 < s.length(); v0 = v0 + 5){
            String v3 = s.substring(v0, v0 + 1);
            int w3 = 4 - (Integer.parseInt(v3, 16) % 4);

            StringBuilder v4 = new StringBuilder();
            v4.append(s.substring(v0 + 1 + w3, v0 + 5));
            String tmp = s.substring(v0 + 1, v0 + 1 + w3);
            v4.append(tmp);
            v3 = v4.toString();
            v2.append(v3);
        }
        String x = convertHexToString(v2.toString());
        //System.out.println("test2:" + x + " " + x.length());
        return x.substring(0, 11);
    }

    public String encode(String s){
        if(s.length() != 11){
            System.out.println("input error!");
            return "";
        }
        StringBuilder v0 = new StringBuilder();
        v0.append(s + "a");
        String W0 = v0.toString();
        Byte[] v1 = getSalt();
        String v2 = convertStringToHex(W0);
        //System.out.println("v2.length:" + v2.length());
        StringBuffer v3 = new StringBuffer();
        for(int i = 0; i < v2.length() - 2; i = i + 4){
            int w5 = (int) (v1[i/4]);
            int v5 = w5 % 4;

            String w4 = Integer.toHexString(w5);
            v3.append(w4);

            StringBuilder vv4 = new StringBuilder();
            String v6 = v2.substring(i + v5, i + 4);
            vv4.append(v6);

            String vv5 = v2.substring(i, v5 + i);
            vv4.append(vv5);
            v3.append(vv4.toString());
        }
        //System.out.println("test1:" + v3.toString() + " " + v3.toString().length());
        return v3.toString();
    }

}