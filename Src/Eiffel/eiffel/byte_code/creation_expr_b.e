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
			allocates_memory,
			analyze,
			generate,
			get_register,
			enlarged,
			has_call,
--			, inlined_byte_code
			is_simple_expr,
			is_single,
			is_type_fixed,
			line_number,
			parameters,
			pre_inlined_code,
			propagate,
			register,
			set_line_number,
			size,
			unanalyze
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

feature -- Register

	register: REGISTRABLE
			-- Where the temporary result is stored

	get_register
			-- Get a register
		do
			if register = Void then
				create {REGISTER} register.make (Reference_c_type)
			end
		end

	propagate (r: REGISTRABLE)
			-- <Precursor>
		local
			t: TYPE_A
		do
			if not context.propagated then
				t := real_type (type)
				if
					register = Void and then
					(r.is_predefined and then not context.has_rescue or else not attached call) and then
					t.c_type.same_class_type (r.c_type) and then
					(r.is_result implies not context.current_feature.is_once)
				then
					register := r
					Context.set_propagated
				elseif attached call as c and then not t.is_basic then
					c.propagate (r)
				end
			end
		end

feature -- C code generation

	enlarged: CREATION_EXPR_B
			-- Enlarge current_node
		local
			l_type: CL_TYPE_A
			has_creation_call: BOOLEAN
		do
			create Result
			Result.set_is_active (is_active)
			Result.set_info (info)
			Result.set_type (type)
			if attached call as creation_call then
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
						has_creation_call := True
					elseif not l_type.base_class.feature_of_rout_id (creation_call.routine_id).is_empty then
						has_creation_call := True
						creation_call.set_precursor_type (l_type)
					elseif is_simple_special_creation then
							-- We cannot optimize the empty routine `{SPECIAL}.make' as otherwise
							-- it will simply generate a normal creation in `generate' below.
						has_creation_call := True
					end
				else
					has_creation_call := True
				end
				if
					has_creation_call and then
					attached {ROUTINE_B} creation_call.enlarged_on (context.real_type (type)) as c
				then
					Result.set_call (c)
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
			elseif not attached register then
				create {REGISTER} register.make (l_type.c_type)
			end
			if system.is_scoop and then l_type.is_separate then
					-- Mark current because separate calls use Current to compute client processor ID.
				context.mark_current_used
					-- Inform the context that there is a separate call.
				context.set_has_separate_call
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
			register := Void
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

	is_active: BOOLEAN
			-- Shall an active region be created if the creation type is separate?

	is_creation_instruction: BOOLEAN
			-- Is expression used to model creation instruction?

feature -- Access

	parameters: BYTE_LIST [PARAMETER_B]
			-- <Precursor>
		do
			if call /= Void then
				Result := call.parameters
			end
		end

	info: CREATE_INFO
			-- Creation info for creation the right type

	call: ROUTINE_B
			-- Call after creation expression: can be Void.

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
		do
			Result := attached {CREATION_EXPR_B} other
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
			l_is_make_filled: BOOLEAN
			l_generate_call: BOOLEAN
			l_is_separate: BOOLEAN
			p: PARAMETER_B
		do
			buf := buffer
			generate_line_info

			t := real_type (type)
			l_is_separate := system.is_scoop and then t.is_separate

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
				if attached {SPECIAL_CLASS_TYPE} type.associated_class_type (context.context_class_type.type) as l_class_type then
					if attached call as l_call then
						p := l_call.parameters.first
						p.generate
						if l_is_make_filled then
							p := l_call.parameters [2]
							p.generate
						end
					end
					info.generate_start (buf)
					info.generate_gen_type_conversion (0)
					if attached {PARAMETER_BL} p as parameter then
						l_class_type.generate_creation (buf, info, register, parameter, l_is_make_filled, is_special_make_empty, True)
					end
					info.generate_end (buf)
					l_generate_call := l_is_make_filled
				else
					check
						is_special_class_type: False
					end
				end
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

			if l_is_separate then
					-- Attach new object to a new region.
				buf.put_new_line
				buf.put_string (if is_active then "RTS_PA (" else "RTS_PP (" end)
				register.print_register
				buf.put_two_character (')', ';')
			end

			if l_generate_call and then attached call as c then
				c.set_parent (nested_b)
				if not l_is_make_filled then
					c.generate_parameters (register)
				end
					-- Call a creation procedure (or a creation function for a once class).
				c.generate_call (l_is_separate, l_is_separate and is_active, True,
					if attached t.base_class as b and then b.is_once then register else Void end, register)
				c.set_parent (Void)
				generate_frozen_debugger_hook_nested
			end
		end

feature -- Inlining

	size: INTEGER
			-- <Precursor>
		do
				-- Inline if creation type is known at compile time.
			Result :=
				if
					info.is_explicit implies
					system.is_scoop and then type.is_separate
				then
						-- The type depends on the context or the call is separate: no inlining.
					{LACE_I}.inlining_threshold
				elseif attached call as c then
						-- Non-separate call on a fixed type.
					c.size + 1
				else
						-- Creation with a fixed type.
					1
				end
		end

--	inlined_byte_code: like Current
--		local
--			l_type: like type
--		do
--			Result := Current
--			if attached call as l_call then
--				l_type := real_type (type)
--				if
--					not l_type.is_basic and then
--					l_type.is_explicit and then
--					not is_simple_special_creation and then
--					(system.is_scoop implies not l_type.is_separate)
--				then
--					l_call.set_parent (nested_b)
--					l_call.set_register (register)
--					l_call.set_call_kind (call_kind_creation)
--					if attached {ROUTINE_B} l_call.inlined_byte_code as r then
--						call := r
--					end
--					l_call.set_parent (Void)
--				end
--			end
--		end

	pre_inlined_code: CALL_B
		do
			Result := Current
			if attached call as c and then attached c.parameters as p then
					-- Update paramaters.
				c.set_parameters (p.pre_inlined_code)
			end
		end

feature {BYTE_NODE_VISITOR} -- Assertion support

	is_special_call_valid: BOOLEAN
			-- Is current creation call a call to SPECIAL.make_filled if `for_make_filled', otherwise to SPECIAL.make?
		do
			Result :=
				attached call as c and then
				attached c.parameters as p and then
				p.count = if is_special_make_filled then 2 else 1 end
		ensure
			is_special_call_valid: Result implies
				(attached call as c and then
				attached c.parameters as p and then
				p.count = if is_special_make_filled then 2 else 1 end)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end
