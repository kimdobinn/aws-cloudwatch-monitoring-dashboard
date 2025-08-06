# 🧠 CloudWatch Multi-Region EC2 & ELB Monitoring – Architecture Guide

This document explains the technical design and structure of the CloudWatch monitoring dashboard created for observing EC2 and ELB performance across multiple AWS regions and accounts.

---

## 🔧 Design Objectives

- Centralize EC2 & ELB observability in one dashboard
- Enable quick region switching via dynamic variables
- Surface alarms with clear thresholds and anomaly detection
- Provide alerting via SNS email subscriptions
- Maintain dashboard extensibility for future regions or services

---

## 📦 Stack Overview

| Component     | Purpose                                         |
|--------------|--------------------------------------------------|
| **CloudWatch Dashboard** | Main interface for real-time monitoring |
| **CloudWatch Alarms**    | Resource usage alerts with thresholds and anomaly detection |
| **SNS Topic**            | Sends email alerts for triggered alarms |
| **Property Variables**   | Allow dashboard-wide filtering by instance, load balancer, and region |
| **CWAgent**              | Publishes RAM and disk metrics not included by default |

---

## 🧩 Variable Strategy

The dashboard uses **3 `property` variables** for maximum flexibility:

| Variable     | Scope          | Used By              |
|--------------|----------------|----------------------|
| `region`     | AWS Region     | All widgets & alarms |
| `InstanceId` | EC2 Resources  | CPU, RAM, Disk       |
| `LoadBalancer` | ELB Resources | Request, Error Rates |

These variables allow dynamic switching between regions and resources without creating separate dashboards.

---

## 📈 Metrics Monitored

### 🔹 EC2
- `CPUUtilization` (AWS/EC2)
- `mem_used_percent` (CWAgent)
- `disk_used_percent` (CWAgent)
- `NetworkIn` / `NetworkOut` (AWS/EC2)

### 🔹 ELB (Application Load Balancer)
- `RequestCount`
- `ActiveConnectionCount`
- `HTTPCode_ELB_4XX_Count`
- `HTTPCode_ELB_5XX_Count`

---

## 🚨 Alarm Strategy

Alarms were defined in **three formats**:
- CloudFormation (YAML and JSON)
- AWS CLI (`put-metric-alarm`)

### 🔔 Alarm Features:
- Static threshold alarms (e.g., NetworkIn > 281MB)
- Anomaly detection alarms (e.g., disk usage outside expected pattern)
- Alert routing via SNS topic: `cloudwatch-observability-alarm-topic`

### Example:
```yaml
AlarmName: sg-prod-backend-high-network-in-percent-alarm
Metric: NetworkIn
Threshold: 281250000
Period: 300 (5 min)
Evaluation: 2 datapoints
Alert Channel: SNS email

📬 Email Alert Flow

CloudWatch Alarm ➝ SNS Topic ➝ Email Subscriber

A sample SNS alert looks like:

```bash
Alarm Name: sg-production-backend-high-network-in-percent-alarm
Region: ap-southeast-1
State: ALARM
Metric: NetworkIn (AWS/EC2)
Threshold: > 281,250,000 bytes
Current value: 305,000,000 bytes
```

🖥️ Dashboard UI Breakdown
Gauges: Current CPU, RAM, Disk metrics

Time Series: ELB performance and request/error rates

Alarm Panels: Current status per region

Text Widgets: User instructions & notes

Layout is built for clarity, allowing engineers to spot bottlenecks at a glance.

🔄 Extensibility
Easily extend to support additional regions or services (e.g., RDS, Lambda)

Add more variables (e.g., Environment, AppName) as needed

Dashboards can be exported and version-controlled as JSON

✅ Lessons Learned
CloudWatch variables are powerful but require careful dimension matching

SNS is a simple and effective notification channel

Anomaly detection adds context to thresholds and reduces false positives

Always export working dashboards to avoid overwriting issues

📁 Related Files
dashboard/dashboard-config.json: Full CloudWatch dashboard definition

alarms/cloudformation/: YAML alarm templates

alarms/aws-cli/: CLI commands for quick alarm creation

docs/sample-sns-email.txt: Example email for triggered alert
