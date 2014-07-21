#free people
from bs4 import BeautifulSoup
import urllib2
import sys
#import lxml

sys.path.append("/Users/fcolombo/Documents/gilt");

import defaultparser
import crawler

#import html5lib

class FpCrawler:
	def getProductParser(self):
		def findBrand(soup):
			return "Nasty Gal"

		def findPrice(soup):
			priceTag = soup.find('span', class_="current-price")
			if priceTag is not None:
				price = priceTag.text
				return price

		def findProductName(soup):
			h = soup.find('h1', class_="product-name")
			name = h.text
			print name
			return crawler.removeSymbols(name)

		def findImageLink(soup):
			thumbnail = soup.find("img", class_="category-item-thumb")
			if thumbnail is not None:
				image = thumbnail['src']
				return image
			return ""

		productParser = crawler.ProductParser(findImageLink, findProductName, findBrand, findPrice)
		productParser.findBrand = findBrand
		productParser.findPrice = findPrice
		productParser.findProductName = findProductName
		productParser.findImageLink = findImageLink
		return productParser

	def getParser(self):
		def findProductUrls(soup, base_url):
			urls = []
			productCells = soup.find_all("li", class_= "thumbnail--large thumbnail")
			for cell in productCells: 
				n = cell.find("a", attrs={"itemprop":"url"})
				if n is not None: 
					url = n['href']
					if url is not None:
						print "Found product url", url
						urls.append(url)
			print urls
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating FreePeople Crawler"
		self.crawler = crawler.Crawler(["http://www.freepeople.com/index.cfm/navigationitemid/6f354958-c557-4c8e-974b-a465d68af51b/fuseaction/products.browse/categoryid/3c77b415-a309-4742-bc3c-011f2c33ab60/hasleftnav/yes/startresult/1/showall/1/sizes/lt/"], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = FpCrawler()
	crawler.crawl()

main()