from bs4 import BeautifulSoup
import urllib2
import sys
#import lxml
sys.path.append("/Users/fcolombo/Documents/gilt");
from urlparse import urljoin

import defaultparser
import crawler

#import html5lib

class LuluCrawler:
	def getProductParser(self):
		def findBrand(soup):
			brandTag = soup.find('p', class_="brand")
			if brandTag is not None: 
				brand = brandTag.text 
				return brand 
			return "Lulus"

		def findPrice(soup):
			priceTag = soup.find('span', class_="sale")
			if priceTag is not None:
				price = priceTag.text
				return price

		def findProductName(soup):
			h = soup.find('h1', class_="product-title")
			if h is not None:
				name = h.text
				print name
				return crawler.removeSymbols(name)

		def findImageLink(soup):
			thumbnail = soup.find("img", class_="zoom_large")
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
			productCells = soup.find_all("div", class_= "description")
			for cell in productCells: 
				next = cell.find("h3")
				if next is not None: 
					end = next.find('a')
					if end is not None:
						url = end['href']
						urls.append(urljoin(base_url,url))
			print urls
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating Lulus Crawler"
		self.crawler = crawler.Crawler(["http://www.lulus.com/categories/page1-80/13/dresses.html"], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = LuluCrawler()
	crawler.crawl()

#main()