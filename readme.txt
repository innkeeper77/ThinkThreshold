# Script to set battery thresholds for Lenovo Thinkpads running Windows 10
# Tested on a Thinkpad Yoga X1 2nd Gen 2017 - may or may not work for you.
# This software comes with no guarantee. Use at your own risk, etc! MIT license - see license file. 
# -------------------------------------------------------------------------------------------------
# To use: You must set 3 variables below the dotted line in the script. (.ps1 file) 
# The script WILL NOT WORK AT ALL unless you enter your correct battery serial number!
#
# Please leave the quotation marks. They are required.
# 
# 1. Your unique battery serial number. 
# 	To find it, copy and pase the following command into windows powershell (run as admin)
# 	Get-ChildItem -Path hklm:software\Wow6432Node\Lenovo\PWRMGRV\ConfKeys\Data
# 	The serial number should be obvious: The key folder name on the left, that is a mix of letters and numbers. Eg: mine looks like L4NJ78S03E2
# 	Type your unique serial number into the BattSerial variableending up similar to: $BattSerial = "L4NJ78S03E2"
# 
# 2. Your threshold start percentage. When should the battery start charging, in a percentage? The script default is set to 85% ($StartP = "85")
# 3. Your threshold stop percentage. When should the battery STOP charging, in a percentage? The script default is set to 90%   ($StopP = "90")
#
# After you set these, if you run this script, the battery thresholds will be set. You likely have to reboot for them to take effect.
#
# To ensure the thresholds STAY set, you may need to run this script automatically using the task scheduler. Other laptops may not need this step.
# You only need to do this only if your laptop forgets the thresholds you set.
#
# 1. Save the script somewhere where it will not be deleted. I save mine in C:\Startup
# 2. Create a task in task scheduler.
# 	Open Task scheduler, Action>Create Task. Give it a name (Eg:ThresholdSetter)
#	Select "Run whether user is logged on or not", and "Run with the highest privileges".
# 	Under the Triggers tab, click "New" at the bottom and under "Begin the task", select "At workstation unlock"
#	Check the box for "Delay task for:" and set it to 1 minute (if desired). 
#	Under Actions, hit "New" at the bottom and set the action to "Start a program". 
#	Set the Program/script to Powershell.exe and under Add arguments, add the following: 
#	-ExecutionPolicy Bypass -WindowStyle Hidden C:\Startup\ThresholdSetter.ps1
#	Under Conditions, uncheck "Start this task only if the computer is on AC power".
# Under Settings, change "Stop this task if it runs longer than:" to 1 hour.
# If desired, set the task to repeat indefinately. I have mine reset the values every 30 minutes, and that seems to work well for my laptop
#
# 	Note: The task does not start the script directly. You are making a task to start powershell in the background, 
#	and then having powershell run the specific script.
#
# 	You now have to reboot to get the battery to accept the new thresholds. 
# 	Once you have set everything up, run the script manually (just this once) and reboot. 
# 	Your thresholds should now be set!
#
#
# Credits:
#	
# Copyright (c) 2017 innkeeper77 - MIT License - Feel free to use in your projects
#
# For instructions on using the Task Scheduler, Thanks u/thebigbug from reddit, on 
# https://www.reddit.com/r/Surface/comments/63orso/solution_for_undervolting_settings_not_sticking/ 
# Instructions there were used to write the instructions here.
# 
