#!/bin/bash

# Loop to simulate multiple patch requests
for i in {1..5}; do
  ## Server Name
  server=server$(( ( RANDOM % 10 )  + 1 )).boschsg

  ## Random Date time
  days_in_front=7  # Fixed to 7 days from now
  hours_in_front=$(shuf -i 0-24 -n 1)  # Random hour between 0 and 24
  minutes_array=("00" "15" "30" "45")
  minute=$(shuf -e "${minutes_array[@]}" -n 1)  # Random 15-minute interval
  scheduled_update_time=$(date '+%Y-%m-%d %H' -d "+$days_in_front days +$hours_in_front hours")

  echo "$server $scheduled_update_time:$minute:00"

  # Insert data into the MySQL database running in a Docker container
  # Assuming the container name is 'mysql-container' and MySQL is accessible inside
  # Replace 'root' with the actual username and 'password' with the actual password
  docker exec -i mysql-container mysql -uroot -pYourPassword -e "
    INSERT INTO patching.patch (server, status, update_time) 
    VALUES ('$server', 'Booked', '$scheduled_update_time:$minute:00');
  "

done
