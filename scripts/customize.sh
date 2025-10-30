#!/bin/bash

# Script de personnalisation du template MMO-RPG
# Usage: ./scripts/customize.sh "NomDuProjet" "com.monentreprise.monprojet"

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <nom-du-projet> <package-java>"
    echo "Exemple: $0 \"MonRPGAventure\" \"com.monentreprise.rpg\""
    exit 1
fi

PROJECT_NAME="$1"
JAVA_PACKAGE="$2"
OLD_PACKAGE="com.example"
OLD_ARTIFACT="test"

echo "🎮 Personnalisation du template MMO-RPG"
echo "=================================="
echo "Nom du projet: $PROJECT_NAME"
echo "Package Java: $JAVA_PACKAGE"
echo ""

# Fonction pour remplacer dans un fichier
replace_in_file() {
    local file="$1"
    local old="$2"
    local new="$3"
    
    if [ -f "$file" ]; then
        sed -i.bak "s|$old|$new|g" "$file" && rm "$file.bak"
        echo " Mis à jour: $file"
    fi
}

# 1. Mettre à jour pom.xml
echo " Mise à jour pom.xml..."
replace_in_file "pom.xml" "<artifactId>test</artifactId>" "<artifactId>$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')</artifactId>"
replace_in_file "pom.xml" "<groupId>com.example</groupId>" "<groupId>$JAVA_PACKAGE</groupId>"
replace_in_file "pom.xml" "<name>RPG Multijoueur</name>" "<name>$PROJECT_NAME</name>"

# 2. Mettre à jour compose.yaml
echo " Mise à jour Docker Compose..."
replace_in_file "compose.yaml" "test-0.0.1-SNAPSHOT.jar" "$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')-0.0.1-SNAPSHOT.jar"

# 3. Mettre à jour Dockerfile
echo " Mise à jour Dockerfile..."
replace_in_file "dockerfile" "test-0.0.1-SNAPSHOT.jar" "$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')-0.0.1-SNAPSHOT.jar"

# 4. Mettre à jour application.properties
echo " Mise à jour application.properties..."
replace_in_file "src/main/resources/application.properties" "rpg-multijoueur" "$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

# 5. Créer la nouvelle structure de packages
echo " Création de la nouvelle structure de packages..."
OLD_PACKAGE_PATH="src/main/java/com/example"
NEW_PACKAGE_PATH="src/main/java/$(echo $JAVA_PACKAGE | tr '.' '/')"

if [ -d "$OLD_PACKAGE_PATH" ]; then
    mkdir -p "$(dirname $NEW_PACKAGE_PATH)"
    cp -r "$OLD_PACKAGE_PATH" "$NEW_PACKAGE_PATH"
    
    # Mettre à jour les imports dans tous les fichiers Java
    find "$NEW_PACKAGE_PATH" -name "*.java" -exec sed -i.bak "s|package com.example|package $JAVA_PACKAGE|g" {} \;
    find "$NEW_PACKAGE_PATH" -name "*.java" -exec sed -i.bak "s|import com.example|import $JAVA_PACKAGE|g" {} \;
    find "$NEW_PACKAGE_PATH" -name "*.java.bak" -delete
    
    # Supprimer l'ancien package
    rm -rf "$OLD_PACKAGE_PATH"
    echo " Structure de packages mise à jour"
fi

# 6. Mettre à jour les tests
echo " Mise à jour des tests..."
OLD_TEST_PATH="src/test/java/com/example"
NEW_TEST_PATH="src/test/java/$(echo $JAVA_PACKAGE | tr '.' '/')"

if [ -d "$OLD_TEST_PATH" ]; then
    mkdir -p "$(dirname $NEW_TEST_PATH)"
    cp -r "$OLD_TEST_PATH" "$NEW_TEST_PATH"
    
    # Mettre à jour les imports dans les tests
    find "$NEW_TEST_PATH" -name "*.java" -exec sed -i.bak "s|package com.example|package $JAVA_PACKAGE|g" {} \;
    find "$NEW_TEST_PATH" -name "*.java" -exec sed -i.bak "s|import com.example|import $JAVA_PACKAGE|g" {} \;
    find "$NEW_TEST_PATH" -name "*.java.bak" -delete
    
    # Supprimer l'ancien package de test
    rm -rf "$OLD_TEST_PATH"
    echo " Tests mis à jour"
fi

# 7. Mettre à jour .env.example
echo " Mise à jour .env.example..."
replace_in_file ".env.example" "Mon RPG Template" "$PROJECT_NAME"

# 8. Mettre à jour README.md
echo " Mise à jour README.md..."
replace_in_file "README.md" "mon-rpg" "$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"

echo ""
echo " Personnalisation terminée !"
echo "================================"
echo "Actions suivantes recommandées:"
echo "1. Vérifiez les fichiers modifiés"
echo "2. Adaptez le README.md à votre projet"
echo "3. Modifiez .env selon vos besoins"
echo "4. Testez la compilation: mvn clean compile"
echo "5. Lancez les tests: mvn test"
echo ""
echo "Le template est maintenant personnalisé pour votre projet '$PROJECT_NAME' !"