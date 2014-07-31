from bs4 import BeautifulSoup
import urllib2
import sys

sys.path.append("/Users/fcolombo/Documents/gilt");
import defaultparser
import crawler
from urlparse import urljoin

#import html5lib

class AeCrawler:
	def getProductParser(self):
		def findBrand(soup):
			brand = "American Eagle Outfitters";
			return crawler.removeSymbols(brand)
			

		def findPrice(soup):
			tag = soup.find('span', attrs={"itemprop":"price"})
			priceTag = tag.find(class_="dollars")
			if priceTag is not None:
				p = priceTag.text
				return p
			return ""

		def findProductName(soup):
			rightcol = soup.find('h1', attrs={"itemprop":"name"});
			if rightcol is not None:
				name = rightcol.text
				return crawler.removeSymbols(name)

		def findImageLink(soup):
			t = soup.find("div", attrs={"id":"imgHolder"})
			thumbnail = soup.find("img")
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
			productCells = soup.find_all("div", class_= "sProd")
			for cell in productCells: 
				a = cell.find('a')
				if a is not None:
					url = a['href']
					if url is not None: 
						print "Found product url", url
						urls.append(urljoin(base_url,url))
			return urls

		parser = crawler.Parser(self.getProductParser(), findProductUrls)
		return parser 

	def __init__(self): 
		print "Creating Aecrew Crawler"
		self.crawler = crawler.Crawler(['http://www.ae.com/web/browse/category.jsp?catId=cat1320034', 
                                         'http://www.ae.com/web/browse/category.jsp?catId=cat10051'], self.getParser())


	def crawl(self):
		self.crawler.crawl()

def main():
	crawler = AeCrawler()
	crawler.crawl()

#if __name__ == '__main__': main()
#main()