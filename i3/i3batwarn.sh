#! /bin/bash -x

SLEEP_TIME=5 # Default time between checks.
SAFE_PERCENT=30 # Still safe at this level.

ICON_FOLDER="/usr/share/notify-osd/icons/Humanity/scalable/status"

DANGER_HEADER="Battery is running low."
DANGER_MESSAGE="Connect your charger."
DANGER_PERCENT=15 # Warn when battery at this level.
DANGER_BATTERY_IMAGE="$ICON_FOLDER/notification-battery-020.svg"

CRITICAL_HEADER="Battery too low!"
CRITICAL_MESSAGE="Hibernating in 2 minutes."
CRITICAL_PERCENT=7 # Hibernate when battery at this level.
CRITICAL_BATTERY_IMAGE="$ICON_FOLDER/notification-battery-000.svg"

# set Battery
BATTERY=$(ls /sys/class/power_supply/ | grep '^BAT')

# set full path
ACPI_PATH="/sys/class/power_supply/$BATTERY"

export DISPLAY=:0.0

NOTIFY_PID=0

function notify {
  /usr/bin/notify-send "$1" "$2" -i "$3" -t $4 >/dev/null 2>&1 &
  NOTIFY_PID=$!
}

function kill_notify {
  if [ $NOTIFY_PID -gt 0 ]; then
    kill $NOTIFY_PID
    NOTIFY_PID=0
  fi
}

while [ true ]; do

  kill_notify

  # get battery status
  STAT=$(cat $ACPI_PATH/status)

  # get remaining energy value
  REM=`grep "POWER_SUPPLY_ENERGY_NOW" $ACPI_PATH/uevent | cut -d= -f2`

  # get full energy value
  FULL=`grep "POWER_SUPPLY_ENERGY_FULL_DESIGN" $ACPI_PATH/uevent | cut -d= -f2`

  # get current energy value in percent
  PERCENT=`echo $(( $REM * 100 / $FULL ))`

  if [ "$STAT" == "Discharging" ]; then
    pm-powersave true

    if [[ $PERCENT -gt $SAFE_PERCENT ]]; then
      SLEEP_TIME=10
    else
      SLEEP_TIME=5
      if [[ $PERCENT -le $DANGER_PERCENT ]]; then
        if [[ $PERCENT -le $CRITICAL_PERCENT ]]; then
          notify "$CRITICAL_HEADER" "$CRITICAL_MESSAGE" "$CRITICAL_BATTERY_IMAGE" 800
          SLEEP_TIME=1
          pm-hibernate
        else
          notify "$DANGER_HEADER"   "$DANGER_MESSAGE"   "$DANGER_BATTERY_IMAGE"   500
          SLEEP_TIME=2
        fi
      fi
    fi
  else
    pm-powersave false
    SLEEP_TIME=10
  fi

  sleep ${SLEEP_TIME}m

done
