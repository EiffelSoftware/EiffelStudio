-- Eiffel Call and Access

deferred class CALL_ACCESS_B 

inherit

	ACCESS_B
		redefine
			make_byte_code, make_creation_byte_code, generate_il
		end

feature

	feature_id: INTEGER is
			-- Feature id of the called feature
		deferred
		end

	feature_name: STRING is
			-- Feature name called
		deferred
		end

	routine_id: INTEGER
			-- Routine ID for the access (used in final mode generation)

	written_in: INTEGER
			-- Class ID where Current is written.

	precursor_type : CL_TYPE_I
			-- Type of parent in a precursor call if any.

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

feature -- IL code generation

	generate_il is
			-- Generate IL code for feature call.
		do
			generate_il_call (False)
		end

	generate_il_call (invariant_checked: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `invariant_checked' generates invariant check
			-- before call.
		require
			il_generation: System.il_generation
		deferred
		end

	need_real_metamorphose (a_type: CL_TYPE_I): BOOLEAN is
			-- Does call originate from a reference type?
		require
			a_type_not_void: a_type /= Void
			a_type_has_associated_class: a_type.associated_class_type.associated_class /= Void
		local
			class_c: CLASS_C
		do
			class_c := a_type.associated_class_type.associated_class
			Result := written_in /= class_c.class_id
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a feature call
		do
			make_code (ba, False)
		end

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate call as a creation procedure
		do
			make_code (ba, True)
		end

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a feature call. 
			-- If not `flag', generate
			-- an invariant check before the call.
			-- Doesn't process the parameters
		require
			ba_not_void: ba /= Void
		deferred
		end

	standard_make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a feature call. If not `flag', generate
			-- an invariant check before the call.
			-- if `meta', metamorphose the feature call.
			-- Doesn't process the parameters
		require
			ba_not_void: ba /= Void
		local
			basic_type: BASIC_I
			cl_type: CL_TYPE_I
			static_type: INTEGER
			real_feat_id: INTEGER
			associated_class: CLASS_C
			feat_tbl: FEATURE_TABLE
			inst_cont_type: TYPE_I
			metamorphosed: BOOLEAN
			origin, offset: INTEGER
			r_id: INTEGER
			rout_info: ROUT_INFO
		do
			inst_cont_type := context_type
			metamorphosed := inst_cont_type.is_basic 
							and then not inst_cont_type.is_bit
			if metamorphosed then
				basic_type ?= inst_cont_type
				if is_feature_special (False, basic_type) then
					make_special_byte_code (ba, basic_type)
				else
						-- Process the feature id of `feature_name' in the
						-- associated reference type
					associated_class :=
								basic_type.associated_reference.associated_class
					feat_tbl := associated_class.feature_table
debug ("BYTE_CODE")
io.error.putstring ("Associated class: ")
io.error.putstring (associated_class.name)
io.error.putstring (", feature name: ")
io.error.putstring (feature_name)
io.error.putstring ("%NFEATURE_TABLE: ")
feat_tbl.trace
io.error.new_line
end
					if parameters /= Void then
						ba.append (Bc_rotate)
						ba.append_short_integer (parameters.count + 1)
					end
					ba.append (Bc_metamorphose)
					if associated_class.is_precompiled then
						r_id := feat_tbl.item (feature_name).rout_id_set.first
						rout_info := System.rout_info_table.item (r_id)
						origin := rout_info.origin
						offset := rout_info.offset
						make_end_precomp_byte_code (ba, flag, origin, offset)
					else
						real_feat_id := feat_tbl.item (feature_name).feature_id
						static_type := basic_type.associated_reference.static_type_id - 1
						make_end_byte_code (ba, flag, real_feat_id, static_type)
					end
				end
			else
				cl_type ?= inst_cont_type
				if cl_type.is_true_expanded then
						-- Feature `type_id' of CL_TYPE_I needs the
						-- the attribute `expanded' to be False
					cl_type := clone (cl_type)
					cl_type.set_is_true_expanded (False)
				end
				if is_first then 
						--! Cannot melt basic calls hence is_first
						--! is not used in the above if meta statement.
					ba.append (Bc_current)
				else
					if parameters /= Void then
						ba.append (Bc_rotate)
						ba.append_short_integer (parameters.count + 1)
					end
				end
				associated_class := cl_type.base_class
				if associated_class.is_precompiled then
					r_id := associated_class.feature_table.item
						(feature_name).rout_id_set.first
					rout_info := System.rout_info_table.item (r_id)
					origin := rout_info.origin
					offset := rout_info.offset
					make_end_precomp_byte_code (ba, flag, origin, offset)
				else
					static_type := cl_type.associated_class_type.static_type_id - 1
					real_feat_id := real_feature_id
					make_end_byte_code (ba, flag, real_feat_id, static_type)
				end
			end
		end

	make_end_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN; 
					real_feat_id: INTEGER; static_type: INTEGER) is
			-- Make final portion of the standard byte code.
		require
			ba_not_void: ba /= Void
		do
			if 	is_first or flag then
				ba.append (code_first)
			else
				ba.append (code_next)
					-- Generate feature name for test of void reference
				ba.append_raw_string (feature_name)
			end
				-- Generate feature id
			ba.append_integer (real_feat_id)
			ba.append_short_integer (static_type)
			make_precursor_byte_code (ba)
		end

	make_end_precomp_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN; 
					origin: INTEGER; offset: INTEGER) is
			-- Make final portion of the standard byte code
			-- for a precompiled call.
		require
			ba_not_void: ba /= Void
		do
			if 	is_first or flag then
				ba.append (precomp_code_first)
			else
				ba.append (precomp_code_next)
					-- Generate feature name for test of void reference
				ba.append_raw_string (feature_name)
			end
			ba.append_integer (origin)
			ba.append_integer (offset)
			make_precursor_byte_code (ba)
		end

	make_precursor_byte_code (ba: BYTE_ARRAY) is
			-- Add dynamic type of parent, if necessary.
		require
			ba_not_void: ba /= Void
		do
			-- Nothing by default.
		end

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Make byte code for special calls.
			-- (To be redefined in FEATURE_B).
		require
			ba_not_void: ba /= Void
			basic_type_not_void: basic_type /= Void
		do
			-- Do nothing
		end

	real_feature_id: INTEGER is
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
			Result := feature_id
			instant_context_type := context_type
			if
				instant_context_type.is_basic
				and then not instant_context_type.is_bit
			then
					-- We perform a non-optimized call on a basic type
				basic_type ?= instant_context_type
					-- Process the feature id of `feature_name' in the
					-- associated reference type
				associated_class := basic_type.associated_reference.associated_class
				feat_tbl := associated_class.feature_table
				Result := feat_tbl.item (feature_name).feature_id
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
					associated_class := cl_type.associated_class_type.associated_class
					feat_tbl := associated_class.feature_table
					Result := feat_tbl.item (feature_name).feature_id
				end
			end
		end

	code_first: CHARACTER is
			-- Byte code when call is first (no invariant)
		deferred
		end

	code_next: CHARACTER is
			-- Byte code when call is nested (invariant)
		deferred
		end

	precomp_code_first: CHARACTER is
			-- Byte code when precompiled call is first (no invariant)
		deferred
		end

	precomp_code_next: CHARACTER is
			-- Byte code when precompiled call is nested (invariant)
		deferred
		end

	basic_register: REGISTRABLE is
			-- Register used to store the metamorphosed simple type
		do
		end

	is_feature_call: BOOLEAN is
			-- Is access a feature call?
		do
		end

	release_hector_protection is
			-- Only for externals
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
			if type_i.is_basic then
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
					class_type := basic_type.associated_reference.type
						-- If an invariant is to be checked however, the
						-- metamorphosis was already made by the invariant
						-- checking routine.
					buf.putchar ('(')
					basic_type.metamorphose (basic_register, reg,
									buf, context.workbench_mode)
					buf.putchar (',')
					buf.new_line
					buf.putchar ('%T')
					generate_metamorphose_end (basic_register, reg,
									class_type, basic_type, buf)
					release_hector_protection
				end
			else
				class_type ?= type_i;	-- Cannot fail
				generate_end (reg, class_type, class_type.is_separate)
				release_hector_protection
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; is_class_separate: BOOLEAN) is
			-- Generate final portion of C code.
		require
			gen_reg_not_void: gen_reg /= Void
			class_type_not_void: class_type /= Void
		local
			buf: GENERATION_BUFFER
		do
			generate_access_on_type (gen_reg, class_type)
				-- Now generate the parameters of the call, if needed.
			if not is_class_separate then
				if not is_attribute then
					buf := buffer
					buf.putchar ('(')
				end
				if is_feature_call then
					gen_reg.print_register
				end
				if parameters /= Void then
					generate_parameters_list
				end
				if not is_attribute then
					buf.putchar (')')
				end
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
		local
			is_class_separate: BOOLEAN
		do
			is_class_separate := class_type.is_separate

			generate_end (gen_reg, class_type, is_class_separate)

				-- Now generate the parameters of the call, if needed.
			if not is_class_separate then
				buf.putstring (");")
				buf.new_line
				basic_type.end_of_metamorphose (basic_register, meta_reg, buf)
			end
		end

end
