from bs4 import BeautifulSoup
import urllib2
import sys
#import lxml
sys.path.append("/Users/fcolombo/Documents/gilt");

import defaultparser
import crawler

#import html5lib

class KarmaCrawler:
	def getProductParser(self):
		def findBrand(soup):
			return ""

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
			productCells = soup.find_all("div", class_= "yui3-u-1-5 thumbnail  ")
			for cell in productCells: 
				next = cell.find('a')
				if next is not None:
					url = next['href']
					if url is not None: 
						print "Found product url", url
						urls.append(url)
			print urls
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating KarmaLoop Crawler"
		self.crawler = crawler.Crawler(["http://www.nastygal.com/clothes-tops?viewAll=true"], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = KarmaCrawler()
	crawler.crawl()

main()