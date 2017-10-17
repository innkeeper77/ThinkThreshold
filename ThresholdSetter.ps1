# Script to set battery thresholds for Lenovo Thinkpads running Windows 10
# Tested on a Thinkpad Yoga X1 2nd Gen 2017 - may or may not work for you.
# This software comes with no guarantee. Use at your own risk, etc. MIT license - see details in seperate file. 
#
# To use: You must set 3 variables below the dotted line. Please leave the quoatation marks.
#
# The script WILL NOT WORK unless you enter your correct battery serial number!
# 
# 1. Your unique battery serial number. 
# To find out your battery serial number, copy and pase the following command into windows powershell (run as admin)
# Get-ChildItem -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data
# The serial number should be obvious: The key folder name on the left, that is a mix of letters and numbers. 
# Eg: mine looks like "L4NJ78S03E2"
# 
# 2. Your threshold start percentage. When should the battery start charging, in a percentage? Mine is set to 85% ($StartP = "85")
# 3. Your threshold stop percentage. When should the battery STOP charging, in a percentage? Mine is set to 90%   ($StopP = "90")
#
# After you set these, if you run this script, the battery thresholds will be set. 
# To ensure they STAY set, I suggest running this script automatically using the task scheduler
#
# To create a task that runs every time the computer starts up:
# Open Task scheduler, Action>Create Task. Give it a name (Eg:ThresholdsSetter), select "Run whether user is logged on or not", 
# and "Run with the highest privileges".
# Under the Triggers tab, hit "New" at the bottom and under "Begin the task", select "At System Startup" Check the box for "Delay 
# task for:" and set it to 1 minute (if desired). 
#
# When you have the task set, have it run powershell, silently, with this script as the argument. 
# (You may have saved it in a different spot than me. Point to wherever this script is located)
# Under Actions, hit "New" at the bottom and set the action to "Start a program". Set the Program/script 
# to Powershell.exe and under Add arguments, add the following: 
# -ExecutionPolicy Bypass -WindowStyle Hidden C:\Startup\ThresholdSetter.ps1
#
# Under Conditions, uncheck "Start this task only if the computer is on AC power".
# Under Settings, change "Stop this task if it runs longer than:" to 1 hour.
# ONLY IF NEEDED, also add triggers to run when resuming from sleep. "Under the Triggers tab, hit "New" at the bottom and under "Begin the task", select "On an event". Under Log choose System, under Source choose Kernel-Power, and under Event ID type 507. Check the box for "Delay task for:" and set it to 30 seconds. Create another new trigger doing the exact same thing, but put Event ID as 107 this time." 

# (For instructions on Task Scheduler, Thanks u/thebigbug from reddit, on 
# https://www.reddit.com/r/Surface/comments/63orso/solution_for_undervolting_settings_not_sticking/ 
# - I shamelessly copied much of it for the instructions here. )
# 
# You probably have to reboot to get this to work the first time, so once you have set everything up, 
# run the script manually (just this once) and reboot. 
# Your thresholds should now be set!
#
# ----------------------------------------------------------------------------------------------------------------------------------

$BattSerial = "L4NJ78S03E2"
$StartP = "85"
$StopP = "90"

$val = Get-ItemProperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartControl"
if($val.ChargeStartControl -ne 1)
{
 set-itemproperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartControl" -value 1
}

$val = Get-ItemProperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopControl"
if($val.ChargeStopControl -ne 1)
{
 set-itemproperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopControl" -value 1
}

$val = Get-ItemProperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartPercentage"
if($val.ChargeStartPercentage -ne $StartP)
{
 set-itemproperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartPercentage" -value $StartP
}

$val = Get-ItemProperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopPercentage"
if($val.ChargeStopPercentage -ne $StopP)
{
 set-itemproperty -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopPercentage" -value $StopP
}
