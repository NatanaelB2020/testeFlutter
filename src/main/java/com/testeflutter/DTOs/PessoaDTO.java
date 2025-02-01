package com.testeflutter.dtos;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PessoaDTO {
    private Long id;
    private String nome;
    private String cpf;
    private String rg;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd/MM/yyyy")
    private String dataNasc;
    private String sexo;
    private String mae;
    private String pai;
    private String email;
    private String cep;
    private String endereco;
    private int numero;
    private String bairro;
    private String cidade;
    private String estado;
    private String telefoneFixo;
    private String celular;
    private double altura;
    private double peso;
    private String tipoSanguineo;
}
