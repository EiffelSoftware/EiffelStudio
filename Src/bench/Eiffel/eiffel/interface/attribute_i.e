class ATTRIBUTE_I 

inherit

	FEATURE_I
		rename
			transfer_to as basic_transfer_to,
			process_pattern as basic_process_pattern
		redefine
			new_rout_unit, melt, access, generate, new_rout_id,
			in_pass3, is_none_attribute, set_type, type, is_attribute,
			unselected, has_poly_unit, undefinable, to_generate_in,
			generation_class_id
		end;
	FEATURE_I
		redefine
			transfer_to, process_pattern, unselected,
			new_rout_unit, melt, access, generate, new_rout_id,
			in_pass3, is_none_attribute, set_type, type, is_attribute,
			has_poly_unit, undefinable, to_generate_in, generation_class_id
		select
			transfer_to, process_pattern
		end;
	SHARED_DECLARATIONS;
	BYTE_CONST

feature 

	type: TYPE;
			-- Attribute type

	has_function_origin: BOOLEAN;
			-- Flag for detecting a redefinition of a function into an
			-- attribute. This flag is set by routine `process' of
			-- class FEATURE_TABLE and will be useful for generating a
			-- access function of this attribute in the C file associated
			-- to the class where this attribute is available.

	generate_in: INTEGER;
			-- Class id where an equivalent feature has to be generate

	set_has_function_origin (b: BOOLEAN) is
			-- Assign `b' to `has_function_origin'.
		do
			has_function_origin := b;
		end;

	set_generate_in (i: INTEGER) is
			-- Assign `i' to `generate_in'.
		do
			generate_in := i
		end;

	is_attribute: BOOLEAN is
			-- is the feature an attribute ?
		do
			Result := True;
		end;

	is_none_attribute: BOOLEAN is
			-- Has the attribute a NONE type ?
		do
			Result := type.actual_type.is_none;
		end;

	has_poly_unit: BOOLEAN is
			-- Has the attribute an associated polymorphic unit ?
		do
			Result := not is_none_attribute
		end;

	new_rout_unit: ROUT_UNIT is
			-- New routine unit
		require else
			has_to_be_generated: generate_in > 0
		do
			!!Result;
			Result.set_body_index (body_index);
			Result.set_type (type.actual_type);
			Result.set_written_in (generate_in);
			Result.set_pattern_id (pattern_id);
		end;

	undefinable: BOOLEAN is
			-- Is an attribute undefinable ?
		do
			-- Do nothing
		end;

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			type := t
		end;

	in_pass3: BOOLEAN is
			-- Does an attribute support the type check ?
		do
			-- Do nothing
		end;

	new_rout_id: INTEGER is
			-- New routine id for attribute
		do
			Result := - Routine_id_counter.next;
		end;

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := a_class.id = generate_in
		end;

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			attribute_b: ATTRIBUTE_B;
		do
			!!attribute_b;
			attribute_b.init (Current);
			attribute_b.set_type (access_type);
			Result := attribute_b;
		end;

	generate (class_type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generate feature written in `class_type' in `file'.
		do
			if (not is_none_attribute) and then used then
				-- Generation of a routine to access the attribute
				generate_attribute_access (class_type, file);
			end;
		end;

	generate_attribute_access (class_type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generates attribute access function.
			-- [Redecalaration of a function into an attribute]
		local
			result_type: TYPE_I;
			gen_type: GEN_TYPE_I;
			table_name, internal_name: STRING;
			skeleton: SKELETON;
			table: POLY_TABLE [ENTRY];
			rout_id: INTEGER;
		do
			skeleton := class_type.skeleton;
			result_type := type.actual_type.type_i;
			if result_type.has_formal then
				gen_type ?= class_type.type;
				result_type := result_type.instantiation_in
														(gen_type);
			end;
			result_type.c_type.generate (file);
			internal_name := Encoder.feature_name
											(class_type.id, body_id);
			file.putstring (internal_name);
			file.putstring ("(Current)");
			file.new_line;
			file.putstring ("char *Current;");
			file.new_line;
			file.putchar ('{');
			file.new_line;
			file.indent;
			file.putstring ("return *");
			result_type.c_type.generate_access_cast (file);
			file.putstring ("(Current + ");
			if byte_context.final_mode then
				rout_id := - rout_id_set.first;
				table := Eiffel_table.item_id (rout_id);
				if table.is_polymorphic (class_type.type_id) then
					table_name := Encoder.table_name (rout_id).twin;
					file.putchar ('(');
					file.putstring (table_name);
					file.putchar ('-');
					file.putint (table.min_type_id - 1);
					file.putstring (")[Dtype(Current)]");
						-- Mark attribute offset table used.
					Eiffel_table.mark_used (rout_id);
						-- Remember external attribute offset declaration
					Extern_declarations.add_attribute_table (table_name);
				else
					skeleton.generate_offset (file, feature_id);
				end;
			else
				file.putstring ("RTWA(");
				file.putint (class_type.id - 1);
				file.putchar (',');
				file.putint (feature_id);
				file.putstring (", Dtype(Current))");
			end;		
			file.putstring(");");
			file.new_line;
			file.exdent;
			file.putchar('}');
			file.new_line;
			file.new_line;

		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_ATTRIBUTE_I;
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected attribute
		local
			s: D_ATTRIBUTE_I
		do
			!!s;
			transfer_to (s);
			s.set_access_in (in);
			Result := s;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			basic_transfer_to (other);
			other.set_type (type);
			other.set_has_function_origin (has_function_origin);
			other.set_generate_in (generate_in);
		end;

	generation_class_id: INTEGER is
			-- Id of the class where the feature has to be generated in
		do
			if generate_in > 0 then
				Result := generate_in
			else
				Result := written_in
			end;
		end;

	process_pattern is
			-- Process pattern
		do
			if not is_none_attribute then
				basic_process_pattern;
			end;
		end;

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Melt an attribute
		local
			melted_feature: MELT_FEATURE;
			ba: BYTE_ARRAY;
			result_type: TYPE_I;
			static_type: INTEGER;
			current_type: CL_TYPE_I;
		do
			ba := Byte_array;
			ba.clear;
	
				-- Start	
			ba.append (Bc_start);
				-- Routine id
			ba.append_integer (- rout_id_set.first);
				-- Meta-type of Result
			result_type := byte_context.real_type (type.actual_type.type_i);
			ba.append_integer (result_type.sk_value);
				-- Argument count
			ba.append_short_integer (0);
				-- Once mark
			ba.append ('%U');
				-- Local count
			ba.append_short_integer (0);
				-- No argument clone
			ba.append (Bc_no_clone_arg);
				-- Feature name
			ba.append_raw_string (feature_name);
				-- Type where the feature is written in
			current_type := byte_context.current_type;
			static_type := current_type.type_id - 1;
			ba.append_short_integer (static_type);
				-- No rescue
			ba.append ('%U');
				-- Access to attribute; Result := <attribute access>
			ba.append (Bc_current);
			ba.append (Bc_attribute);
				-- Feature id
			ba.append_integer (feature_id);
				-- Static type
			ba.append_short_integer (current_type.associated_class_type.id - 1);
				-- Attribute meta-type
			ba.append_uint32_integer (result_type.sk_value);
			ba.append (Bc_rassign);
			
				-- End mark
			ba.append (Bc_null);
				
			melted_feature := ba.melted_feature;
			melted_feature.set_body_id (dispatch.real_body_id);
			M_feature_server.put (melted_feature);

			Dispatch_table.mark_melted (dispatch);
			Execution_table.mark_melted (exec);
		end;

end
