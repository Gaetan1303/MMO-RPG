# Spring Boot MMO-RPG Template

Un template moderne et réutilisable pour créer des applications RPG multijoueurs avec Spring Boot, WebSocket, PostgreSQL et authentification JWT.

## Fonctionnalités

- **Authentification JWT** - Système complet de login/register avec sécurité
- **Gestion de personnages** - Création et gestion multi-personnages (18 classes FFT)
- **WebSocket/STOMP** - Communication temps réel pour le multijoueur
- **Base de données** - PostgreSQL avec migrations + profil H2 pour dev
- **Mercure Hub** - Broadcasting server-sent events
- **Docker** - Déploiement containerisé complet
- **Tests** - Tests d'intégration complets
- **Architecture propre** - Principes SOLID, patterns DTO/Service/Repository

## Prérequis

- **Docker & Docker Compose** (recommandé)
- **Java 21+** (si exécution locale)
- **Maven 3.9+** (si exécution locale)

## Démarrage rapide

### 1. Configuration

```bash
# Cloner le template
git clone <votre-repo> mon-rpg
cd mon-rpg

# Copier la configuration d'exemple
cp .env.example .env

# (Optionnel) Modifier les variables d'environnement
nano .env
```

### 2. Lancement avec Docker (Recommandé)

```bash
# Démarrer tous les services
docker-compose up -d --build

# Vérifier que tout fonctionne
curl http://localhost:8080/health
```

### 3. Lancement en mode développement (sans Docker)

```bash
# Utiliser le profil 'dev' avec H2 en mémoire
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

## Architecture du template

```
src/main/java/com/example/rpg/
├── config/          # Configuration Spring (Security, WebSocket)
├── controller/      # Contrôleurs REST & WebSocket  
├── dto/            # Data Transfer Objects
├── exception/      # Gestion des exceptions
├── factory/        # Factories (personnages, stats)
├── model/          # Entités JPA
├── repository/     # Repositories Spring Data
├── security/       # Configuration sécurité JWT
├── service/        # Logique métier
├── strategy/       # Patterns Strategy
└── websocket/      # Configuration WebSocket/STOMP
```

## Configuration

### Variables d'environnement (.env)

| Variable | Description | Défaut |
|----------|-------------|--------|
| `DB_NAME` | Nom de la base de données | `rpgdb` |
| `DB_USER` | Utilisateur PostgreSQL | `rpguser` |
| `DB_PASS` | Mot de passe PostgreSQL | `rpgpassword` |
| `JWT_SECRET` | Clé secrète JWT | (généré) |
| `MERCURE_JWT_SECRET` | Clé Mercure Hub | (généré) |

### Profils Spring

- **`prod`** (défaut) : PostgreSQL + Docker
- **`dev`** : H2 en mémoire pour développement  
- **`test`** : H2 en mémoire pour tests

## Endpoints API

### Authentification
- `POST /auth/register` - Inscription
- `POST /auth/login` - Connexion
- `POST /api/auth/register` - Inscription (alias)
- `POST /api/auth/login` - Connexion (alias)

### Personnages (JWT requis)
- `POST /api/character/create` - Créer un personnage
- `GET /api/character/me` - Mon personnage
- `GET /api/character/list` - Mes personnages
- `GET /api/character/classes` - Classes disponibles

### WebSocket
- Endpoint : `/ws`
- Topics : `/topic/game/movement`, `/topic/game/combat`

## Tests

```bash
# Tests unitaires et d'intégration
mvn test

# Tests d'un contrôleur spécifique
mvn test -Dtest=AuthControllerIntegrationTest
```

## Docker

### Services

- **app** : Application Spring Boot (port 8080)
- **db** : PostgreSQL 15 (port 5433)  
- **mercure** : Hub Mercure (port 8081)
- **caddy** : Reverse proxy (port 3000)

### Commandes utiles

```bash
# Démarrer
docker-compose up -d

# Voir les logs
docker compose logs -f

# Redémarrer un service
docker compose restart app
```

## Développement

### Mode développement avec H2
```bash
# Utilise H2 en mémoire au lieu de PostgreSQL
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

### Mode production
```bash
# Démarre PostgreSQL + application
./scripts/dev.sh
```

## Scripts utiles

- `./scripts/setup.sh` - Installation complète
- `./scripts/dev.sh` - Mode développement
- `./scripts/customize.sh` - Personnalisation du template

## Structure du projet

# Arrêter tout
docker-compose down
```

## Personnalisation du template

### 1. Setup automatique

```bash
# Script de setup initial
./scripts/setup.sh

# Personnaliser le projet
./scripts/customize.sh "MonNouveauRPG" "com.monentreprise.rpg"
```

### 2. Ajouter de nouvelles classes de personnages

```java
// Dans CharacterClass.java
NOUVELLE_CLASSE("Description", hp, mp, atk, def, speed, move);

// Dans CharacterController.java - ajouter emoji
case NOUVELLE_CLASSE -> " =) ";
```

### 3. Nouveaux endpoints WebSocket

```java
@MessageMapping("/game/nouvel-event")
@SendTo("/topic/game/response")
public ResponseMessage handleNouvelEvent(EventMessage message) {
    return new ResponseMessage(result);
}
```

## Stack technique

- **Backend** : Spring Boot 3.5, Spring Security 6, Spring Data JPA
- **Base de données** : PostgreSQL 15, H2 (dev/test)
- **Sécurité** : JWT avec JJWT
- **WebSocket** : Spring WebSocket + STOMP
- **Tests** : JUnit 5, MockMvc
- **Build** : Maven 3.9
- **Containerisation** : Docker, Docker Compose


# Hibernate
SPRING_JPA_HIBERNATE_DDL_AUTO=update
EOF
```

**IMPORTANT** : En production, changez ces secrets !

### 3. Installer les dépendances Electron

```bash
cd electron-shell
npm install
cd ..
```

## Lancement du projet

### Option 1 : Lancement complet avec Docker (RECOMMANDÉ)

```bash
# Depuis la racine du projet
export $(cat .env | grep -v '^#' | xargs)
docker-compose up --build -d
```

Services lancés :
- **Backend Spring Boot** : http://localhost:8080
- **PostgreSQL** : localhost:5433
- **Mercure Hub** : http://localhost:8081
- **Caddy (Reverse Proxy)** : http://localhost:3000

Vérification :
```bash
docker ps                                    # Tous les conteneurs UP
curl http://localhost:8080/health            # {"status":"UP"}
curl http://localhost:8080/api/character/classes | jq length  # 18
```

### Option 2 : Lancement manuel (développement)

**Terminal 1 - Backend** :
```bash
export $(cat .env | grep -v '^#' | xargs)
./mvnw spring-boot:run
```

**Terminal 2 - Electron** :
```bash
cd electron-shell
npm start              # Mode normal
# ou
npm run dev            # Avec DevTools
```

## Arrêt propre

```bash
docker-compose down                # Arrête les conteneurs
docker-compose down -v             # + supprime les volumes (DB)
```

## Endpoints principaux

### REST API

| Endpoint | Méthode | Auth | Description |
|----------|---------|------|-------------|
| `/` | GET | Public | Page d'accueil API |
| `/health` | GET | Public | Health check |
| `/api/auth/register` | POST | Public | Inscription |
| `/api/auth/login` | POST | Public | Connexion (retourne JWT) |
| `/api/character/classes` | GET | Public | Liste des 18 classes FFT |
| `/api/character/create` | POST | JWT | Créer un personnage |
| `/api/character/list` | GET | JWT | Liste des personnages |
| `/api/character/me` | GET | JWT | Personnage actif |

### WebSocket STOMP

**Connexion** : `ws://localhost:8080/ws` (ou `/ws-sockjs` avec SockJS)

**Headers requis** :
```javascript
{
  "Authorization": "Bearer <JWT_TOKEN>"
}
```

**Destinations client → serveur** :
- `/app/game/connect` - Connecter un personnage
- `/app/game/move` - Déplacer (validé côté serveur)
- `/app/chat/send` - Envoyer un message chat

**Souscriptions serveur → client** :
- `/topic/game/position` - Positions de tous les joueurs (broadcast)
- `/topic/game/disconnect` - Notifications de déconnexion
- `/user/queue/errors` - Erreurs privées

### Mercure SSE

**Endpoint** : `http://localhost:8081/.well-known/mercure?topic=chat/global`

Écoute des messages chat en temps réel via Server-Sent Events.

## Tests

Le projet a été testé avec succès en charge :
- **75 joueurs simultanés** (50 en mouvement + 25 en chat)
- **100% taux de succès**, 0 erreurs
- **75,196 messages** broadcast
- **Latence moyenne : 0.16ms**
- Infrastructure validée comme TRÈS STABLE

Voir `doc technique/PHASE1_WEBSOCKET_IMPLEMENTATION.md` pour les détails.

## Variables d'environnement

| Variable | Valeur par défaut | Description |
|----------|-------------------|-------------|
| `DB_NAME` | rpgdb | Nom base PostgreSQL |
| `DB_USER` | rpguser | Utilisateur PostgreSQL |
| `DB_PASS` | rpgpassword | Mot de passe PostgreSQL |
| `JWT_SECRET` | (voir .env) | Secret JWT (256 bits min) |
| `MERCURE_JWT_SECRET` | (voir .env) | Secret Mercure |

## Dépannage

### Backend ne démarre pas

1. Vérifier que le fichier `.env` existe et est correctement chargé :
```bash
export $(cat .env | grep -v '^#' | xargs)
docker-compose config  # Affiche la config avec variables
```

2. Logs Docker :
```bash
docker logs test-mvn_app_1 --tail 100
```

3. Erreur PostgreSQL "no password provided" :
```bash
# Re-créer les conteneurs
docker-compose down
export $(cat .env | grep -v '^#' | xargs)
docker-compose up --build -d
```

### Electron ne se lance pas

```bash
cd electron-shell
rm -rf node_modules package-lock.json
npm install
npm start
```

### Endpoint /api/character/classes retourne vide

Le backend n'a pas démarré correctement. Vérifier :
```bash
curl http://localhost:8080/health
docker logs test-mvn_app_1 | grep ERROR
```

### WebSocket refuse la connexion

1. Vérifier que le JWT est valide :
```bash
# Obtenir un token
TOKEN=$(curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"password"}' | jq -r '.token')

# Tester un endpoint protégé
curl http://localhost:8080/api/character/list \
  -H "Authorization: Bearer $TOKEN"
```

2. Le endpoint `/ws` doit être accessible :
```bash
curl -i http://localhost:8080/ws
# Devrait retourner un Upgrade WebSocket ou 400 (normal en HTTP)
```

## Documentation technique

Consultez le dossier `doc technique/` :
- **ARCHITECTURE.md** : Diagrammes complets (Electron, Backend, Flow)
- **PHASE1_WEBSOCKET_IMPLEMENTATION.md** : Implémentation WebSocket détaillée
- **Diagrammes UML** : Classes, séquences, états

## Technologies utilisées

### Backend
- Spring Boot 3.5.6
- Spring Security + JWT
- Spring WebSocket (STOMP)
- PostgreSQL 15
- Hibernate/JPA
- Mercure Hub (SSE)

### Frontend
- Electron 28.0.0
- Architecture MVC modulaire
- Axios (HTTP)
- Pattern Singleton pour l'état

### Infrastructure
- Docker + Docker Compose
- Caddy (reverse proxy)
- Multi-stage Dockerfile

## Licence

Projet éducatif - RPG FFT Multiplayer 