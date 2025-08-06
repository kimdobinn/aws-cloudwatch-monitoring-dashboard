# 1. prod-backend-network-in-alarm
aws cloudwatch put-metric-alarm \
--alarm-name 'prod-backend-network-in-alarm' \
--alarm-description 'Alarm for high inbound network traffic' \
--no-actions-enabled \
--alarm-actions 'arn:aws:sns:ap-southeast-1:123456789012:my-alarm-topic' \
--metric-name 'NetworkIn' \
--namespace 'AWS/EC2' \
--statistic 'Average' \
--dimensions '[{"Name":"InstanceId","Value":"i-xxxxxxxxxxxxxxxxx"}]' \
--period 300 \
--evaluation-periods 2 \
--datapoints-to-alarm 2 \
--threshold 281250000 \
--comparison-operator 'GreaterThanThreshold' \
--treat-missing-data 'missing'

# 2. prod-backend-network-out-alarm
aws cloudwatch put-metric-alarm \
--alarm-name 'prod-backend-network-out-alarm' \
--alarm-description 'Alarm for high outbound network traffic' \
--no-actions-enabled \
--alarm-actions 'arn:aws:sns:ap-southeast-1:123456789012:my-alarm-topic' \
--metric-name 'NetworkOut' \
--namespace 'AWS/EC2' \
--statistic 'Average' \
--dimensions '[{"Name":"InstanceId","Value":"i-xxxxxxxxxxxxxxxxx"}]' \
--period 300 \
--evaluation-periods 2 \
--datapoints-to-alarm 2 \
--threshold 281250000 \
--comparison-operator 'GreaterThanThreshold' \
--treat-missing-data 'missing'

# 3. prod-backend-disk-anomaly-alarm
aws cloudwatch put-metric-alarm \
--alarm-name 'prod-backend-disk-anomaly-alarm' \
--alarm-description 'Anomaly alarm for disk usage' \
--no-actions-enabled \
--alarm-actions 'arn:aws:sns:ap-southeast-1:123456789012:my-alarm-topic' \
--evaluation-periods 2 \
--datapoints-to-alarm 2 \
--threshold-metric-id 'anomaly_band' \
--comparison-operator 'LessThanLowerOrGreaterThanUpperThreshold' \
--treat-missing-data 'missing' \
--metrics '[{"Id":"disk_usage_percent","ReturnData":true,"MetricStat":{"Metric":{"Namespace":"CWAgent","MetricName":"disk_used_percent","Dimensions":[{"Name":"path","Value":"/"},{"Name":"device","Value":"nvme0n1p1"},{"Name":"fstype","Value":"xfs"},{"Name":"InstanceId","Value":"i-xxxxxxxxxxxxxxxxx"}]},"Period":300,"Stat":"Average","Unit":"Percent"}},{"Id":"anomaly_band","Label":"Disk Usage Anomaly","ReturnData":true,"Expression":"ANOMALY_DETECTION_BAND(disk_usage_percent, 0.1)"}]'

# 4. prod-frontend-disk-anomaly-alarm
aws cloudwatch put-metric-alarm \
--alarm-name 'prod-frontend-disk-anomaly-alarm' \
--alarm-description 'Anomaly alarm for frontend disk usage' \
--no-actions-enabled \
--alarm-actions 'arn:aws:sns:ap-southeast-1:123456789012:my-alarm-topic' \
--evaluation-periods 2 \
--datapoints-to-alarm 2 \
--threshold-metric-id 'anomaly_band' \
--comparison-operator 'LessThanLowerOrGreaterThanUpperThreshold' \
--treat-missing-data 'missing' \
--metrics '[{"Id":"disk_usage_percent","ReturnData":true,"MetricStat":{"Metric":{"Namespace":"CWAgent","MetricName":"disk_used_percent","Dimensions":[{"Name":"InstanceId","Value":"i-yyyyyyyyyyyyyyyyy"},{"Name":"device","Value":"nvme0n1p1"},{"Name":"path","Value":"/"},{"Name":"fstype","Value":"xfs"}]},"Period":300,"Stat":"Average","Unit":"Percent"}},{"Id":"anomaly_band","Label":"Disk Usage Anomaly","ReturnData":true,"Expression":"ANOMALY_DETECTION_BAND(disk_usage_percent, 0.1)"}]'

# 5. prod-frontend-network-in-alarm
aws cloudwatch put-metric-alarm \
--alarm-name 'prod-frontend-network-in-alarm' \
--alarm-description 'Alarm for frontend high network-in' \
--no-actions-enabled \
--alarm-actions 'arn:aws:sns:ap-southeast-1:123456789012:my-alarm-topic' \
--metric-name 'NetworkIn' \
--namespace 'AWS/EC2' \
--statistic 'Average' \
--dimensions '[{"Name":"InstanceId","Value":"i-yyyyyyyyyyyyyyyyy"}]' \
--period 300 \
--evaluation-periods 2 \
--datapoints-to-alarm 2 \
--threshold 281250000 \
--comparison-operator 'GreaterThanThreshold' \
--treat-missing-data 'missing'

# 6. prod-frontend-network-out-alarm
aws cloudwatch put-metric-alarm \
--alarm-name 'prod-frontend-network-out-alarm' \
--alarm-description 'Alarm for frontend high network-out' \
--no-actions-enabled \
--alarm-actions 'arn:aws:sns:ap-southeast-1:123456789012:my-alarm-topic' \
--metric-name 'NetworkOut' \
--namespace 'AWS/EC2' \
--statistic 'Average' \
--dimensions '[{"Name":"InstanceId","Value":"i-yyyyyyyyyyyyyyyyy"}]' \
--period 300 \
--evaluation-periods 2 \
--datapoints-to-alarm 2 \
--threshold 281250000 \
--comparison-operator 'GreaterThanThreshold' \
--treat-missing-data 'missing'
