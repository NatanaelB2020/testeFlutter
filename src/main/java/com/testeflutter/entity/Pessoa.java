package com.testeflutter.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "pessoas")
@Data
public class Pessoa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "cpf", nullable = false, unique = true)
    private String cpf;

    @Column(name = "rg", nullable = false, unique = true)
    private String rg;

    @Column(name = "data_nasc")
    private String dataNasc;

    @Column(name = "sexo")
    private String sexo;

    @Column(name = "mae")
    private String mae;

    @Column(name = "pai")
    private String pai;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "cep")
    private String cep;

    @Column(name = "endereco")
    private String endereco;

    @Column(name = "numero")
    private Integer numero;

    @Column(name = "bairro")
    private String bairro;

    @Column(name = "cidade")
    private String cidade;

    @Column(name = "estado")
    private String estado;

    @Column(name = "telefone_fixo")
    private String telefoneFixo;

    @Column(name = "celular")
    private String celular;

    @Column(name = "altura")
    private Double altura;

    @Column(name = "peso")
    private Integer peso;

    @Column(name = "tipo_sanguineo")
    private String tipoSanguineo;
}
