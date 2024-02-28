import java.util.Scanner;

public class CheckBox {

    Checker checker =new Checker();
    Encoder encoder = new Encoder();

    public boolean check(String input){
        boolean result = checker.check(input);
        return result;
    }

    public String encode(String input) {
        return encoder.encode(input);
    }

    public String decode(String input) {
        return encoder.decode(input);
    }

    public static void main(String[] args){
        CheckBox checkBox = new CheckBox();

        if (args.length != 1){
            System.out.println("please choose task through command line parameter");
            return;
        }

        System.out.print("input: " );
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();

        if (args[0].equals("task1")){
            System.out.println("task 1: " + checkBox.check(input));
        }
        else if (args[0].equals("task2")){ // StudentID
            String encodeStr = checkBox.encode(input);
            String decodeStr = checkBox.decode(encodeStr);
            System.out.println("encode: " + encodeStr);
            System.out.println("decode: " + decodeStr);
        }
        else {
            System.out.println("Please choose task");
        }
    }

}
