indexing
	description: "Code generator for argument expressions"
	date: "$$"
	revision: "$$"		

class
	ECDP_ARGUMENT_EXPRESSION_FACTORY

inherit
	ECDP_EXPRESSION_FACTORY

create
	make	

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_argument_reference_expression (a_source: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION) is
			-- | Check `current_type' is not Void else raise an exception.
			-- | Create instance of `EG_ARGUMENT_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_argument_reference_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_argument: ECDP_ARGUMENT_REFERENCE_EXPRESSION
		do
			if current_type = Void then
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_type, ["argument reference expression"])
			end
			
			create an_argument.make
			initialize_argument_reference_expression (a_source, an_argument)
			set_last_expression (an_argument)
		ensure
			non_void_last_expression: last_expression /= Void
			argument_reference_expression_ready: last_expression.ready
		end			

	generate_parameter_declaration_expression (a_source: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION) is
			-- | Check `current_type' is not Void else raise an exception.
			-- | Create instance of `EG_ARGUMENT_DECLARATION_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_parameter_declaration_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_parameter: ECDP_PARAMETER_DECLARATION_EXPRESSION
		do
			if current_type = Void then
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_type, ["parameter declaration expression"])
			end

			create l_parameter.make
			initialize_parameter_declaration_expression (a_source, l_parameter)
			set_last_expression (l_parameter)
		ensure
			non_void_last_expression: last_expression /= Void
			argument_reference_expression_ready: last_expression.ready
		end			

feature {NONE} -- Implementation

	initialize_argument_reference_expression (a_source: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION; an_argument: ECDP_ARGUMENT_REFERENCE_EXPRESSION) is
			-- | Set `name'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_argument: an_argument /= Void
		do
			an_argument.set_argument_name (a_source.parameter_name)
		ensure
			argument_reference_expression_ready: an_argument.ready
		end	

	initialize_parameter_declaration_expression (a_source: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION; a_parameter: ECDP_PARAMETER_DECLARATION_EXPRESSION) is
			-- | Set`name'
			-- | Set `type'
			-- | Add parameter to 
			
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_argument: a_parameter /= Void
		local
			argument_type_name: STRING
		do
			a_parameter.set_name (a_source.name)

			if a_source.type.array_element_type /= Void then
				a_parameter.set_is_array (True)
			end

			create argument_type_name.make_from_cil (a_source.type.base_type)
			a_parameter.set_parameter_type (argument_type_name)
			if not eiffel_types.is_generated_type (argument_type_name) then
				eiffel_types.add_external_type (argument_type_name)
			end
		ensure
			argument_reference_expression_ready: a_parameter.ready
		end	

end -- class ECDP_ARGUMENT_EXPRESSION_FACTORY

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