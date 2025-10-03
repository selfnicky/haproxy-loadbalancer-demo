# HAProxy Load Balancer on AWS Lightsail - Terraform Automation

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![HAProxy](https://img.shields.io/badge/HAProxy-%23FF5A00.svg?style=for-the-badge)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

A complete Infrastructure as Code solution for deploying a production-ready HAProxy load balancer with multiple backend web servers on AWS Lightsail. This project demonstrates modern DevOps practices by automating the entire infrastructure deployment using Terraform.

## 🚀 Features

- **Infrastructure as Code**: Complete AWS environment defined in Terraform
- **Load Balancing**: HAProxy with round-robin algorithm for traffic distribution
- **Containerized Applications**: Multiple PHP web servers running in Docker containers
- **Real-time Monitoring**: Built-in HAProxy statistics dashboard
- **Automated Security**: Auto-generated SSH keys and configured firewall rules
- **Cost Optimization**: AWS Lightsail for predictable cloud pricing
- **High Availability**: Multiple backend servers with health checks

## 📋 Prerequisites

- AWS Account with Lightsail access
- Terraform 1.0+ installed
- AWS CLI configured with appropriate permissions
- Git for version control

## 🏗️ Architecture

┌─────────────────┐
│ Client │
│ │
└─────────┬───────┘
│
▼
┌─────────────────┐
│ HAProxy │ ← Load Balancer (Port 80)
│ AWS Lightsail │ ← Statistics (Port 8080)
└─────────┬───────┘
│
┌─────┴─────┐
│ │
▼ ▼
┌─────────┐ ┌─────────┐
│ Web 1 │ │ Web 2 │ ← Backend Servers
│ Port 8000│ │ Port 8005│ ← Docker Containers
└─────────┘ └─────────┘