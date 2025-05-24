# 🔧 End-to-End CI/CD Pipeline with GitLab, Docker, and Terraform

This project demonstrates a full DevOps workflow using a self-hosted GitLab CI/CD pipeline. It includes infrastructure provisioning, website deployment, automated testing (unit + integration), and teardown.

---

## 🚀 Project Overview

### 🏗️ Tech Stack

| Purpose              | Tool/Service Used                  |
|----------------------|------------------------------------|
| CI/CD Engine         | GitLab (self-hosted)               |
| Pipeline Execution   | GitLab Runner                      |
| Infrastructure       | Terraform                          |
| Web Server           | Nginx                              |
| Unit Testing         | RSpec (via custom container)       |
| Integration Testing  | Selenium Chrome                    |
| Infrastructure Target| AWS (via environment variables)    |
| SSL for GitLab       | OpenSSL (self-signed)              |
| Container Runtime    | Docker + Docker Compose            |

---

## 📂 Folder Structure

```plaintext
.
├── docker-compose.yml
├── infra/                # Terraform configuration
├── website/              # Static website files (HTML/CSS/JS)
├── spec/
│   ├── unit/             # RSpec unit tests
│   └── integration/      # RSpec integration tests
├── .gitlab-ci.yml        # GitLab CI/CD pipeline definition
