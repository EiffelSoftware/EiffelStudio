indexing 
	description: "Source code generator for base reference (precursor) expression"
	date: "$$"
	revision: "$$"
	
class
	ECD_BASE_REFERENCE_EXPRESSION

inherit
	ECD_EXPRESSION

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
			-- NOT SUPPORTED YET !!!
		do
			create Result.make (120)
			Result.append (indent_string)
			Result.append ("NOT SUPPORTED YET !!! (EG_BASE_REFERENCE_EXPRESSION)")
		end
		
feature -- Status Report

	ready: BOOLEAN is 
			-- Is expression ready to be generated?
		do
			Result := True
		end
		
	type: TYPE is
			-- Type
		do
			Result := Void
		end

end -- class ECD_BASE_REFERENCE_EXPRESSION

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