#!/usr/bin/python
from os import *
from re import findall, split
import string

### Config

dirname = "/System/Library/Frameworks/AppKit.framework/Headers"
classname = "NSView"
#dirname = "."
#classname = "NSArray"

###

class Argument:
	name = ""
	type = ""

	def __init__(self, name, type):
		self.name = name
		self.type = type
	

class Signature:
	def __init__(self, sig):
		self.method_name = []
		self.arguments = []
		self.return_type = sig[0]
		i = 2
		while i < len(sig):
			self.arguments.append( Argument(sig[i+1], sig[i]) )
			i += 3
		self.method_name.append(sig[1])
		i = 4
		while i < len(sig):
			self.method_name.append(sig[i])
			i += 3
		
	def __str__(self):
		string = "(" + self.return_type + ")" + self.method_name[0]
		return string
		
	def is_function(self):
		return (self.return_type != "void")
		
	def EiffelArguments(self):
		e_sig = []
		for arg in self.arguments:
			e_sig.append( Argument(EiffelName(arg.name), EiffelType(arg.type)))
		return e_sig
		
	def EiffelReturnType(self):
		return EiffelType(self.return_type)
	
	def FeatureName(self):
		name = ""
		for n in self.method_name:
			name += "_" + n
		return EiffelName(name[1:])

	def InternalFeatureName(self):
		return (EiffelName(classname) + "_" + self.FeatureName())
		
	def EiffelFeature(self):
		return '''
	''' + self.FeatureName() + EiffelArguments(self) + EiffelReturn(self) + '''
		do
			''' + InternalCall(self) + '''
		end'''

	def InternalEiffelFeature(self):
		return '''
	frozen ''' + sig.InternalFeatureName() + ' ' + InternalEiffelArguments(sig) + InternalEiffelReturn(sig) + '''
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"''' + CocoaCall(sig) + '''"
		end'''
	
typeMap = {
	"void": "",
	"char": "CHARACTER",
	"BOOL": "BOOLEAN",
	"id": "NS_OBJECT",
	"SEL": "SELECTOR",
	"NSInteger": "INTEGER",
	"IBAction": "",
	"CGFloat" : "REAL",
	"void * /* WindowRef */": "WINDOW_REF"
	}
	
expandedTypes = ["REAL", "BOOLEAN", "INTEGER"]

# TODO:
# - Special treatment for handling C types passed by value in (NSRect, NSSize and NSPoint)
# - Automatically wrap return types (POINTER -> NS_ ...)
# - opt. NS_STRING <-> STRING / STRING_GENERAL auto conversion

def EiffelType(type):
	if type.endswith("*"):
		return "POINTER[" + EiffelType(type[:-1].rstrip()) + "]"
	if type.startswith("const"):
		return EiffelType(type[6:])
		
	if type[:2] in ["NS", "CG", "CA", "CI"]:
		if typeMap.has_key(type):
			return typeMap[type]
		else:
			return type[:2] + EiffelTypeName(type[2:])
	else:
		return typeMap[type]

def InternalEiffelType(type):
	et = EiffelType(type)
	if et in expandedTypes:
		return et
	else:
		return "POINTER"

def EiffelTypeName(name):
	for c in string.ascii_uppercase:
		name = name.replace(c, "_" + c.lower())
	for c in string.ascii_uppercase:
		name = name.replace(c.lower(), c)
	return name
	
def EiffelName(name):
	for c in string.ascii_uppercase:
		name = name.replace("NS" + c, c.lower())
	for c in string.ascii_uppercase:
		name = name.replace(c, "_" + c.lower())
	return name

def CNames2EiffelNames(name):
	i = 3
	while i < len(sig):
		sig[i] = EiffelName(sig[i])
		i += 3
	return sig


def EiffelArguments(sig):
	arguments = ""
	for arg in sig.EiffelArguments():
		arguments +=  "a_" + arg.name + ": " + arg.type + "; "
	if arguments != "":
		arguments = " (" + arguments[0:-2] + ")"
	return arguments

def InternalEiffelArguments(sig):
	arguments = "a_" + EiffelName(classname) + ": " + InternalEiffelType(classname) + "; "
	for arg in sig.arguments:
		arguments +=  "a_" + EiffelName(arg.name) + ": " + InternalEiffelType(arg.type) + "; "

	arguments = "(" + arguments[0:-2] + ")"
	return arguments

def EiffelReturn(sig):
	if sig.EiffelReturnType() == "":
		return ""
	else:
		return ": " + EiffelType(sig.return_type)

def InternalEiffelReturn(sig):
	if sig.EiffelReturnType() == "":
		return ""
	else:
		return ": " + InternalEiffelType(sig.return_type)

def CocoaCall(sig):
	string = ""
	if sig.is_function():
		string += "return "
	string += "[(" + classname + "*)" + "$a_" + EiffelName(classname) + " "
	string += sig.method_name[0]
	if len(sig.arguments) > 0:
		string += ": " + "$a_" + EiffelName(sig.arguments[0].name)
		i = 1
		while i < len(sig.arguments):
			string += " " + sig.method_name[i] + ": $a_" + sig.EiffelArguments()[i].name
			i = i + 1
	string += "];"
	return string

def InternalCall(sig):
	string = ""
	if sig.is_function():
		string += "Result := "
	string += sig.InternalFeatureName() + " (cocoa_object, "
	for arg in sig.EiffelArguments():
		string += "a_" + arg.name
		if arg.type.startswith("NS_"):
			string += ".cocoa_object"
		string += ", "
	string = string[0:-2] + ")"
	return string

def createWrapper(sig):
	sig = Signature (sig)
	methods.append(sig.EiffelFeature())
	internal_methods.append(sig.InternalEiffelFeature())


# Main:
methods = []
internal_methods = []

f = file(dirname + "/" + classname + ".h")
lines = f.readlines()

for line in lines:
	for signature in findall(r"^- (.*);", line):
		sig = []
		for part in split(":", signature):
			for (type, name) in findall(r"\((.*)\)(.*)", part):
				sig.append(type)
				if name.count(" ") >= 1:
					sig.extend(split(" ", name))
				else:
					sig.append(name)
		createWrapper(sig)

for line in lines:
	for signature in findall(r"^\+ (.*);", line):
		print signature

for c in methods:
	print c
print
print "feature {NONE} -- Objective-C implementation"
for c in internal_methods:
	print c
