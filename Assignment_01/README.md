# Cloud-Native Web Application – Health Check API

## 📌 Overview

This is a cloud-native backend web application developed using Python, Flask, SQLAlchemy, and PostgreSQL. The application implements a `/healthz` endpoint that performs a database connectivity check and inserts a timestamped record into a `health_check` table.

This project meets cloud-native requirements, including stateless design, ORM-based DB bootstrapping, proper HTTP status code handling, and JSON-based RESTful practices. It is ready to be containerized and deployed on any cloud platform.

---

## ⚙️ Technology Stack

| Component          | Technology               |
|--------------------|--------------------------|
| Programming Lang   | Python 3.10+             |
| Framework          | Flask                    |
| ORM                | SQLAlchemy               |
| Database           | PostgreSQL               |
| OS (target)        | Ubuntu 24.04 LTS         |
| Packaging (option) | Docker                   |
| API Format         | RESTful + JSON           |

---

## 🧠 Learning Objectives

- Understand cloud-native web app architecture
- Implement a RESTful health check endpoint
- Auto-bootstrap a relational database using an ORM
- Handle HTTP methods and error codes properly
- Prepare for deployment in containerized cloud environments

---

## 📂 Project Structure

Minal_Tayde_002319636_01/
└── webapp/
├── app/
│ ├── init.py # App & DB setup
│ ├── models.py # SQLAlchemy ORM model
│ └── routes.py # /healthz endpoint
├── run.py # Entry point
├── requirements.txt # Python dependencies
├── .gitignore # Exclude venv, pycache, etc.
└── README.md # You're here!

yaml
Copy
Edit

---

## Setup Instructions (Local)

### 1. Start PostgreSQL
Using Docker:
```bash
docker run --name healthdb -e POSTGRES_PASSWORD=password -e POSTGRES_DB=healthdb -p 5432:5432 -d postgres
2. Create and Activate Virtual Environment
bash
Copy
Edit
python -m venv venv
# Windows
venv\Scripts\activate
# macOS/Linux
source venv/bin/activate
3.  Install Dependencies
bash
Copy
Edit
cd webapp
pip install -r requirements.txt
4.  Set Environment Variable
bash
Copy
Edit
# Windows CMD
set DATABASE_URL=postgresql://postgres:password@localhost:5432/healthdb

# PowerShell
$env:DATABASE_URL="postgresql://postgres:password@localhost:5432/healthdb"
5.  Run the App
bash
Copy
Edit
python run.py
Testing the Health Check API
Successful Health Check
bash
Copy
Edit
curl -v http://localhost:8080/healthz
Expected:

200 OK

New row inserted in health_check table

Method Not Allowed
bash
Copy
Edit
curl -X POST http://localhost:8080/healthz
Expected: 405 Method Not Allowed

Payload Not Allowed
bash
Copy
Edit
curl -X GET -d '{"check":1}' http://localhost:8080/healthz
Expected: 400 Bad Request

DB Failure (Simulate by stopping container)
bash
Copy
Edit
docker stop healthdb
curl http://localhost:8080/healthz
Expected: 503 Service Unavailable

Database Table: health_check
Column	Type	Description
id	Integer (PK)	Auto-increment primary key
timestamp	DateTime	UTC time when health was checked

Optional: Dockerize the App
(Add only if Dockerfile/docker-compose.yml is used)