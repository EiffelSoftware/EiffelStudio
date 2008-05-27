indexing
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
			generate_parameters
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	DEBUG_OUTPUT
		export
			{NONE} all
		end

feature -- Access

	feature_id: INTEGER
			-- Feature id of the called feature.

	feature_name_id: INTEGER
			-- Feature name ID of called feature.

	feature_name: STRING is
			-- Feature name called
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	routine_id: INTEGER
			-- Routine ID for the access (used in final mode generation)

	written_in: INTEGER
			-- Class ID where Current is written.

	precursor_type : TYPE_A
			-- Type of parent in a precursor call if any.

	enlarged: CALL_ACCESS_B is
			-- Redefined only for changing the return type.
		do
			Result := Current
		end

	enlarged_on (type_i: TYPE_A): CALL_ACCESS_B is
			-- Enlarged byte node evaluated in the context of `type_i'.
			-- Redefined because we want to change the return type.
		do
				-- Fallback to default implementation.
			Result := enlarged
		end

feature -- Setting

	set_precursor_type (p_type : like precursor_type) is
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

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_A) is
			-- Make byte code for special calls.
		do
		end

	real_feature_id (a_context_type: CL_TYPE_A): INTEGER is
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

	basic_register: REGISTRABLE is
			-- Register used to store the metamorphosed simple type
		do
		end

	is_feature_call: BOOLEAN is
			-- Is access a feature call?
		do
		end

	generate_parameters_list is
			-- Only for routines and externals
		do
		end

	generate_parameters (reg: REGISTRABLE) is
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

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A) is
			-- Generate access on `reg' in a `typ' context\
		require
			reg_not_void: reg /= Void
			typ_not_void: typ /= Void
		do
		end

	generate_workbench_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A; result_register: REGISTER) is
			-- Generate feature call in a `typ' context
			-- in workbench mode.
		require
			result_register_attached: c_type.is_pointer implies result_register /= Void
		local
			is_nested: BOOLEAN
			rout_info: ROUT_INFO
			buf: GENERATION_BUFFER
			cl_type_i: CL_TYPE_A
			return_type: TYPE_C
		do
			is_nested := not is_first
			buf := buffer

			if precursor_type /= Void then
				cl_type_i ?= context.real_type (precursor_type)
				check
					cl_type_i_attached: cl_type_i /= Void
				end
			else
				cl_type_i := typ
			end

			return_type := c_type
			if not return_type.is_void then
				buf.put_character ('(')
				buf.put_character ('(')
				if return_type.is_pointer then
					context.print_argument_register (result_register, buf)
					buf.put_string (" = ")
				end
			end
			buf.put_character ('(')
			return_type.generate_function_cast (buf, argument_types, True)

			if
				Compilation_modes.is_precompiling or else
				cl_type_i.associated_class.is_precompiled
			then
				if is_nested and need_invariant then
					buf.put_string ("RTVPF(")
				else
					buf.put_string ("RTWPF(")
				end
				rout_info := System.rout_info_table.item (routine_id)
				buf.put_class_id (rout_info.origin)
				buf.put_string (gc_comma)
				buf.put_integer (rout_info.offset)
			else
				if is_nested and need_invariant then
					buf.put_string ("RTVF(")
				else
					buf.put_string ("RTWF(")
				end
				buf.put_static_type_id (cl_type_i.static_type_id (context.context_class_type.type))
				buf.put_string (gc_comma)
				buf.put_integer (real_feature_id (cl_type_i))
			end
			buf.put_string (gc_comma)
			if not is_nested then
				if precursor_type /= Void then
						-- Use dynamic type of parent instead
						-- of dynamic type of Current.
					buf.put_string ("RTUD(")
					buf.put_static_type_id (cl_type_i.static_type_id (context.context_class_type.type))
					buf.put_character (')')
				else
					context.generate_current_dtype
				end
			elseif need_invariant then
				buf.put_string_literal (feature_name)
				buf.put_string (gc_comma)
				reg.print_register
			else
				buf.put_string (gc_upper_dtype_lparan)
				reg.print_register
				buf.put_character (')')
			end
			buf.put_string ("))")
		end

	generate_workbench_end (result_register: REGISTER) is
			-- Generate final portion of C code in workbench mode.
		require
			result_register_attached: c_type.is_pointer implies result_register /= Void
		local
			buf: GENERATION_BUFFER
			return_type: TYPE_C
			l_context: like context
		do
			buf := buffer
			l_context := context
			return_type := c_type
			if return_type.is_pointer then
					-- Return value might be unboxed.
					-- It should be boxed now.
					-- The type of the result register has to be preserved.
				buf.put_string ("), ((")
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
				buf.put_character (')')
			elseif not return_type.is_void then
					-- Return value should be of an expected basic type.
					-- It can be used as it is.
				buf.put_character (')')
				buf.put_character ('.')
				return_type.generate_typed_field (buf)
				buf.put_character (')')
			end
		end

	generate_special_feature (reg: REGISTRABLE; basic_type: BASIC_A) is
			-- Generate code for special routines (is_equal, copy ...).
			-- (Only for feature calls)
		require
			reg_not_void: reg /= Void
			basic_type_not_void: basic_type /= Void
		do
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN is
			-- Is feature a special routine of class of `target_type'?
			-- (Only for feature calls)
		do
		end

	do_generate (reg: REGISTRABLE) is
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
				class_type ?= type_i;	-- Cannot fail
				generate_end (reg, class_type)
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A) is
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
		basic_type: BASIC_A; buf: GENERATION_BUFFER) is
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

feature {NONE} -- Debug

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			if feature_name_id > 0 then
				Result := Names_heap.item (feature_name_id)
			else
				Result := "Not yet set"
			end
		end

feature {NONE} -- Implementation

	byte_node (f: FEATURE_I; a_context_type: TYPE_A): ACCESS_B is
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
				Result := f.access (real_type (f.type.instantiation_in (a_context_type, f.written_in)), False)
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

end -- class CALL_ACCESS_B
