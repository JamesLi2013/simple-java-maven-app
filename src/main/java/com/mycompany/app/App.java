package com.mycompany.app;

/**
 * Hello world!
 */
public class App
{

    private final String message = "Hello World! 2019/01/18 19:24 \n github hook test11";

    public App() {}

    public static void main(String[] args) {
        System.out.println(new App().getMessage());
//        String msg="mysql     1053     1  0 Jan15 ?        00:16:25 /usr/sbin/mysqld";
//        String[] split = msg.split("\\s+");
//        for (String s : split) {
//            System.out.println(s);
//        }
//        System.out.println("--:"+split[1]);
    }

    private final String getMessage() {
        return message;
    }

}
