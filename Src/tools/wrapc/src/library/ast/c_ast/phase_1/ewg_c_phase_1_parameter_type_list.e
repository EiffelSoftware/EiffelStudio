note

	description:

		"AST Element of Phase 1, representing C parameter type lists"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_PARAMETER_TYPE_LIST

create

	make,
	make_with_ellipsis,
	make_empty_with_ellipsis

feature {NONE} -- Initialisation

	make (a_parameter_list: like parameter_list)
			-- Create new parameter type list with `a_parameter_list' as
			-- parameter list.
		require
			a_parameter_list_not_void: a_parameter_list /= Void
		do
			parameter_list := a_parameter_list
		ensure
			parameter_list_set: parameter_list = a_parameter_list
			doesnt_have_ellipsis_parameter: not has_ellipsis_parameter
		end

	make_with_ellipsis (a_parameter_list: like parameter_list)
			-- Create new parameter type list with `a_parameter_list' as
			-- parameter list plus the last parameter will be the special
			-- "..." parameter.
		require
			a_parameter_list_not_void: a_parameter_list /= Void
		do
			make (a_parameter_list)
			set_ellipsis_parameter (True)
		ensure
			parameter_list_set: parameter_list = a_parameter_list
			has_ellipsis_parameter: has_ellipsis_parameter
		end

	make_empty_with_ellipsis
			-- Create new parameter type with arbitrary many parameters.
		do
			create parameter_list.make
			set_ellipsis_parameter (True)
		ensure
			no_parameters: parameter_list.count = 0
			has_ellipsis_parameter: has_ellipsis_parameter
		end

feature -- Access

	parameter_list: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]
			-- Parameters

	has_ellipsis_parameter: BOOLEAN
			-- Does this function have take arbitrary many unnamed parameters after the regular ones?

feature -- Element change

	set_ellipsis_parameter (a_value: BOOLEAN)
			-- Set `has_ellipsis_parameter' to `a_value'.
		do
			has_ellipsis_parameter := a_value
		ensure
			has_ellipsis_parameter_set: has_ellipsis_parameter = a_value
		end

invariant

	parameter_list_not_void: parameter_list /= Void
--	parameter_list_doesnt_have_void: not parameter_list.has (Void)

end
