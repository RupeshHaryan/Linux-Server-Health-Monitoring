# Linux Server Health Monitoring

A Bash-based Linux server monitoring project that collects system health information and generates a detailed log report.

## Features

- CPU load monitoring
- Memory usage monitoring
- Disk usage monitoring
- Top CPU-consuming processes
- Hostname and system date information
- Disk health warning when usage reaches 80%
- Log-based reporting
- Can be automated using Cron

## Technologies Used

- Linux (Fedora)
- Bash Shell Scripting
- Cron
- Linux system utilities

## How to Run

Make the script executable:

    chmod +x system_monitor.sh

Run the monitoring script:

    ./system_monitor.sh

View the generated report:

    cat ~/system_health.log

## Sample Checks

The script checks:

- CPU load using `uptime`
- Memory using `free`
- Disk usage using `df`
- Processes using `ps`
- Hostname using `hostname`

## Disk Health Monitoring

The script checks the root filesystem usage.

If disk usage reaches 80% or higher, it generates a warning:

    WARNING: Disk usage is 80%

Otherwise:

    OK: Disk usage is 25%

## Cron Automation

The script can be scheduled using Cron to run automatically.

Example:

    crontab -e

Add:

    0 8 * * * /home/rupeshharyan/github-projects/linux-server-health-monitor/system_monitor.sh

This runs the monitoring script every day at 8:00 AM.

## Project Purpose

This project was created to gain practical experience with Linux system administration, Bash scripting, monitoring, logging, and task automation.

## Future Improvements

- CPU usage threshold alerts
- Memory usage alerts
- Email notifications
- Network connectivity monitoring
- Log rotation

