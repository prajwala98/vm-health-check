# vm-health-check
A simple shell script to analyze the health of Ubuntu virtual machines based on CPU, memory, and disk usage.  
The script declares the VM as **HEALTHY** if all three metrics are below 60% utilization, and **NOT HEALTHY** if any are above 60%.  
An optional `explain` argument provides detailed reasoning for the health status.

## Features

- Checks CPU, memory, and disk usage on Ubuntu VMs.
- Declares VM state as "HEALTHY" or "NOT HEALTHY" based on 60% utilization thresholds.
- Explains reasons for health status with an optional argument.
- Easy to use and extend.

## Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/prajwala98/vm-health-check.git
   cd vm-health-check
   ```

2. **Make the script executable:**
   ```bash
   chmod +x vm_health_check.sh
   ```

3. **Run the health check:**
   ```bash
   ./vm_health_check.sh
   ```

4. **Run with explanation:**
   ```bash
   ./vm_health_check.sh explain
   ```

### Output

- If all metrics are below 60%:
  ```
  State of Virtual Machine: HEALTHY
  ```

- If any metric is above 60% (with `explain`):
  ```
  State of Virtual Machine: NOT HEALTHY
  Reason: CPU usage is above threshold (75%)
  Reason: Disk usage is above threshold (81%)
  Current usages:
    CPU usage:    75%
    Memory usage: 53%
    Disk usage:   81%
  ```

## Requirements

- Ubuntu virtual machine
- Bash shell
- `top`, `free`, and `df` utilities (default on Ubuntu)

## Repository Description

This repository provides a shell script to monitor the health of Ubuntu virtual machines.  
It checks CPU, memory, and disk utilization and reports the overall health status based on customizable thresholds.  
Ideal for basic VM monitoring and integration into automated maintenance or alerting workflows.

## License

MIT License
