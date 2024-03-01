import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter your name please:");
        String name = scanner.nextLine();
        System.out.println("Hello " + name);
        System.out.println(name + " please give an integer number:");
        int num1 = Integer.parseInt(scanner.nextLine());
        System.out.println(name + " please give an integer number again:");
        int num2 = Integer.parseInt(scanner.nextLine());
        System.out.println(name + "please give an integer number for the last time:");
        int num3 = Integer.parseInt(scanner.nextLine());
    }
}