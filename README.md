# Shell Process and Load Monitor

### Configuring

Change the value of variable `base_log_folder` located on process_monitor.sh file to the location that you would like to log.

Change the value of variable `base_folder` located on process-ctl.sh file to the location where the project is in your computer.

If you want, you can change the parameters of the monitor in `process_monitor.sh` file. Values above that parameters are logged. The parameters are:

| Name                | Default value | Description                    |
|---------------------|:-------------:|--------------------------------|
| MAX_PCPU            | 150           | Max processor use by a process |
| MAX_PMEM            | 15            | Max memory use by a process    |
| MAX_LOAD            | 8             | Max system load                |
| MAX_CPU_TEMPERATURE | 75            | Max CPU temperature            |

### Usage

Use the "process-ctl.sh" to manage Process Monitor.

Ex:

To start the monitor  

    $ ./process-ctl.sh start  

To stop the monitor  

    $ ./process-ctl.sh stop  

To check the status of the monitor  

    $ ./process-ctl status  


