package com.testeflutter.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


public class TestesDeConversao {
    public static void main(String[] args) {
        String dataJson = "07\\/09\\/1992";
        dataJson = dataJson.replace("\\/", "/");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate dataConvertida = LocalDate.parse(dataJson, formatter);

        System.out.println("Data convertida: " + dataConvertida.format(formatter)); // Deve imprimir 07/09/1992
    }

}
