package com.testeflutter.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.testeflutter.dtos.PessoaDTO;
import com.testeflutter.entity.Pessoa;
import com.testeflutter.mappers.PessoaMapper;
import com.testeflutter.repository.PessoaRepository;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class PessoaService {

    @Autowired
    private PessoaRepository pessoaRepository;

    @Transactional
    public void salvarPessoas(List<PessoaDTO> pessoasDTO) {
        for (PessoaDTO pessoaDTO : pessoasDTO) {
            Pessoa pessoa = PessoaMapper.INSTANCE.toEntity(pessoaDTO);

            // Verificar se a data de nascimento é válida
            if (pessoa.getDataNasc() == null) {
                throw new IllegalArgumentException("Data de nascimento inválida para a pessoa: " + pessoaDTO.getNome());
            }

            pessoaRepository.save(pessoa);
        }
    }

    public Map<String, Long> getCandidatosPorEstado() {
        List<Object[]> result = pessoaRepository.countByEstado();
        Map<String, Long> candidatosPorEstado = new HashMap<>();

        for (Object[] row : result) {
            String estado = (String) row[0];
            Long count = ((Number) row[1]).longValue();
            candidatosPorEstado.put(estado, count);
        }

        return candidatosPorEstado;
    }

    @Transactional
    public void salvarPessoa(PessoaDTO pessoaDTO) {
        // Convertendo o DTO para a entidade
        Pessoa pessoa = PessoaMapper.INSTANCE.toEntity(pessoaDTO);

        // Salvando a pessoa no banco
        pessoaRepository.save(pessoa);
    }

    // Método para buscar a faixa etária e o IMC médio
    public Map<Integer, Double> getFaixaEtariaAndImcMedio() {
        List<Object[]> result = pessoaRepository.findFaixaEtariaAndImcMedio();
        Map<Integer, Double> faixaEtariaAndImc = new LinkedHashMap<>(); // Mantém a ordem do SQL

        DecimalFormat df = new DecimalFormat("#0.0"); // Formata para uma casa decimal

        for (Object[] row : result) {
            Integer faixaEtaria = ((Number) row[0]).intValue();
            Double imcMedio = row[1] != null ? ((Number) row[1]).doubleValue() : null;

            // Formatar para uma casa decimal
            if (imcMedio != null) {
                imcMedio = Double.valueOf(df.format(imcMedio).replace(",", ".")); // Evita problemas com separador
                                                                                  // decimal
            }

            faixaEtariaAndImc.put(faixaEtaria, imcMedio);
        }

        return faixaEtariaAndImc;
    }

    public Map<String, Double> getPercentualObesosPorSexo() {
        List<Object[]> result = pessoaRepository.findPercentualObesosPorSexo();
        Map<String, Double> percentualObesosPorSexo = new HashMap<>();

        for (Object[] row : result) {
            String sexo = (String) row[0]; // "M" ou "F"
            Double percentual = row[1] != null ? ((Number) row[1]).doubleValue() : 0.0;
            percentualObesosPorSexo.put(sexo, Math.round(percentual * 10.0) / 10.0); // Arredonda para 1 casa decimal
        }

        return percentualObesosPorSexo;
    }

    public Map<String, Long> getQuantidadeDoadoresPorTipoSanguineo() {
        List<Object[]> result = pessoaRepository.findDoadoresPorTipoSanguineo();
        Map<String, Long> doadoresPorTipo = new HashMap<>();

        for (Object[] row : result) {
            String tipoReceptor = (String) row[0];
            Long quantidade = ((Number) row[1]).longValue();
            doadoresPorTipo.put(tipoReceptor, quantidade);
        }

        return doadoresPorTipo;
    }

    public Map<String, Object> getDadosPorEstado(String estado) {
        Map<String, Object> dadosPorEstado = new HashMap<>();

        // Filtra os dados das faixas etárias e IMC médio com o filtro de estado
        dadosPorEstado.put("faixaEtariaAndImc", getFaixaEtariaAndImcMedioByEstado(estado));

        // Filtra os dados dos percentuais de obesidade com o filtro de estado
        dadosPorEstado.put("percentualObesos", getPercentualObesosPorSexoByEstado(estado));

        // Filtra os dados dos doadores por tipo sanguíneo com o filtro de estado
        dadosPorEstado.put("doadoresPorTipoSanguineo", getDoadoresPorTipoSanguineoByEstado(estado));

        return dadosPorEstado;
    }

    // Métodos com filtro de estado

    // Método para buscar a faixa etária e o IMC médio filtrado por estado
    public Map<Integer, Double> getFaixaEtariaAndImcMedioByEstado(String estado) {
        List<Object[]> result = pessoaRepository.findFaixaEtariaAndImcMedioByEstado(estado);
        Map<Integer, Double> faixaEtariaAndImc = new LinkedHashMap<>();

        DecimalFormat df = new DecimalFormat("#0.0");

        for (Object[] row : result) {
            Integer faixaEtaria = ((Number) row[0]).intValue();
            Double imcMedio = row[1] != null ? ((Number) row[1]).doubleValue() : null;

            if (imcMedio != null) {
                imcMedio = Double.valueOf(df.format(imcMedio).replace(",", "."));
            }

            faixaEtariaAndImc.put(faixaEtaria, imcMedio);
        }

        return faixaEtariaAndImc;
    }

    public Map<String, Double> getPercentualObesosPorSexoByEstado(String estado) {
        List<Object[]> result = pessoaRepository.findPercentualObesosPorSexoByEstado(estado);
        Map<String, Double> percentualObesosPorSexo = new HashMap<>();

        for (Object[] row : result) {
            String sexo = (String) row[0];
            Double percentual = row[1] != null ? ((Number) row[1]).doubleValue() : 0.0;
            percentualObesosPorSexo.put(sexo, Math.round(percentual * 10.0) / 10.0);
        }

        return percentualObesosPorSexo;
    }

    public Map<String, Long> getDoadoresPorTipoSanguineoByEstado(String estado) {
        List<Object[]> result = pessoaRepository.findDoadoresPorTipoSanguineoByEstado(estado);
        Map<String, Long> doadoresPorTipo = new HashMap<>();

        for (Object[] row : result) {
            String tipoReceptor = (String) row[0];
            Long quantidade = ((Number) row[1]).longValue();
            doadoresPorTipo.put(tipoReceptor, quantidade);
        }

        return doadoresPorTipo;
    }
}
