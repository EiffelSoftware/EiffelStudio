indexing
	description: "Source code generator for argument reference expression"
	date: "$$"
	revision: "$$"
	
class
	CODE_ARGUMENT_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_argument: like argument) is
			-- Initialize `argument' with empty string.
		require
			non_void_argument: a_argument /= Void
		do
			argument := a_argument
		ensure
			argument_set: argument = a_argument
		end
		
feature -- Access

	argument: CODE_VARIABLE_REFERENCE
			-- Argument name
	
	code: STRING is
			-- | Result := `argument_name'
			-- Eiffel code of argument reference expression
		do
			Result := argument.eiffel_name
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := argument.type
		end

invariant
	non_void_argument: argument /= Void
	
end -- class CODE_ARGUMENT_REFERENCE_EXPRESSION

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