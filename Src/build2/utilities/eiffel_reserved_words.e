indexing
	description: "Objects that provide access to all reserved words of Eiffel."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_RESERVED_WORDS

feature -- Access

	reserved_words: HASH_TABLE [STRING, STRING] is
			-- All reserved words of Eiffel as specified
			-- in ETL3. In alphabetical order and all lowercase.
		once
			create Result.make (0)
			Result.put ("agent", "agent")
			Result.put ("", "alias")
			Result.put ("all", "all")
			Result.put ("and", "and")
			Result.put ("as", "as")
			Result.put ("assign", "assign")
			Result.put ("check", "check")
			Result.put ("class", "class")
			Result.put ("convert", "convert")
			Result.put ("create", "create")
			Result.put ("current", "current")
			Result.put ("debug", "debug")
			Result.put ("deferred", "deferred")
			Result.put ("do", "do")
			Result.put ("else", "else")
			Result.put ("endif", "elseif")
			Result.put ("end", "end")
			Result.put ("ensure", "ensure")
			Result.put ("expanded", "expanded")
			Result.put ("export", "export")
			Result.put ("external", "external")
			Result.put ("false", "false")
			Result.put ("feature", "feature")
			Result.put ("from", "from")
			Result.put ("frozen", "frozen")
			Result.put ("if", "if")
			Result.put ("implies", "implies")
			Result.put ("indexing", "indexing")
			Result.put ("infix", "infix")
			Result.put ("inherit", "inherit")
			Result.put ("inspect", "inspect")
			Result.put ("invariant", "invariant")
			Result.put ("is", "is")
			Result.put ("like", "like")
			Result.put ("local", "local")
			Result.put ("loop", "loop")
			Result.put ("not", "not")
			Result.put ("obsolete", "obsolete")
			Result.put ("old", "old")
			Result.put ("once", "once")
			Result.put ("or", "or")
			Result.put ("prefix", "prefix")
			Result.put ("precursor", "precursor")
			Result.put ("pure", "pure")
			Result.put ("redefine", "redefine")
			Result.put ("reference", "reference")
			Result.put ("rename", "rename")
			Result.put ("require", "require")
			Result.put ("rescue", "rescue")
			Result.put ("result", "result")
			Result.put ("retry", "retry")
			Result.put ("separate", "separate")
			Result.put ("then", "then")
			Result.put ("true", "true")
			Result.put ("tuple", "tuple")
			Result.put ("undefine", "undefine")
			Result.put ("unique", "unique")
			Result.put ("until", "until")
			Result.put ("variant", "variant")
			Result.put ("when", "when")
			Result.put ("xor", "xor")
			Result.compare_objects
		ensure
			Result_not_void: Result /= Void
			Result_count_is_61: Result.count = 61
		end
		

end -- class EIFFEL_RESERVED_WORDS
