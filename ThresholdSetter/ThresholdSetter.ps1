# Script to set battery thresholds for Lenovo Thinkpads running Windows 10
# Tested on a Thinkpad Yoga X1 2nd Gen 2017 - may or may not work for you.
# AS IS SOFTWARE- See documentation for details
#
# ----------------------------------------------------------------------------------------------------------------------------------

$BattSerial = "L4NJ78S03E2" #YOU MUST CHANGE THIS FOR YOUR SPECIFIC LAPTOP - see readme
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
