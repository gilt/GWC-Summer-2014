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

class ShopBopCrawler:

	def getProductParser(self):
		def findBrand(soup):
			brandTag = soup.find('a', attrs={"itemprop":"brand"})
			if brandTag is not None:
				brand = brandTag.text
				return crawler.removeSymbols(brand)
			return ""

		def findPrice(soup):
			priceTag = soup.find('div', class_="priceBlock")
			if priceTag is not None:
				price = priceTag.text
				return crawler.removeSymbols(price)

		def findProductName(soup):
			h = soup.find('span', attrs={"itemprop":"name"})
			name = h.text
			print name
			return crawler.removeSymbols(name)

		def findImageLink(soup):
			thumbnail = soup.find("img", attrs={"itemprop":"image"})
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
			productCells = soup.find_all("div", attrs={"data-at":"productContainer"})
			for cell in productCells: 
				a = cell.find('a')
				if a is not None:
					url = a['href']
					print "Found product url", url
					urls.append(urljoin(base_url,url))
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating ShopBop Crawler"
		self.crawler = crawler.Crawler({ "dresses": ['http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=0',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=100',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=200',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=300',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=400',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=500',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=600',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=700',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=800',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=900',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1000',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1100',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1200',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1300',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1400',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1500',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1600',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1700',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1800',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=1900',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2000',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2100',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2200',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2300',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2400',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2500',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2600',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2700',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2800',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=2900',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=3000',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=3100',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=3200',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=3300',
			'http://www.shopbop.com/clothing-dresses/br/v=1/2534374302063518.htm?baseIndex=3400'],
			"tops":
			['http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm'
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=100',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=200',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=300',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=400',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=500',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=600',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=700',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=800',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=900',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1000',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1100',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1200',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1300',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1400',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1500',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1600',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1700',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1800',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=1900',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2000',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2100',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2200',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2300',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2400',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2500',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2600',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2700',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2800',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=2900',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=3000',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=3100',
			'http://www.shopbop.com/clothing-tops/br/v=1/2534374302060562.htm?baseIndex=3200'],
			"skirts":
			['http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=100',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=200',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=300',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=400',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=500',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=600',
			'http://www.shopbop.com/clothing-skirts/br/v=1/2534374302024619.htm?baseIndex=700'],
			"shorts":
			['http://www.shopbop.com/clothing-shorts/br/v=1/2534374302024684.htm',
			'http://www.shopbop.com/clothing-shorts/br/v=1/2534374302024684.htm?baseIndex=100',
			'http://www.shopbop.com/clothing-shorts/br/v=1/2534374302024684.htm?baseIndex=200',
			'http://www.shopbop.com/clothing-shorts/br/v=1/2534374302024684.htm?baseIndex=300',
			'http://www.shopbop.com/clothing-shorts/br/v=1/2534374302024684.htm?baseIndex=400',
			'http://www.shopbop.com/clothing-shorts/br/v=1/2534374302024684.htm?baseIndex=500',			
			]}, self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = ShopBopCrawler()
	crawler.crawl()

main()