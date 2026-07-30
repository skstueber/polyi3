#!/usr/bin/env bash

# helper: find hwmon path by name fragment
find_hwmon_by_name() {
  namefrag="$1"
  for hw in /sys/class/hwmon/hwmon*; do
    if [ -f "$hw/name" ]; then
      nm=$(cat "$hw/name")
      if [[ "$nm" == *"$namefrag"* ]]; then
        echo "$hw"
        return 0
      fi
    fi
  done
  return 1
}

# ---------------- CPU ----------------
cpu_hw=$(find_hwmon_by_name "k10temp" || true)
cpu_temp_raw=""
if [ -n "$cpu_hw" ]; then
  # prefer labeled 'Tctl' or any temp*_input
  for f in "$cpu_hw"/temp*_input; do
    [ -f "$f" ] || continue
    lbl="${f%_input}_label"
    if [ -f "$lbl" ]; then
      L=$(cat "$lbl")
      if [[ "$L" == *"Tctl"* || "$L" == *"Tdie"* ]]; then
        cpu_temp_raw=$(cat "$f")
        break
      fi
    else
      cpu_temp_raw=$(cat "$f"
      ); break
    fi
  done
fi

# fallback: try reading sensors output for Tctl
if [ -z "$cpu_temp_raw" ]; then
  cpu_temp=$(sensors 2>/dev/null | awk -F'[:+°]' '/k10temp-pci/{p=1} p && /Tctl/ {gsub(/ /,"",$2); print $2; exit}')
  if [ -n "$cpu_temp" ]; then
    cpu_temp_raw=$((cpu_temp * 1000))
  fi
fi

if [ -n "$cpu_temp_raw" ]; then
  cpu_temp=$(( (cpu_temp_raw + 500) / 1000 ))  # round
else
  cpu_temp=-1
fi

# ---------------- GPU (AMDGPU) ----------------
gpu_hw=$(find_hwmon_by_name "amdgpu" || true)
gpu_temp_raw=""
if [ -n "$gpu_hw" ]; then
  # prefer label 'edge' or 'junction'
  for f in "$gpu_hw"/temp*_input; do
    [ -f "$f" ] || continue
    lbl="${f%_input}_label"
    if [ -f "$lbl" ]; then
      L=$(cat "$lbl")
      if [[ "$L" == *"edge"* || "$L" == *"junction"* ]]; then
        gpu_temp_raw=$(cat "$f")
        break
      fi
    fi
  done
  # fallback to first temp*_input
  if [ -z "$gpu_temp_raw" ] && [ -f "$gpu_hw/temp1_input" ]; then
    gpu_temp_raw=$(cat "$gpu_hw/temp1_input")
  fi
fi

# fallback to sensors parse if still empty
if [ -z "$gpu_temp_raw" ]; then
  gpu_temp=$(sensors 2>/dev/null | awk -F'[:+°]' '/amdgpu-pci/{p=1} p && /edge/ {gsub(/ /,"",$2); print $2; exit}')
  if [ -n "$gpu_temp" ]; then
    gpu_temp_raw=$((gpu_temp * 1000))
  fi
fi

if [ -n "$gpu_temp_raw" ]; then
  gpu_temp=$(( (gpu_temp_raw + 500) / 1000 ))
else
  gpu_temp=-1
fi

# ---------------- color thresholds ----------------
# adjust thresholds to taste
cpu_color="%{F#00FF00}"   # green
if [ "$cpu_temp" -ge 80 ]; then cpu_color="%{F#ff0000}"
elif [ "$cpu_temp" -ge 70 ]; then cpu_color="%{F#FFE000}"; fi

gpu_color="%{F#00FF00}"
if [ "$gpu_temp" -ge 85 ]; then gpu_color="%{F#ff0000}"
elif [ "$gpu_temp" -ge 79 ]; then gpu_color="%{F#FFE000}"; fi

cpu_icon="󰻠"
gpu_icon="󱎓"

# build output
out=""
if [ "$cpu_temp" -ge 0 ]; then
  out+="${cpu_color}${cpu_icon} ${cpu_temp}°C%{F-}"
else
  out+="%{F#707880}${cpu_icon} N/A%{F-}"
fi

out+="  |  "

if [ "$gpu_temp" -ge 0 ]; then
  out+="${gpu_color}${gpu_icon} ${gpu_temp}°C%{F-}"
else
  out+="%{F#707880}${gpu_icon} N/A%{F-}"
fi

echo "$out"
EOF
