indexing 
	description: "Source code generator for this reference expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_DEFAULT_VALUE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION
	
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_type: like target_type; a_variable_name: STRING) is
			-- Creation routine
		require
			attached_type: a_type /= Void
			attached_variable_name: a_variable_name /= Void
		do
			target_type := a_type
			variable_name := a_variable_name
		ensure
			target_type_set: target_type = a_type
			variable_name_set: variable_name = a_variable_name
		end
		
feature -- Access

	target_type: CODE_TYPE_REFERENCE
			-- Type including this expression

	variable_name: STRING
			-- Dummy local variable name

	code: STRING is
			-- | Result := "Current"
			-- Eiffel code of this reference expression
		do
			Result := variable_name
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := target_type
		end

invariant
	non_void_target_type: target_type /= Void
	non_void_variable_name: variable_name /= Void

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