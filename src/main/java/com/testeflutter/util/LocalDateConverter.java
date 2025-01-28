package com.testeflutter.util;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Converter(autoApply = true)
public class LocalDateConverter implements AttributeConverter<LocalDate, String> {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    @Override
    public String convertToDatabaseColumn(LocalDate date) {
        return (date != null) ? date.format(FORMATTER) : null;
    }

    @Override
    public LocalDate convertToEntityAttribute(String dbData) {
        return (dbData != null && !dbData.isEmpty()) ? LocalDate.parse(dbData, FORMATTER) : null;
    }

    // Método estático para facilitar o uso fora da classe
    public static LocalDate convertStringToLocalDate(String dataNasc) {
        return (dataNasc != null && !dataNasc.isEmpty()) ? LocalDate.parse(dataNasc, FORMATTER) : null;
    }
}
