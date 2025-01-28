package com.testeflutter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.testeflutter.entity.Pessoa;

public interface PessoaRepository extends JpaRepository<Pessoa, Long> {

    // Consulta nativa para contar o número de candidatos por estado
    @Query(value = "SELECT estado, COUNT(*) FROM pessoas GROUP BY estado", nativeQuery = true)
    List<Object[]> countByEstado();

    // Consulta nativa para contar o número de candidatos por estado

    @Query(value = """
            SELECT
                FLOOR(TIMESTAMPDIFF(YEAR, STR_TO_DATE(data_nasc, '%d/%m/%Y'), CURDATE()) / 10) * 10 AS faixa_etaria,
                AVG(peso / (altura * altura)) AS imc_medio
            FROM pessoas
            WHERE peso IS NOT NULL AND altura IS NOT NULL
            GROUP BY faixa_etaria
            ORDER BY faixa_etaria
            """, nativeQuery = true)
    List<Object[]> findFaixaEtariaAndImcMedio();

    @Query(value = """
                SELECT
                    sexo,
                    COUNT(CASE WHEN (peso / (altura * altura)) > 30 THEN 1 END) * 100.0 / COUNT(*)
                FROM pessoas
                WHERE peso IS NOT NULL AND altura IS NOT NULL
                GROUP BY sexo
            """, nativeQuery = true)
    List<Object[]> findPercentualObesosPorSexo();

    @Query(value = """
            SELECT
                p_receptor.tipo_sanguineo AS tipoReceptor,
                COUNT(p_doador.id) AS quantidadeDoadores
            FROM pessoas p_receptor
            JOIN pessoas p_doador
                ON (
                    (p_receptor.tipo_sanguineo = 'A+' AND p_doador.tipo_sanguineo IN ('A+', 'A-', 'O+', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'A-' AND p_doador.tipo_sanguineo IN ('A-', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'B+' AND p_doador.tipo_sanguineo IN ('B+', 'B-', 'O+', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'B-' AND p_doador.tipo_sanguineo IN ('B-', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'AB+' AND p_doador.tipo_sanguineo IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'AB-' AND p_doador.tipo_sanguineo IN ('A-', 'B-', 'AB-', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'O+' AND p_doador.tipo_sanguineo IN ('O+', 'O-')) OR
                    (p_receptor.tipo_sanguineo = 'O-' AND p_doador.tipo_sanguineo IN ('O-'))
                )
            WHERE
                p_doador.peso > 50
                AND TIMESTAMPDIFF(YEAR, STR_TO_DATE(p_doador.data_nasc, '%d/%m/%Y'), CURDATE()) BETWEEN 16 AND 69
            GROUP BY p_receptor.tipo_sanguineo
            ORDER BY FIELD(p_receptor.tipo_sanguineo, 'O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+')
            """, nativeQuery = true)
    List<Object[]> findDoadoresPorTipoSanguineo();

}
