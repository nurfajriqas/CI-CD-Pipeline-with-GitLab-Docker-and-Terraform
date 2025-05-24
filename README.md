# 🔧 End-to-End CI/CD Pipeline with GitLab, Docker, and Terraform

This project showcases a complete DevOps workflow using a self-hosted GitLab CI/CD pipeline. It covers infrastructure provisioning with Terraform, static website deployment with Nginx (for local/testing) and AWS S3 (for production), automated testing (unit + integration), and full container orchestration using Docker Compose.

---

## 🚀 Project Overview

### 🏗️ Tech Stack

| Purpose              | Tool/Service Used                  |
|----------------------|----------------------------------|
| CI/CD Engine         | GitLab (self-hosted)             |
| Pipeline Execution   | GitLab Runner                    |
| Infrastructure       | Terraform                       |
| Web Server           | Nginx (local), AWS S3 (production) |
| Unit Testing         | RSpec (via custom container)     |
| Integration Testing  | Selenium Chrome                  |
| Infrastructure Target| AWS S3 Bucket (static website)  |
| SSL for GitLab       | OpenSSL (self-signed)            |
| Container Runtime    | Docker + Docker Compose          |

---

## 📂 Folder Structure

```plaintext
.
├── docker-compose.yml
├── infra/                # Terraform configuration for AWS S3 website hosting
├── website/              # Static website files (HTML/CSS/JS)
├── spec/
│   ├── unit/             # RSpec unit tests
│   └── integration/      # RSpec integration tests (Selenium)
├── .gitlab-ci.yml        # GitLab CI/CD pipeline definition
````

---

## ☁️ AWS Infrastructure

This project uses **AWS S3** to host the static website files, provisioned via **Terraform**. The Terraform script:

* Creates a unique S3 bucket with a randomized prefix.
* Configures public access and ownership controls to allow public read.
* Uploads all files from the `/website` directory with appropriate MIME types.
* Sets the bucket for static website hosting with `index.htm` as the default document.
* Outputs the website endpoint URL as `website_url`.

### AWS Credentials

Set your AWS credentials as environment variables before running the pipeline:

```bash
export AWS_ACCESS_KEY_ID=your_access_key_id
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
export AWS_DEFAULT_REGION=your_preferred_region
```

The deployed website will be accessible at the S3 static website URL provided by Terraform output.

---

## 📦 Services Summary

| Service                          | Description                                           |
| -------------------------------- | ----------------------------------------------------- |
| `terraform`                      | Deploys AWS S3 infrastructure using Terraform         |
| `website`                        | Serves static content locally via Nginx (for testing) |
| `selenium`                       | Headless Chrome for integration tests                 |
| `unit-tests`                     | Runs RSpec unit tests                                 |
| `integration-tests`              | Runs Selenium-based integration tests                 |
| `gitlab`                         | Self-hosted GitLab instance with SSL                  |
| `gitlab-runner`                  | GitLab CI/CD runner for executing jobs                |
| `gitlab-db`                      | PostgreSQL database backend for GitLab                |
| `create-self-signed-certificate` | Generates self-signed SSL certificate                 |

---

## 🔁 CI/CD Pipeline Stages

This GitLab pipeline consists of three main stages:

* **Test**

  * `check`: Verifies the environment setup by listing files.
  * `unit-test`: Runs RSpec unit tests for isolated component validation.

* **Deploy**

  * `deploy`: Provisions AWS S3 infrastructure via Terraform and uploads static website files.
  * `integration-test`: Runs Selenium integration tests after deployment to validate the full system.

* **Teardown** (Optional)

  * `teardown`: Destroys the AWS infrastructure using Terraform to save costs and clean up resources.

---

## 🛠️ How to Run

1. Start all services locally (GitLab, GitLab Runner, Selenium, etc.):

   ```bash
   docker compose up -d
   ```

2. Access GitLab via:

   * Web: [https://gitlab.example.com/](https://gitlab.example.com/)
   * SSH: port `2222`

3. Make sure the GitLab Runner is registered and running.

4. Set AWS credentials as environment variables before pipeline execution.

---

## ✅ Requirements

* Docker & Docker Compose
* AWS credentials with permissions to create S3 buckets and upload objects
* Terraform v1.x
* GitLab Runner installed & configured
* Ruby & RSpec (for local test development)

---

## 🔒 SSL Notes

This project uses a self-signed certificate generated automatically via OpenSSL inside the container `create-self-signed-certificate`. This certificate enables HTTPS for the GitLab web interface.

---

## 📜 License

This project is intended for educational and demonstration purposes.

---

## ✍️ Author

Built as part of a hands-on DevOps learning track. Feel free to fork, modify, or use it for interviews and portfolio showcases.


