# Script to set battery thresholds for Lenovo Thinkpads running Windows 10
# Tested on a Thinkpad Yoga X1 2nd Gen 2017 running the latest Lenovo Companion software- may or may not work for you.
# AS IS SOFTWARE- See documentation for details
#
# ----------------------------------------------------------------------------------------------------------------------------------
#
# Please submit a bug report on github if this script does not work, or stops working. Software updates can break it, and that is beyond my control. 

$BattSerial = "L4NJ78S03E2" #YOU MUST CHANGE THIS FOR YOUR SPECIFIC LAPTOP - Battery serial number as shown in Lenovo Companion battery info. If you have two batteries, you can run two copies of the script and set them differently as desired.
$StartP = "85" # Set this to the charge start percentage. The default 85 means charging starts if the battery is below 85% full
$StopP = "90" # Set this to the charge stop percentage. The default 90 means charging stops if the battery is at or above 90% full

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
