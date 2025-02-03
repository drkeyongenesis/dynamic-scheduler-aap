#!/bin/bash

# Initialize starting minutes and loop for every 5 minutes for 2 hours
minutes_in_front=5

for i in {1..24}; do
  ## Random Server Name Generation
  server="server$(( ( RANDOM % 10 ) + 1 )).boschsg"  # Generates server1.boschsg, server2.boschsg, etc.

  ## Add 7 days and random minutes for scheduling
  days_in_front=7

  # Calculate the scheduled update time
  scheduled_update_time=$(TZ=UTC date '+%Y-%m-%d %H:%M:00' -d "+$days_in_front days +$minutes_in_front minutes")

  # Echo the scheduled time for debugging purposes
  echo "Scheduled Update for $server: $scheduled_update_time"

  # Insert the patching request into MySQL (ensure MySQL is running on the provided IP)
  mysql -h 192.168.122.12 -u root -pd0ddl3 -e "
    INSERT INTO patching.patch (server, status, update_time) 
    VALUES ('$server', 'Booked', '$scheduled_update_time');
  "
  
  # Check if MySQL command succeeded
  if [ $? -eq 0 ]; then
    echo "Patch request for $server scheduled successfully."
  else
    echo "Error scheduling patch request for $server."
  fi

  # Increment the minutes by 5 for the next iteration
  minutes_in_front=$(( minutes_in_front + 5 ))
done
