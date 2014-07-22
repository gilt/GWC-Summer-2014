#saks 
from bs4 import BeautifulSoup
import urllib2
import sys
from urlparse import urljoin
#import lxml
sys.path.append("/Users/fcolombo/Documents/gilt");

import defaultparser
import crawler

#import html5lib

class SaksCrawler:

	def getProductParser(self):
		def findBrand(soup):
			brandTag = soup.find('h1', class_="brand")
			if brandTag is not None:
				brand = brandTag.text
				return brand
			return ""

		def findPrice(soup):
			priceTag = soup.find('span', class_="product-price")
			if priceTag is not None:
				price = priceTag.text
				return crawler.removeSymbols(price)

		def findProductName(soup):
			h = soup.find('h2', class_="description")
			name = h.text
			print name
			return crawler.removeSymbols(name)

		def findImageLink(soup):
			t = soup.find("object", attrs={"type":"application/x-shockwave-flash"})
			thumbnail = t.find('img')
			if thumbnail is not None:
				image = thumbnail['src']
				if image is not None:
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
			productCells = soup.find_all("div", class_= "product-text")
			for cell in productCells: 
				a = cell.find('a')
				if a is not None:
					url = a['href']
					print "Found product url", url
					urls.append(url)
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating Saks Crawler"
		self.crawler = crawler.Crawler(['http://www.saksfifthavenue.com/Women-s-Apparel/Dresses/shop/_/N-52flor/Ne-6lvnb5'], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = SaksCrawler()
	crawler.crawl()

#main()