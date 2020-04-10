import os, requests, json
from bs4 import BeautifulSoup

url = 'https://geographyfieldwork.com/WorldCapitalCities.htm'

data = requests.get(url).content
soup = BeautifulSoup(data)


rows = soup.findAll("tr")

capitals = {}

for row in rows:
    # print(row.findNext().text)
    # print(row.findNext().findNextSibling().text)
    # print("--")
    if row.findNext().findNextSibling():
        capitals[row.findNext().text] = row.findNext().findNextSibling().text



country_capital = {}

with open("flags.json", "r") as in_file:
    flags = json.load(in_file)

    for flag in flags:
        if flag['country'] in capitals:
            country_capital[flag['country']] = capitals[flag['country']]
        else:
            country_capital[flag['country']] = "??"


with open("capitals.json", "w", encoding="utf-8") as out_file:
    json.dump(country_capital, out_file)


print(len(country_capital))

print("\n\n Capitals extraction completed !! \n")