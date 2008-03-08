indexing
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
			analyze, unanalyze,
			generate, register, get_register,
			enlarged, size, is_simple_expr, is_single, is_type_fixed,
			line_number, set_line_number, has_call, allocates_memory
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_creation_expr_b (Current)
		end

feature -- Register

	register: REGISTRABLE
			-- Where the temporary result is stored

	get_register is
			-- Get a register
		do
			create {REGISTER} register.make (Reference_c_type)
		end

	count_register: REGISTER
			-- Store size of SPECIAL instance to create is stored if needed.

feature -- C code generation

	enlarged: CREATION_EXPR_B is
			-- Enlarge current_node
		local
			l_type: CL_TYPE_A
		do
			create Result
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
					if l_type = Void then
						Result.set_call (call.enlarged_on (context.real_type (type)))
					elseif not l_type.associated_class.feature_of_rout_id (call.routine_id).is_empty then
						Result.set_call (call.enlarged_on (context.real_type (type)))
						Result.call.set_precursor_type (l_type)
					elseif call.routine_id = system.special_make_rout_id then
							-- We cannot optimized the empty routine `{SPECIAL}.make' as otherwise
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

	analyze is
			-- Analyze creation node
		local
			l_call: like call
			l_type: like type
		do
			l_type := real_type (type)
			if not l_type.is_basic then
				info.analyze
				get_register
				l_call := call
				if l_call /= Void then
					if l_call.routine_id = system.special_make_rout_id then
						check
							is_special_call_valid: is_special_call_valid
						end
						l_call.parameters.first.analyze
					else
						l_call.set_parent (nested_b)
						l_call.set_register (register)
						l_call.set_need_invariant (False)
						l_call.analyze_on (register)
						l_call.set_parent (Void)
					end
				end
			else
				create {REGISTER} register.make (l_type.c_type)
			end
		end

	unanalyze is
			-- Unanalyze creation code
		local
			l_call: like call
		do
			if not real_type (type).is_basic then
				Precursor {ACCESS_B}
				l_call := call
				if l_call /= Void then
					if l_call.routine_id = system.special_make_rout_id then
						check
							is_special_call_valid: is_special_call_valid
						end
						l_call.parameters.first.unanalyze
					else
						l_call.unanalyze
					end
				end
			end
		end

feature -- Status report

	has_call: BOOLEAN is
			-- Does current node include a call?
		do
			Result := call /= Void
		end

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

	is_single: BOOLEAN is
			-- True if no call after inline object creation or if call
			-- `is_single'.
		do
			Result := call = Void or else call.is_single
		end

	is_simple_expr: BOOLEAN is
			-- True if no call after inline object creation or if call
			-- `is_simple_expr'.
		do
			Result := call = Void or else call.is_simple_expr
		end

	is_type_fixed: BOOLEAN is
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?
		do
			Result := info = Void and then type.is_standalone
		end

feature -- Access

	info: CREATE_INFO
			-- Creation info for creation the right type

	call: CALL_ACCESS_B
			-- Call after creation expression: can be Void.

	is_creation_instruction: BOOLEAN
			-- Is expression used to model creation instruction?

	line_number: INTEGER
			-- Line number where construct begins in the Eiffel source.

	nested_b: NESTED_BL is
			-- Create a fake nested so that `call.is_first' is False.
		do
			create Result
			Result.set_target (Current)
			Result.set_message (call)
		end

feature -- Settings

	set_info (i: like info) is
			-- Assign `i' to `info'.
		require
			i_not_void: i /= Void
		do
			info := i
		ensure
			info_set: info = i
		end

	set_call (c: like call) is
			-- Assign `c' to `call'. `c' maybe Void in case of call
			-- to `default_create' from ANY.
		do
			call := c
		ensure
			call_set: call = c
		end

	set_creation_instruction (v: BOOLEAN) is
			-- Set `is_creation_instruction' to `v'.
		do
			is_creation_instruction := v
		ensure
			is_creation_instruction_set: is_creation_instruction = v
		end

	set_line_number (lnr : INTEGER) is
			-- Assign `lnr' to `line_number'.
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

	set_type (t: like type) is
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Comparisons

	same (other: ACCESS_B): BOOLEAN is
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

	generate is
			-- Generate C code for creation expression
		local
			buf: GENERATION_BUFFER
			l_basic_type: BASIC_A
			l_call: like call
			l_special_creation: BOOLEAN
			l_class_type: SPECIAL_CLASS_TYPE
			parameter: PARAMETER_BL
		do
			buf := buffer
			generate_line_info

			l_basic_type ?= real_type (type)
			l_call := call
			l_special_creation := l_basic_type = Void and then
				l_call /= Void and then l_call.routine_id = system.special_make_rout_id
			if l_basic_type /= Void then
				buf.put_new_line
				register.print_register
				buf.put_string (" = ")
				l_basic_type.c_type.generate_default_value (buf)
				buf.put_character (';')
			elseif l_special_creation then
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
				l_call.parameters.first.generate
				info.generate_start (buf)
				info.generate_gen_type_conversion (0)
				parameter ?= l_call.parameters.first
				l_class_type.generate_creation (buf, info, register, parameter)
				info.generate_end (buf)
			else
				info.generate_start (buf)
				info.generate_gen_type_conversion (0)
				buf.put_new_line
				register.print_register
				buf.put_string (" = ")
				info.generate
				buf.put_character (';')
				info.generate_end (buf)

				if call /= Void then
					call.set_parent (nested_b)
					call.generate_parameters (register)
						-- We need a new line since `generate_on' doesn't do it.
					buf.put_new_line
					call.generate_on (register)
					call.set_parent (Void)
					buf.put_character (';')
					generate_frozen_debugger_hook_nested
				end
				if
					context.workbench_mode
					or else context.system.keep_assertions
				then
					buf.put_new_line
					buf.put_string ("RTCI2(")
					register.print_register
					buf.put_string (gc_rparan_semi_c)
				end
			end
		end

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- has a creation instruction
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

feature {BYTE_NODE_VISITOR} -- Assertion support

	is_special_call_valid: BOOLEAN is
			-- Is current creation call a call to SPECIAL.make?
		do
			Result := call /= Void and then call.parameters /= Void and then
				call.parameters.count = 1
		ensure
			is_special_call_valid: Result implies
				(call /= Void and then call.parameters /= Void and then
				call.parameters.count = 1)
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CREATION_EXPR_B
