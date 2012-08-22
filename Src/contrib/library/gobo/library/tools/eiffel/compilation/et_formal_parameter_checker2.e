note

	description:

		"Eiffel formal parameter validity checkers, second pass"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_FORMAL_PARAMETER_CHECKER2

inherit

	ET_CLASS_SUBPROCESSOR
		redefine
			make
		end

	ET_AST_NULL_PROCESSOR
		undefine
			make
		redefine
			process_class,
			process_class_type,
			process_generic_class_type,
			process_tuple_type
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new signature checker for features of given classes.
		do
			precursor {ET_CLASS_SUBPROCESSOR}
			create constraint_context.make_with_capacity (current_class, 1)
		end

feature -- Validity checking

	check_formal_parameters_validity (a_class: ET_CLASS)
			-- Second pass of the validity check of the formal generic
			-- parameters of `a_class'. Do not try to check the
			-- creation procedures of formal parameters (this is done
			-- only for parent types, creation types and expanded
			-- types). Set `has_fatal_error' if an error occurred.
		require
			a_class_not_void: a_class /= Void
			a_class_preparsed: a_class.is_preparsed
		local
			i, nb: INTEGER
			a_parameters: ET_FORMAL_PARAMETER_LIST
			a_formal: ET_FORMAL_PARAMETER
			old_class: ET_CLASS
		do
			has_fatal_error := False
			old_class := current_class
			current_class := a_class
			a_parameters := current_class.formal_parameters
			if a_parameters /= Void then
				nb := a_parameters.count
				from i := 1 until i > nb loop
					a_formal := a_parameters.formal_parameter (i)
					check_constraint_validity (a_formal)
					i := i + 1
				end
			end
			current_class := old_class
		end

feature {NONE} -- Constraint validity

	check_constraint_validity (a_formal: ET_FORMAL_PARAMETER)
			-- Check whether the constraint of `a_formal' is a valid
			-- constraint in `current_class'. Check whether the actual
			-- generic parameters of the constraint of `a_formal' conform
			-- to their corresponding formal parameters' constraints.
			-- Do not check for the validity of the creation procedures
			-- of these constraints (this is done only for parent types,
			-- creation types and expanded types). Set `has_fatal_error'
			-- if an error occurred.
		require
			a_formal_not_void: a_formal /= Void
		local
			a_constraint: ET_TYPE
		do
			a_constraint := a_formal.constraint
			if a_constraint /= Void then
				a_constraint.process (Current)
			end
		end

	check_class_type_constraint (a_type: ET_CLASS_TYPE)
			-- Check whether `a_type' is valid when appearing in a
			-- constraint of a formal parameter in `current_class'.
			-- Check whether the actual generic parameters of `a_type'
			-- conform to their corresponding formal parameters' constraints.
			-- Do not check for the validity of the creation procedures
			-- of these constraints (this is done only for parent types,
			-- creation types and expanded types). Set `has_fatal_error'
			-- if an error occurred.
		require
			a_type_not_void: a_type /= Void
		local
			i, nb: INTEGER
			a_formals: ET_FORMAL_PARAMETER_LIST
			an_actuals: ET_ACTUAL_PARAMETER_LIST
			an_actual: ET_TYPE
			a_formal: ET_FORMAL_PARAMETER
			a_constraint: ET_TYPE
			a_class: ET_CLASS
		do
			a_class := a_type.base_class
			if a_class.is_generic then
				a_formals := a_class.formal_parameters
				check a_class_generic: a_formals /= Void end
				an_actuals := a_type.actual_parameters
				if an_actuals = Void or else an_actuals.count /= a_formals.count then
						-- Error already reported during first pass of
						-- formal generic parameters validity checking.
					set_fatal_error
				else
					nb := an_actuals.count
					from i := 1 until i > nb loop
						an_actual := an_actuals.type (i)
						an_actual.process (Current)
						a_formal := a_formals.formal_parameter (i)
						a_constraint := a_formal.constraint
						if a_constraint = Void then
							a_constraint := current_universe.detachable_any_type
						end
							-- If we have:
							--    class A [G, H -> LIST [G]] ...
							--    class X [G -> A [ANY, LIST [STRING]] ...
							-- we need to check that "LIST [STRING]" conforms to
							-- "LIST [ANY]", not just "LIST [G]". So, the constraint
							-- needs to be handled in the correct type context.
						constraint_context.set (a_type, current_class)
						if not an_actual.conforms_to_type (a_constraint, constraint_context, current_class) then
								-- The actual parameter does not conform to the
								-- constraint of its corresponding formal parameter.
							set_fatal_error
							error_handler.report_vtcg3a_error (current_class, current_class, a_type, an_actual, a_constraint)
						end
						i := i + 1
					end
				end
			end
		end

	check_tuple_type_constraint (a_type: ET_TUPLE_TYPE)
			-- Check whether `a_type' is valid when appearing in a
			-- constraint of a formal parameter in `current_class'.
			-- Check whether the actual generic parameters of `a_type'
			-- conform to their corresponding formal parameters' constraints.
			-- Do not check for the validity of the creation procedures
			-- of these constraints (this is done for parent types,
			-- creation types and expanded types). Set `has_fatal_error'
			-- if an error occurred.
		require
			a_type_not_void: a_type /= Void
		local
			a_parameters: ET_ACTUAL_PARAMETER_LIST
			i, nb: INTEGER
		do
			a_parameters := a_type.actual_parameters
			if a_parameters /= Void then
				nb := a_parameters.count
				from i := 1 until i > nb loop
					a_parameters.type (i).process (Current)
					i := i + 1
				end
			end
		end

feature {ET_AST_NODE} -- Type dispatcher

	process_class (a_class: ET_CLASS)
			-- Process `a_class'.
		do
			process_class_type (a_class)
		end

	process_class_type (a_type: ET_CLASS_TYPE)
			-- Process `a_type'.
		do
			check_class_type_constraint (a_type)
		end

	process_generic_class_type (a_type: ET_GENERIC_CLASS_TYPE)
			-- Process `a_type'.
		do
			process_class_type (a_type)
		end

	process_tuple_type (a_type: ET_TUPLE_TYPE)
			-- Process `a_type'.
		do
			check_tuple_type_constraint (a_type)
		end

feature {NONE} -- Implementation

	constraint_context: ET_NESTED_TYPE_CONTEXT
			-- Constraint context for type conformance checking

invariant

	constraint_context_not_void: constraint_context /= Void

end
