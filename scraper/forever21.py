from bs4 import BeautifulSoup
import urllib2
import sys
from urlparse import urljoin
#import lxml
sys.path.append("/Users/fcolombo/Documents/gilt");

import defaultparser
import crawler

#import html5lib

class ForeverCrawler:

	def getProductParser(self):
		def findBrand(soup):
			return "Forever21"

		def findPrice(soup):
			priceTag = soup.find('p', class_="product-price")
			if priceTag is not None:
				price = priceTag.text
				return price

		def findProductName(soup):
			h = soup.find('h1', class_="product-title")
			name = h.text
			print name
			return crawler.removeSymbols(name)

		def findImageLink(soup):
			thumbnail = soup.find("img", class_="ItemImage")
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
			productCells = soup.find_all("div", class_= "ItemImage")
			for cell in productCells: 
				a = cell.find('a')
				if a is not None:
					print "here"
					url = a['href']
					print "Found product url", url
					urls.append(urljoin(base_url,url))
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating Forever21 Crawler"
		self.crawler = crawler.Crawler(['http://www.forever21.com/Product/Category.aspx?br=f21&category=dress&pagesize=100&page=1'], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = ForeverCrawler()
	crawler.crawl()

#main()