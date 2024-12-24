set Weeks;  # Hét számok
set Days;   # Napok
set Ambassadors; # Nagykövetek
set Leagues;  # Osztályok

param isMeetup{Weeks, Days} binary;  # Meetup van-e az adott napon
param attendance{Weeks, Days} >= 0, integer;  # Résztvevők száma
param isHoliday{Weeks, Days} binary;  # Ünnepnap-e az adott napon
param leagueThresholds{Leagues} >= 0, integer;  # Osztályhatárok (pl. Origin = 0-60 stb.)

# Döntési változók
var x{Ambassadors, Weeks, Days} binary;  # Nagykövet jelenléte az adott meetupon
var reward{Weeks, Days} binary;  # Rewardos meetup-e
var totalCheckin{Weeks, Days} >= 0, integer;  # Meetup összesített checkinje

# Osztályzáshoz intervallumok
var league{Leagues} binary;  # Melyik osztályban vagyunk

# Célfüggvény: Maximalizáljuk a rewardos meetupokon kiosztható pontokat
maximize TotalRewards:
    sum {w in Weeks, d in Days} reward[w, d] * attendance[w, d];

# Feltételek

# Minden meetupra legalább egy nagykövet kell
# s.t. MeetupHeld {w in Weeks, d in Days}:
#     sum {a in Ambassadors} x[a, w, d] >= isMeetup[w, d];

# Meetup akkor rewardos, ha legalább egy nagykövet megtartja (ez csak elméleti logikában fontos)
s.t. RewardCondition {w in Weeks, d in Days}:
    reward[w, d] <= sum {a in Ambassadors} x[a, w, d];

# Szilveszter csak piros betűs napokon és hétvégén ér rá
s.t. SzilveszterAvailability {w in Weeks, d in Days}:
    x["Szilveszter", w, d] <= isHoliday[w, d] + (if (d == "Saturday" or d == "Sunday") then 1 else 0);

# Medárd hétfőn nem ér rá
s.t. MedardNoMonday {w in Weeks}:
    x["Medard", w, "Monday"] = 0;

# Medárd hétvégén csak egy meetupon vehet részt
s.t. MedardWeekendLimit {w in Weeks}:
    x["Medard", w, "Saturday"] + x["Medard", w, "Sunday"] <= 1;

# Egy nagykövet hetente legalább 1, de legfeljebb 3 meetupot tart
s.t. AmbassadorLimit {a in Ambassadors, w in Weeks}:
    1 <= sum {d in Days} x[a, w, d] <= 3;

# Lure Party, ha van rewardos meetup, hogy növeljük a checkint
s.t. TotalCheckinCalculation {w in Weeks, d in Days}:
    totalCheckin[w, d] = 2 * attendance[w, d] - 3 * reward[w, d];

# Osztályhoz tartozás (összesített checkin alapján negyedéves értékelés)
s.t. LeagueClassificationOrigin:
    sum {w in Weeks, d in Days} totalCheckin[w, d] >= leagueThresholds["Origin"] * league["Origin"];

s.t. LeagueClassificationGreat:
    sum {w in Weeks, d in Days} totalCheckin[w, d] >= leagueThresholds["Great"] * league["Great"];

s.t. LeagueClassificationMaster:
    sum {w in Weeks, d in Days} totalCheckin[w, d] >= leagueThresholds["Master"] * league["Master"];

s.t. LeagueClassificationUltra:
    sum {w in Weeks, d in Days} totalCheckin[w, d] >= leagueThresholds["Ultra"] * league["Ultra"];

s.t. LeagueClassificationLegendary:
    sum {w in Weeks, d in Days} totalCheckin[w, d] >= leagueThresholds["Legendary"] * league["Legendary"];

# Egyszerre csak egy ligában lehetünk
s.t. SingleLeague:
    sum {l in Leagues} league[l] = 1;

# Kimenet nyomtatása
solve;

printf "Total Rewards: %g\n", TotalRewards;
printf "League: ";
for {l in Leagues: league[l] = 1} {
    printf "%s\n", l;
}

# Meetupról és részvételről jelentés
for {w in Weeks, d in Days: isMeetup[w, d] = 1} {
    printf "Week %d, %s: ", w, d;
    for {a in Ambassadors: x[a, w, d] = 1} {
        printf "%s ", a;
    }
    printf "\n";
}

end;
