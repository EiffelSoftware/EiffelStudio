indexing 
	description: "Source code generator for variable reference expressions"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_VARIABLE_REFERENCE_EXPRESSION

inherit
	ECDP_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `variable_name'.
		do
			create variable_name.make_empty
		ensure
			non_void_variable_name: variable_name /= Void
		end
		
feature -- Access

	variable_name: STRING
			-- Name of variable to reference

	code: STRING is
			-- | Result := "`variable_name'"
			-- Eiffel code of variable reference expression
		do
			create Result.make_from_string (Resolver.eiffel_entity_name (variable_name))
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is variable reference expression ready to be generated?
		do
			Result := variable_name /= Void and not variable_name.is_empty
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name (Resolver.dotnet_type_name (variable_name))
		end

feature -- Status Setting

	set_variable_name (a_name: like variable_name) is
			-- Set `variable_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			variable_name := a_name
		ensure
			variable_name_set: variable_name = a_name
		end		

invariant
	non_void_variable_name: variable_name /= Void
	
end -- class ECDP_VARIABLE_REFERENCE_EXPRESSION

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