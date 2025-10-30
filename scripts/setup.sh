#!/bin/bash

# Script de setup initial pour le template MMO-RPG
# Configure l'environnement de développement

set -e

echo " Setup du template MMO-RPG"
echo "============================="
echo ""

# Vérifier les prérequis
echo " Vérification des prérequis..."

# Java
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f 2 | cut -d'.' -f 1)
    echo " Java $JAVA_VERSION détecté"
    if [ "$JAVA_VERSION" -lt 21 ]; then
        echo " Java 21+ recommandé (version actuelle: $JAVA_VERSION)"
    fi
else
    echo "Java non trouvé. Installez Java 21+ avant de continuer."
    exit 1
fi

# Maven
if command -v mvn &> /dev/null; then
    echo " Maven détecté"
else
    echo " Maven non trouvé, le wrapper Maven sera utilisé"
fi

# Docker
if command -v docker &> /dev/null; then
    echo " Docker détecté"
    if command -v docker-compose &> /dev/null; then
        echo " Docker Compose détecté"
    else
        echo " Docker Compose non trouvé"
    fi
else
    echo "Docker non trouvé (optionnel pour le mode dev)"
fi

echo ""

# Configuration initiale
echo " Configuration initiale..."

# Créer .env s'il n'existe pas
if [ ! -f ".env" ]; then
    echo " Création du fichier .env depuis .env.example..."
    cp .env.example .env
    echo " Fichier .env créé"
    echo " Modifiez .env selon vos besoins avant le premier démarrage"
else
    echo " Fichier .env existe déjà"
fi

# Rendre les scripts exécutables
echo " Configuration des scripts..."
chmod +x scripts/*.sh
echo " Scripts rendus exécutables"

echo ""
echo " Options de démarrage:"
echo "========================"
echo "1. Mode développement (H2):"
echo "   ./scripts/dev.sh"
echo ""
echo "2. Mode production (Docker):"
echo "   docker-compose up -d --build"
echo ""
echo "3. Tests:"
echo "   mvn test"
echo ""
echo "4. Personnalisation:"
echo "   ./scripts/customize.sh \"MonProjet\" \"com.monentreprise.rpg\""
echo ""
echo " Setup terminé ! Choisissez une option ci-dessus pour commencer."