indexing 
	description: "Source code generator for primitive expressions"
	date: "$$"
	revision: "$$"

class
	CODE_PRIMITIVE_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_value: like value) is
			-- Initialize `value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
feature -- Access

	value: SYSTEM_OBJECT
			-- Object to represent
			
	code: STRING is
			-- | Result := "`value'" 
			-- | OR		:= "("`value'").to_cil" if value is SYSTEM_STRING
			-- Eiffel code of primitive expression
		local
			l_string: STRING
			i: INTEGER
		do
			l_string := value.to_string
			create Result.make (l_string.count + 10)			
			Result.append ("(%"")
			from
				i := 1
			until
				i > l_string.count
			loop
				inspect 
					l_string.item (i)
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
					Result.append_character (l_string.item (i))
				end
				
				i := i + 1
			end

			Result.append ("%").to_cil")
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is primitive expression ready to be generated?
		do
			Result := value /= Void
		end

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := Type_reference_factory.type_reference_from_type (value.get_type)
		end

invariant
	non_void_value: value /= Void

end -- class CODE_PRIMITIVE_EXPRESSION

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