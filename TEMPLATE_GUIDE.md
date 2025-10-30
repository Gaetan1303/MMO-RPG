# Template Guide - Quick Reference

## Quick Start Commands

```bash
# 1. Initial setup
./scripts/setup.sh

# 2a. Development mode (H2 database)
./scripts/dev.sh

# 2b. Production mode (Docker)
docker-compose up -d --build

# 3. Customize for your project
./scripts/customize.sh "MyAwesomeRPG" "com.mycompany.myrpg"
```

## File Structure Overview

```
MMO-RPG Template
├── src/main/java/com/example/rpg/  # Core application
│   ├── controller/                 # REST & WebSocket endpoints
│   ├── service/                    # Business logic
│   ├── model/                      # JPA entities
│   ├── security/                   # JWT & Spring Security
│   └── websocket/                  # Real-time communication
├── scripts/                        # Automation scripts
│   ├── setup.sh                    # Initial setup
│   ├── dev.sh                      # Development mode
│   └── customize.sh                # Project customization
├── .env.example                    # Environment template
├── template.json                   # Template metadata
├── compose.yaml                    # Docker orchestration
└── README.md                       # Complete documentation
```

## Key Features Implemented

**Authentication**
- JWT-based login/register
- Dual endpoint support (`/auth/*` and `/api/auth/*`)
- Spring Security integration

**Character Management**  
- 18 FFT character classes
- Multi-character support per user
- Stats system with 14 FFTA attributes

**Real-time Communication**
- WebSocket/STOMP for multiplayer
- Mercure Hub for SSE
- Game state synchronization

**Database Flexibility**
- PostgreSQL for production
- H2 in-memory for development
- Flyway migrations support

**Docker Ready**
- Multi-stage Dockerfile
- Complete docker-compose stack
- Health checks included

**Testing Suite**
- Integration tests for all controllers
- MockMvc for HTTP testing
- H2 for test isolation

## Customization Checklist

When creating a new project from this template:

- [ ] Run `./scripts/customize.sh "ProjectName" "com.company.package"`
- [ ] Update `.env` with your configuration
- [ ] Modify `pom.xml` metadata (name, description)
- [ ] Customize character classes in `CharacterClass.java`
- [ ] Update WebSocket topics for your game mechanics
- [ ] Configure your frontend client URLs in CORS settings
- [ ] Set up your production JWT secrets
- [ ] Test with `mvn test` and `docker-compose up`

## Development Workflow

1. **Start development**: `./scripts/dev.sh`
2. **Make changes**: Edit code, run tests with `mvn test`
3. **Test integration**: `docker-compose up -d --build`
4. **Deploy**: Configure production environment

## Support & Documentation

- **Full docs**: See `README.md`
- **Config**: Check `.env.example` for all options
- **Issues**: Run `mvn test` first, check logs
- **Deploy**: Use `docker-compose` for production

---
*Template version 1.0.0 - Ready for your next RPG adventure!*