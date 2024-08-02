import bs4 as bs
import requests
import re
import json
import os
import time
import pandas as pd

allFormsPageURL = "https://www.uscis.gov/forms/all-forms?sort_bef_combine=sticky_ASC&ftopics_tid=0"
# regex to remove excess whitespace
whitespacePattern = re.compile(r"\s+")
# regex for determining if URL is a form, should all be of the form https://www.uscis.gov/x-y
# only 1 section after .gov/ and a - in the URL, must contain a number after the - as well
formURLPattern = re.compile(r"/[^/]+-\d+")
# if page contains class="btn btn--anchor" which has text "File Online" then it is online fileable
fileOnlinePattern = re.compile(r"File Online")
# (PDF,*KB)
formFilePattern = re.compile(r"\(PDF,(\d+)KB\)")
# form URLs are of the form /sites/default/files/document/forms/
formFileURLPattern = re.compile(r"/sites/default/files/document/forms/")
def getFormURLs():
    allFormURLS = []
    formFileURLPrefix = "https://www.uscis.gov"
    # Get all form URLs
    allFormsPage = requests.get(allFormsPageURL)
    allFormsPageSoup = bs.BeautifulSoup(allFormsPage.text, 'html.parser')
    for link in allFormsPageSoup.find_all('a'):
        url = link.get('href')
        print(url)
        if url and formURLPattern.match(url):
            print(url)
            allFormURLS.append(formFileURLPrefix+url)
    allFormURLS = set(allFormURLS)
    allFormURLS = sorted(list(allFormURLS))
    return allFormURLS

def checkIsOnlineFileable(formPageSoup: bs.BeautifulSoup):
    buttonElement = formPageSoup.find('a', class_='btn btn--anchor"')
    if not buttonElement:
        return False
    if fileOnlinePattern.match(buttonElement.text):
        return True
    return False

def downloadFormFilesAndSaveURLsAndReturnFilesMap(formPageSoup: bs.BeautifulSoup):
    formFilesURLs = []
    formFileURLPrefix = "https://www.uscis.gov"
    formFiles = formPageSoup.find_all('a',)
    formFiles = [file.get('href') for file in formFiles]
    formFiles = [file for file in formFiles if formFileURLPattern.match(file)]
    print(sorted(formFiles))
    print("*"*20)
    for file in formFiles:
        formFilesURLs.append(formFileURLPrefix + file)
    print(formFilesURLs)
    # create new directory to save files
    dirName = formFilesURLs[0]
    if dirName[-1] == '/':
        dirName = dirName[:-1]
    # get last part of URL
    dirName = dirName.split('/')[-1]
    # remove file extension
    dirName = dirName.rsplit('.', 1)[0]
    os.mkdir(dirName)
    os.chdir(dirName)
    filenameURLMap = {}
    formFilesURLs = set(sorted(formFilesURLs))
    # save each file to new dir
    for fileURL in formFilesURLs:
        # get file name
        fileName = fileURL.split('/')[-1]
        # download file
        file = requests.get(fileURL)
        # save file
        with open(fileName, 'wb') as f:
            f.write(file.content)
        filenameURLMap[fileName] = fileURL
    with open('formFilesURLs.txt', 'w') as f:
        for url in formFilesURLs:
            f.write(url + '\n')
    os.chdir('..')
    return filenameURLMap

def getFormLongDescription(formPageSoup: bs.BeautifulSoup):
    # get long description from class=content-section
    longDescription = formPageSoup.find('div', class_='content-section')
    # remove all non-p tags
    longDescription = longDescription.find_all('p')
    longDescription = [p for p in longDescription if not fileOnlinePattern.match(p.text)]
    longDescription = [p.text for p in longDescription]
    longDescription = ' '.join(longDescription)
    longDescription = whitespacePattern.sub(' ', longDescription)
    return longDescription


df = pd.DataFrame(columns=['Form Number', 'Form Title', 'Page URL', 'Fileable Online', 'Short Description',
                           'Long Description', 'File Name', 'File URL', 'Extra Files'])
failedURLs = []
URLs = getFormURLs()

for URL in URLs:
    try:
        soup = bs.BeautifulSoup(requests.get(URL).text, 'html.parser')
        # split class=page-title js-page-title by comma to get form number and form name
        formNumber, formTitle = soup.find('h1', class_='page-title js-page-title').text.split(',', maxsplit=1)
        formNumber = formNumber.strip()
        formTitle = formTitle.strip()
        isOnlineFileable = checkIsOnlineFileable(soup)
        filenamesURLs = downloadFormFilesAndSaveURLsAndReturnFilesMap(soup)
        # take the shortest filename as the main form file
        fileName, fileURL = min(filenamesURLs.items(), key=lambda x: len(x[0]))
        # pop main form file from filenamesURLs
        filenamesURLs.pop(fileName)
        longDescription = getFormLongDescription(soup)
        new_row = {'Form Number': formNumber, 'Form Title': formTitle, 'Page URL': URL, 
            'Fileable Online': isOnlineFileable, 'Short Description': None,
            'Long Description': longDescription, 'File Name': fileName,
            'File URL': fileURL, 'Extra Files': filenamesURLs}
        # Use the .loc method to add the new row
        df.loc[len(df)] = new_row
        time.sleep(1)
    except Exception as e:
        failedURLs.append(URL)
        print(f"Failed to scrape {URL}")
        continue
# writed failed URLs to file
with open('failedURLs.txt', 'w') as f:
    for url in failedURLs:
        f.write(url + '\n')
df.to_csv('forms.csv', index=False)