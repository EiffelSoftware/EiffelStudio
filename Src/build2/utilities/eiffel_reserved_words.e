indexing
	description: "Objects that provide access to all reserved words of Eiffel."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_RESERVED_WORDS

feature -- Access

	reserved_words: ARRAYED_LIST [STRING] is
			-- All reserved words of Eiffel as specified
			-- in ETL3. In alphabetical order and all lowercase.
		do
			create Result.make (0)
			Result.extend ("agent")
			Result.extend ("alias")
			Result.extend ("all")
			Result.extend ("and")
			Result.extend ("as")
			Result.extend ("assign")
			Result.extend ("check")
			Result.extend ("class")
			Result.extend ("convert")
			Result.extend ("create")
			Result.extend ("current")
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
			Result.extend ("precursor")
			Result.extend ("pure")
			Result.extend ("redefine")
			Result.extend ("reference")
			Result.extend ("rename")
			Result.extend ("require")
			Result.extend ("rescue")
			Result.extend ("Result")
			Result.extend ("retry")
			Result.extend ("separate")
			Result.extend ("then")
			Result.extend ("true")
			Result.extend ("tuple")
			Result.extend ("undefine")
			Result.extend ("unique")
			Result.extend ("until")
			Result.extend ("variant")
			Result.extend ("when")
			Result.extend ("xor")
			Result.compare_objects
		ensure
			Result_not_void: Result /= Void
			Result_count_is_61: Result.count = 61
		end
		

end -- class EIFFEL_RESERVED_WORDS
