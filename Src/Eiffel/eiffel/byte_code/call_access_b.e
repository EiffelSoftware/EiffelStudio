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
			enlarged_on
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

	precursor_type : CL_TYPE_I
			-- Type of parent in a precursor call if any.

	enlarged: CALL_ACCESS_B is
			-- Redefined only for type check
		do
			Result := Current
		end

	enlarged_on (type_i: TYPE_I): CALL_ACCESS_B is
			-- Enlarged byte node evaluated in the context of `type_i'.
		do
				-- Fallback to default implementation.
			Result := enlarged
		end

feature -- Setting

	set_precursor_type (p_type : CL_TYPE_I) is
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

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Make byte code for special calls.
		do
		end

	real_feature_id (context_class: CLASS_C): INTEGER is
			-- The feature ID in INTEGER is not necessarily the same as
			-- in the INTEGER_REF class. And likewise for other simple types.
			-- But also for generic derivation which contains an expanded type
			-- as a generic parameter.
		local
			associated_class: CLASS_C
			feat_tbl: FEATURE_TABLE
			instant_context_type: TYPE_I
			basic_type: BASIC_I
			cl_type: CL_TYPE_I
			gen: GEN_TYPE_I
		do
			if context.is_written_context then
					-- Code is processed in the context where it is written
				Result := feature_id
			else
					-- Code is processed in the context different from the one where it is written
				Result := context_class.feature_of_rout_id (routine_id).feature_id
			end
			if precursor_type = Void then
				instant_context_type := context_type
				if
					instant_context_type.is_basic
					and then not instant_context_type.is_bit
				then
						-- We perform a non-optimized call on a basic type
					basic_type ?= instant_context_type
						-- Process the feature id of `feature_name' in the
						-- associated reference type
					associated_class := basic_type.reference_type.base_class
					feat_tbl := associated_class.feature_table
					Result := feat_tbl.item_id (feature_name_id).feature_id
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
					if gen /= Void and then instant_context_type.is_true_expanded then
						cl_type ?= instant_context_type
						associated_class := cl_type.base_class
						feat_tbl := associated_class.feature_table
						Result := feat_tbl.item_id (feature_name_id).feature_id
					end
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

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate access on `reg' in a `typ' context\
		require
			reg_not_void: reg /= Void
			typ_not_void: typ /= Void
		do
		end

	generate_special_feature (reg: REGISTRABLE; basic_type: BASIC_I) is
			-- Generate code for special routines (is_equal, copy ...).
			-- (Only for feature calls)
		require
			reg_not_void: reg /= Void
			basic_type_not_void: basic_type /= Void
		do
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_I): BOOLEAN is
			-- Is feature a special routine of class of `target_type'?
			-- (Only for feature calls)
		do
		end

	do_generate (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		require
			valid_register: reg /= Void
		local
			type_i: TYPE_I
			class_type: CL_TYPE_I
			basic_type: BASIC_I
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
					buf.put_character ('(')
					basic_type.metamorphose (basic_register, reg,
									buf, context.workbench_mode)
					buf.put_character (',')
					buf.put_new_line
					buf.put_character ('%T')
					generate_metamorphose_end (basic_register, reg,
									class_type, basic_type, buf)
				end
			else
				class_type ?= type_i;	-- Cannot fail
				generate_end (reg, class_type)
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I) is
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

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_I;
		basic_type: BASIC_I; buf: GENERATION_BUFFER) is
			-- Generate final portion of C code.
		require
			gen_reg_not_void: gen_reg /= Void
			meta_reg_not_void: meta_reg /= Void
			basic_type_not_void: basic_type /= Void
			buf_not_void: buf /= Void
		do
			generate_end (gen_reg, class_type)

				-- Now generate the parameters of the call, if needed.
			buf.put_string (");")
			buf.put_new_line
			basic_type.end_of_metamorphose (basic_register, meta_reg, buf)
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

	byte_node (f: FEATURE_I): ACCESS_B is
			-- Byte node for the context feature `f'
		require
			f_not_void: f /= Void
		local
			p: like parent
		do
			Result := f.access (real_type (type))
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
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
