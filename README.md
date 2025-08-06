# Multi-Region CloudWatch Monitoring for EC2 & ELB Resources

A full-featured AWS CloudWatch dashboard setup for monitoring EC2 and ELB resources across multiple environments and regions (US-Prod, AU-Prod, SG-UAT, SG-STG-Demo). Designed to improve operational awareness through customizable metrics, alarms, and real-time visualization.

## Tools & Skills

- **AWS CloudWatch**: Dashboards, metrics, anomaly detection, and alarms
- **CloudFormation (YAML & JSON)**: Dashboard provisioning and alarm deployment
- **AWS CLI**: Rapid testing and deployment of monitoring configurations
- **IAM & SNS**: Permissions and alerting pipeline for alarm notifications
- **JSON & Markdown**: Dashboard definitions and documentation

## Monitoring Capabilities

### Metrics Tracked
- **EC2 CPUUtilization**
- **RAM Usage** (via CWAgent)
- **Disk Utilization** (via CWAgent)
- **API Gateway Latency**
- **4XX / 5XX Errors**

### Alarms
- High CPU, RAM, Disk usage for each EC2 role (e.g., Event Scheduler, Backend, Frontend)
- API Gateway: Latency, abnormal 4XX and 5XX response count

### Dashboard Features
- **Pattern and Property Variables** for filtering by region and instance ID
- **Gauge View** for disk and RAM monitoring with red zones above 90%
- **TimeSeries View** for trend analysis
- **SingleValue View** for quick-glance metrics
- **Anomaly Detection Band** for backend memory usage
- **Grouped Alarms View** by environment

## 📂 Project Structure

```
aws-cloudwatch-monitoring-dashboard/
├── alarms/
│   ├── aws-cli/
|   |   ├── sg-production-backend-high-network-in-percent-alarm.sh
│   ├── cloudformation/
|   |   ├── sg-production-backend-high-network-in-percent-alarm.yaml
│   ├── json/
|   |   ├── sg-production-backend-high-network-in-percent-alarm.json
├── dashboard/
│   ├── dashboard-config.json
├── sns/
│   ├── sample-sns-email.txt
├── dashboard.png
├── README.md
```

## Key Features Demonstrated

1. **Cross-Region, Multi-Account Dashboarding**
   - Integrated dashboards for multiple prod and test environments.
   - Dynamic widget filtering using `pattern` and `property` variables.

2. **Full-stack Monitoring**
   - From infrastructure-level metrics (CPU, memory, disk) to application-level (API Gateway latency and errors).

3. **Anomaly Detection Integration**
   - Uses `ANOMALY_DETECTION_BAND` to visualize expected memory usage ranges.

4. **Alerting via SNS**
   - Alarms routed through SNS topics for immediate notification.

5. **Production-Ready Layout**
   - Strategic grouping of widgets for clarity and operational triage.

## Sample Alarms

- [us-prod-backend-high-cpu](https://github.com/kimdobinn/aws-cloudwatch-monitoring/blob/main/cloudformation/us-prod-alarms.yaml#L12)
- [your-api-5XX-alarm](https://github.com/kimdobinn/aws-cloudwatch-monitoring/blob/main/dashboard_sanitized.json#L190)

## Testing

You can deploy alarms manually using AWS CLI:

```bash
aws cloudwatch put-metric-alarm --cli-input-json file://cloudformation/us-prod-cpu-alarm.json
```

Or deploy an entire alarm stack using CloudFormation:

```bash
aws cloudformation deploy   --template-file cloudformation/us-prod-alarms.yaml   --stack-name cw-us-prod-alarms   --capabilities CAPABILITY_IAM
```

## Notes

- All `InstanceId`, `ARN`, and internal identifiers have been masked in the public version.
- Region defaults are set to `ap-southeast-1` (Singapore) and `us-east-1`.

## Author

[@kimdobinn](https://github.com/kimdobinn)