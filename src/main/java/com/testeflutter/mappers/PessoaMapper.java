package com.testeflutter.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import com.testeflutter.DTOs.PessoaDTO;
import com.testeflutter.entity.Pessoa;

@Mapper(componentModel = "spring")
public interface PessoaMapper {

    PessoaMapper INSTANCE = Mappers.getMapper(PessoaMapper.class);

    // Mapeando diretamente a String dataNasc para String na entidade
    @Mapping(source = "dataNasc", target = "dataNasc")
    Pessoa toEntity(PessoaDTO pessoaDTO);

    PessoaDTO toDTO(Pessoa pessoa);
}
