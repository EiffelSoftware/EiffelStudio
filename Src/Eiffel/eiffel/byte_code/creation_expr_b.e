note
	description: "Byte code for creation expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_B

inherit
	ACCESS_B
		redefine
			analyze, unanalyze, parameters,
			generate, register, get_register, propagate,
			enlarged, size, is_simple_expr, is_single, is_type_fixed,
			line_number, set_line_number, has_call, allocates_memory
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_creation_expr_b (Current)
		end

feature -- Access

	parameters: BYTE_LIST [PARAMETER_B]
		do
			if call /= Void then
				Result := call.parameters
			end
		end

feature -- Register

	register: REGISTRABLE
			-- Where the temporary result is stored

	get_register
			-- Get a register
		do
			create {REGISTER} register.make (Reference_c_type)
		end

	count_register: REGISTER
			-- Store size of SPECIAL instance to create is stored if needed.

	propagate (r: REGISTRABLE)
			-- Do nothing
		do
		end

feature -- C code generation

	enlarged: CREATION_EXPR_B
			-- Enlarge current_node
		local
			l_type: CL_TYPE_A
		do
			create Result
			Result.set_is_active (is_active)
			Result.set_info (info)
			Result.set_type (type)
			if call /= Void then
				if context.final_mode and then info.is_explicit then
						-- Special handling of creation when type is monomorphic:
						-- 1 - if body of `call' is empty then we do not generate the call at all
						-- 2 - if not empty, we do as if it was a call to precursor.
						-- 3 - if we cannot get the type of the creation, we do it the normal way.
						-- 4 - if empty and it is {SPECIAL}.make we do the normal way.
					l_type := info.type_to_create
					if
						l_type = Void or else
						not l_type.has_associated_class or else
						l_type.base_class.assertion_level.is_invariant or else
						l_type.is_separate
					then
							-- Type is not fixed, is separate or class invariant should be checked.
							-- The latter is done inside the creation procedure.
						Result.set_call (call.enlarged_on (context.real_type (type)))
					elseif not l_type.base_class.feature_of_rout_id (call.routine_id).is_empty then
						Result.set_call (call.enlarged_on (context.real_type (type)))
						Result.call.set_precursor_type (l_type)
					elseif is_simple_special_creation then
							-- We cannot optimize the empty routine `{SPECIAL}.make' as otherwise
							-- it will simply generate a normal creation in `generate' below.
						Result.set_call (call.enlarged_on (context.real_type (type)))
					end
				else
					Result.set_call (call.enlarged_on (context.real_type (type)))
				end
			end
			Result.set_creation_instruction (is_creation_instruction)
		end

feature -- Analyze

	analyze
			-- Analyze creation node
		local
			l_type: like type
		do
			l_type := real_type (type)
			if not l_type.is_basic then
				info := info.updated_info
				info.analyze
				get_register
				if attached call as l_call then
					if is_simple_special_creation then
						check
							is_special_call_valid: is_special_call_valid
						end
						l_call.parameters.first.analyze
					else
						l_call.set_parent (nested_b)
						l_call.set_register (register)
						l_call.set_call_kind (call_kind_creation)
						l_call.analyze_on (register)
						l_call.set_parent (Void)
					end
				end
			else
				create {REGISTER} register.make (l_type.c_type)
			end
			if system.is_scoop and then real_type (type).is_separate then
					-- Allocate a register for a container that stores arguments
					-- to be passed to the scheduler.
				create separate_register.make (pointer_c_type)
					-- The register is not used right after the call.
				separate_register.free_register
					-- Mark current because separate calls use Current to compute client processor ID.
				context.mark_current_used
			end
		end

	unanalyze
			-- Unanalyze creation code
		do
			if not real_type (type).is_basic and then attached call as l_call then
				if is_simple_special_creation then
					check
						is_special_call_valid: is_special_call_valid
					end
					l_call.parameters.first.unanalyze
				else
					l_call.unanalyze
				end
			end
			separate_register := Void
		end

feature -- Status report

	has_call: BOOLEAN
			-- Does current node include a call?
		do
			Result := call /= Void
		end

	allocates_memory: BOOLEAN = True
			-- Current always allocates memory.

	is_single: BOOLEAN
			-- True if no call after inline object creation or if call
			-- `is_single'.
		do
			Result := call = Void or else call.is_single
		end

	is_simple_expr: BOOLEAN
			-- True if no call after inline object creation or if call
			-- `is_simple_expr'.
		do
			Result := call = Void or else call.is_simple_expr
		end

	is_type_fixed: BOOLEAN
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?
		do
			Result := info = Void and then type.is_standalone
		end

	is_special_creation: BOOLEAN
			-- Is Current representing a creation expression for SPECIAL?
		do
			Result := call /= Void and then
				(call.routine_id = system.special_make_filled_rout_id or
				call.routine_id = system.special_make_empty_rout_id or
				call.routine_id = system.special_make_rout_id)
		ensure
			definition: Result implies call /= Void
		end

	is_simple_special_creation: BOOLEAN
			-- Is Current representing a creation expression for SPECIAL?
		do
			Result := call /= Void and then
				(call.routine_id = system.special_make_empty_rout_id or
				call.routine_id = system.special_make_rout_id)
		ensure
			definition: Result implies call /= Void
		end

	is_special_make_filled: BOOLEAN
			-- Is Current representing a creation expression involving `make_filled' from SPECIAL?
		do
			Result := call /= Void and then call.routine_id = system.special_make_filled_rout_id
		end

	is_special_make_empty: BOOLEAN
			-- Is Current representing a creation expression involving `make_filled' from SPECIAL?
		do
			Result := call /= Void and then call.routine_id = system.special_make_empty_rout_id
		end

feature -- Access

	is_active: BOOLEAN
			-- Shall an active region be created if the creation type is separate?

	info: CREATE_INFO
			-- Creation info for creation the right type

	call: CALL_ACCESS_B
			-- Call after creation expression: can be Void.

	is_creation_instruction: BOOLEAN
			-- Is expression used to model creation instruction?

	line_number: INTEGER
			-- Line number where construct begins in the Eiffel source.

	nested_b: NESTED_BL
			-- Create a fake nested so that `call.is_first' is False.
		do
			create Result
			Result.set_target (Current)
			Result.set_message (call)
		end

feature -- Settings

	set_is_active (v: BOOLEAN)
			-- Set `is_active' to `v'.
		do
			is_active := v
		ensure
			is_active_set: is_active = v
		end

	set_info (i: like info)
			-- Assign `i' to `info'.
		require
			i_not_void: i /= Void
		do
			info := i
		ensure
			info_set: info = i
		end

	set_call (c: like call)
			-- Assign `c' to `call'. `c' maybe Void in case of call
			-- to `default_create' from ANY.
		do
			call := c
		ensure
			call_set: call = c
		end

	set_creation_instruction (v: BOOLEAN)
			-- Set `is_creation_instruction' to `v'.
		do
			is_creation_instruction := v
		ensure
			is_creation_instruction_set: is_creation_instruction = v
		end

	set_line_number (lnr : INTEGER)
			-- Assign `lnr' to `line_number'.
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

	set_type (t: like type)
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Comparisons

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		local
			creation_expr_b: CREATION_EXPR_B
		do
			creation_expr_b ?= other
			Result := creation_expr_b /= Void
		end

feature -- Type info

	type: TYPE_A
			-- Current static type of creation.

feature -- Generation

	generate
			-- Generate C code for creation expression
		local
			buf: GENERATION_BUFFER
			t: TYPE_A
			l_class_type: SPECIAL_CLASS_TYPE
			parameter: PARAMETER_BL
			l_is_make_filled: BOOLEAN
			l_generate_call: BOOLEAN
		do
			buf := buffer
			generate_line_info

			t := real_type (type)
			if attached {BASIC_A} t as l_basic_type then
				buf.put_new_line
				register.print_register
				buf.put_string (" = ")
				l_basic_type.c_type.generate_default_value (buf)
				buf.put_character (';')
			elseif is_special_creation then
				l_is_make_filled := is_special_make_filled
				check
					is_special_call_valid: is_special_call_valid
				end
				check
					is_special_type: type.has_associated_class_type (context.context_class_type.type)
				end
				l_class_type ?= type.associated_class_type (context.context_class_type.type)
				check
					l_class_type_not_void: l_class_type /= Void
				end
				if attached call as l_call then
					l_call.parameters.first.generate
					if l_is_make_filled then
						l_call.parameters.i_th (2).generate
						parameter ?= l_call.parameters.i_th (2)
					else
						parameter ?= l_call.parameters.first
					end
				end
				info.generate_start (buf)
				info.generate_gen_type_conversion (0)
				l_class_type.generate_creation (buf, info, register, parameter, l_is_make_filled, is_special_make_empty, True)
				info.generate_end (buf)
				l_generate_call := l_is_make_filled
			else
				info.generate_start (buf)
				info.generate_gen_type_conversion (0)
				buf.put_new_line
				register.print_register
				buf.put_string (" = ")
				info.generate
				buf.put_character (';')
				info.generate_end (buf)
				l_generate_call := True
			end

			if system.is_scoop and then t.is_separate then
					-- Attach new object to a new region.
				buf.put_new_line
				if is_active then
					buf.put_string ("RTS_PA (")
				else
					buf.put_string ("RTS_PP (")
				end
				register.print_register
				buf.put_two_character (')', ';')
			end

			if l_generate_call and then attached call as c then
				c.set_parent (nested_b)
				if not l_is_make_filled then
					c.generate_parameters (register)
				end
					-- Call a creation procedure
				c.generate_call (separate_register, attached separate_register, Void, register)
				c.set_parent (Void)
				generate_frozen_debugger_hook_nested
			end
		end

feature -- Inlining

	size: INTEGER
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

feature {BYTE_NODE_VISITOR} -- Assertion support

	is_special_call_valid: BOOLEAN
			-- Is current creation call a call to SPECIAL.make_filled if `for_make_filled', otherwise to SPECIAL.make?
		do
			Result := call /= Void and then call.parameters /= Void and then
				((not is_special_make_filled and call.parameters.count = 1) or (is_special_make_filled and call.parameters.count = 2))
		ensure
			is_special_call_valid: Result implies
				(call /= Void and then call.parameters /= Void and then
				((not is_special_make_filled and call.parameters.count = 1) or (is_special_make_filled and call.parameters.count = 2)))
		end

feature {NONE} -- Separate feature call

	separate_register: REGISTER;
			-- Register to store data to be passed to the scheduler

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CREATION_EXPR_B
