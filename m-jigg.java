package com.mouseJiggler.app;

import java.awt.*;

/**
 * Hello world!
 *
 */
public class App 
{
    public static final int SLEEP_MILLIS = 10 * 1000;

    public static void main(String... args) throws Exception {
        Robot robot = new Robot();
        
        int ind = 0;

        int px = 0;
        int py = 0;

        while (true) {
            Point point = MouseInfo.getPointerInfo().getLocation();
            
            if (px != point.x || py != point.y) {
                px = point.x;
                py = point.y;

                System.out.printf("New Coordinates detected!! X: %s, Y: %s\n", px, py);
            }
            
            robot.mouseMove(px, py);

            System.out.printf("Mouse Move! Counter: %d\n", ind);
            ind += 1;

            Thread.sleep(SLEEP_MILLIS);
        }
    }
}
