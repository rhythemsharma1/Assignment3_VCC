
#!/bin/bash

# Check CPU usage and scale if > 75%
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/., *\([0-9.]\)%* id.*//" | awk '{print 100 - $1}')
echo "Current CPU usage: $CPU_USAGE%"

if (( $(echo "$CPU_USAGE > 75" | bc -l) )); then
  echo "CPU usage is greater than 75%. Triggering auto-scaling."
  # Trigger auto-scaling (e.g., create a new instance in GCP)
  gcloud compute instances create new-instance --zone=us-central1-a --image-family=debian-9 --image-project=debian-cloud
else
  echo "CPU usage is below 75%. No scaling needed."
fi
