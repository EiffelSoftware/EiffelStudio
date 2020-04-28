note

	description:

		"AST Element of Phase 1, representing C declaratiors"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_DIRECT_DECLARATOR

inherit

	EWG_C_CALLING_CONVENTION_CONSTANTS

	EWG_CL_ATTRIBUTE_CONSTANTS
		export
			{NONE} all
		end

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all
		end

create

	make,
	make_anonymous,
	make_abstract

feature {NONE}

	make (a_name: STRING)
		require
			a_name_not_void: a_name /= Void
		do
			make_internal
			name := a_name
		ensure
			not_is_abstract: not is_abstract
		end

	make_anonymous (a_declarator: EWG_C_PHASE_1_DECLARATOR)
		do
			make_internal
			declarator := a_declarator
		ensure
			is_abstract_when_a_declarator_is_abstract: a_declarator.is_abstract = is_abstract
		end

	make_abstract
		do
			make_internal
		ensure
			is_abstract: is_abstract
		end

	make_internal
		do
			create arrays.make
		end

feature

	add_array_last (a_array: EWG_C_PHASE_1_ARRAY)
		do
			arrays.put_last (a_array)
		end

	set_name (a_name: STRING)
		do
			name := a_name
		end

	set_declarator (a_declarator: EWG_C_PHASE_1_DECLARATOR)
		do
			declarator := a_declarator
		end

	set_parameters (a_value: like parameters)
		require
			-- TODO: doesn't seem to work always
--			parameters_is_void: parameters = Void
			a_declarations_not_void: a_value /= Void
		do
			parameters := a_value
		end

feature

	arrays: DS_LINKED_LIST [EWG_C_PHASE_1_ARRAY]
			-- zero or more

	arrays_indirect: DS_LINKED_LIST [EWG_C_PHASE_1_ARRAY]
			-- arrays from this direct declarator and (possibly recursivly nested)
			-- direct declarators
		do
			Result := arrays.twin
			if attached declarator as l_declarator then
				Result.extend_last (l_declarator.arrays_indirect)
			end
		ensure
			result_not_void: Result /= Void
		end

	pointers_indirect: DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]
			-- pointers from this direct declarator and (possibly recursivly nested)
			-- direct declarators
		do
			if attached declarator as l_declarator then
				Result := l_declarator.pointers_indirect
			else
				create Result.make
			end
		ensure
			result_not_void: Result /= Void
		end


	parameters: detachable EWG_C_PHASE_1_PARAMETER_TYPE_LIST
			-- zero or more
			-- TODO: invariant: every parameter declaration must only contain
			-- one declarator

	name: detachable STRING
			-- can be Void

	declarator: detachable EWG_C_PHASE_1_DECLARATOR
			-- can be Void

	is_abstract: BOOLEAN
			-- Direct abstract declarators have no name.
			-- NOTE: A direct declarator is also abstract if it has a
			-- parameter which has an abstract declarator
		do
			Result := name = Void and
							(declarator = Void or else attached declarator as l_declarator and then l_declarator.is_abstract)
		end

	has_abstract_parameter_declaration: BOOLEAN
		require
			parameters_not_void: parameters /= Void
		local
			cs: DS_LINKED_LIST_CURSOR [EWG_C_PHASE_1_DECLARATION]
		do
			if attached parameters as l_parameters then
				from
					cs := l_parameters.parameter_list.new_cursor
					cs.start
				until
					cs.off
				loop
					if cs.item.has_abstract_declarator then
						Result := True
						cs.go_after
					else
						cs.forth
					end
				end
			end
		end

	is_function_direct_declarator: BOOLEAN
			-- Does this direct declarator represent a function ?
		do
			Result := parameters /= Void
		end

	calling_convention: INTEGER
		do
			if has_calling_convention_set then
				Result := calling_convention_internal
			elseif attached declarator as l_declarator then
				Result := l_declarator.direct_declarator.calling_convention
			else
				Result := calling_convention_internal
			end
		end

	set_calling_convention (a_value: INTEGER)
			-- Sets the calling conventions used for this function type.
			-- See `calling_convention' for details.
		require
			a_value_is_valid_calling_convention: is_valid_calling_convention_constant (a_value)
-- TODO: The following assertion is not always true: "typedef void (__cdecl *foo3)(void);"
--			is_function_direct_declarator: is_function_direct_declarator
		do
			calling_convention_internal := a_value
			has_calling_convention_set := True
		ensure
			calling_convention_set: calling_convention_internal = a_value
		end

	set_calling_convention_from_attribute_sequence (a_list: DS_LINKED_LIST[INTEGER])
		require
			a_list_not_void: a_list /= Void
			a_list_not_empty: not a_list.is_empty
-- TODO: The following assertion is not always true: "typedef void (__cdecl *foo3)(void);"
--			is_function_direct_declarator: is_function_direct_declarator
		local
			cs: DS_LINKED_LIST_CURSOR [INTEGER]
		do
			from
				cs := a_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if (cs.item = cl_attribute_cdecl) then
					set_calling_convention (cdecl)
				elseif (cs.item = cl_attribute_stdcall) then
					set_calling_convention (stdcall)
				elseif (cs.item = cl_attribute_fastcall) then
					set_calling_convention (fastcall)
				end
				cs.forth
			end
		end

feature

	nested_name: detachable STRING
			-- Name of `Current' or (if `name = Void')
			-- name of nested declarator
		require
			not_abstract: not is_abstract
		do
			if attached name as l_name then
				Result := l_name
			elseif attached declarator as l_declarator then
				Result := l_declarator.name
			end
		end

feature

	make_concrete (a_name: STRING)
			-- Give the direct (abstract) declarator a (pseudo) name.
		require
			is_abstract: is_abstract
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			if attached declarator as l_declarator then
				l_declarator.make_concrete (a_name)
			else
				name := a_name
			end
		ensure
			not_abstract: not is_abstract
		end

feature {NONE} -- Implementation

	calling_convention_internal: INTEGER
			-- If this function is a function direct declarator then
			-- `calling_convention' indicates the calling convention
			-- for the resulting function type.
			-- See C_AST_CALLING_CONVENTION_CONSTANTS for details.

	has_calling_convention_set: BOOLEAN

feature

	c_code: STRING
		local
			array_cs: DS_LINEAR_CURSOR [EWG_C_PHASE_1_ARRAY]
			param_cs: DS_LINEAR_CURSOR [EWG_C_PHASE_1_DECLARATION]
		do
			create Result.make (10)
			if attached name as l_name then
				Result.append_string (l_name)
			end
			if attached declarator as l_declarator then
				Result.append_string (l_declarator.c_code)
			end

			from
				array_cs := arrays.new_cursor
				array_cs.start
			until
				array_cs.off
			loop
				Result.append_character ('[')
				if array_cs.item.is_size_defined then
					Result.append_string (array_cs.item.size)
				end
				Result.append_character (']')
				array_cs.forth
			end

			if attached parameters as l_parameters then
				from
					param_cs := l_parameters.parameter_list.new_cursor
					param_cs.start
				until
					param_cs.off
				loop
					-- TODO: parameters.c_code not yet implemented
					-- Result.append_string (param_cs.item.c_code)
					param_cs.forth
				end
			end
		ensure
			result_not_void: Result /= Void
		end


invariant

	arrays_not_void: arrays /= Void
	function_implies_no_arrays: is_function_direct_declarator implies arrays.count = 0
	arrays_implies_no_function: arrays.count > 0 implies parameters = Void
	function_implies_no_void_parameter: is_function_direct_declarator implies parameters /= Void
	not_name_and_declarator_non_void: not (name /= Void and declarator /= Void)
			-- Doesn't seem to hold for "int i[sizeof (int*)];"
	calling_convention_valid_when_is_function: is_function_direct_declarator implies is_valid_calling_convention_constant (calling_convention)

end
