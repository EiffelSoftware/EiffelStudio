indexing
	description: "Eiffel representation of a CodeDom snippet statement"
	date: "$$"
	revision: "$$"		

class
	ECDP_SNIPPET_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Do nothing.
		do
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
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is snippet statement ready to be generated?
		do
			Result := value /= Void
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
	
end -- class ECDP_SNIPPET_STATEMENT

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