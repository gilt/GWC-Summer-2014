from bs4 import BeautifulSoup
import urllib2
import sys
#import lxml
sys.path.append("/Users/fcolombo/Documents/gilt");

import defaultparser
import crawler

#import html5lib

class NastyCrawler:
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
			productCells = soup.find_all("a", class_= "product-link")
			for cell in productCells: 
				url = cell['href']
				if url is not None: 
					print "Found product url", url
					urls.append(url)
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating NastyGal Crawler"
		self.crawler = crawler.Crawler(["http://www.nastygal.com/clothes-tops?viewAll=true"], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = NastyCrawler()
	crawler.crawl()

main()