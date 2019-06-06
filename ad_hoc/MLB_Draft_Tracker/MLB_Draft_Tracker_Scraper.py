import requests
import urllib
import csv
import os
import sys
import datetime
import codecs
import argparse
from collections import OrderedDict
from time import time, sleep


from py_data_getter import data_getter


getter = data_getter()

sleep_time = 1

base_url = 'https://statsapi.mlb.com/api/v1/draft/%s'


def initiate(year):
    start_time = time()

    process(year)

    end_time = time()
    elapsed_time = float(end_time - start_time)
    print '\n\nmlb_draft_tracker_scraper.py'
    print 'time elapsed (in seconds): ' + str(elapsed_time)
    print 'time elapsed (in minutes): ' + str(elapsed_time/60.0)


def process(year):
    url = base_url % year
    print(url)
    json = getter.get_url_data(url, 'json')
    prospect_lists = json['drafts']['rounds']
    scrape_prospects(year, prospect_lists)


def scrape_prospects(year, prospect_lists):

    csv_title = os.getcwd() + '/%s_MLB_Draft.csv' % (year)
    csv_file = open(csv_title, 'wb')
    append_csv = csv.writer(csv_file)
    csv_header = []

    csv_cols = OrderedDict()
    csv_cols['MlbID'] = ['person', 'id']
    csv_cols['PlayerFirst'] = ['person', 'firstName']
    csv_cols['PlayerLast'] = ['person', 'lastName']
    csv_cols['UseName'] = ['person', 'useName']
    csv_cols['MiddleName'] = ['person', 'middleName']
    csv_cols['BirthDate'] = ['person', 'birthDate']
    csv_cols['PrimaryPosition'] = ['person', 'primaryPosition', 'abbreviation']

    csv_cols['HomeCity'] = ['home', 'city']
    csv_cols['HomeState'] = ['home', 'state']
    csv_cols['HomeCountry'] = ['home', 'country']
    csv_cols['BirthCity'] = ['person', 'birthCity']
    csv_cols['BirthState'] = ['person', 'birthStateProvince']
    csv_cols['BirthCountry'] = ['person', 'birthCountry']

    csv_cols['SchoolName'] = ['school', 'name']
    csv_cols['SchoolClass'] = ['school', 'schoolClass']
    csv_cols['SchoolCountry'] = ['school', 'country']
    csv_cols['SchoolState'] = ['school', 'state']

    csv_cols['round'] = ['pickRound']
    csv_cols['pickRound'] = ['pickNumber']
    csv_cols['pickNumber'] = ['pickNumber']
    csv_cols['MlbRank'] = ['rank']
    csv_cols['PickValue'] = ['pickValue']
    csv_cols['SigningBonus'] = ['signingBonus']

    csv_cols['Height'] = ['person', 'height']
    csv_cols['Weight'] = ['person', 'weight']
    csv_cols['BatSide'] = ['person', 'batSide', 'code']
    csv_cols['PitchSide'] = ['person', 'pitchHand', 'code']

    csv_cols['DraftedTeam'] = ['team', 'name']
    csv_cols['MlbVideo'] = ['scoutingReport']
    csv_cols['MlbBlurb'] = ['blurb']

    for k, v in csv_cols.items():
        csv_header.append(k)
    append_csv.writerow(csv_header)

    for i, rnd in enumerate(prospect_lists):
        print i+1
        if i == 0:
            max_pick = 0
        else:
            max_pick = prospect_lists[i-1]['picks'][-1]['pickNumber']

        for plr in rnd['picks']:
            row = []
            entry = {}

            for key, path in csv_cols.items():
                plr_path = plr
                try:
                    for pth in path:
                        plr_path = plr_path[pth]

                    if key == 'pickRound':
                        v = plr_path - max_pick
                    elif key == 'Height':
                        v = int(plr_path.split("'")[0])*12 + int(plr_path.split("'")[1])
                    else:
                        v = plr_path
                except KeyError:
                    v = None


                if type(v) in (str, unicode):
                    v = "".join([l if ord(l) < 128 else "" for l in v])
                row.append(v)

            append_csv.writerow(row)
            # raw_input(row)

if __name__ == '__main__':     
    parser = argparse.ArgumentParser()
    parser.add_argument('--end_year',type=int,default=2019)

    args = parser.parse_args()
    
    initiate(args.end_year)

