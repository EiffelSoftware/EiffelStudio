indexing
	description: "Constants for use by the code formatter."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_FORMATTER_CONSTANTS

feature -- Access

	keywords: ARRAYED_LIST [STRING] is
			-- Keywords
		once
			create Result.make (58)
			Result.compare_objects
			Result.extend ("alias")
			Result.extend ("all")
			Result.extend ("and")			
			Result.extend ("Precursor")
			Result.extend ("agent")
			Result.extend ("as")
			Result.extend ("check")
			Result.extend ("class")
			Result.extend ("create")
			Result.extend ("debug")
			Result.extend ("deferred")
			Result.extend ("do")			
			Result.extend ("else")
			Result.extend ("elseif")
			Result.extend ("end")
			Result.extend ("ensure")
			Result.extend ("expanded")
			Result.extend ("export")
			Result.extend ("external")			
			Result.extend ("false")
			Result.extend ("feature")
			Result.extend ("from")
			Result.extend ("frozen")
			Result.extend ("if")
			Result.extend ("implies")
			Result.extend ("indexing")			
			Result.extend ("infix")
			Result.extend ("inherit")
			Result.extend ("inspect")
			Result.extend ("invariant")
			Result.extend ("is")
			Result.extend ("like")
			Result.extend ("local")			
			Result.extend ("loop")
			Result.extend ("not")
			Result.extend ("obsolete")
			Result.extend ("old")
			Result.extend ("once")
			Result.extend ("or")
			Result.extend ("prefix")			
			Result.extend ("redefine")
			Result.extend ("rename")
			Result.extend ("require")
			Result.extend ("rescue")
			Result.extend ("result")
			Result.extend ("retry")
			Result.extend ("select")			
			Result.extend ("separate")
			Result.extend ("strip")
			Result.extend ("then")
			Result.extend ("true")
			Result.extend ("undefine")
			Result.extend ("unique")
			Result.extend ("until")			
			Result.extend ("variant")
			Result.extend ("when")
			Result.extend ("xor")
		end		
	
	symbols: ARRAYED_LIST [STRING] is
			-- Symbols
		once
			create Result.make (19)
			Result.compare_objects
			Result.extend ("=")
			Result.extend ("&lt;")
			Result.extend ("&gt;")
			Result.extend (":")
			Result.extend ("<<")
			Result.extend (">>")
			Result.extend ("!!")
			Result.extend ("/=")			
			Result.extend (":=")
			Result.extend ("?=")
			Result.extend ("->")
			Result.extend ("(")
			Result.extend (")")
			Result.extend ("[")
			Result.extend ("]")
			Result.extend ("{")
			Result.extend ("}")
			Result.extend ("'")
			Result.extend ("+")
			Result.extend ("$")
			Result.extend ("%%")
		end
	
	format_tags: HASH_TABLE [STRING, STRING] is
			-- Code format tags
		once
			create Result.make (11)
			Result.compare_objects
			Result.extend ("<character>", "</character>")
			Result.extend ("<class_name>", "</class_name>")
			Result.extend ("<cluster_name>", "</cluster_name>")
			Result.extend ("<comment>", "</comment>")
			Result.extend ("<feature_name>", "</feature_name>")			
			Result.extend ("<generics>", "</generics>")
			Result.extend ("<keyword>", "</keyword>")
			Result.extend ("<local_variable>", "</local_variable>")
			Result.extend ("<number>", "</number>")
			Result.extend ("<string>", "</string>")
			Result.extend ("<symbol>", "</symbol>")
		end
	
	dot_char: CHARACTER is '.'
			-- Dot call character
			
	newline_string: STRING is "%N"
	
	tab_string: STRING is "%T"
	
	space_string: STRING is " "
	
	empty_string: STRING is ""
	
end -- class CODE_FORMATTER_CONSTANTS

