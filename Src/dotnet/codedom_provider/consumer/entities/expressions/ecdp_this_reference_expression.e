indexing 
	description: "Source code generator for this reference expressions"
	date: "$$"
	revision: "$$"
	
class
	ECDP_THIS_REFERENCE_EXPRESSION

inherit
	ECDP_REFERENCE_EXPRESSION
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
			create arguments.make
		end
		
feature -- Access

	code: STRING is
			-- | Result := "Current"
			-- Eiffel code of this reference expression
		do
			Result := Dictionary.Current_keyword.twin
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is this reference expression ready to be generated?
		do
			Result := True
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name ("System.Object")
		end

end -- class ECDP_THIS_REFERENCE_EXPRESSION

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