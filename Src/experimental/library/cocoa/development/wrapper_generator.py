#!/usr/bin/python
from os import *
from string import Template
import string
import re

# Features:
# - Automatically generates a Eiffel wrapper functions for each Objective-C message
#   -> Converts CamalCase to underscore_names
# - Type are mapped:
#   -> basic C types to the corresponding Eiffel (expanded) type
#   -> Automatically box/unbox pointers to Objective-C objects with references to an Eiffel wrapper object
# - Special treatment for handling C arguments which are passed by value in (NSRect, NSSize and NSPoint)

# TODO:
# - Handling of objective C routine returning a struct was not properly handled.
# - If a .h contains the declaration of different classes/protocols then they are all packed for the same class which is not correct.


### Config

dirname = "/System/Library/Frameworks/AppKit.framework/Headers"
classname = "NSSavePanel"
#classname = "NSImage"
#dirname = "/System/Library/Frameworks/Foundation.framework/Headers"
#classname = "NSData"

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
		return self.is_static

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
		
	def EiffelFeature(self):
		def CallInternalFeature():
			args = ["item"]
			for arg in self.EiffelArguments():
				if arg.type.canDereference():
					args.append(arg.name + ".item")
				else:
					if arg.type in expandedTypes:
						args.append(arg.name)
					else: # A non expanded type that is passed by value
						args.append(arg.name + ".item")
			if self.isFunction() and (not self.EiffelReturnType().canDereference() and not self.EiffelReturnType().isExpanded()):
				# Special treatment for non expanded types that are passed by value as a return type
				args.append("Result.item")
			result = "{" + EiffelTypeN(classname) + "_API}." + self.InternalFeatureName() + " (" + ', '.join(args) +  ")"

			if self.isFunction():
				if self.EiffelReturnType().canDereference():
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
			if return_type.name == "":
				return ""
			else:
				if return_type.canDereference():
					return ": " + return_type.Dereference().name
				else:
					return ": " + return_type.name
			
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
			if self.isStatic():
				string += "[" + classname + " "
			else:
				string += "[(" + classname + "*)" + "$a_" + EiffelName(classname) + " "
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
				arguments.append ("a_" + EiffelName(classname) + ": " + InternalEiffelTypeName(classname))
			for i in range(len(self.arguments)):
				arguments.append (self.EiffelArguments()[i].name + ": " + InternalEiffelTypeName(self.arguments[i].type.name))
		
			ret = "; ".join(arguments)
			if len (arguments) > 0:
				return "(" + ret + ")"
			else:
				return ret

		def InternalEiffelReturn():
			if self.isFunction():
				return ""
			else:
				return ": " + InternalEiffelTypeName(self.return_type)
			
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
					string += " " + self.method_name[i] + ": (" + self.arguments[0].type.name + ") " + self.arguments[i].name
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
	"id <NSCopying>": "NS_COPYING",
	"IconRef": "ICON_REF",
	"unsigned char": "NATURAL_8",
	"bitmapFormat": "BITMAP_FORMAT",
	"bytesPerRow": "BYTES_PER_ROW"
	}
	
expandedTypes = ["REAL", "REAL_64", "CHARACTER", "BOOLEAN", "INTEGER"]

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


# Main:
def main():
	methods = []
	internal_methods = []
	
	lines = file(dirname + "/" + classname + ".h").readlines()
	
	for line in lines:
		if line.find("//") != -1:
			line = line[:line.find("//")];
		line = line.replace("\t", " ");
		for signature in re.findall(r"^- (.*);", line):
			tokens = []
			for part in re.split(":", signature):
				for (type, name) in re.findall(r"\(([a-zA-Z0-9 \*]*)\)(.*)", part):
					tokens.append(type)
					if name.count(" ") >= 1:
						tokens.extend(re.split(" ", name))
					else:
						tokens.append(name)
			while tokens.count("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER") > 0:
				tokens.remove("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER")
			while tokens.count ("__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)") > 0:
				tokens.remove("__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)")
			try:
				sig = Signature (tokens, False)
				methods.append(sig.EiffelFeature())
				internal_methods.append(sig.InternalEiffelFeature())
			except:
				print "Failed to generate code for " + "|".join(tokens)
	
	for line in lines:
		for signature in re.findall(r"^\+ (.*);", line):
			tokens = []
			for part in re.split(":", signature):
				for (type, name) in re.findall(r"\(([a-zA-Z0-9 \*]*)\)(.*)", part):
					tokens.append(type)
					if name.count(" ") >= 1:
						tokens.extend(re.split(" ", name))
					else:
						tokens.append(name)
			while tokens.count("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER") > 0:
				tokens.remove("AVAILABLE_MAC_OS_X_VERSION_10_5_AND_LATER")
			while tokens.count ("__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)") > 0:
				tokens.remove("__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0)")
			sig = Signature (tokens, True)
			print sig.InternalEiffelFeature()
			
	
	for c in methods:
		print c
	print
	print "feature {NONE} -- Objective-C implementation"
	for c in internal_methods:
		print c
		
main()
