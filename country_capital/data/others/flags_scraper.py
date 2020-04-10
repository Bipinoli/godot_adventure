import os, requests, json
from bs4 import BeautifulSoup

url = 'https://www.worldometers.info/geography/flags-of-the-world/'
baseurl = 'https://www.worldometers.info'

data = requests.get(url)
soup = BeautifulSoup(data.content,)


flags = []

images = soup.findAll("img")
for div in images:
    if 'width' in div.attrs and div.attrs['width'] == '120':
        # print(div.attrs['src'])
        # print(div.findParent().findParent().findNext().findNextSibling().text)
        flags.append({'country': div.findParent().findParent().findNext().findNextSibling().text,
                      'flag': baseurl + div.attrs['src']})


with open("flags.json", "w", encoding="utf-8") as handler:
    json.dump(flags, handler)


for flag in flags:
    imageData = requests.get(flag['flag']).content
    with open(os.path.join('images', flag['country'] + '.gif'), 'wb') as handler:
        handler.write(imageData)

print("Flag images download complete !!")