package com.testeflutter.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        // Permitir requisições de http://localhost:55543 (Flutter)
        registry.addMapping("/**") // Aplica a configuração a todos os endpoints
                .allowedOrigins("http://localhost:55543") // Permite a origem do Flutter
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // Métodos permitidos
                .allowedHeaders("*") // Permite todos os cabeçalhos
                .allowCredentials(true); // Permite o uso de cookies e credenciais
    }
}
