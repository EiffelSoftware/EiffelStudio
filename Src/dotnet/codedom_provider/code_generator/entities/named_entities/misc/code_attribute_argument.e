indexing
	description: "Attribute argument of a custom attribute"
	date: "$$"
	revision: "$$"	

class
	CODE_ATTRIBUTE_ARGUMENT

inherit
	CODE_NAMED_ENTITY
		redefine
			ready,
			set_name
		end
		
	CODE_SHARED_CODE_GENERATOR_CONTEXT
		undefine
			default_create,
			is_equal
		end

create
	default_create
	
feature -- Access

	value: CODE_EXPRESSION
			-- List of arguments.
			
	type: STRING
			-- Dotnet type of the custom attribute.
			
	code: STRING is
			-- | Result := "`value'"	 if name.is_empty
			-- | OR
			-- | Result := "["`name'", `value']"
		local
			feature_arguments: LINKED_LIST [CODE_EXPRESSION]
			l_eiffel_name: STRING
		do
			create Result.make (120)
			if name.is_empty then
				Result.append (value.code)
			else
				Result.append ("[")
				create feature_arguments.make
				Result.append (Dictionary.Double_quotes)
				l_eiffel_name := Feature_finder.eiffel_feature_name_from_dynamic_args (Dotnet_types.dotnet_type (type), name, feature_arguments)
				if l_eiffel_name = Void then
					l_eiffel_name := Feature_finder.eiffel_feature_name_from_dynamic_args (Dotnet_types.dotnet_type (type), "get_" + name, feature_arguments)
				end
				check
					non_void_l_eiffel_name: l_eiffel_name /= Void
					not_empty_l_eiffel_name: not l_eiffel_name.is_empty
				end
				Result.append (l_eiffel_name)
				Result.append (Dictionary.Double_quotes)
				Result.append (", ")
				Result.append (value.code)
				Result.append ("]")
			end
		end

feature -- Status Report
			
	ready: BOOLEAN is
			-- Is comment ready to be generated?
		do
			Result := name /= Void and value /= Void
		end

feature -- Status Setting

	set_name (a_name: like name) is
			-- redefinition of preconditions of set_name.
		require else
			non_void_name: a_name /= Void
		do
			name := a_name
		end

	set_value (a_value: CODE_EXPRESSION) is
			-- Set `value' to `a_value'.
		require
			non_void_a_value: a_value /= Void
		do
			value := a_value
		ensure
			a_value_set: value = a_value
		end

	set_type (a_type: STRING) is
			-- Set `type' to `a_type'.
		require
			non_void_a_type: a_type /= Void
		do
			type := a_type
		ensure
			a_type_set: type = a_type
		end

end -- class CODE_ATTRIBUTE_ARGUMENT

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