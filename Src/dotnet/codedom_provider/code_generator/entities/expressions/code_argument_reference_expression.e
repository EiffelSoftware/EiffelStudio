indexing
	description: "Source code generator for argument reference expression"
	date: "$$"
	revision: "$$"
	
class
	CODE_ARGUMENT_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION
	
	CODE_SHARED_CODE_GENERATOR_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `argument_name' with empty string.
		do
			create arguments.make
			create argument_name.make_empty
		ensure
			non_void_argument_name: argument_name /= Void
		end
		
feature -- Access

	argument_name: STRING 
			-- Argument name
	
	code: STRING is
			-- | Result := `argument_name'
			-- Eiffel code of argument reference expression
		do
			Check
				not_empty_argument_name: not argument_name.is_empty
			end
		
			create Result.make_from_string (Resolver.eiffel_entity_name (argument_name))
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is argument reference expression ready to be generated?
		do
			Result := argument_name /= Void and not argument_name.is_empty
		end

	type: TYPE is
			-- Type
		local
			l_dotnet_type_name: STRING
		do
			l_dotnet_type_name := Resolver.feature_result_type (Void, argument_name, arguments)
			if l_dotnet_type_name /= Void then
				Result := Dotnet_types.dotnet_type (l_dotnet_type_name)
			end
		end

feature -- Status Setting

	set_argument_name (a_name: like argument_name) is
			-- Set `argument_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			argument_name := a_name
		ensure
			argument_name_set: argument_name = a_name
		end
			
invariant
	non_void_argument_name: argument_name /= Void
	
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