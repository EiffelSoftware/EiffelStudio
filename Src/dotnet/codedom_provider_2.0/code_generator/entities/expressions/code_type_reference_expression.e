indexing 
	description: "Source code generator for type reference expressions"
	date: "$$"
	revision: "$$"	

class
	CODE_TYPE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_referenced_type: CODE_TYPE_REFERENCE) is
			-- Initialize `referenced_type'.
		require
			non_void_referenced_type: a_referenced_type /= Void
		do
			referenced_type := a_referenced_type
		ensure
			referenced_type_set: referenced_type = a_referenced_type
		end
		
feature -- Access

	referenced_type: CODE_TYPE_REFERENCE
			-- Type which is referred to

	code: STRING is
			-- | Result := "`referred_type'"
			-- Eiffel code of type reference expression
		do
			Result := referenced_type.eiffel_name
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := referenced_type
		end

invariant
	non_void_referenced_type: referenced_type /= Void
	
end -- class CODE_TYPE_REFERENCE_EXPRESSION

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