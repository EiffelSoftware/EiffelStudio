indexing
	description: "Code generator for property expressions"
	date: "$$"
	revision: "$$"		

class
	ECDP_PROPERTY_EXPRESSION_FACTORY

inherit
	ECDP_EXPRESSION_FACTORY

create
	make

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_property_reference_expression (a_source: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `EG_PROPERTY_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_property_reference_expression: ECDP_PROPERTY_REFERENCE_EXPRESSION
		do
			create a_property_reference_expression.make
			initialize_property_reference_expression (a_source, a_property_reference_expression)
			set_last_expression (a_property_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
			property_reference_expression_ready: last_expression.ready
		end

	generate_property_set_value_reference_expression (a_source: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION) is
			-- | Create instance of `EG_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_property_set_value_reference_expression: ECDP_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION
		do
			create a_property_set_value_reference_expression.make
			initialize_property_set_value_reference_expression (a_source, a_property_set_value_reference_expression)
			set_last_expression (a_property_set_value_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end	

feature {NONE} -- Implementation

	initialize_property_reference_expression (a_source: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION; a_property_reference_expression: ECDP_PROPERTY_REFERENCE_EXPRESSION) is
			-- | Call `GetType' on target object to get type CodeDom name in which property is defined.
			-- | Get `EG_GENERATED_TYPE' using `eg_generated_types' and CodeDom name from `GetType'.
			-- | Generate hash value from property name (with prefix `get' or `setter' whether it is a getter or a setter) and arguments
			-- | and give generated value to `eg_routines' to get `EG_FUNCTION' or `EG_ROUTINE' (whether it is getter or setter).

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_property_reference: a_property_reference_expression /= Void
		local
			a_property_name: STRING
			a_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			create a_property_name.make_from_cil (a_source.property_name)
			a_property_reference_expression.set_property_name (a_property_name)
			
			a_target_object := a_source.target_object
			code_dom_generator.generate_expression_from_dom (a_target_object)
			a_property_reference_expression.set_target_object (last_expression)
			
			if current_namespace /= Void then
				a_property_reference_expression.set_current_namespace (current_namespace.name)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_namespace, ["property reference expression"])
			end
			if current_type /= Void then
				a_property_reference_expression.set_current_class (current_type.name)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_type, ["property reference expression"])
			end
		ensure
			property_reference_expression_ready: a_property_reference_expression.ready
		end

	initialize_property_set_value_reference_expression (a_source: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION;
															a_property_set_value_reference_expression: ECDP_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION) is
			-- Generate Eiffel code from `a_source'.
			-- PrivateGeneratePropertySetValueReferenceExpression"
		require
			non_void_source: a_source /= Void
			non_void_property_set_value_reference_expression: a_property_set_value_reference_expression /= Void
		do
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Does_nothing, ["property set value reference expression"])
		end

end -- class ECDP_PROPERTY_EXPRESSION_FACTORY

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