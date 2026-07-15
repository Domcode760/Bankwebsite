# Bankwebsite
Lernprojekt zur Entwicklung einer Bankanwendung mit Node.js, Express, EJS und MySQL. Schwerpunkt Backend-Entwicklung, Datenbanken und sichere Datenverarbeitung.

Ziel des Projekts war es, eine realistische Webanwendung mit Benutzerverwaltung, Datenbankanbindung und typischen Backend-Strukturen umzusetzen.

Die Anwendung simuliert grundlegende Funktionen einer Bank:

- Benutzeranmeldung (Authentication)
- Verwaltung von Bankkonten
- Einzahlungen und Auszahlungen (ATM Transactions)
- Überweisungen zwischen Konten (Transfers)
- Anzeige der Transaktionshistorie
- Session-basierte Benutzerverwaltung

Das Projekt wurde eigenständig entwickelt, wobei der Fokus auf dem Verständnis von Backend-Architektur, Datenbankdesign und sauberer Code-Struktur lag.

---

# Technologien

## Backend

- Node.js
- Express.js
- JavaScript (ES Modules)
- MySQL
- mysql2
- express-session

## Frontend

- EJS (Embedded JavaScript Templates)
- HTML
- CSS

## Weitere Tools

- Git / GitHub
- Nodemon
- MySQL Workbench
- dotenv

---

# Architektur

Die Anwendung ist in verschiedene Bereiche aufgeteilt:

```
Bankwebsite
│
├── database
│   ├── db.js
│   ├── schema.sql
│   └── seed.sql
│
├── errors
│   ├── AppError.js
│   ├── AuthenticationError.js
│   └── TransactionError.js
│
├── middleware
│   ├── authMiddleware.js
│   ├── errorMiddleware.js
│   └── localsMiddleware.js
│
├── routes
│   ├── auth.route.js
│   ├── atm.route.js
│   ├── transaction.route.js
│   └── transfer.route.js
│
├── services
│   ├── bankAccount.services.js
│   └── transactions.services.js
│
├── views
│   ├── login.ejs
│   ├── index.ejs
│   ├── atm.ejs
│   ├── transfer.ejs
│   └── transactions.ejs
│
├── public
│   └── css
│
├── server.js
├── package.json
└── README.md
```

---

# Datenbank

Die Datenbank wurde mit MySQL erstellt und über `mysql2` mit der Anwendung verbunden.

Das Datenbankdesign wurde so aufgebaut, dass Erweiterungen wie weitere Benutzerrollen, Kredite oder automatische Zahlungen möglich sind.

Aktuelle Tabellen:

- `users`
- `roles`
- `audit_log`
- `bank_account`
- `transactions`
- `subscription`
- `account_subscription`
- `loan`
- `loan_payment`
- `subscription_payment`

## Datenbank Setup

Das Datenbankschema befindet sich unter:

```
database/schema.sql
```

Testdaten können über:

```
database/seed.sql
```

eingefügt werden.

---

# Backend Features

## Authentication

Die Anmeldung verwendet:

- Passwort-Hashing mit `bcrypt`
- Sessions mit `express-session`
- geschützte Routes durch Middleware

Beispiel:

```
Login
 ↓
User Validation
 ↓
Password Compare
 ↓
Session Creation
 ↓
Protected Routes
```

---

## Transaction Handling

Banktransaktionen werden über Datenbanktransaktionen abgesichert.

Beispiel bei einer Überweisung:

```
BEGIN TRANSACTION

Check Accounts

Check Balance

Remove Amount from Sender

Add Amount to Receiver

Create Transaction Record

COMMIT
```

Falls ein Fehler auftritt:

```
ROLLBACK
```

Dadurch wird verhindert, dass ein Konto belastet wird, ohne dass das andere Konto den Betrag erhält.

---

## Error Handling

Das Projekt verwendet ein eigenes Error Handling System.

Eigene Error Classes:

- `AppError`
- `AuthenticationError`
- `TransactionError`

Zusätzlich werden Fehler zentral über eine Error Middleware verarbeitet.

Async Routes werden mit einem `asyncHandler` Wrapper verarbeitet, wodurch Fehler automatisch an die Error Middleware weitergegeben werden.

---

# Lernfortschritte

Während der Entwicklung wurden verschiedene Backend-Konzepte praktisch umgesetzt:

- Express Routing
- Middleware Architecture
- Request / Response Lifecycle
- Sessions
- Authentication
- SQL Relations
- Database Transactions
- Connection Handling
- Error Handling
- Separation of Concerns
- Service Layer Architecture

Besonders wichtig war die Verbesserung der Projektstruktur während der Entwicklung.

Anfangs befand sich mehr Logik direkt in den Routes. Durch die Weiterentwicklung wurde die Anwendung stärker getrennt:

```
Route
 ↓
Service
 ↓
Database
```

Dadurch wurde der Code übersichtlicher und leichter erweiterbar.

---

# Installation

Repository klonen:

```bash
git clone https://github.com/Domcode760/Bankwebsite.git
```

In den Projektordner wechseln:

```bash
cd Bankwebsite
```

Dependencies installieren:

```bash
npm install
```

---

# Environment Variables

Eine `.env` Datei muss erstellt werden:

```env
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=bankwebsite

SESSION_SECRET=your_secret
```

Die Datei wird absichtlich nicht im Repository gespeichert.

---

# Anwendung starten

Development Mode:

```bash
npm run dev
```

Danach ist die Anwendung erreichbar unter:

```
http://localhost:3000
```

---

# Aktueller Status

Das Projekt befindet sich weiterhin in Entwicklung.

Geplante Erweiterungen:

- Rollen- und Berechtigungssystem
- Admin-Bereich
- Audit Logging
- Kreditverwaltung
- automatische Zahlungen
- weitere UI Verbesserungen

---

# Motivation

Dieses Projekt entstand aus dem Interesse, Backend-Entwicklung nicht nur theoretisch zu lernen, sondern durch die Entwicklung einer vollständigen Anwendung praktisch anzuwenden.

Dabei lag der Fokus nicht nur auf funktionierendem Code, sondern auch auf Architektur, Wartbarkeit und dem Verständnis der einzelnen technischen Entscheidungen.
