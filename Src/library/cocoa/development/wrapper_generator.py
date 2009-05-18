#!/usr/bin/python
from os import *
from re import findall, split
from string import Template
import string

# Features:
# - Automatically generates a Eiffel wrapper function for each Objective-C function with type mappings for expanded types
#

# TODO:
# - Special treatment for handling C types passed by value in (NSRect, NSSize and NSPoint)
# - Automatically wrap return types (POINTER -> NS_ ...)
# - opt. NS_STRING <-> STRING / STRING_GENERAL auto conversion
# Use consistent function naming

### Config

dirname = "/System/Library/Frameworks/AppKit.framework/Headers"
classname = "NSTextField"
#dirname = "."
#classname = "NSArray"

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
		return EiffelType()

class EiffelType(Type):
	pass

# Represents a C or Eiffel argument to a method
class Argument:
	name = ""
	type = ""

	def __init__(self, name, type):
		self.name = name
		self.type = type

class CArgument(Argument):
	def to_eiffel_argument(self):
		eif_arg_name = EiffelName(self.name)
		if not eif_arg_name.startswith("a_"):
				eif_arg_name = "a_" + eif_arg_name
		return Argument(eif_arg_name, EiffelType(self.type))

class Signature:
	def __init__(self, sig):
		self.method_name = []
		self.arguments = []
		self.return_type = sig[0]
		i = 2
		while i < len(sig):
			self.arguments.append( CArgument(sig[i+1], sig[i]) )
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
		return (self.return_type != "void")
			
	def EiffelArguments(self):
		e_sig = []
		for arg in self.arguments:
			e_sig.append( arg.to_eiffel_argument() )
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
		def CallInternalFeature():
			args = ["cocoa_object"]
			for arg in self.EiffelArguments():
				if canDereference(arg.type):
					args.append(arg.name + ".cocoa_object")
				else:
					if arg.type in expandedTypes:
						args.append(arg.name)
					else: # A non expanded type that is passed by value
						args.append(arg.name + ".item")
			if self.isFunction() and (not canDereference(self.EiffelReturnType()) and not self.EiffelReturnType() in expandedTypes):
				# Special treatment for non expanded types that are passed by value as a return type
				args.append("Result.item")
			result = self.InternalFeatureName() + " (" + ', '.join(args) +  ")"

			if self.isFunction():
				if canDereference(self.EiffelReturnType()):
					result = "create Result.make_shared (" + result + ")"
				else:
					if self.EiffelReturnType() in expandedTypes:
						result = "Result := " + result
					else:
						result = "create Result.make\n\t\t\t" + result
					
			return result

		def Arguments():
			arguments = ""
			for arg in self.EiffelArguments():
				if canDereference(arg.type):
					arguments +=  arg.name + ": " + Dereference(arg.type) + "; "
				else:
					arguments +=  arg.name + ": " + arg.type + "; "
			if arguments != "":
				arguments = " (" + arguments[0:-2] + ")"
			return arguments
		
		def Return():
			if self.EiffelReturnType() == "":
				return ""
			else:
				if canDereference(self.EiffelReturnType()):
					return ": " + Dereference(self.EiffelReturnType())
				else:
					return ": " + self.EiffelReturnType()
			
		return Template('''
	$name$args$ret
		do
			$body
		end''').substitute(name = self.FeatureName(),
						   args = Arguments(),
						   ret  = Return(),
						   body = CallInternalFeature())

	def InternalEiffelFeature(self):
		def CallCocoa():
			string = ""
			if self.isFunction():
				string += "return "
			string += "[(" + classname + "*)" + "$a_" + EiffelName(classname) + " "
			string += self.method_name[0]
			if len(self.arguments) > 0:
				string += ": " + "$" + self.EiffelArguments()[0].name
				i = 1
				while i < len(self.arguments):
					string += " " + self.method_name[i] + ": $" + self.EiffelArguments()[i].name
					i = i + 1
			string += "];"
			return string

		def InternalEiffelArguments():
			arguments = "a_" + EiffelName(classname) + ": " + InternalEiffelType(classname) + "; "
			for i in range(len(self.arguments)):
				arguments +=  self.EiffelArguments()[i].name + ": " + InternalEiffelType(self.arguments[i].type) + "; "
		
			arguments = "(" + arguments[0:-2] + ")"
			return arguments

		def InternalEiffelReturn():
			if self.EiffelReturnType() == "":
				return ""
			else:
				return ": " + InternalEiffelType(self.return_type)
	
		return Template('''
	frozen $name $args$ret
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"$body"
		end''').substitute(name = self.InternalFeatureName(),
						   args = InternalEiffelArguments(),
						   ret  = InternalEiffelReturn(),
						   body = CallCocoa())
	
typeMap = {
	"void": "",
	"char": "CHARACTER",
	"int": "INTEGER",
	"float": "REAL",
	"double": "REAL_64",
	"BOOL": "BOOLEAN",
	"id": "NS_OBJECT",
	"SEL": "SELECTOR",
	"NSInteger": "INTEGER",
	"NSUInteger": "INTEGER",
	"IBAction": "",
	"CGFloat" : "REAL",
	"void * /* WindowRef */": "WINDOW_REF",
	"id <NSCopying>": "NS_COPYING"			
	}
	
expandedTypes = ["REAL", "REAL_64", "CHARACTER", "BOOLEAN", "INTEGER"]

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

def canDereference(type):
	if type.startswith("POINTER[") and type.endswith("]"):
		return True
	else:
		return False

def Dereference(type):
	#pre: canDereference(type)
	if canDereference(type):
	   return type[8:-1]
	raise "Can't dereference type: " + type

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


# Main:
def main():
	methods = []
	internal_methods = []
	
	lines = file(dirname + "/" + classname + ".h").readlines()
	
	for line in lines:
		if line.find("//") != -1:
			line = line[:line.find("//")];
		for signature in findall(r"^- (.*);", line):
			tokens = []
			for part in split(":", signature):
				for (type, name) in findall(r"\((.*)\)(.*)", part):
					tokens.append(type)
					if name.count(" ") >= 1:
						tokens.extend(split(" ", name))
					else:
						tokens.append(name)
			while tokens.count("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER") > 0:
				tokens.remove("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER")
			sig = Signature (tokens)
			methods.append(sig.EiffelFeature())
			internal_methods.append(sig.InternalEiffelFeature())
	
	for line in lines:
		for signature in findall(r"^\+ (.*);", line):
			print "--class method: " + signature
	
	for c in methods:
		print c
	print
	print "feature {NONE} -- Objective-C implementation"
	for c in internal_methods:
		print c
		
main()
