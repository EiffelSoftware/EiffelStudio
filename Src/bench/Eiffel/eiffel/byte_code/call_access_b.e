-- Eiffel Call and Access

deferred class CALL_ACCESS_B 

inherit

	ACCESS_B
		redefine
			make_byte_code, make_creation_byte_code
		end;
	
feature

	feature_id: INTEGER is
			-- Feature id of the called feature
		deferred
		end;

	feature_name: STRING is
			-- Feature name called
		deferred
		end;

	rout_id: INTEGER is
			-- Routine ID for the access (used in final mode generation)
		local
			class_type: CL_TYPE_I;
		do
			class_type ?= context_type;
			Result := class_type.base_class.feature_table.item
				(feature_name).rout_id_set.first;
			if Result < 0 then
				Result := -Result;
			end;
		ensure
			positive_routine_id: Result > 0;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a feature call
		do
			make_code (ba, False);
		end;

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate call as a creation procedure
		do
			make_code (ba, True);
		end;

	require_metamorphosis (con_type: TYPE_I): BOOLEAN is
			-- Does `con_type' require metamorphosis?
		do
			Result := con_type.is_basic
					and then not con_type.is_bit;
			
		end;

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a feature call. 
			-- If not `flag', generate
			-- an invariant check before the call.
			-- Doesn't process the parameters
		deferred
		end;

	standard_make_code (ba: BYTE_ARRAY; flag: BOOLEAN; 
				meta: BOOLEAN; instant_context_type: TYPE_I) is
			-- Generate byte code for a feature call. If not `flag', generate
			-- an invariant check before the call.
			-- if `meta', metamorphose the feature call.
			-- Doesn't process the parameters
		local
			basic_type: BASIC_I;
			cl_type: CL_TYPE_I;
			static_type: INTEGER;
			real_feat_id: INTEGER;
			associated_class: CLASS_C;
			feat_tbl: FEATURE_TABLE;
		do
			real_feat_id := feature_id;
			if meta then
				basic_type ?= instant_context_type;
				static_type := basic_type.associated_dtype;
					-- Process the feature id of `feature_name' in the
					-- associated reference type
				associated_class :=
							basic_type.associated_reference.associated_class;
				feat_tbl := associated_class.feature_table;
				real_feat_id := feat_tbl.item (feature_name).feature_id;
			else
				cl_type ?= instant_context_type;
				if cl_type.is_expanded then
						-- Feature `type_id' of CL_TYPE_I needs the
						-- the attribute `expanded' to be False
					cl_type := clone (cl_type);
					cl_type.set_is_expanded (False);
				end;
				static_type := cl_type.associated_class_type.id - 1;
			end;
			if is_first then
				ba.append (Bc_current);
			else
				if parameters /= Void then
					ba.append (Bc_rotate);
					ba.append_short_integer (parameters.count + 1);
				end;
				if meta then
					ba.append (Bc_metamorphose);
					ba.append_short_integer (static_type);
					static_type := basic_type.associated_reference.id - 1;
				end;
			end;
			if is_first or flag then
				ba.append (code_first);
			else
				ba.append (code_next);
					-- Generate feature name for test of void reference
				ba.append_raw_string (feature_name);
			end;
				-- Generate feature id
			ba.append_integer (real_feat_id);
			ba.append_short_integer (static_type);
		end;

	real_feature_id: INTEGER is
			-- The feature ID in INTEGER is not necessarily the same as
			-- in the INTEGER_REF class. And likewise for other simple types.
		local
			associated_class: CLASS_C;
			feat_tbl: FEATURE_TABLE;
			instant_context_type: TYPE_I;
			basic_type: BASIC_I;
			static_type: INTEGER;
		do
			Result := feature_id;
			instant_context_type := context_type;
			if 	instant_context_type.is_basic
				and then
				not instant_context_type.is_bit
			then
				basic_type ?= instant_context_type;
				static_type := basic_type.associated_dtype;
					-- Process the feature id of `feature_name' in the
					-- associated reference type
				associated_class :=
							basic_type.associated_reference.associated_class;
				feat_tbl := associated_class.feature_table;
				Result := feat_tbl.item (feature_name).feature_id;
			end;
		end;

	code_first: CHARACTER is
			-- Byte code when call is first (no invariant)
		deferred
		end;

	code_next: CHARACTER is
			-- Byte code when call is nested (invariant)
		deferred
		end;

	basic_register: REGISTRABLE is
			-- Register used to store the metamorphosed simple type
		do
		end;

	is_feature_call: BOOLEAN is
			-- Is access a feature call?
		do
		end;

	generate_metamorphose (reg: REGISTRABLE) is
			-- Generate the metamorphosis of simple type as a statement if
			-- needed.
		local
			basic_type: BASIC_I;
			type_i: TYPE_I;
		do
			type_i := context_type;
			if type_i.is_basic then
				basic_type ?= type_i;
				basic_type.metamorphose
					(basic_register, reg, generated_file, context.workbench_mode);
				generated_file.putchar (';');
				generated_file.new_line;
			end;
		end;

	release_hector_protection is
			-- Only for externals
		do
		end;

	generate_parameters_list is
			-- Only for routines and externals
		do
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate access on `reg' in a `typ' context
		do
		end;

	generate_special_feature (reg: REGISTRABLE) is
            -- Generate code for special routines (is_equal, copy ...).
			-- (Only for feature calls);
		do
		end;

	is_feature_special: BOOLEAN is
			-- Is feature a special routine 
			-- (Only for feature calls);
		do
		end;

	do_generate (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		require
			valid_register: reg /= Void
		local
			type_i: TYPE_I;
			class_type: CL_TYPE_I;
			basic_type: BASIC_I;
		do
			type_i := context_type;
				-- Special provision is made for calls on basic types
				-- (they have to be themselves known by the compiler).
			if type_i.is_basic then
				if is_feature_special and not type_i.is_bit then
					generate_special_feature (reg);
				else
					-- Generation of metamorphosis is enclosed between (), and
					-- the expressions are separated with ',' which means the C
					-- keeps only the last expression, i.e. the function call.
					-- That way, statements like "s := i.out" are correctly
					-- generated with a minimum of temporaries.
					basic_type ?= type_i;
					class_type := basic_type.associated_reference.type;
						-- If an invariant is to be checked however, the
						-- metamorphosis was already made by the invariant
						-- checking routine.
					generated_file.putchar ('(');
					basic_type.metamorphose
						(basic_register, reg, generated_file, context.workbench_mode);
					generated_file.putchar (',');
					generated_file.new_line;
					generated_file.putchar ('%T');
					generate_end (basic_register, class_type, True);
				end
			else
				class_type ?= type_i;	-- Cannot fail
				generate_end (reg, class_type, False);
			end;
		end;

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; meta: BOOLEAN) is
			-- Generate final portion of C code.
		do
			generate_access_on_type (gen_reg, class_type);
				-- Now generate the parameters of the call, if needed.
			if not is_attribute then
				generated_file.putchar ('(');
			end;
			if is_feature_call then
				gen_reg.print_register;
			end;
			if parameters /= Void then
				generate_parameters_list;
			end;
			if not is_attribute then
				generated_file.putchar (')');
			end;
			if meta then
					-- Close parenthesis opened by metamorphosis code
				generated_file.putchar (')');
			end;
			release_hector_protection;
		end;

end
