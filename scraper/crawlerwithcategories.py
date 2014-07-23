from bs4 import BeautifulSoup
import urllib2
import urllib
import requests 
import json 
#import requests
#import mysql.connector
#import boto

from pymongo import MongoClient
client = MongoClient('mongodb://francesca:harrison@kahana.mongohq.com:10025/gilt')
db = client.gilt
products2 = db.products2
class ProductParser: 
	def __init__(self, findImageLink, findProductName, findBrand, findPrice):
		self.findImage = findImageLink
		self.findProductName = findProductName
		self.findBrand = findBrand
		self.findPrice =findPrice 
		#self.findDescription = findDescription
		#self.checkBrand = False


	def postProduct(self):
		db = client.gilt
		tests = db.tests
		newP = {'image': self.image, 'name': self.productName, 'brand': self.brand, 'purchaseUrl': self.purchaseUrl, 'price': self.price, 'category':self.category}
		print newP
		tests.insert(newP)
		
	def parse(self, soup, url):
		self.image = self.findImageLink(soup);
		self.productName = self.findProductName(soup);
		self.brand = self.findBrand(soup);
		self.price = self.findPrice(soup);
		self.category = category; 
		self.purchaseUrl = url;
		self.postProduct();
		
		
class Parser:
	def __init__(self, productParser, findProductURLs):
		self.findProductURLs = findProductURLs
		self.productParser = productParser
		
		
	def parse(self, soup, category, url):
		print "Parsing soup at url", url
		urls = self.findProductURLs(soup, url);
		for url in urls:
			sock = urllib2.urlopen(url)
			print "Parsing product url: ", url
			try:
				product_soup = BeautifulSoup(sock.read().decode('utf-8'), "lxml")
				self.productParser.parse(product_soup, category, url)
			except BaseException, e:
				print "Error:", str(e)
				print "Skipping product at url:", url
				continue
		
	

class Crawler:
	def __init__(self, entries, soupParser):
		self.entries = entries
		self.soupParser = soupParser

	def crawl(self):
		categories = self.entries.keys()
		for category in categories:
			urls = self.entries[category]
			for url in self.entries:

				sock = urllib2.urlopen(url)
			#try:
				soup = BeautifulSoup(sock, "html.parser")
				self.soupParser.parse(soup, url)
			#except:
				#print "Testing category url: ", url
				#try:
				#	sock = BeautifulSoup(requests.get(url).text)
				#	self.soupParser.parse(soup,url)
				#except:
				#	print "real deal error"
			#continue

				
	
def removeSymbols(string):
	string = string.strip(u'\u00ae')
	string = string.strip(u'\r\n\t\t\t\t\t\t\t\t\t\t')
	string = string.strip(u'\xa0\xa0\xa0\xa0\xa0')
	string = string.strip(u'\n            \n        ')
	string = string.strip(u'\u2122')
	string = string.strip(u'\u00a9')
	return string
	   
