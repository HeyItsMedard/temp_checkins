import json
import random
from datetime import datetime

with open("meetups.json", "r", encoding="utf-8") as file:
    json_data = json.load(file)

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
ambassadors = ["Medard", "Szilveszter"]
leagues = ["Origin", "Great", "Ultra", "Master", "Legendary"]

# Ünnepnapok listája (októbertől kezdődően)
holidays = [
    "2024-10-23",  # Nemzeti ünnep
    "2024-11-01",  # Mindenszentek
    "2024-12-24",  # Szenteste
    "2024-12-25",  # Karácsony
    "2024-12-26",  # Karácsony másnapja
]

# Fix hetek 1-től 13-ig (október 1-től december 31-ig)
weeks = list(range(1, 14))

# Bináris tábla és részvételi számok inicializálása
bin_table = {week: {day: 0 for day in days} for week in weeks}
attendance_table = {week: {day: 0 for day in days} for week in weeks}
holiday_table = {week: {day: 0 for day in days} for week in weeks}


# JSON adatok feldolgozása
for event in json_data["events"]:
    date_obj = datetime.strptime(event["date"], "%Y-%m-%d")
    week_number = (date_obj - datetime(2024, 10, 1)).days // 7 + 1  # Hét szám 1-től 13-ig
    day_name = date_obj.strftime("%A")  # Nap neve (Monday, Tuesday stb.)

    if 1 <= week_number <= 13:
        # Bináris tábla frissítése
        bin_table[week_number][day_name] = 1

        # Részvétel számának meghatározása
        if day_name == "Monday":
            attendance = random.randint(3, 5)
        elif day_name == "Tuesday":
            attendance = random.randint(5, 7)
        elif day_name in ["Wednesday", "Thursday", "Friday"]:
            attendance = random.randint(7, 15)
        else:  # Szombat és vasárnap
            if "Gigantamax" in event["type"] or "Wild Area" in event["type"]:
                attendance = random.randint(20, 25)
            else:
                attendance = random.randint(15, 20)

        # Részvételi szám tábla frissítése
        attendance_table[week_number][day_name] = attendance
    
    # Ünnepnapok frissítése
    if event["date"] in holidays:
        holiday_table[week_number][day_name] = 1

# .dat fájl generálása
with open("meetup.dat", "w") as dat_file:
    dat_file.write("set Days := " + " ".join(days) + ";\n\n")
    dat_file.write("set Ambassadors :=  " + " ".join(ambassadors) + ";\n\n")
    dat_file.write("set Weeks := " + " ".join(map(str, weeks)) + ";\n\n")
    dat_file.write("set Leagues := " + " ".join(leagues) + ";\n\n")

    # Bináris változók paraméterként
    dat_file.write("param isMeetup :\n")
    dat_file.write(" " * 10 + " ".join(days) + " :=\n")
    for week in weeks:
        day_data = bin_table[week]
        dat_file.write(f"{week:10} " + " ".join(map(str, day_data.values())) + "\n")
    dat_file.write(";\n\n")

    # Részvételi számok paraméterként
    dat_file.write("param attendance :\n")
    dat_file.write(" " * 10 + " ".join(days) + " :=\n")
    for week in weeks:
        day_data = attendance_table[week]
        dat_file.write(f"{week:10} " + " ".join(map(str, day_data.values())) + "\n")
    dat_file.write(";\n")

    # Ünnepnapok bináris táblája
    dat_file.write("param isHoliday :\n")
    dat_file.write(" " * 10 + " ".join(days) + " :=\n")
    for week in weeks:
        day_data = holiday_table[week]
        dat_file.write(f"{week:10} " + " ".join(map(str, day_data.values())) + "\n")
    dat_file.write(";\n")

    # Ligák határainak hozzáadása
    dat_file.write("param leagueThresholds :=\n")
    dat_file.write("    Origin      60\n")
    dat_file.write("    Great       249\n")
    dat_file.write("    Ultra       749\n")
    dat_file.write("    Master      1499\n")
    dat_file.write("    Legendary   999999  # elérhetetlen nagy szám\n")
    dat_file.write(";\n")

print("meetup_schedule_with_attendance.dat fájl sikeresen generálva!")
