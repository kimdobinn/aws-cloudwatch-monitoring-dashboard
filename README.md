# 🌐 AWS CloudWatch Multi-Region EC2 & ELB Monitoring Dashboard

![Built with CloudFormation](https://img.shields.io/badge/Built%20With-CloudFormation-blue)
![AWS CloudWatch](https://img.shields.io/badge/Service-AWS%20CloudWatch-yellow)
![Multi-Account](https://img.shields.io/badge/Scope-Multi--Account%2FRegion-green)
![Alerts](https://img.shields.io/badge/Alerts-SNS%20Email%20Enabled-red)

## 📘 Overview

This project implements a centralized **CloudWatch dashboard** for monitoring EC2 and ELB resources across multiple AWS regions and accounts. It visualizes metrics like **CPU**, **RAM**, and **Disk** usage using property and pattern variables and integrates with **SNS** to trigger alert emails via CloudWatch alarms.

---

## 🧱 Architecture

- **CloudWatch Dashboard**: Multi-region widgets using pattern variables (region + load balancer) and property variables (InstanceId).
- **Monitored Metrics**:
  - EC2: CPUUtilization, RAM (via CWAgent), Disk (%), Network In/Out
  - ELB: Connection Count, HTTP 4XX/5XX, Request Count
- **Alarms**:
  - Created via CloudFormation YAML, JSON, and AWS CLI
  - Anomaly detection included for disk usage
- **SNS Alerting**: Alarms notify via the `cloudwatch-observability-alarm-topic` topic
- **Dashboard Instructions** embedded as Markdown text widgets.

---

## 🚀 Deployment Instructions

### Option 1: CloudFormation (YAML)
In the [alarms/cloudformation](alarms/cloudformation) folder, use your preferred deployment method:
```bash
aws cloudformation deploy \
  --template-file ec2-network-in.yaml \
  --stack-name ec2-network-in-alert \
  --capabilities CAPABILITY_IAM


Option 2: JSON
Upload any file from **alarms/json** in the AWS Console → CloudFormation → Create Stack.

Option 3: AWS CLI
Copy and paste the respective CLI file from **alarms/aws-cli** to create the alarm instantly.

📊 Dashboard Setup
To import the dashboard:

Open CloudWatch > Dashboards → Create dashboard

Choose JSON tab and paste from dashboard/dashboard-config.json

Customize variable values under Actions → Manage variables

📨 Sample SNS Email Alert

Alarm Name: sg-production-backend-high-network-in-percent-alarm
Region: ap-southeast-1
State: ALARM
Description: Network inbound traffic exceeded threshold (281 MB over 10 mins)
Metric: NetworkIn (AWS/EC2)
Threshold: > 281,250,000 bytes
Current value: 305,000,000 bytes


🧠 Lessons Learned
CloudWatch dashboards are highly customizable — using pattern and property variables together allows dynamic, reusable visualizations across environments.

Alarm configuration flexibility (via YAML/CLI/Console) supports multiple ops workflows.

SNS topic subscriptions provide a seamless way to distribute alerts via email without manual polling.

📂 Repository Structure
cloudwatch-multi-region-monitoring/
├── README.md
├── dashboard/
│   └── dashboard-config.json
├── alarms/
│   ├── cloudformation/
│   ├── json/
│   └── aws-cli/
├── docs/
│   └── architecture.md
└── assets/
    └── dashboard-diagram.png


📬 Contact
Maintained by a DevOps Cloud Engineer for production-level infrastructure.


---

## 📄 `docs/architecture.md`

```markdown
# 🧠 Architecture Deep Dive

This monitoring solution supports **multi-account, multi-region** visibility using dynamic variable substitution and alarm propagation.

### Variable Strategy
- **Pattern Variable (`Region`)**: Encodes both region and load balancer into a single string (`region|loadBalancer`) for cross-region ELB metric pulling.
- **Property Variable (`InstanceId`)**: Enables instance-specific filtering for CPU, RAM, and Disk utilization.

### Alarm Strategy
- **Static Threshold Alarms**: e.g., NetworkIn/Out > 281MB over 10 mins
- **Anomaly Detection Alarms**: Disk usage deviations beyond 0.1 SD
- **SNS Integration**: Single topic `cloudwatch-observability-alarm-topic` receives all alarm events

### Dashboard Sections
1. **Resource Summary (Gauges)** — CPU, Disk, RAM for selected instance
2. **Trends (TimeSeries)** — historical CPU/RAM/Disk usage
3. **ELB Metrics** — Request/Connection/4XX/5XX counts
4. **Alarm Panels** — Status of all regional alarms
5. **Text Widgets** — Embedded instructions

### Email Flow
1. CloudWatch Alarm → SNS Topic
2. SNS Topic → Email subscription
3. Engineers receive alerts for spikes or degradation in usage

This setup ensures a robust, reusable system that scales with infrastructure expansion.
