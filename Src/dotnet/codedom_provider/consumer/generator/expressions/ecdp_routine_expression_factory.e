indexing
	description: "Code generator for routine expressions"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_ROUTINE_EXPRESSION_FACTORY

inherit
	ECDP_EXPRESSION_FACTORY

create
	make

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_routine_invoke_expression (a_source: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `EG_ROUTINE_INVOKE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_invoke_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_routine_invoke_expression: ECDP_ROUTINE_INVOKE_EXPRESSION
		do
			create a_routine_invoke_expression.make
			initialize_generate_routine_invoke_expression (a_source, a_routine_invoke_expression)
			set_last_expression (a_routine_invoke_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_routine_reference_expression (a_source: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `EG_ROUTINE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_reference_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_routine_reference_expression: ECDP_ROUTINE_REFERENCE_EXPRESSION
		do
			create a_routine_reference_expression.make
			initialize_generate_routine_reference_expression (a_source, a_routine_reference_expression)
			set_last_expression (a_routine_reference_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

feature {NONE} -- Implementation

	initialize_generate_routine_invoke_expression (a_source: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION; a_routine_invoke_expression: ECDP_ROUTINE_INVOKE_EXPRESSION) is
			-- | Call to `generate_routine_reference_expression' to generate `routine'.
			-- | Call to `generate_arguments' if any.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_a_routine_invoke_expression: a_routine_invoke_expression /= Void
		local
			a_routine_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			a_routine: ECDP_ROUTINE_REFERENCE_EXPRESSION
		do
			a_routine_expression := a_source.method
			if a_routine_expression /= Void then
				code_dom_generator.generate_expression_from_dom (a_routine_expression)
				a_routine ?= last_expression
				if a_routine /= Void then
					a_routine_invoke_expression.set_routine (a_routine)
				end
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_method, ["method invoke expression"])
			end
			generate_arguments (a_source, a_routine_invoke_expression)
		end

	generate_arguments (a_source: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION; a_routine_invoke_expression: ECDP_ROUTINE_INVOKE_EXPRESSION) is
			-- | Call in loop to `generate_expression_from_dom'.

			-- Generate invoked routine arguments.
		require
			non_void_source: a_source /= Void
			non_void_routine_invoke_expression: a_routine_invoke_expression /= Void
		local
			i: INTEGER
			arguments: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			an_argument: SYSTEM_DLL_CODE_EXPRESSION
		do
			arguments := a_source.parameters
			if arguments /= Void then
				from
				until
					i = arguments.count
				loop
					an_argument := arguments.item (i)
					if an_argument /= Void then
						code_dom_generator.generate_expression_from_dom (an_argument)
						a_routine_invoke_expression.add_argument (last_expression)
					end
					i := i + 1
				end
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_parameters, ["method invoke expression"])
			end
		end

	initialize_generate_routine_reference_expression (a_source: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION; a_routine_reference_expression: ECDP_ROUTINE_REFERENCE_EXPRESSION) is
			-- | Set `target_object' and `name'.
			-- | Set `current_namespace' and `current_type' if they are /= Void
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_a_routine_reference_expression: a_routine_reference_expression /= Void
		local			
			routine_name: STRING
			target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			target_object := a_source.target_object
			if target_object /= Void then
				code_dom_generator.generate_expression_from_dom (target_object)
				a_routine_reference_expression.set_target_object (last_expression)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_target_object, ["method reference expression"])
			end

			create routine_name.make_from_cil (a_source.method_name)
			a_routine_reference_expression.set_routine_name (routine_name)

			if current_namespace /= Void then
				a_routine_reference_expression.set_current_namespace (current_namespace.name)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_namespace, ["method reference expression"])
			end
			if current_type /= Void then
				a_routine_reference_expression.set_current_class (current_type.name)
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_current_type, ["method reference expression"])
			end
		end

end -- class ECDP_ROUTINE_EXPRESSION_FACTORY

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