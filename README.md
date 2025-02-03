# Dynamic Patching Automation and Scheduling with Ansible Automation Platform

This POC describes an approach to automating patching tasks with Ansible Automation Platform (AAP), with dynamic scheduling based on user input. In this case, the server requires an automated patching process that can handle both the patch execution and its dynamic scheduling at a specified time from the user's request (Freeze Period, Change Windwow, Emergency Cancellation and Priority-Queue Insertion).

## Problem Statement

The customer’s procedure for patching is that the end user raises a patching request. The request contains:
- A list of servers
- A list of patches
- A specified time for when the patching task should be executed

The goal is to automate the patching task itself and the scheduling process, ensuring that the patching is executed at the exact time mentioned in the request.

However, the existing Ansible Automation Platform (AAP) only supports static scheduling using the built-in scheduler feature, which is not suitable for dynamic scheduling based on external inputs (e.g., patching requests). The AAP scheduler is more like a cron job in Linux, where the schedule is set manually and cannot adapt to dynamic changes.

This walks through the steps I took to handle dynamic scheduling using AAP, specifically for a patching use case.

## Solution Overview

To achieve dynamic scheduling, I created two templates in AAP:
1. **Patching Template**: Executes the patching task.
2. **Schedule Template**: Schedules when to run the patching task.

I leveraged the Ansible Automation Platform REST API to dynamically add and delete schedules based on the provided patching request.

### Steps to Implement

1. **Patching Template**
   - The patching template is designed to install the patches on the specified servers. Once the patching task is completed, the associated schedule is deleted automatically.
   
2. **Schedule Template**
   - The schedule template defines when the patching task will be executed, based on the time specified in the user’s patching request.

3. **Use of REST API**
   - The Ansible REST API is used to create and delete schedules dynamically based on the time window provided in the change request.
   - The scheduling process is automated, so there’s no need for manual intervention.

## Ansible Automation Platform (AAP) Scheduling Behavior

In the AAP Web Console, schedules can typically be created:
- From a template
- From a project
- From an inventory source

However, schedules cannot be created directly from the **main Schedules** screen. This limits its flexibility for handling dynamic schedules, as the scheduling needs to be manually configured and lacks automation.

### Issue with AAP’s Built-in Scheduler

The built-in scheduler in AAP is ideal for static, recurring tasks but does not fit the customer’s requirement for dynamically setting the schedule based on input provided by the end user. This is because the schedule in AAP is fixed and cannot be adjusted dynamically based on external factors (like the patching request).

## Implementation Details

To address this limitation, I created two custom templates and used the AAP REST API to manage the schedules dynamically:

1. **Patching Template**: 
   - Executes the patching task on the selected servers.
   - After the patch is installed, the associated schedule is removed.

2. **Schedule Template**: 
   - This template takes the time specified in the patching request and schedules the patching task accordingly.

3. **REST API**:
   - The REST API is used to programmatically add and remove schedules based on the timing provided in the patching request.
   - The API ensures that the patch is executed exactly at the specified time and then deletes the schedule once the task is complete.

## How It Works

1. The customer submits a patching request that includes the server list, patch list, and the time window for patching.
2. A script is triggered to create a schedule dynamically using the **Schedule Template**.
3. The schedule triggers the **Patching Template** at the specified time.
4. Once the patching is complete, the schedule is deleted automatically.

## Benefits

- **Dynamic Scheduling**: Schedules are created and deleted based on the user’s input, which makes the process much more flexible.
- **Automation**: The entire patching and scheduling process is automated, reducing the manual overhead involved in patching tasks.
- **Customizable**: The solution can be customized to work with different types of patching requests, server configurations, and time windows.

## Conclusion

The original scheduling functionality in AAP is good for static schedules but does not meet the needs of dynamic scheduling based on user input. By leveraging the AAP REST API, I was able to create a solution that dynamically schedules and manages patching tasks based on the provided change request, making the entire process more efficient and automated.

## Future Enhancements

- Add error handling and logging to ensure the scheduling process is robust and traceable.
- Implement more complex scheduling logic to handle different time zones and recurring patching tasks.

## Resources

- [Ansible Automation Platform Documentation](https://docs.ansible.com/ansible-automation-platform)
- [Ansible REST API Documentation](https://docs.ansible.com/ansible/latest/automation-controller/rest_api.html)
