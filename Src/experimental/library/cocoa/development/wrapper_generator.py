#!/usr/bin/python
from os import *
from string import Template
import string
import re
import urllib2
import sgmllib
import traceback, sys

# Features:
# - Automatically generates a Eiffel wrapper functions for each Objective-C message
#   -> Converts CamalCase to underscore_names
# - Type are mapped:
#   -> basic C types to the corresponding Eiffel (expanded) type
#   -> Automatically box/unbox pointers to Objective-C objects with references to an Eiffel wrapper object
# - Special treatment for handling C arguments which are passed by value in (NSRect, NSSize and NSPoint)
# - Fetch the documentation from Apple.com and extract feature documentation

# TODO:
# - Handling of objective C routine returning a struct was not properly handled.
# - If a .h contains the declaration of different classes/protocols then they are all packed for the same class which is not correct.
# - Recognize delegate methods and treat them accordingly
# - Refactor Signature to Message (containing the Objective-C abstractions and info) and Feature (eiffel equivelent)

### Config

basedir = "/System/Library/Frameworks"

"""
config = {
		  "framework": "ApplicationKit",
		  "dirname": basedir + "/AppKit.framework/Headers",
		  "class": "NSRunLoop",
		  "include": "Cocoa/NSRunLoop.h"
		  }
"""
config = {
		  "framework": "Foundation",
		  "dirname": basedir + "/Foundation.framework/Headers",
		  "class": "NSValue",
		  "include": "Foundation/NSValue.h"
		  }

headerpath = config["dirname"] + "/" + config["class"] + ".h"

# URL schema:
url = Template("http://developer.apple.com/mac/library/documentation/Cocoa/Reference/$framework/Classes/${class}_Class/Reference/Reference.html").\
        substitute (config)
#url = Template("http://developer.apple.com/mac/library/documentation/Cocoa/Reference/$framework/Classes/${class}_Class/Reference/$class.html").\
#        substitute (config)


###

class Type:
	name = "" # String representation
	
	def __init__(self, name):
		self.name = name
		
	def canDereference(self):
		return False
	
	def Dereference(self):
		return self

class CType(Type):
	def toEiffelType(self):
		return EiffelType(EiffelTypeN(self.name))

	def canDereference(self):
		if self.name.endswith("*"):
			return True
		else:
			return False
	
	def Dereference(self):
		if self.canDereference():
		   return CType(self.name[0:-1].strip())
		raise "Can't dereference type: " + type

class EiffelType(Type):
	def canDereference(self):
		if self.name.startswith("POINTER[") and self.name.endswith("]"):
			return True
		else:
			return False
	
	def Dereference(self):
		#require: canDereference()
		if self.canDereference():
		   return EiffelType(self.name[8:-1])
		raise "Can't dereference type: " + type
	
	def isExpanded(self):
		 return self.name in expandedTypes

# Represents a C or Eiffel argument to a method
class Argument:
	name = ""
	type = Type("")

	def __init__(self, name, type):
		self.name = name
		self.type = type

class CArgument(Argument):
	def to_eiffel_argument(self):
		eif_arg_name = EiffelName(self.name)
		if not eif_arg_name.startswith("a_"):
				eif_arg_name = "a_" + eif_arg_name
		return Argument(eif_arg_name, self.type.toEiffelType())

class Signature:
	def __init__(self, sig, is_static):
		self.method_name = []
		self.arguments = []
		self.is_static = is_static
		self.return_type = sig[0]
		i = 2
		while i < len(sig):
			self.arguments.append( CArgument(sig[i+1], CType(sig[i])) )
			i += 3
		self.method_name.append(sig[1])
		i = 4
		while i < len(sig):
			self.method_name.append(sig[i])
			i += 3
		
	def __str__(self):
		string = "(" + self.return_type + ")" + self.method_name[0]
		return string
		
	def isFunction(self):
		return (self.EiffelReturnType().name != "")
			
	def isStatic(self):
		"""True iff the signature has a + as first character."""
		return self.is_static

	def isConstructor(self):
		""""We treat a static message as constructor if it returns an object of it's containing class"""
		if self.is_static:
			t = CType(self.return_type)
			if t.canDereference():
				if t.Dereference().name == config["class"]:
					return True
		return False

	def EiffelArguments(self):
		e_sig = []
		for arg in self.arguments:
			e_sig.append (arg.to_eiffel_argument())
		return e_sig
		
	def EiffelReturnType(self):
		return EiffelType(EiffelTypeN(self.return_type))
	
	def FeatureName(self):
		name = ""
		for n in self.method_name:
			name += "_" + n
		return EiffelName(name[1:])

	def InternalFeatureName(self):
		return (self.FeatureName())
		
	def MessageName(self):
		string = self.method_name[0]
		if len(self.arguments) > 0:
			string += ":"
			i = 1
			while i < len(self.arguments):
				string += self.method_name[i] + ":"
				i = i + 1
		return string

	
	def EiffelFeature(self, abstract):
		def CallInternalFeature():
			args = []
			if not self.isStatic():
				args.append("item")
			for arg in self.EiffelArguments():
				if arg.type.canDereference():
					args.append(arg.name + ".item")
				else:
					if arg.type.isExpanded():
						args.append(arg.name)
					else: # A non expanded type that is passed by value
						args.append(arg.name + ".item")
			if self.isFunction() and (not self.EiffelReturnType().canDereference() and not self.EiffelReturnType().isExpanded()):
				# Special treatment for non expanded types that are passed by value as a return type
				args.append("Result.item")
			result = "{" + EiffelTypeN(config["class"]) + "_API}." + self.InternalFeatureName() + " (" + ', '.join(args) +  ")"

			if self.isFunction():
				if self.isConstructor():
					result = "make_from_pointer (" + result + ")"
				elif self.EiffelReturnType().canDereference():
					result = "create Result.share_from_pointer (" + result + ")"
				else:
					if self.EiffelReturnType().isExpanded():
						result = "Result := " + result
					else:
						result = "create Result.make\n\t\t\t" + result
					
			return result

		def Arguments():
			arguments = ""
			for arg in self.EiffelArguments():
				if arg.type.canDereference():
					arguments +=  arg.name + ": " + arg.type.Dereference().name + "; "
				else:
					arguments +=  arg.name + ": " + arg.type.name + "; "
			if arguments != "":
				arguments = " (" + arguments[0:-2] + ")"
			return arguments
		
		def Return():
			return_type = self.EiffelReturnType()
			if self.isConstructor():
				return ""
			elif return_type.name == "":
				return ""
			else:
				if return_type.canDereference():
					return ": " + return_type.Dereference().name
				else:
					return ": " + return_type.name
			
		return Template('''
	$name$args$ret
			-- $comment
		do
			$body
		end''').substitute(name = self.FeatureName(),
						   args = Arguments(),
						   ret  = Return(),
						   body = CallInternalFeature(),
						   comment = abstract)

	def InternalEiffelFeature(self):
		def CallCocoa():
			string = ""
			if self.isFunction():
				string += "return "
			if self.isStatic():
				string += "[" + config["class"] + " "
			else:
				string += "[(" + config["class"] + "*)" + "$a_" + EiffelName(config["class"]) + " "
			string += self.method_name[0]
			if len(self.arguments) > 0:
				arg = self.arguments[0]
				eiffelArg = self.EiffelArguments()[0]
				if eiffelArg.type.canDereference() or eiffelArg.type.isExpanded():
					string += ": " + "$" + eiffelArg.name
				else:
				    string += ": *(" + arg.type.name + "*)$" + eiffelArg.name
				i = 1
				while i < len(self.arguments):
					arg = self.arguments[i]
					eiffelArg = self.EiffelArguments()[i]
					if eiffelArg.type.canDereference() or eiffelArg.type.isExpanded():					   
						string += " " + self.method_name[i] + ": $" + eiffelArg.name
					else:
					    string += " " + self.method_name[i] + ": *(" + arg.type.name + "*)$" + eiffelArg.name
					i = i + 1
			string += "];"
			return string

		def InternalEiffelArguments():
			arguments = []
			if not self.isStatic():
				arguments.append ("a_" + EiffelName(config["class"]) + ": " + InternalEiffelTypeName(config["class"]))
			for i in range(len(self.arguments)):
				arguments.append (self.EiffelArguments()[i].name + ": " + InternalEiffelTypeName(self.arguments[i].type.name))
		
			ret = "; ".join(arguments)
			if len (arguments) > 0:
				return "(" + ret + ")"
			else:
				return ret

		def InternalEiffelReturn():
			if self.isFunction():
				return ": " + InternalEiffelTypeName(self.return_type)
			else:
				return ""
			
		def CocoaSignature():
			if self.isStatic():
				string = "+ "
			else:
				string = "- "
			string += "(" + self.return_type + ")"
			string += self.method_name[0]
			if len(self.arguments) > 0:
				string += ": (" + self.arguments[0].type.name + ") " + self.arguments[0].name
				i = 1
				while i < len(self.arguments):
					string += " " + self.method_name[i] + ": (" + self.arguments[i].type.name + ") " + self.arguments[i].name
					i = i + 1
			return string
	
		return Template('''
	frozen $name $args$ret
			-- $comment
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"$body"
		end''').substitute(name = self.InternalFeatureName(),
						   args = InternalEiffelArguments(),
						   ret  = InternalEiffelReturn(),
						   body = CallCocoa(),
						   comment = CocoaSignature())
	
typeMap = {
	"void": "",
	"char": "CHARACTER",
	"int": "INTEGER",
	"unsigned int": "NATURAL",
	"short": "INTEGER_16",
	"unsigned short": "NATURAL_16",
	"unsigned long long": "NATURAL_64",
	"long long": "INTEGER_64",
	"float": "REAL",
	"double": "REAL_64",
	"BOOL": "BOOLEAN",
	"id": "POINTER[NS_OBJECT]",
	"SEL": "POINTER[OBJC_SELECTOR]",
	"NSInteger": "INTEGER",
	"NSUInteger": "NATURAL",
	"IBAction": "",
	"CGFloat" : "REAL",
	"void *": "POINTER",
	"const void *": "POINTER",
	"void * /* WindowRef */": "WINDOW_REF",
	"id <NSCopying>": "NS_COPYING",
	"IconRef": "ICON_REF",
	"unsigned char": "NATURAL_8",
	"unichar": "NATURAL_16",
	"bitmapFormat": "BITMAP_FORMAT",
	"bytesPerRow": "BYTES_PER_ROW",
	"NSToolbarDisplayMode": "INTEGER",
	"NSToolbarSizeMode": "INTEGER",
	"NSGlyph": "INTEGER",
	"NSSplitViewDividerStyle": "INTEGER",
	"Class": "OBJC_CLASS",
	"NSTimeInterval": "REAL_64"
	}

enumMap = {
	"NSControlSize": "NSUInteger",
	"NSStringEncoding": "NSUInteger",
	"NSFontRenderingMode": "NSUInteger",
	"NSCellImagePosition": "NSUInteger",
	"NSBezelStyle": "NSUInteger",
	"NSButtonType": "NSUInteger",
	"NSGradientType": "NSUInteger",
	"NSImageScaling": "NSUInteger",
	"NSFontAction": "int",
	"NSFontTraitMask": "unsigned int",
	"NSCompositingOperation": "int",
	"NSBitmapFormat": "int",
	"NSImageLoadStatus": "int",
    "NSImageCacheMode": "int",
    "NSEventType": "int",
    "NSPointingDeviceType": "int",
	"NSWindowCollectionBehavior": "NSUInteger",
	"NSControlTint": "NSUInteger",
	"NSScrollerPart": "NSUInteger",
	"NSScrollerArrow": "NSUInteger",
	"NSScrollArrowPosition": "NSUInteger",
	"NSUsableScrollerParts": "NSUInteger"
}
	
expandedTypes = ["REAL", "REAL_64", "CHARACTER", "BOOLEAN", "INTEGER", "NATURAL", "NATURAL_64", "INTEGER_64", "NATURAL_16", "INTEGER_16"]

def EiffelTypeN(CTypeName):
	if CTypeName.endswith("*"):
		return "POINTER[" + EiffelTypeN(CTypeName[:-1].rstrip()) + "]"
	if CTypeName.startswith("const"):
		return EiffelTypeN(CTypeName[6:])
		
	if typeMap.has_key(CTypeName):
		return typeMap[CTypeName]
	else:
		if CTypeName[:2] in ["NS", "CG", "CA", "CI", "UI"]:
			return EiffelTypeName(CTypeName)
		else:
			raise "Type not found: " + CTypeName

def InternalEiffelTypeName(CTypeName):
	et = EiffelTypeN(CTypeName)
	if et in expandedTypes:
		return et
	else:
		return "POINTER"

def EiffelTypeName(name):
    return CamelCase2spaced_out(name).upper()
	
def EiffelName(name):
	return CamelCase2spaced_out(name).lower()

def CamelCase2spaced_out(stringAsCamelCase):
    """Converts a camel case string to a string separated by underscores.
    >>> CamelCase2spaced_out('TabViewItem')
    'Tab_View_Item'
    """
    
    if stringAsCamelCase is None:
        return None

    pattern = re.compile('([A-Z][A-Z][a-z])|([a-z][A-Z])')
    return pattern.sub(lambda m: m.group()[:1] + "_" + m.group()[1:], stringAsCamelCase)

def CNames2EiffelNames(name):
	i = 3
	while i < len(sig):
		sig[i] = EiffelName(sig[i])
		i += 3
	return sig


class Task:
	def __init__(self, name):
		self.name = name
		self.messages = []

	def __repr__(self):
		return "%s %r" % (self.name, self.messages)

class Feature:
	def __init__(self, name):
		self.name = name
		
	def getName(self):
		return self.name
	
	

class Message:
	def __init__(self, name):
		self.name = name
		self.abstract = ""
		self.signature = False

	def set_abstract(self, abstract):
		self.abstract = abstract.encode('utf8')

	def get_abstract(self):
		return self.abstract
	
	def get_eiffel_abstract(self):
		return self.abstract.replace("<code>", "`").replace("</code>", "'")
		
	def get_name(self):
		return self.name
	
	def set_signature(self, signature):
		# TODO: Get rid of this!
		self.signature = signature
	
	def get_signature(self):
		# TODO: Get rid of this!
		return self.signature

	def get_eiffel_wrapper_feature(self):
		if self.signature:
			return self.signature.EiffelFeature(self.get_eiffel_abstract())
		else:
			return "-- Error generating " + self.name + ": Message signature for feature not set"
	
	def get_eiffel_api_feature(self):
		if self.signature:
			return self.signature.InternalEiffelFeature()
		else:
			return "-- Error generating " + self.name + ": Message signature for feature not set"

	def is_constructor(self):
		return self.signature.isConstructor();
	
	def __repr__(self):
		return name

class AppleDocumentationParser(sgmllib.SGMLParser):
    "A simple parser class."

    def parse(self, s):
        "Parse the given string 's'."
        self.feed(s)
        self.close()
        no_messages = 0
        for task in self.tasks:
        	no_messages += len(task.messages)
        print "Parsing ended with " + str(len(self.tasks)) + " Tasks, " + str (no_messages) + " Messages"

    def __init__(self, verbose=0):
        "Initialise an object, passing 'verbose' to the superclass."

        sgmllib.SGMLParser.__init__(self, verbose)
        self.last_task = False
        self.last_message = False
        self.task_coming_up = False
        self.section = "Overview"
        self.tasks = []
        
    def start_h3 (self, attributes):
        for name, value in attributes:
            if name == "class" and value == "tasks":
                self.task_coming_up = True

    def start_a (self, attributes):
    	if self.section == "Tasks" and self.last_task:
	    	for name, value in attributes:
	    		if name == "href":
	    			if value.count(".html#//apple_ref/occ/instm/") or value.count(".html#//apple_ref/occ/clm/"):
	    				self.last_message = Message (re.search(".*/(.*)$", value).group(1))
    					self.last_task.messages.append (self.last_message) 
    
    def start_img (self, attributes):
    	if self.section == "Tasks" and self.last_message:
	    	for name, value in attributes:
	    		if name == "data-abstract":
    			     self.last_message.set_abstract(value)
    
    def handle_data (self, data):
        if self.task_coming_up == True:
          	self.last_task = Task (data)
          	self.tasks.append (self.last_task)
        if data in ["Tasks", "Class Methods", "Instance Methods"]:
        	self.section = data
            
    def end_h3(self):
        self.task_coming_up = False

    def get_tasks(self):
        "Return the list of Tasks."

        return self.tasks
       
    def print_tasks(self):
   		for task in self.tasks:
   			print task.name
		   	for message in task.messages:
				print "\t" + message.name

class ObjC_Class:
	def __init__(self, name):
		self.name = name
		
	def set_tasks(self, tasks):
		self.tasks = tasks
		
	def get_tasks(self):
		return self.tasks
       
	def get_message_by_name (self, name):
	   for task in self.tasks:
	   	   for message in task.messages:
	   	   	   if (name == message.get_name()):
	   	   	   	   return message
	   raise "Message " + name + " not found." 
       
# Tokens which end up in the message signature when parsing but we can't deal with
ignore_tokens = [
	"DEPRECATED_IN_MAC_OS_X_VERSION_10_4_AND_LATER",
	"DEPRECATED_IN_MAC_OS_X_VERSION_10_5_AND_LATER",
	"DEPRECATED_IN_MAC_OS_X_VERSION_10_6_AND_LATER",
	"AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER",
	"AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER",
	"__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)",
	""];

# Main:
def main():
	for (key, value) in enumMap.items():
		typeMap[key] = typeMap[value];
	
	my_class = ObjC_Class(config["class"])
	
	try:
		documentation = urllib2.urlopen(url).read().\
		   replace("\xe2\x80\x99", "`").replace("&#8217;", "`").\
		   replace("\xe2\x80\x94", "--").\
		   replace("\xe2\x80\x93", "-").\
		   replace("\xe2\x80\x9c", "\"").replace("\xe2\x80\x9d", "\"").\
		   replace("\x80", "\\0x80").\
		   replace("\x81", "\\0x81").\
		   replace("\x93", "\\0x93").\
		   replace("\x94", "\\0x94").\
		   replace("\x96", "\\0x96").\
		   replace("\x98", "989898").\
		   replace("\x99", "999999").\
		   replace("\x9c", "9C9C9C").\
		   replace("\x9d", "9D9D9D").\
		   replace("\x9f", "\\0x9F").\
		   replace("\xa0", "A0A0A0").\
		   replace("\xa4", "\\0xA4").\
		   replace("\xa6", "\\0xA6").\
		   replace("\xa8", "\\0xA8").\
		   replace("\xb1", "B1B1B1").\
		   replace("\xb4", "B4B4B4").\
		   replace("\xbc", "\\0xBC").\
		   replace("\xc2", "C2C2C2").\
		   replace("\xc3", "\\0xC3").\
		   replace("\xc4", "\\0xC4").\
		   replace("\xe2", "E2E2E2")
		for code in range(0x80, 0xFF):
		 	documentation = documentation.replace(chr(code), "\\0x" + str(code))
		documentation = documentation.decode("ascii")
		   # Some hacking to get rid of unicode chars
	except urllib2.HTTPError:
		print "URL: " + url
		traceback.print_exc (file=sys.stdout)
		
	myparser = AppleDocumentationParser()
	myparser.parse (documentation)
	my_class.set_tasks (myparser.get_tasks())


	
	internal_methods = []
	
	lines = file(headerpath).readlines()
	
	for line in lines:
		if line.find("//") != -1:
			line = line[:line.find("//")];
		line = line.replace("\t", " ");
		for (sign, signature) in re.findall(r"^([+-]) (.*);", line):
			tokens = []
			#print (sign, signature)
			for part in re.split(":", signature):
				for (type, name) in re.findall(r"\(([a-zA-Z0-9 \*]*)\)(.*)", part):
					tokens.append(type)
					if name.count(" ") >= 1:
						tokens.extend(re.split(" ", name))
					else:
						tokens.append(name)
			for t in ignore_tokens:
				while tokens.count(t) > 0:
					tokens.remove(t)
			try:
				isStatic = (sign == "+")
				sig = Signature (tokens, isStatic)
				if isStatic:
				    my_class.get_message_by_name (sig.MessageName()).set_signature (sig)
				else:
				    my_class.get_message_by_name (sig.MessageName()).set_signature (sig)
			except:
				print "Failed to generate code for " + "|".join(tokens)					
				traceback.print_exc (file=sys.stdout)
				print
	
	# Output:
	creation_procedures = []
	for task in my_class.get_tasks():
		for message in task.messages:
	   		try:
	   			if message.is_constructor():
	   				creation_procedures.append (message.get_signature().FeatureName());
	   	   	except:
	   	   		pass
	print "create"
	print "\t" + (",\n\t").join(creation_procedures)
	print "create {NS_OBJECT}"
	print "\tmake_from_pointer,"
	print "\tshare_from_pointer"
	print

	for task in my_class.get_tasks():
		print "feature -- " + task.name
		for message in task.messages:
	   		try:
	   	   	    print message.get_eiffel_wrapper_feature()
		   	except:
		   		print "Failed to generate code for " + "|".join(tokens)					
				traceback.print_exc (file=sys.stdout)
				print
		print ""
	   
	print "-- API --"
	for task in my_class.get_tasks():
	   print "feature -- " + task.name
	   for message in task.messages:
	   	   try:
	   	   	    print message.get_eiffel_api_feature()
		   except:
				print "Failed to generate code for " + "|".join(tokens)					
				traceback.print_exc (file=sys.stdout)
				print
	   print ""

main()
