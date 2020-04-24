import os, json, base64, re

# for l in os.listdir():
#     if l != 'merger.py':
#         name = l.split('.')[0].split('country-by-')[1]
#         name = re.sub('-', '_', name)
#         print(name, "= '" + l + "'")

country_name = 'country-by-name.json'
capital_city = 'country-by-capital-city.json'
continent = 'country-by-continent.json'
currency_code = 'country-by-currency-code.json'
region_in_world = 'country-by-region-in-world.json'
life_expectancy = 'country-by-life-expectancy.json'
currency_name = 'country-by-currency-name.json'
calling_code = 'country-by-calling-code.json'
flag = 'country-by-flag.json'
languages = 'country-by-languages.json'
national_dish = 'country-by-national-dish.json'
elevation = 'country-by-elevation.json'
surface_area = 'country-by-surface-area.json'
government_type = 'country-by-government-type.json'
domain_tld = 'country-by-domain-tld.json'
landlocked = 'country-by-landlocked.json'
yearly_average_temperature = 'country-by-yearly-average-temperature.json'




countries = {}
flag_info = {}




''' country names '''

with open(country_name, 'r') as in_file:
    nations = json.load(in_file)
    for nation in nations:
        if nation['country'] not in countries:
            countries[nation['country']] = {}
    print("\n", "-"*35)
    print("\t\t Total {} country names found !!".format(len(countries)))




''' decode base64 encoded svg images of flags '''


with open(flag, 'r') as in_file:
    flags = json.load(in_file)
    # print(flags)
    for flag in flags:
        if flag['country'] not in flag_info:
            if not flag['flag_base64']:
                continue

            flag_name = flag['country']
            flag_name = re.sub(' ', '_', flag_name) + '.svg'
            flag_info[flag['country']] = { 'flag': flag_name }
            encoded_svg = flag['flag_base64'].split('base64,')[1]
            
            if len(encoded_svg) % 4 != 0 and encoded_svg[-1:] != '=':
                encoded_svg = encoded_svg[:-(len(encoded_svg)%4)]

            flag_svg = base64.b64decode(encoded_svg)
            # with open(os.path.join('flags', flag_name), 'wb') as out_file:
            #     out_file.write(flag_svg)
                

    print("\n", "-"*35)
    print("\t\t Total {} flags found !!".format(len(flag_info)))





''' incorporate flag data '''

not_country = []
for country in flag_info:
    if country not in countries:
        not_country.append(country)
        continue
    countries[country]['flag'] = flag_info[country]['flag']

print("\n", "-"*35)
print("\t\t found flag errors: ", not_country)




def incorporateDataValue(json_file_path, key_name):
    print("\n", "-"*35)
    not_country = []
    with open(json_file_path, 'r') as in_file:
        data = json.load(in_file)
        print(data[0])
        for c in data:
            if c['country'] not in countries:
                not_country.append(c['country'])
                continue
            countries[c['country']][key_name] = c[key_name]

    print("\t\t found {} errors: ".format(json_file_path), not_country)


def incorporateDataList(json_file_path, key_name):
    print("\n", "-"*35)
    not_country = []
    with open(json_file_path, 'r') as in_file:
        data = json.load(in_file)
        print(data[0])
        for c in data:
            if c['country'] not in countries:
                not_country.append(c['country'])
                continue 
            if key_name not in countries[c['country']]:
                countries[c['country']][key_name] = []
            countries[c['country']][key_name].append(c[key_name])

    print("\t\t found {} errors: ".format(json_file_path), not_country)



def handleErrorValue(actual_country_name, country_name, json_file_path, key):
    with open(json_file_path, 'r') as in_file:
        data = json.load(in_file)
        for d in data:
            if d['country'] != country_name:
                continue
            countries[actual_country_name][key] = d[key]
        print("\n\t\t Handled error ", countries[actual_country_name])


def handleErrorList(actual_country_name, country_name, json_file_path, key):
    with open(json_file_path, 'r') as in_file:
        data = json.load(in_file)
        for d in data:
            if d['country'] != country_name:
                continue
            if key not in countries[actual_country_name]:
                countries[actual_country_name][key] = []
            countries[actual_country_name][key].append(d[key])
        print("\n\t\t Handled error ", countries[actual_country_name])


''' incorporate capital data '''
incorporateDataValue(capital_city, 'city')

''' incorporate continent data '''
incorporateDataValue(continent, 'continent')
handleErrorValue('SriLanka', 'Sri Lanka', continent, 'continent')

''' incorporate currency_code data '''
incorporateDataValue(currency_code, 'currency_code')

''' incorporate region_in_world data '''
incorporateDataValue(region_in_world, 'location')

''' incorporate life_expectancy data '''
incorporateDataValue(life_expectancy, 'expectancy')

''' incorporate currency_name data '''
incorporateDataValue(currency_name, 'currency_name')

''' incorporate calling_code data '''
incorporateDataValue(calling_code, 'calling_code')

''' incorporate languages data '''
incorporateDataList(languages, 'language')
handleErrorList('SriLanka', 'Sri Lanka', languages, 'language')
handleErrorList('Congo', 'Congo, The Democratic Republic of the', languages, 'language')
handleErrorList('The Democratic Republic of Congo', 'Congo, The Democratic Republic of the', languages, 'language')
handleErrorList('North Macedonia', 'Macedonia', languages, 'language')
handleErrorList('North Macedonia', 'Taiwan', languages, 'language')


''' incorporate national_dish data '''
incorporateDataValue(national_dish, 'dish')

''' incorporate elevation data '''
incorporateDataValue(elevation, 'elevation')

''' incorporate surface_area data '''
incorporateDataValue(surface_area, 'area')
handleErrorValue("Congo", 'The Democratic Republic of the Congo', surface_area, 'area')
handleErrorValue("Micronesia, Federated States of", 'Federated States of Micronesia', surface_area, 'area')
handleErrorValue("SriLanka", 'Sri Lanka', surface_area, 'area')
handleErrorValue("Virgin Islands, British", 'British Virgin Islands', surface_area, 'area')
handleErrorValue("Virgin Islands, U.S.", 'U.S. Virgin Islands', surface_area, 'area')

''' incorporate government_type data '''
incorporateDataValue(government_type, 'government')

''' incorporate domain_tld data '''
incorporateDataValue(domain_tld, 'tld')

''' incorporate landlocked data '''
incorporateDataValue(landlocked, 'landlocked')

''' incorporate yearly_average_temperature data '''
incorporateDataValue(yearly_average_temperature, 'temperature')





''' store the incorporated data '''
with open("countries.json", "w") as out_file:
    json.dump(countries, out_file)

print("\n\n Countries information stored as countries.json file !!")