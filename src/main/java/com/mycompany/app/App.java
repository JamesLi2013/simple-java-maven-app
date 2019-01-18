package com.mycompany.app;

/**
 * Hello world!
 */
public class App
{

    private final String message = "Hello World! 2019/01/18 16:24 \n github hook test11";

    public App() {}

    public static void main(String[] args) {
        System.out.println(new App().getMessage());
    }

    private final String getMessage() {
        return message;
    }

}
