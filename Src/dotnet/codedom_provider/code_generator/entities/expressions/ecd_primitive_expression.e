indexing 
	description: "Source code generator for primitive expressions"
	date: "$$"
	revision: "$$"

class
	ECD_PRIMITIVE_EXPRESSION

inherit
	ECD_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `value'.
		do
		end
		
feature -- Access

	value: SYSTEM_OBJECT
			-- Object to represent
			
	code: STRING is
			-- | Result := "`value'" 
			-- | OR		:= "("`value'").to_cil" if value is SYSTEM_STRING
			-- Eiffel code of primitive expression
		local
			string: SYSTEM_STRING
		do
			check
				not_empty_value: value /= Void
			end
			
			Result := value.to_string
			string ?= value
			if string /= Void then
				Result := format_string (Result)
			end
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is primitive expression ready to be generated?
		do
			Result := value /= Void
		end

	type: TYPE is
			-- Type
		do
			Result := value.get_type
		end

feature -- Status Setting

	set_value (a_value: like value) is
			-- Set `value' with `a_value'.
		require
			non_void_value: a_value /= Void
		do
			value := a_value
		ensure
			value_set: value = a_value
		end		
		
feature {NONE} -- Implementation		

	format_string (s: STRING): STRING is
			-- Format string to eiffel syntax.
		require
			non_void_string: s /= Void
		local
			i: INTEGER
		do
			create Result.make (s.count + 10)
			
			Result.append (Dictionary.Opening_round_bracket)
            Result.append (Dictionary.Double_quotes)

			from
				i := 1
			until
				i > s.count
			loop
				inspect 
					s.item (i)
				when '%R' then
					Result.append ("%%R")
				when '%T' then
					Result.append ("%%T")
				when '%"' then
					Result.append ("%%%"")
				when '%%' then
					Result.append ("%%%%")
				when '%'' then
					Result.append ("%%%'")
				when '%N' then
					Result.append ("%%N")
				else
					Result.append_character (s.item (i))
				end
				
				i := i + 1
			end

            Result.append (Dictionary.Double_quotes)
			Result.append (Dictionary.Closing_round_bracket)
			Result.append (Dictionary.Dot_keyword)
			Result.append ("to_cil")            
		ensure
			non_void_result: Result /= Void
		end

end -- class ECD_PRIMITIVE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------