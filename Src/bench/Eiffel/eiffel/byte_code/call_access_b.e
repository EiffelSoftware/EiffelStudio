-- Eiffel Call and Access

deferred class CALL_ACCESS_B 

inherit

	ACCESS_B
		redefine
			make_byte_code, make_creation_byte_code
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

	rout_id: ROUTINE_ID is
			-- Routine ID for the access (used in final mode generation)
		local
			class_type: CL_TYPE_I
		do
			class_type ?= context_type
			Result := class_type.base_class.feature_table.item
				(feature_name).rout_id_set.first
		ensure
			routine_id_not_void: Result /= Void
		end

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
		deferred
		end

	standard_make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a feature call. If not `flag', generate
			-- an invariant check before the call.
			-- if `meta', metamorphose the feature call.
			-- Doesn't process the parameters
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
			r_id: ROUTINE_ID
			rout_info: ROUT_INFO
		do
			inst_cont_type := context_type
			metamorphosed := inst_cont_type.is_basic 
							and then not inst_cont_type.is_bit
			if metamorphosed then
				if is_feature_special then
					make_special_byte_code (ba)
				else
					basic_type ?= inst_cont_type
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
						origin := rout_info.origin.id
						offset := rout_info.offset
						make_end_precomp_byte_code (ba, flag, origin, offset)
					else
						real_feat_id := feat_tbl.item (feature_name).feature_id
						static_type := basic_type.associated_reference.id.id - 1
						make_end_byte_code (ba, flag, real_feat_id, static_type)
					end
				end
			else
				cl_type ?= inst_cont_type
				if cl_type.is_expanded then
						-- Feature `type_id' of CL_TYPE_I needs the
						-- the attribute `expanded' to be False
					cl_type := clone (cl_type)
					cl_type.set_is_expanded (False)
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
					origin := rout_info.origin.id
					offset := rout_info.offset
					make_end_precomp_byte_code (ba, flag, origin, offset)
				else
					static_type := cl_type.associated_class_type.id.id - 1
					real_feat_id := feature_id
					make_end_byte_code (ba, flag, real_feat_id, static_type)
				end
			end
		end

	make_end_byte_code (ba: BYTE_ARRAY; flag: BOOLEAN; 
					real_feat_id: INTEGER; static_type: INTEGER) is
			-- Make final portion of the standard byte code.
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
		do
			-- Nothing by default.
		end

	make_special_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for special calls.
			-- (To be redefined in FEATURE_B).
		do
			-- Do nothing
		end

	make_java_typecode (ba: BYTE_ARRAY) is
			-- Add the sk_value of the type of this
			-- call (true return type).
		local
			res_type_a: TYPE_A
			res_type_i: TYPE_I
			res_cname: STRING
			f: FEATURE_I
			ftype: FORMAL_A
		do
			if System.java_generation and then type /= Void then

				f := context_type.type_a.associated_class.feature_table.item (feature_name)

				res_type_i := Context.real_type (type)
				res_type_a := res_type_i.type_a

				if f /= Void then
				   ftype ?= f.type
				end

				if ftype /= Void then
					ba.append (Bc_java_rtype)

					-- Output the name of the feature.
					-- NOTE: May be removed later (for
					--	   debugging purposes only)

					ba.append_raw_string (feature_name)
					ba.append_uint32_integer (res_type_i.sk_value)

					if res_type_a /= Void and then
								res_type_a.has_associated_class then
						res_cname := res_type_a.associated_class.name
					end

					-- NOTE:
					-- The name of the type is also provided for
					-- debugging purposes. Will be removed soon.

					if res_cname /= Void then
						ba.append_raw_string (res_cname)
					else
						ba.append_raw_string ("-no type-")
					end
				end
			else
				-- Nothing: we're not generating Java byte-code.
			end
		end

	real_feature_id: INTEGER is
			-- The feature ID in INTEGER is not necessarily the same as
			-- in the INTEGER_REF class. And likewise for other simple types.
		local
			associated_class: CLASS_C
			feat_tbl: FEATURE_TABLE
			instant_context_type: TYPE_I
			basic_type: BASIC_I
			static_type: INTEGER
		do
			Result := feature_id
			instant_context_type := context_type
			if 	instant_context_type.is_basic
				and then
				not instant_context_type.is_bit
			then
				basic_type ?= instant_context_type
				static_type := basic_type.associated_dtype
					-- Process the feature id of `feature_name' in the
					-- associated reference type
				associated_class :=
							basic_type.associated_reference.associated_class
				feat_tbl := associated_class.feature_table
				Result := feat_tbl.item (feature_name).feature_id
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
			-- Generate access on `reg' in a `typ' context
		do
		end

	generate_special_feature (reg: REGISTRABLE) is
			-- Generate code for special routines (is_equal, copy ...).
			-- (Only for feature calls)
		do
		end

	is_feature_special: BOOLEAN is
			-- Is feature a special routine 
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
			f: INDENT_FILE
		do
			type_i := context_type
				-- Special provision is made for calls on basic types
				-- (they have to be themselves known by the compiler).
			if type_i.is_basic then
				if is_feature_special and not type_i.is_bit then
					generate_special_feature (reg)
				else
					f := generated_file
						-- Generation of metamorphosis is enclosed between (), and
						-- the expressions are separated with ',' which means the C
						-- keeps only the last expression, i.e. the function call.
						-- That way, statements like "s := i.out" are correctly
						-- generated with a minimum of temporaries.
					basic_type ?= type_i
					class_type := basic_type.associated_reference.type
						-- If an invariant is to be checked however, the
						-- metamorphosis was already made by the invariant
						-- checking routine.
					f.putchar ('(')
					basic_type.metamorphose (basic_register, reg,
									f, context.workbench_mode)
					f.putchar (',')
					f.new_line
					f.putchar ('%T')
					generate_metamorphose_end (basic_register, reg,
									class_type, basic_type, f)
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
		local
			f: INDENT_FILE
		do
			generate_access_on_type (gen_reg, class_type)
				-- Now generate the parameters of the call, if needed.
			if not is_class_separate then
				if not is_attribute then
					f := generated_file
					f.putchar ('(')
				end
				if is_feature_call then
					gen_reg.print_register
				end
				if parameters /= Void then
					generate_parameters_list
				end
				if not is_attribute then
					f.putchar (')')
				end
			end
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_I;
		basic_type: BASIC_I; file: INDENT_FILE) is
			-- Generate final portion of C code.
		local
			is_class_separate: BOOLEAN
		do
			is_class_separate := class_type.is_separate

			generate_end (gen_reg, class_type, is_class_separate)

				-- Now generate the parameters of the call, if needed.
			if not is_class_separate then
				file.putstring (");")
				file.new_line
				basic_type.end_of_metamorphose (basic_register, meta_reg, file)
			end
		end

end
