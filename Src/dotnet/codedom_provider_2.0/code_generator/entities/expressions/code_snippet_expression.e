indexing 
	description: "Source code generator for snippet expressions"
	date: "$$"
	revision: "$$"

class
	CODE_SNIPPET_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make (a_value: STRING) is
			-- Initialize `value' with `a_value'.
		require
			non_void_value: a_value /= Void
			valid_value: not a_value.is_empty
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- Eiffel code of snippet expression
		do
			Result := value
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := None_type_reference
			Event_manager.raise_event ({CODE_EVENTS_IDS}.Incorrect_result, ["code snippet expression type"])
		end

invariant
	non_void_value: value /= Void
	
end -- class CODE_SNIPPET_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------