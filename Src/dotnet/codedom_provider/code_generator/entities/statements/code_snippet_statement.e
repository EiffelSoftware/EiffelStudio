indexing
	description: "Eiffel representation of a CodeDom snippet statement"
	date: "$$"
	revision: "$$"		

class
	CODE_SNIPPET_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_value: like value) is
		require
			non_void_value: a_value /= Void
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- | Result := "`value'"
			-- Eiffel code of snippet statement
		do
			create Result.make (indent_string.count + value.count + 1)
			Result.append (indent_string)
			Result.append (value)
			Result.append ("%N")
		end
	
	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

end -- class CODE_SNIPPET_STATEMENT

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