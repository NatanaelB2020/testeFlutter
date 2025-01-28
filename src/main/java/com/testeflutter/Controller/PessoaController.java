package com.testeflutter.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.testeflutter.DTOs.PessoaDTO;
import com.testeflutter.service.PessoaService;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/pessoas")
public class PessoaController {

    @Autowired
    private PessoaService pessoaService;

    @PostMapping("/salvar")
    public ResponseEntity<String> salvarPessoas(@RequestBody List<PessoaDTO> pessoasDTO) {
        try {
            pessoaService.salvarPessoas(pessoasDTO);
            return ResponseEntity.ok("Pessoas salvas com sucesso");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/candidatos-por-estado")
    public ResponseEntity<Map<String, Long>> getCandidatosPorEstado() {
        Map<String, Long> resultado = pessoaService.getCandidatosPorEstado();
        return ResponseEntity.ok(resultado);
    }

    @PostMapping("/salvar-uma")
    public ResponseEntity<String> salvarPessoa(@RequestBody PessoaDTO pessoaDTO) {
        try {
            pessoaService.salvarPessoa(pessoaDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body("Pessoa salva com sucesso");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro interno ao salvar pessoa");
        }
    }

    @GetMapping("/faixa-etaria-imc")
    public Map<Integer, Double> getFaixaEtariaAndImc() {
        return pessoaService.getFaixaEtariaAndImcMedio();
    }

    @GetMapping("/percentual-obesos")
    public ResponseEntity<Map<String, Double>> getPercentualObesos() {
        return ResponseEntity.ok(pessoaService.getPercentualObesosPorSexo());
    }

    @GetMapping("/doadores-por-tipo-sanguineo")
    public Map<String, Long> getDoadoresPorTipoSanguineo() {
        return pessoaService.getQuantidadeDoadoresPorTipoSanguineo();
    }

}
