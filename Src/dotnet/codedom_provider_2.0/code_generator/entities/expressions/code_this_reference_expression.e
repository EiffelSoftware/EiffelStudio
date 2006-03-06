indexing 
	description: "Source code generator for this reference expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_THIS_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION
	
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NON} all
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_type: like current_type) is
			-- Creation routine
		require
			non_void_type: a_type /= Void
		do
			current_type := a_type
		ensure
			current_type_set: current_type = a_type
		end
		
feature -- Access

	current_type: CODE_GENERATED_TYPE
			-- Type including this expression

	code: STRING is
			-- | Result := "Current"
			-- Eiffel code of this reference expression
		do
			Result := "Current"
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := Type_reference_factory.type_reference_from_code (current_type)
		end

invariant
	non_void_current_type: current_type /= Void

end -- class CODE_THIS_REFERENCE_EXPRESSION

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