indexing 
	description: "Source code generator for snippet expressions"
	date: "$$"
	revision: "$$"

class
	ECD_SNIPPET_EXPRESSION

inherit
	ECD_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `value' with empty string.
		do
			create value.make_empty
		ensure
			non_void_value: value /= Void
		end
		
feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- Eiffel code of snippet expression
		do
			Check
				not_empty_value: not value.is_empty
			end

			Result := value.twin
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is snippet expression ready to be generated?
		do
			Result := value /= Void and not value.is_empty
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name ("System.Object")
		end

feature -- Status Setting

	set_value (a_value: like value) is
			-- Set `value' with `a_value'.
		require
			non_void_value: a_value /= Void
			not_empty_value: not a_value.is_empty
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
invariant
	non_void_value: value /= Void
	
end -- class ECD_SNIPPET_EXPRESSION

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