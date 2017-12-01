# Script to set battery thresholds for Lenovo Thinkpads running Windows 10
# Tested on a Thinkpad Yoga X1 2nd Gen 2017 - may or may not work for you.
# AS IS SOFTWARE- See documentation for details
#
# ----------------------------------------------------------------------------------------------------------------------------------
#
# This MAY NOT WORK unless you have the latest lenovo companion software installed. Future updates may also break the script. You have been warned. 
# Please submit a bug report on github if this script does not work, or stops working. Software updates can break it, and that is beyond my control. 

$BattSerial = "L4NJ78S03E2" #YOU MUST CHANGE THIS FOR YOUR SPECIFIC LAPTOP - Battery serial number as shown in Lenovo Companion battery info. If you have two batteries, you can run two copies of the script and set them differently as desired.
$StartP = "85"
$StopP = "90"

$val = Get-ItemProperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartControl"
if($val.ChargeStartControl -ne 1)
{
 set-itemproperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartControl" -value 1
}

$val = Get-ItemProperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopControl"
if($val.ChargeStopControl -ne 1)
{
 set-itemproperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopControl" -value 1
}

$val = Get-ItemProperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartPercentage"
if($val.ChargeStartPercentage -ne $StartP)
{
 set-itemproperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStartPercentage" -value $StartP
}

$val = Get-ItemProperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopPercentage"
if($val.ChargeStopPercentage -ne $StopP)
{
 set-itemproperty -Path hklm:software\WOW6432Node\Lenovo\PWRMGRV\ConfKeys\Data\$BattSerial -Name "ChargeStopPercentage" -value $StopP
}
