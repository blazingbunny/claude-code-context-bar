#!/bin/bash
# Claude March 2026 Usage Promotion — Off-Peak Countdown Timer
# Peak hours: 8 AM–2 PM ET  |  Off-peak: everything else (2x usage)
# Promotion period: March 13–27, 2026

PROMO_START=20260313
PROMO_END=20260327

# Color theme — matches context-bar.sh
C_RESET='\033[0m'
C_GRAY='\033[38;5;245m'
C_BAR_EMPTY='\033[38;5;238m'
C_ACCENT='\033[38;5;74m'     # blue
C_GREEN='\033[38;5;71m'

trap 'tput cnorm 2>/dev/null; echo; exit 0' INT TERM
tput civis 2>/dev/null

render() {
    et_hour=$(( 10#$(TZ=America/New_York date +%H) ))
    et_min=$(( 10#$(TZ=America/New_York date +%M) ))

    local_time=$(date '+%H:%M %Z')
    et_time=$(TZ=America/New_York date '+%H:%M %Z')

    today=$(date +%Y%m%d)
    in_promo=false
    [[ "$today" -ge "$PROMO_START" && "$today" -le "$PROMO_END" ]] && in_promo=true

    if [[ $et_hour -ge 8 && $et_hour -lt 14 ]]; then
        status="PEAK"
        mins_until=$(( (14 - et_hour) * 60 - et_min ))
        if [[ $mins_until -ge 60 ]]; then
            countdown="$(( mins_until / 60 ))h $(( mins_until % 60 ))m"
        else
            countdown="${mins_until}m"
        fi
        label="2x in"
    else
        status="OFF-PEAK"
        if [[ $et_hour -lt 8 ]]; then
            mins_until=$(( (8 - et_hour) * 60 - et_min ))
        else
            mins_until=$(( (32 - et_hour) * 60 - et_min ))
        fi
        if [[ $mins_until -ge 60 ]]; then
            countdown="$(( mins_until / 60 ))h $(( mins_until % 60 ))m left"
        else
            countdown="${mins_until}m left"
        fi
        label="2x ON |"
    fi

    clear

    # Header row — same layout as context-bar.sh
    printf "${C_ACCENT}Claude Mar 2026 Promotion${C_GRAY} | 🕐 ${local_time} | ET ${et_time}${C_RESET}\n"
    printf "${C_BAR_EMPTY}─────────────────────────────────────────────${C_RESET}\n"

    if ! $in_promo; then
        printf "${C_GRAY}Status: inactive (outside Mar 13–27)${C_RESET}\n"
    elif [[ "$status" == "OFF-PEAK" ]]; then
        printf "${C_GREEN}🚀 ${label} ${countdown}${C_RESET}\n"
        printf "${C_GRAY}Peak resumes at 8 AM ET  |  Off-peak: 2 PM–8 AM ET${C_RESET}\n"
    else
        printf "${C_ACCENT}⏳ ${label} ${countdown}${C_RESET}\n"
        printf "${C_GRAY}Off-peak starts at 2 PM ET  |  Peak: 8 AM–2 PM ET${C_RESET}\n"
    fi

    printf "${C_BAR_EMPTY}─────────────────────────────────────────────${C_RESET}\n"
    printf "${C_GRAY}Updates every 15 min — Ctrl+C to exit${C_RESET}\n"
}

while true; do
    render
    sleep 900
done
