indexing 
	description: "Source code generator for base reference (precursor) expression"
	date: "$$"
	revision: "$$"
	
class
	CODE_BASE_REFERENCE_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
		end
		
feature -- Access

	code: STRING is
			-- | Result C# := "base"
			-- Eiffel code of base reference expression
			-- Don't generate anything, generation is done in {CODE_ROUTINE_REFERENCE_EXPRESSION}
		do
		end

feature -- Element Settings

	set_type (a_type: like type) is
			-- Set `type' with `a_type'
		require
			attached_type: a_type /= Void
		do
			internal_type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			if internal_type = Void then
				Result := None_type_reference
			else
				Result := internal_type
			end
		end

feature {NONE} -- Implementation

	internal_type: CODE_TYPE_REFERENCE
			-- Cache for `type'

end -- class CODE_BASE_REFERENCE_EXPRESSION

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