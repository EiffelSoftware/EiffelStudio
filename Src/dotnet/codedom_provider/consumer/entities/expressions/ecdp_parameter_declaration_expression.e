indexing 
	description: "Source code generator for argument declaration expressions"
	date: "$$"
	revision: "$$"

class
	ECDP_PARAMETER_DECLARATION_EXPRESSION

inherit
	ECDP_EXPRESSION

	ECDP_DIRECTIONS
	
	ECDP_SHARED_CONSUMER_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `name' and `type'.
		do
			create name.make_empty
			create parameter_type.make_empty
		ensure
			non_void_name: name /= Void
			non_void_parameter_type: parameter_type /= Void
			not_empty_direction: direction > 0
		end
		
feature -- Access

	name: STRING
			-- Argument name

	parameter_type: STRING
			-- type of parameter
			
	direction: INTEGER
			-- direction of the attribute (in, out or ref)
			-- Useless in eiffel

	is_array: BOOLEAN
			-- Is parameter a NATIVE_ARRAY type?

	code: STRING is
			-- | Result := "`name': `TYPE'"
			-- | or Result := "`name': TYPED_POINTER [`TYPE']" if direction is out or inout
			-- Eiffel code of argument declaration expression
		local
			l_name: STRING
			l_byref: BOOLEAN
		do
			check
				not_empty_parameter_type: not parameter_type.is_empty
				not_empty_name: not name.is_empty
			end

			create Result.make (120)
			l_name := Resolver.unique_entity_name (name)
			Resolver.add_variable (parameter_type, l_name)
			Result.append (Resolver.eiffel_entity_name (l_name))
			Result.append (dictionary.Colon)
			Result.append (dictionary.Space)
			l_byref := direction = out_argument or direction = inout_argument
			if l_byref then
				Result.append ("TYPED_POINTER [")
			end
			Result.append (Resolver.eiffel_type_name (parameter_type))
			if l_byref then
				Result.append ("]")
			end
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is argument declaration expression ready to be generated?
		do
			Result := not name.is_empty and not parameter_type.is_empty and is_valid_direction (direction)
		end

	type: TYPE is
			-- Type
		local
			l_dotnet_type_name: STRING
			l_arguments: LINKED_LIST [ECDP_EXPRESSION]
		do
			create l_arguments.make
			l_dotnet_type_name := Resolver.feature_result_type (Void, name, l_arguments)
			Result := Dotnet_types.dotnet_type (l_dotnet_type_name)
		end

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end
		
	set_parameter_type (a_parameter_type: like parameter_type) is
			-- Set `paramter_type' with `a_parameter_type'.
		require
			non_void_parameter_type: a_parameter_type /= Void
			positif_parameter_type: not a_parameter_type.is_empty
		do
			parameter_type := a_parameter_type
		ensure
			parameter_type_set: parameter_type = a_parameter_type
		end
		
	set_direction (a_direction: like direction) is
			-- Set `direction' with `a_direction'.
		require
			valid_direction: is_valid_direction (a_direction)
		do
			direction := a_direction
		ensure
			direction_set: direction = a_direction
		end
		
	set_is_array (a_bool: like is_array) is
			-- Set `is_array' with `a_bool'.
		do
			is_array := a_bool
		ensure
			is_array_set: is_array = a_bool
		end

invariant
	non_void_name: name /= Void
	non_void_parameter_type: parameter_type /= Void	

end -- class ECDP_ARGUMENT_DECLARATION_EXPRESSION

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