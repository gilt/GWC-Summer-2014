from bs4 import BeautifulSoup
import urllib2
import sys
#import lxml
sys.path.append("/Users/fcolombo/Documents/gilt");

import defaultparser
import crawler

#import html5lib

class LuluCrawler:
	def getProductParser(self):
		def findBrand(soup):
			return "Lulus"

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
			productCells = soup.find_all("div", class_= "description")
			for cell in productCells: 
				next = cell.find("h3")
				if next is not None: 
					end = next.find('a')
					if end is not None:
						url = end['href']
						print "Found product url", url
						urls.append(url)
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

main()