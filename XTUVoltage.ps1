$status = get-service -name "XTU3SERVICE" | Select-Object {$_.status} | format-wide
if ($status -ne "Running") { restart-service -name "XTU3SERVICE"}
& 'C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\XTUCli.exe' -t -id 34 -v -30 # id 34: Core Voltage Offset and what comes after -v is the voltage offset (Eg: -30 = -30mV)
& 'C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\XTUCli.exe' -t -id 79 -v -30 # id 79: Cache Voltage Offset
& 'C:\Program Files (x86)\Intel\Intel(R) Extreme Tuning Utility\Client\XTUCli.exe' -t -id 83 -v -20 # id 83: Graphics Voltage Offset
sleep 2
stop-service -name "XTU3SERVICE"
sleep 4
stop-process -id $PID -force


# Create a task to run that script every time the computer wakes up from sleep/connected standby:
# Open up Task Scheduler and under Action, hit Create Task. On the first page, give it a name (and description) and select "Run whether user is logged on or not" and "Run with the highest privileges".
# Under the Triggers tab, hit "New" at the bottom and under "Begin the task", select "On an event". Under Log choose System, under Source choose Kernel-Power, and under Event ID type 507. Check the box for "Delay task for:" and set it to 30 seconds. Create another new trigger doing the exact same thing, but put Event ID as 107 this time. I also created a trigger on system startup - under "Begin the task" select "At startup" and set the delay to 1 minute.
# Event ID 507 shows up in the system when your computer wakes from Connected Standby and 107 when the computer wakes from sleep, so we will use those as the triggers for this task (along with at startup, if, like me, you want to keep it running without loading the rest of the XTU software (which I disabled at startup elsewhere)).
# Under Actions, hit "New" at the bottom and set the action to "Start a program". Set the Program/script to Powershell.exe and under Add arguments, add the following: -ExecutionPolicy Bypass -WindowStyle Hidden C:\Startup\XTUvoltage.ps1
# Change the last part of that to whatever you set your file name and/or directory to for the powershell script.
# Under Conditions, uncheck "Start this task only if the computer is on AC power". If you don't do this, it won't come on when you're running on battery which is kinda the point.
# Under Settings, change "Stop this task if it runs longer than:" to 1 hour.
#
# Script modified from Reddit, various sources.