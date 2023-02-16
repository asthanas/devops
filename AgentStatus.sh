#!/bin/bash

# Set the name of the Docker agent container
CONTAINER_NAME="docker-agent"

# Set the email address to send alerts to
ALERT_EMAIL="you@example.com"

# Check if the Docker agent container is running
if docker ps --filter "name=$CONTAINER_NAME" | grep -q "$CONTAINER_NAME"; then
  echo "The Docker agent is running."
else
  echo "The Docker agent is not running. Sending email alert."

  # Send an email alert
  MESSAGE=$(echo -e "<html><body><h2 style=\"color:red;\">Docker Agent Alert</h2><p>The Docker agent is not running.</p><p>Please investigate.</p></body></html>")
  echo -e "To: $ALERT_EMAIL\nSubject: Docker Agent Alert\nContent-Type: text/html\n\n$MESSAGE" | /usr/sbin/sendmail -t
  # Restart the Docker agent container
  docker start $CONTAINER_NAME
fi
