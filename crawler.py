from bs4 import BeautifulSoup
import urllib2
import urllib
import json 

class ProductParser: 
	def _init_(self, findImageLink, findProductName, findBrand, findPrice, findDescription)
		self.findImageLInk = findImageLink
		self.findProductName = findProductName
		self.findBrand = findBrand
		self.findPrice =findPrice 
		self.findDescription = findDescription
		self.checkBrand = False


	def postProduct(self):
		if self.checkBrand: 
			print "Checking brand..."
			param = {"brand": self.brand};
			url = checkBrandUrl + '?' +urllib.urlencode(param);
			check = urllib2.urlopen(url);
			jsonresult = json.loads(check.read());
			if not jsonresult['result']:
				self.brand = {"name":self.brand}
				print "Brand not found"
			else:
				self.brand = jsonresult['result']['id'].encode('utf-8')
				print "Found brand", self.brand

		checkImage = {"imageKey": self.imageKey};
		url = checkImageUrl + '?' + urllib.urlencode(checkImage); 
		print "Checking for imageKey"
		check = urllib2.urlopen(url); 
		jsonresult = json.loads(check.read());
		if jsonresult['result']['exists']:
			print "Image key", self.imageKey, "already present in database"
			return

		product = {'s3image':False, 'image_key': self.image_key, 'name': self.product_name, 'brand': self.brand, 'purchase_url': self.purchase_url, 'price': self.price, 'category': self.category, 'description': self.description}
        productData = json.dumps({'products':[product]})
        print "Posting product with name", self.product_name
        req = urllib2.Request(product_post_url, productData, {'Content-Type': 'application/json'})
        f = urllib2.urlopen(req)
        f.read()
        f.close()
        
    def parse(self, soup, category, url):
        self.image_key = self.findImageLink(soup);
        self.product_name = self.findProductName(soup);
        self.brand = self.findBrand(soup);
        self.price = self.findPrice(soup);
        self.description = self.findDescription(soup);
        self.category = category;
        self.purchase_url = url;
        self.postProduct();
        
        
class Parser:
    def __init__(self, productParser, findProductURLs):
        self.findProductURLs = findProductURLs
        self.productParser = productParser
        
        
    def parse(self, soup, url, category):
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
            for url in urls:
                sock = urllib2.urlopen(url)
                try:
                    soup = BeautifulSoup(sock.read().decode('utf-8'), "lxml")
                    self.soupParser.parse(soup, url, category)
                except:
                    print "Skipping category url: ", url
                    continue

def main():
    def findProductURLs(soup): return ['http://www.google.com']
    def findImageLink(soup): return ''
    def findProductName(soup): return 'Test Product Name'
    def findBrandName(soup): return 'Test Brand Name'
    
    productParser = ProductParser(findImageLink, findProductName, findBrandName)
    parser = Parser(productParser, findProductURLs)
    
    crawler = Crawler(["http://www.google.com","http://www.aol.com"], parser)
    crawler.crawl()
    
def removeSymbols(string):
    string = string.strip(u'\u00ae')
    string = string.strip(u'\u2122')
    string = string.strip(u'\u00a9')
    return string
       

if __name__ == '__main__': main()