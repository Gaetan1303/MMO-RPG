#!/bin/bash

# Script de développement pour le template MMO-RPG
# Lance l'application en mode développement avec H2

set -e

echo " Démarrage en mode développement"
echo "================================="
echo "Base de données: H2 (en mémoire)"
echo "Profil Spring: dev"
echo "Port: 8080"
echo ""

# Vérifier si Java est installé
if ! command -v java &> /dev/null; then
    echo " Java n'est pas installé ou pas dans le PATH"
    echo "Installez Java 21+ avant de continuer"
    exit 1
fi

# Vérifier si Maven est installé
if ! command -v mvn &> /dev/null; then
    echo " Maven non trouvé, utilisation du wrapper Maven..."
    MVN_CMD="./mvnw"
else
    MVN_CMD="mvn"
fi

# Créer un profil application-dev.properties si n'existe pas
DEV_PROPERTIES="src/main/resources/application-dev.properties"
if [ ! -f "$DEV_PROPERTIES" ]; then
    echo " Création du profil de développement..."
    cat > "$DEV_PROPERTIES" << EOF
# Configuration développement avec H2
spring.application.name=rpg-multijoueur-dev
server.port=8080

# Base de données H2 en mémoire
spring.datasource.url=jdbc:h2:mem:devdb
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

# JPA / Hibernate
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# JWT Configuration (dev uniquement)
jwt.secret=dev-secret-key-not-for-production
jwt.expiration=86400000

# CORS permissif pour développement
cors.allowed-origins=http://localhost:3000,http://localhost:8080,http://localhost:5173

# Logs détaillés
logging.level.org.springframework.security=DEBUG
logging.level.org.hibernate.SQL=DEBUG
logging.level.com.example.rpg=DEBUG

# Désactiver Mercure en dev (optionnel)
mercure.url=
mercure.jwt.secret=dev-mercure-secret
EOF
    echo " Profil de développement créé: $DEV_PROPERTIES"
fi

# Lancer l'application
echo " Compilation et démarrage..."
echo "Console H2 disponible sur: http://localhost:8080/h2-console"
echo "API disponible sur: http://localhost:8080"
echo ""
echo "Pour arrêter: Ctrl+C"
echo ""

$MVN_CMD spring-boot:run -Dspring-boot.run.profiles=dev