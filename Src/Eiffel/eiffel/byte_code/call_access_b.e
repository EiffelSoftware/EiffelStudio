note
	description: "Eiffel Call and Access"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	version: "$Revision$"

deferred class
	CALL_ACCESS_B

inherit
	ACCESS_B
		redefine
			enlarged,
			enlarged_on,
			generate_parameters,
			generate_separate_call
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_DECLARATIONS

	DEBUG_OUTPUT
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Access

	feature_id: INTEGER
			-- Feature id of the called feature.

	feature_name_id: INTEGER
			-- Feature name ID of called feature.

	routine_id: INTEGER
			-- Routine ID for the access (used in final mode generation)

	written_in: INTEGER
			-- Class ID where Current is written.

	precursor_type : TYPE_A
			-- Type of parent in a precursor call if any.

	enlarged: CALL_ACCESS_B
			-- Redefined only for changing the return type.
		do
			Result := Current
		end

	enlarged_on (type_i: TYPE_A): CALL_ACCESS_B
			-- Enlarged byte node evaluated in the context of `type_i'.
			-- Redefined because we want to change the return type.
		do
				-- Fallback to default implementation.
			Result := enlarged
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	feature_name: STRING
			-- Feature name called
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

feature -- Setting

	set_precursor_type (p_type : like precursor_type)
			-- Assign `p_type' to `precursor_type'.
		require
			p_type_not_void: p_type /= Void
			not_attribute: not is_attribute
		do
			precursor_type := p_type
		ensure
			precursor_set : precursor_type = p_type
		end

feature -- Byte code generation

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_A)
			-- Make byte code for special calls.
		do
			special_routines.make_byte_code (ba, basic_type)
		end

	real_feature_id (a_context_type: CL_TYPE_A): INTEGER
			-- The feature ID in INTEGER is not necessarily the same as
			-- in the INTEGER_REF class. And likewise for other simple types.
			-- But also for generic derivation which contains an expanded type
			-- as a generic parameter.
		require
			a_context_type_not_void: a_context_type /= Void
			a_context_type_has_class: a_context_type.has_associated_class
		local
			gen: GEN_TYPE_A
		do
			if precursor_type = Void then
				if a_context_type.is_basic and then not a_context_type.is_bit then
						-- We perform a non-optimized call on a basic type.
						-- Process the feature id of `feature_name' in the
						-- associated reference type
					Result := a_context_type.reference_type.associated_class.feature_of_name_id (feature_name_id).feature_id
				else
						-- A generic parameter of current class has been derived
						-- into an expanded type, so we need to find the `feature_id'
						-- of the feature we want to call in the context of the
						-- expanded class.
						-- FIXME: Manu 01/24/2000
						-- We do the search even for a generic class which do not
						-- have a generic parameter who has been derived into an expanded type
						-- We could maybe find a way for not performing the check in the
						-- above case.
					gen ?= context.current_type
					if gen /= Void and then a_context_type.is_true_expanded then
						Result := a_context_type.associated_class.feature_of_rout_id (routine_id).feature_id
					end
				end
			end
				-- No feature ID was computed, so let's compute it.
			if Result = 0 then
				if context.current_type.class_id = a_context_type.class_id then
						-- Code is processed in the context where it is written
					Result := feature_id
				else
						-- Code is processed in the context different from the one where it is written
					Result := a_context_type.associated_class.feature_of_rout_id (routine_id).feature_id
				end
			end
		end

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type
		do
		end

	is_feature_call: BOOLEAN
			-- Is access a feature call?
		do
		end

	generate_parameters_list
			-- Only for routines and externals
		do
		end

	generate_parameters (reg: REGISTRABLE)
			-- Generate code for parameters computation.
			-- `reg' ("Current") is not used except for
			-- inlining
		local
			type_i: TYPE_A
			class_type: CL_TYPE_A
			basic_type: BASIC_A
			buf: GENERATION_BUFFER
		do
			Precursor (reg)
			type_i := context_type
				-- Special provision is made for calls on basic types
				-- (they have to be themselves known by the compiler).
				-- Note: Manu 08/08/2002: if `precursor_type' is not Void, it can only means
				-- that we are currently performing a static access call on a feature
				-- from a basic class. Assuming otherwise is not correct as you
				-- cannot seriously inherit from a basic class.
			if type_i.is_basic and then precursor_type = Void then
				basic_type ?= type_i
				if basic_type.is_bit or else not is_feature_special (True, basic_type) then
					buf := buffer
					class_type := basic_type.reference_type
						-- If an invariant is to be checked however, the
						-- metamorphosis was already made by the invariant
						-- checking routine.
					basic_type.metamorphose (basic_register, reg, buf)
					buf.put_character (';')
					buf.put_new_line
				end
			end
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate access on `reg' in a `typ' context\
		require
			reg_not_void: reg /= Void
			typ_not_void: typ /= Void
		do
		end

	generate_workbench_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A; result_register: REGISTER)
			-- Generate feature call in a `typ' context
			-- in workbench mode.
		require
			result_register_attached: c_type.is_reference implies result_register /= Void
		local
			buf: GENERATION_BUFFER
			return_type: TYPE_C
		do
			buf := buffer
			return_type := c_type
			if not return_type.is_void then
				buf.put_two_character ('(', '(')
				if return_type.is_reference then
					context.print_argument_register (result_register, buf)
					buf.put_string (" = ")
				end
			end
			buf.put_character ('(')
			return_type.generate_function_cast (buf, argument_types, True)
			generate_workbench_address (reg, typ)
			buf.put_character (')')
		end

	generate_workbench_address (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate workbench address of a routine that is called on `reg' of type `typ'.
		require
			reg_attached: attached reg
			typ_attached: attached typ
		do
			generate_call_macro (routine_macro, reg, typ, Void, Void)
		end

	generate_workbench_end (result_register: REGISTER)
			-- Generate final portion of C code in workbench mode.
		require
			result_register_attached: c_type.is_reference implies result_register /= Void
		local
			buf: GENERATION_BUFFER
		do
			if not c_type.is_void then
					-- This is a query. The result value may need conversion.
				buf := buffer
				buf.put_character (')')
				generate_return_value_conversion (result_register)
				buf.put_character (')')
			end
		end

	special_routines: SPECIAL_FEATURES
			-- Array containing special routines.
		once
			create Result
		end

	generate_special_feature (reg: REGISTRABLE; basic_type: BASIC_A)
			-- Generate code for special routines (is_equal, copy ...).
			-- (Only for feature calls)
		require
			reg_not_void: reg /= Void
			basic_type_not_void: basic_type /= Void
		do
			special_routines.generate (buffer, basic_type, reg, parameters)
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN
			-- Is feature a special routine of class of `target_type'?
			-- (Only for feature calls)
		do
		end

	do_generate (reg: REGISTRABLE)
			-- Generate call of feature on `reg'
		require
			valid_register: reg /= Void
		local
			type_i: TYPE_A
			class_type: CL_TYPE_A
			basic_type: BASIC_A
			buf: GENERATION_BUFFER
		do
			type_i := context_type
				-- Special provision is made for calls on basic types
				-- (they have to be themselves known by the compiler).
				-- Note: Manu 08/08/2002: if `precursor_type' is not Void, it can only means
				-- that we are currently performing a static access call on a feature
				-- from a basic class. Assuming otherwise is not correct as you
				-- cannot seriously inherit from a basic class.
			if type_i.is_basic and then precursor_type = Void then
				basic_type ?= type_i
				if not basic_type.is_bit and then is_feature_special (True, basic_type) then
					generate_special_feature (reg, basic_type)
				else
					buf := buffer
						-- Generation of metamorphosis is enclosed between (), and
						-- the expressions are separated with ',' which means the C
						-- keeps only the last expression, i.e. the function call.
						-- That way, statements like "s := i.out" are correctly
						-- generated with a minimum of temporaries.
					class_type := basic_type.reference_type
						-- If an invariant is to be checked however, the
						-- metamorphosis was already made by the invariant
						-- checking routine.
					generate_metamorphose_end (basic_register, reg,
									class_type, basic_type, buf)
				end
			else
				check attached {CL_TYPE_A} type_i as c then
					class_type := c
				end
					-- Use regular class rather than separate one that is handled differently.
				if class_type.is_separate then
					class_type := class_type.as_non_separate
				end
				generate_end (reg, class_type)
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		require
			gen_reg_not_void: gen_reg /= Void
			class_type_not_void: class_type /= Void
		local
			buf: GENERATION_BUFFER
		do
			generate_access_on_type (gen_reg, class_type)
				-- Now generate the parameters of the call, if needed.
			if not is_attribute then
				buf := buffer
				buf.put_character ('(')
			end
			if is_feature_call then
				gen_reg.print_register
			end
			if parameters /= Void then
				generate_parameters_list
			end
			if not is_attribute then
				buf.put_character (')')
			end
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_A;
		basic_type: BASIC_A; buf: GENERATION_BUFFER)
			-- Generate final portion of C code.
		require
			gen_reg_not_void: gen_reg /= Void
			meta_reg_not_void: meta_reg /= Void
			class_type_not_void: class_type /= Void
			basic_type_not_void: basic_type /= Void
			buf_not_void: buf /= Void
		local
			l_target_type: TYPE_A
			l_return_type: TYPE_A
		do
				-- Compute the actual return type and the type of the function being called.
			l_target_type := real_type (type)
			l_return_type := class_type.associated_class.feature_of_rout_id (routine_id).type
			if
				not l_target_type.is_void and then l_target_type.is_expanded and then
				not l_target_type.is_bit and then
				(l_return_type.is_reference or l_return_type.is_like_current)
			then
					-- Result of a basic type is expected.
				buffer.put_character ('*')
				basic_type.c_type.generate_access_cast (buf)
			end
			generate_end (basic_register, class_type)
		end

feature {NONE} -- C code generation

	generate_return_value_conversion (result_register: REGISTER)
			-- Generate conversion of return value to match the expected return type.
		require
			result_register_attached: c_type.is_reference implies attached result_register
			return_type_not_void: not c_type.is_void
		local
			buf: GENERATION_BUFFER
			return_type: TYPE_C
			l_context: like context
		do
			buf := buffer
			return_type := c_type
			l_context := context
			if return_type.is_reference then
					-- Return value might be unboxed.
					-- It should be boxed now.
					-- The type of the result register has to be preserved.
				check
					result_register_attached: attached result_register -- From precondition.
				end
				buf.put_string (", ((")
				l_context.print_argument_register (result_register, buf)
				buf.put_string (".type == SK_REF)? (EIF_REFERENCE) 0: (")
				l_context.print_argument_register (result_register, buf)
				buf.put_character ('.')
				return_type.generate_typed_field (buf)
				buf.put_string (" = RTBU(")
				l_context.print_argument_register (result_register, buf)
				buf.put_string ("))), (")
				l_context.print_argument_register (result_register, buf)
				buf.put_string (".type = SK_POINTER), ")
				l_context.print_argument_register (result_register, buf)
				buf.put_character ('.')
				return_type.generate_typed_field (buf)
			else
					-- Return value should be of an expected basic type.
					-- It can be used as it is.
				buf.put_character ('.')
				return_type.generate_typed_field (buf)
			end
		end

	generate_call_macro (m: like routine_macro; t: REGISTRABLE; c: CL_TYPE_A; s, r: detachable REGISTER)
			-- Generate a call macro identified by `m' to a feature
			-- assuming that `t' contains a target of a call of type `c',
			-- `s' contains arguments (if requires), `r' contains a result (if required).
		require
			m_attached: attached m
			t_attached: attached t
			c_attached: attached c
		local
			is_nested: BOOLEAN
			rout_info: ROUT_INFO
			buf: GENERATION_BUFFER
			cl_type_i: CL_TYPE_A
			l_type: TYPE_A
			macro: TUPLE [normal, precompiled: STRING]
		do
			is_nested := not is_first
			buf := buffer
			if attached precursor_type as p then
				l_type := context.real_type (p)
				if l_type.is_multi_constrained then
					check
						has_multi_constraint_static: has_multi_constraint_static
					end
					l_type := context.real_type (multi_constraint_static)
				end
				check attached {CL_TYPE_A} l_type as ct then
					cl_type_i := ct
				end
			else
				cl_type_i := c
			end
			if is_nested then
				inspect call_kind
				when call_kind_creation then
					macro := m.creation_call
				when call_kind_qualified then
					macro := m.qualified_call
				else
					macro := m.unqualified_call
				end
			else
				macro := m.unqualified_call
			end
			if compilation_modes.is_precompiling or else
				cl_type_i.associated_class.is_precompiled
			then
					-- Call to a precompiled routine.
				buf.put_string (macro.precompiled)
				buf.put_character ('(')
				rout_info := System.rout_info_table.item (routine_id)
				buf.put_class_id (rout_info.origin)
				buf.put_two_character (',', ' ')
				buf.put_integer (rout_info.offset)
			else
					-- Call to a non-precompiled routine.
				buf.put_string (macro.normal)
				buf.put_character ('(')
				buf.put_static_type_id (cl_type_i.static_type_id (Context.context_class_type.type))
				buf.put_two_character (',', ' ')
				buf.put_integer (real_feature_id (cl_type_i))
			end
			buf.put_two_character (',', ' ')
			if not is_nested then
				if precursor_type /= Void then
						-- Use dynamic type of parent instead
						-- of dynamic type of Current.
					buf.put_static_type_id (cl_type_i.static_type_id (context.context_class_type.type))
				else
					context.generate_current_dtype
				end
			elseif call_kind = call_kind_qualified then
					-- Feature name is used to report a call on a void target.
					-- This cannot happen with unqualified call or a creation procedure call.
				buf.put_string_literal (feature_name)
				buf.put_two_character (',', ' ')
				t.print_register
			else
				buf.put_string ({C_CONST}.dtype);
				buf.put_character ('(')
				t.print_register
				buf.put_character (')')
			end
			if attached s then
					-- Add arguments of a call.
				buf.put_two_character (',', ' ')
				s.print_register
			end
			if attached r then
					-- Add result of call.
				buf.put_two_character (',', ' ')
				context.print_argument_register (r, buf)
			end
			buf.put_character (')')
		end

	routine_macro: TUPLE [unqualified_call, qualified_call, creation_call: TUPLE [normal, precompiled: STRING]]
			-- Macros that compute address of a routine to be called.
			-- `Result.unqualified_call' denotes an unqualified call.
			-- `Result.qualified_call' denotes a qualified call.
			-- `Result.creation_call' denotes a call to a creation procedure.
			-- `normal' denotes a call to a non-precompiled feature, `precompiled' - to a precompiled one.
		once
			Result := [["RTWF", "RTWPF"], ["RTVF", "RTVPF"], ["RTWC", "RTWPC"]]
		end

feature {NONE} -- Separate call

	separate_function_macro: TUPLE [unqualified_call, qualified_call, creation_call: TUPLE [normal, precompiled: STRING]]
			-- Name of a macro to make a call to a function depending on the kind of a call:
			-- See `routine_macro' for details.
		once
				-- There are no unqualified separate calls as well as creation function calls.
			Result := [["ERROR", "ERROR"], ["RTS_CF", "RTS_CFP"], ["ERROR", "ERROR"]]
		end

	separate_procedure_macro: TUPLE [unqualified_call, qualified_call, creation_call: TUPLE [normal, precompiled: STRING]]
			-- Name of a macro to make a call to a procedure depending on the kind of a call.
			-- See `routine_macro' for details.
		once
				-- There are no unqualified separate calls.
			Result := [["ERROR", "ERROR"], ["RTS_CP", "RTS_CPP"], ["RTS_CC", "RTS_CCP"]]
		end

	generate_separate_call_for_workbench (s: REGISTER; r: detachable REGISTRABLE; t: REGISTRABLE; result_register: REGISTER)
			-- <Precursor>
		local
			buf: like buffer
		do
			check attached {CL_TYPE_A} context_type as c then
				buf := buffer
				buf.put_new_line
				if attached r then
						-- Call to a function.
					generate_call_macro (separate_function_macro, t, c, s, result_register)
					buf.put_character (';')
					buf.put_new_line
					r.print_register
					buf.put_four_character (' ', '=', ' ', '(')
					context.print_argument_register (result_register, buf)
					generate_return_value_conversion (result_register)
					buf.put_character (')')
				else
						-- Call to a procedure.
					generate_call_macro (separate_procedure_macro, t, c, s, Void)
				end
				buf.put_character (';')
			end
		end

	generate_separate_call (s: REGISTER; r: detachable REGISTRABLE; t: REGISTRABLE)
			-- <Precursor>
		local
			buf: GENERATION_BUFFER
			array_index: INTEGER_32
			target_type: TYPE_A
			rout_table: ROUT_TABLE
			name: STRING
		do
			buf := buffer
			buf.put_new_line
			if attached r then
				buf.put_string ("RTS_CF (")
			elseif call_kind = call_kind_creation then
				buf.put_string ("RTS_CC (")
			else
				buf.put_string ("RTS_CP (")
			end
			target_type := context_type
			array_index := Eiffel_table.is_polymorphic (routine_id, target_type, Context.context_class_type, True)
			if array_index = -2 then
					-- Call to a deferred feature without implementation
				buf.put_string ("NULL")
			elseif precursor_type = Void and then array_index >= 0 then
					-- The call is polymorphic, so generate access to the
					-- routine table.
				name := Encoder.routine_table_name (routine_id)
					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buf.put_string (name)
				buf.put_character ('[')
				buf.put_string ({C_CONST}.dtype);
				buf.put_character ('(')
				t.print_register
				buf.put_two_character (')', '-')
				buf.put_integer (array_index)
				buf.put_character (']')
					-- Mark routine id used
				Eiffel_table.mark_used (routine_id)
					-- Remember extern declaration
				Extern_declarations.add_routine_table (name)
			else
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired, unless we access a
					-- deferred feature in which case we have to be careful
					-- and get the routine name of the first entry in the
					-- routine table.
				rout_table ?= Eiffel_table.poly_table (routine_id)
				rout_table.goto_implemented (target_type, context.context_class_type)
				if rout_table.is_implemented then
					name := rout_table.feature_name
					if rout_table.item.access_type_id /= Context.original_class_type.type_id then
							-- Remember extern routine declaration
						Extern_declarations.add_routine_with_signature (real_type (type).c_type.c_string,
								name, argument_types)
					end
					buf.put_string (name)
				else
						-- Call to a deferred feature without implementation
					buf.put_string ("NULL")
				end
			end
			buf.put_two_character (',', ' ')
			system.separate_patterns.put (Current)
			buf.put_two_character (',', ' ')
			t.print_register
			buf.put_two_character (',', ' ')
			s.print_register
			if attached r then
				buf.put_two_character (',', ' ')
				r.print_register
			end
			buf.put_two_character (')', ';')
		end

feature {NONE} -- Debug

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			if feature_name_id > 0 then
				Result := Names_heap.item (feature_name_id)
			else
				Result := "Not yet set"
			end
		end

feature {NONE} -- Implementation

	byte_node (f: FEATURE_I; a_context_type: TYPE_A): ACCESS_B
			-- Byte node for the context feature `f' called on type `a_context_type'
		require
			f_not_void: f /= Void
		local
			p: like parent
			l_type: TYPE_A
			l_params: like parameters
			i: INTEGER
		do
			if system.il_generation then
					-- We use `False' for the qualified boolean value of `access' otherwise
					-- we get a stack overflow in test#valid120. The reason is that if we are
					-- handling a FEATURE_B which is actually an ATTRIBUTE_I, then we would be
					-- regenerating a FEATURE_B object if it was `parent /= Void' and thus in
					-- enlarged_on we would recurse.
				Result := f.access (f.type.instantiation_in (a_context_type, f.written_in), False)
				p := parent
				if p /= Void then
					Result.set_parent (p)
					if p.message = Current then
						p.set_message (Result)
					else
						check p.target = Current end
						p.set_target (Result)
					end
				end
					-- Adapt attachement type to what `f' expects.
				l_params := parameters
				if l_params /= Void then
					from
						l_params := l_params.deep_twin
						l_params.start
						i := 1
					until
						l_params.after
					loop
						l_type := f.arguments.i_th (i)
							-- Instantiate and also discard anchors are they are not needed
						l_type := l_type.instantiation_in (a_context_type, f.written_in).deep_actual_type
						l_params.item.set_attachment_type (l_type)
						l_params.forth
						i := i + 1
					end
					Result.set_parameters (l_params)
				end
			else
				Result := f.access (type, p/= Void)
				p := parent
				if p /= Void then
					Result.set_parent (p)
					if p.message = Current then
						p.set_message (Result)
					else
						check p.target = Current end
						p.set_target (Result)
					end
				end
				Result.set_parameters (parameters)
			end
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

end -- class CALL_ACCESS_B
