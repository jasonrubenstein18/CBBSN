import csv
from geopy.geocoders import Nominatim
import os
from time import sleep

read_file = os.getcwd()+'/Clients_Player_List-Schools.csv'

write_file = os.getcwd()+'/Clients_Player_List-Schools(2).csv'
csv_file = open(write_file, 'wb')
append_csv = csv.writer(csv_file)
# csv_header = ['SCHOOL','State','State (full)','Latitude','Longitude','SCHOOLKEY','SEASON','SCHOOLDIVISION','SCHOOLCONFERENCEABBR','Phils/Brewers List']
# append_csv.writerow(csv_header)

entries = []
with open(read_file, 'rb') as f:
    mycsv = csv.reader(f)

    flg_cnt = 0
    fnd_cnt = 0
    nfnd_cnt = 0
    for cnt, row in enumerate(mycsv):
        school_name, state_abbrev, state_full, latitude, longitude, schoolkey, season, schooldivision, schoolconferenceabbre, client_list, dummy = row
        print "\nSchool", str(cnt), school_name


        row = row[:-1]

        if school_name == 'SCHOOL':
            row.append('School_Address')
        
        if client_list.upper() == 'X':
            flg_cnt += 1
            print '\t\tFLAGGED (', str(flg_cnt), ')'

            if state_abbrev.upper() in ("BC", "AB", "SK", "MB", "ON", "QC", "NS", "NB", "NL", "PE", "YT", "NT", "NU"):
                school_country = "CAN"
            else:
                school_country = "USA"
            lookup_str = " (" + state_abbrev + ")"
            replace_str = ", " + state_abbrev + ", " + school_country
            school_name = "".join([j if ord(j) < 128 else "" for j in school_name])
            lookup_val = school_name.replace(replace_str, replace_str)

            geolocator = Nominatim(user_agent="school_locator")
            geolocator=Nominatim(timeout=10)

            timeout = True
            slp_cnt = 0
            while timeout is True:
                try:
                    school_location = geolocator.geocode(lookup_val)
                    timeout = False              
                except:
                    if slp_cnt <= 5:
                        sleep_mult = 1
                    else:
                        sleep_mult = 5
                    print 'TIMEOUT, minutes slept =', str(slp_cnt)
                    slp_cnt += 1*sleep_mult
                    sleep(60*sleep_mult)
                    timeout = True

            if school_location is not None:
                fnd_cnt += 1
                print '\t\t\tFOUND (', str(fnd_cnt), ')'
                school_add = school_location.address
                row[3] = school_location.latitude
                row[4] = school_location.longitude
            else:
                nfnd_cnt += 1
                print '\t\t\tNOT FOUND (', str(nfnd_cnt), ')'
                school_add = None

            row.append(school_add)
        else:
            row.append(None)

        for i, v in enumerate(row):
            print i, v
            if type(v) in (str, unicode):
                row[i] = "".join([j if ord(j) < 128 else "" for j in v])
            else:
                row[i] = v

        append_csv.writerow(row)
        sleep(0.1)