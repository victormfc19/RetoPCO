package com.reto.pco.utils;

import java.util.Arrays;

public class Order {

    public static String[] namesByBubble(String[] movements){
        int n = movements.length;
        boolean flag;

        for (int i = 0; i < n - 1; i++) {
            flag = false;

            for (int j = 0; j < n - 1 - i; j++) {
                if (movements[j].compareTo(movements[j + 1]) > 0) {
                    String temp = movements[j];
                    movements[j] = movements[j + 1];
                    movements[j + 1] = temp;
                    flag = true;
                }
            }

            if (!flag) break;
        }

        return movements;
    }
}
