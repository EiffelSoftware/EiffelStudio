note
	description: "C code generation for a routine call."

deferred class ROUTINE_BL

inherit
	ROUTINE_B
		undefine
			allocates_memory,
			analyze_on,
			current_needed_for_access,
			enlarged,
			enlarged_on,
			generate_access,
			generate_access_on_type,
			generate_end,
			generate_on,
			generate_parameters_list,
			inlined_byte_code,
			is_constant_expression,
			is_external,
			is_feature,
			is_feature_call,
			is_special_feature,
			is_unsafe,
			need_target
		redefine
			analyze,
			basic_register,
			call_kind,
			free_register,
			generate_parameters,
			has_one_signature,
			is_polymorphic,
			parent,
			register,
			set_call_kind,
			set_parent,
			set_register
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Access

	parent: NESTED_BL
			-- Parent of access

	register: REGISTRABLE
			-- In which register the expression is stored

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type

	instance_free_creation: CREATION_EXPR_B
			-- An expression to initialize intance-free call.

feature -- Modification

	set_register (r: REGISTRABLE)
			-- Set current register to `r'
		do
			register := r
		end

	set_parent (p: NESTED_BL)
			-- Assign `p' to `parent'
		do
			parent := p
		end

feature {CALL_B} -- Kind of a call: status

	call_kind: INTEGER
			-- <Precursor>

feature {CALL_B} -- Kind of a call: modification

	set_call_kind (value: like call_kind)
			-- <Precursor>
		do
			call_kind := value
		end

feature -- Code generation

	analyze
			-- Build a proper context for code generation.
		do
			analyze_on (current_register)
			get_register
		end

	free_register
			-- Free registers.
		do
			if attached instance_free_creation then
				instance_free_creation.free_register
			end
			Precursor
			if basic_register /= Void then
				basic_register.free_register
			end
		end

	generate_access
			-- Generate access call of feature on `current_register` or a special register to call instance-free feature.
		do
			generate_on (current_register)
		end

	generate_on (reg: REGISTRABLE)
			-- Generate call of the feature on `reg`.
		do
				-- Reset variables
			is_right_parenthesis_needed.put (False)
			is_deferred.put (False)
			do_generate (target_register (reg))
		end

	generate_parameters (reg: REGISTRABLE)
			-- <Precursor>
			-- Prepare an instance-free target if needed.
		do
			Precursor (reg)
			if attached instance_free_creation as c then
				instance_free_creation.generate
			end
		end

feature {NONE} -- Target register

	target_register (r: REGISTRABLE): REGISTRABLE
			-- A target register of the feature call performed on the target `r`.
			-- It may be different for instance-free calls that depend on `r` indirectly.
		do
			Result := if attached instance_free_creation as c then c.register else r end
		end

	analyze_non_object_call_target
			-- Analyze non-object call target (if any), initialize associated target creation code
			-- and allocate a necessary target register.
		local
			c: like instance_free_creation
		do
			if is_class_target_needed then
					-- Generate an empty object to be used as a target of the call.
				check
					instance_free_call_has_precursor_type: attached precursor_type as p
				then
					create c
					c.set_info (p.create_info)
					c.set_type (p)
					if attached multi_constraint_static as t then
						c.set_multi_constraint_static (t)
					end
					c.analyze
					instance_free_creation := c
				end
			end
		end

	analyze_basic_type
			-- Analyze whether this is a call to a regular feature on a basic type
			-- that requires an intermediate register `basic_register` for the target,
			-- or a call to a built-in feature that does not require result register.
		do
			if attached {BASIC_A} context_type as basic_i then
				if not is_feature_special (True, basic_i) then
						-- Get a register to store the metamorphosed basic type,
						-- on which the attribute access is made. The lifetime of
						-- this temporary is really short: just the time to make the call.
					create {REGISTER} basic_register.make (Reference_c_type)
				elseif real_type (type).is_basic and then not attached register then
						-- Do not use a temporary register for built-in features of basic type.
					set_register (no_register)
				end
			end
		end

feature {NONE} -- Code generation

	generate_nested_flag (has_target: BOOLEAN)
			-- Setup a flag that indicates whether a subsequent call is nested,
			-- so that class invariant should be checked on the target that is present if `has_target` is set.
			-- Update `is_right_parenthesis_needed` if the flag is generated and has to be closed after the call.
		require
			is_final_mode: context.final_mode
			is_right_parenthesis_unneeded: not is_right_parenthesis_needed.item
		local
			buf: like buffer
		do
			if system.keep_assertions then
				is_right_parenthesis_needed.put (True)
				buf := buffer
				buf.put_string ("(nstcall = ")
				buf.put_integer (if not is_first and has_target or else call_kind = call_kind_creation then call_kind else 0 end)
				buf.put_two_character (',', ' ')
			end
		end

	generate_no_call
			-- Generate code for the case when there is no suitable routine to call.
			-- This may happen for calls on void target.
		require
			is_final_mode: context.final_mode
			is_effective: not is_deferred.item
		local
			buf: like buffer
			l_type_c: TYPE_C
		do
			buf := buffer
			buf.put_string ({C_CONST}.open_rtna_open)
			buf.put_string ("NULL))")
			l_type_c := real_type (type).c_type
			if not l_type_c.is_void then
				buf.put_two_character (',', ' ')
				l_type_c.generate_default_value (buf)
			end
			buf.put_character (')')
			is_deferred.put (True)
		ensure
			is_deferred: is_deferred.item
		end

feature -- Optimization

	is_polymorphic: BOOLEAN
			-- Is access polymorphic?
		local
			type_i: TYPE_A
		do
			type_i := context_type
			if
				not type_i.is_basic and then
				not attached precursor_type
			then
				Result := Eiffel_table.is_polymorphic_for_body (routine_id, type_i, context.original_class_type) >= 0
			end
		end

	has_one_signature: BOOLEAN
			-- <Precursor>
		do
			Result := Eiffel_table.poly_table (routine_id).has_one_signature
		end

feature {NONE} -- Access

	is_deferred: CELL [BOOLEAN]
			-- Is current feature call a deferred feature without implementation?
			-- This may happen even when there is an implementation, but no suitable object is ever created.
		once
			create Result.put (False)
		ensure
			is_deferred_not_void: Result /= Void
		end

	is_right_parenthesis_needed: CELL [BOOLEAN]
			-- Does current call require to close a parenthesis?
			-- Case when one use `nstcall' or `eif_optimize_return'.
		once
			create Result.put (False)
		ensure
			is_right_parenthesis_needed_attached: attached Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
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
