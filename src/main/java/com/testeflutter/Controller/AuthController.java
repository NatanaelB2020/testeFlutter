package com.testeflutter.controller;

import com.testeflutter.dtos.AuthRequest;
import com.testeflutter.dtos.AuthResponse;
import com.testeflutter.entity.User;
import com.testeflutter.service.JwtService;
import com.testeflutter.service.UserService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(AuthenticationManager authenticationManager, JwtService jwtService, 
                          UserService userService, PasswordEncoder passwordEncoder) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;  // Injeta o PasswordEncoder
    }

    @PostMapping("/login")
    public AuthResponse login(@RequestBody AuthRequest request) {
        // Encontra o usuário pelo nome
        User user = userService.findByUsername(request.getUsername())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        // Verifica se a senha fornecida corresponde à senha armazenada (criptografada)
        if (passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            // Se a senha corresponder, realiza o login
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword()));

            // Gera o token JWT para o usuário autenticado
            String token = jwtService.generateToken(authentication.getName());
            return new AuthResponse(token);
        } else {
            throw new RuntimeException("Senha incorreta!");
        }
    }

    @PostMapping("/register")
    public String register(@RequestBody AuthRequest request) {
        userService.registerUser(request.getUsername(), request.getPassword());
        return "Usuário registrado com sucesso!";
    }
}
