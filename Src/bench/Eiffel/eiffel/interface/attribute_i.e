class ATTRIBUTE_I 

inherit
	FEATURE_I
		redefine
			transfer_to, process_pattern, unselected,
			new_rout_unit, melt, access, generate, new_rout_id,
			in_pass3, is_none_attribute, set_type, type, is_attribute,
			has_poly_unit, undefinable, to_generate_in, generation_class_id,
			to_melt_in, check_expanded
		end

	SHARED_DECLARATIONS

	BYTE_CONST

feature 

	type: TYPE_B
			-- Attribute type

	has_function_origin: BOOLEAN
			-- Flag for detecting a redefinition of a function into an
			-- attribute. This flag is set by routine `process' of
			-- class FEATURE_TABLE and will be useful for generating a
			-- access function of this attribute in the C file associated
			-- to the class where this attribute is available.

	generate_in: CLASS_ID
			-- Class id where an equivalent feature has to be generate

	set_has_function_origin (b: BOOLEAN) is
			-- Assign `b' to `has_function_origin'.
		do
			has_function_origin := b
		end

	set_generate_in (i: CLASS_ID) is
			-- Assign `i' to `generate_in'.
		do
			generate_in := i
		end

	is_attribute: BOOLEAN is True
			-- is the feature an attribute ?

	is_none_attribute: BOOLEAN is
			-- Has the attribute a NONE type ?
		do
			Result := type.actual_type.is_none
		end

	has_poly_unit: BOOLEAN is
			-- Has the attribute an associated polymorphic unit ?
		do
			Result := not is_none_attribute
		end

	new_rout_unit: ROUT_UNIT is
			-- New routine unit
		require else
			has_to_be_generated: generate_in /= Void
		do
			!!Result
			Result.set_body_index (body_index)
			Result.set_type (type.actual_type)
			Result.set_written_in (generate_in)
			Result.set_pattern_id (pattern_id)
		end

	undefinable: BOOLEAN is
			-- Is an attribute undefinable ?
		do
			-- Do nothing
		end

	set_type (t: TYPE_B) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	in_pass3: BOOLEAN is
			-- Does an attribute support the type check ?
		do
			-- Do nothing
		end

	new_rout_id: ATTRIBUTE_ID is
			-- New routine id for attribute
		do
			Result := Routine_id_counter.next_attr_id
		end

	to_melt_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := to_generate_in (a_class)
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := equal (a_class.id, generate_in)
		end

	check_expanded (class_c: CLASS_C) is
			-- Check the expanded validity rules
		local
			vlec: VLEC
			solved_type: TYPE_A
		do
			{FEATURE_I} Precursor (class_c)
			if class_c.is_expanded then
				solved_type ?= type
				if
					solved_type.is_expanded
				and then
					solved_type.associated_class = class_c
				then
					!!vlec
					vlec.set_class (solved_type.associated_class)
					vlec.set_client (class_c)
					Error_handler.insert_error (vlec)
				end
			end
		end

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			attribute_b: ATTRIBUTE_B
			attribute_bs: ATTRIBUTE_BS
		do
			if context.last_constrained_type /= Void and then context.last_constrained_type.is_separate then
				!!attribute_bs
				attribute_bs.init (Current)
				attribute_bs.set_type (access_type)
				Result := attribute_bs
			else
				!!attribute_b
				attribute_b.init (Current)
				attribute_b.set_type (access_type)
				Result := attribute_b
			end
		end

	generate (class_type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generate feature written in `class_type' in `file'.
		require else
			valid_file: file /= Void
			file_open_for_writing: file.is_open_write or file.is_open_append
		do
			if (not is_none_attribute) and then used then
				-- Generation of a routine to access the attribute
				generate_attribute_access (class_type, file)
			end
		end

	generate_attribute_access (class_type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generates attribute access function.
			-- [Redecalaration of a function into an attribute]
		local
			result_type: TYPE_I
			gen_type: GEN_TYPE_I
			table_name, internal_name: STRING
			skeleton: SKELETON
			table: POLY_TABLE [ENTRY]
			rout_id: ROUTINE_ID
			rout_info: ROUT_INFO
		do
			generate_header (file)
			skeleton := class_type.skeleton
			result_type := type.actual_type.type_i
			if result_type.has_formal then
				gen_type ?= class_type.type
				result_type := result_type.instantiation_in (gen_type)
			end
			internal_name := body_id.feature_name (class_type.id)
			add_in_log (class_type, internal_name)

			file.generate_function_signature (result_type.c_type.c_string,
				internal_name, True, Byte_context.extern_declaration_file,
				<<"Current">>, <<"EIF_REFERENCE">>)
			file.indent
			file.putstring ("return *")
			result_type.c_type.generate_access_cast (file)
			file.putstring ("(Current + ")
			rout_id := rout_id_set.first
			if byte_context.final_mode then
				table := Eiffel_table.poly_table (rout_id)
				if table.is_polymorphic (class_type.type_id) then
					table_name := rout_id.table_name
					file.putchar ('(')
					file.putstring (table_name)
					file.putchar ('-')
					file.putint (table.min_type_id - 1)
					file.putstring (")[Dtype(Current)]")
						-- Mark attribute offset table used.
					Eiffel_table.mark_used (rout_id)
						-- Remember external attribute offset declaration
					Extern_declarations.add_attribute_table (table_name)
				else
					skeleton.generate_offset (file, feature_id)
				end
			elseif
				Compilation_modes.is_precompiling or
				class_type.associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id)
				file.putstring ("RTWPA(")
				file.putstring (rout_info.origin.generated_id)
				file.putchar (',')
				file.putint (rout_info.offset)
				file.putstring (", Dtype(Current))")
			else
				file.putstring ("RTWA(")
				file.putint (class_type.id.id - 1)
				file.putchar (',')
				file.putint (feature_id)
				file.putstring (", Dtype(Current))")
			end;		
			file.putstring(");%N}%N%N")
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_ATTRIBUTE_I
		do
			!!rep
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	unselected (in: CLASS_ID): FEATURE_I is
			-- Unselected attribute
		local
			s: D_ATTRIBUTE_I
		do
			!!s
			transfer_to (s)
			s.set_access_in (in)
			Result := s
		end

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			{FEATURE_I} Precursor (other)
			other.set_type (type)
			other.set_has_function_origin (has_function_origin)
			other.set_generate_in (generate_in)
		end

	generation_class_id: CLASS_ID is
			-- Id of the class where the feature has to be generated in
		do
			if generate_in /= Void then
				Result := generate_in
			else
				Result := written_in
			end
		end

	process_pattern is
			-- Process pattern
		do
			if not is_none_attribute then
				{FEATURE_I} Precursor
			end
		end

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Melt an attribute
		local
			melted_feature: MELT_FEATURE
			ba: BYTE_ARRAY
			result_type: TYPE_I
			static_type: INTEGER
			current_type: CL_TYPE_I
			base_class: CLASS_C
			r_id: ROUTINE_ID
			rout_info: ROUT_INFO
		do
			ba := Byte_array
			ba.clear
	
				-- Once mark
			ba.append ('%U')
				-- Start	
			ba.append (Bc_start)
				-- Routine id
			ba.append_integer (rout_id_set.first.id)
				-- Meta-type of Result
			result_type := byte_context.real_type (type.actual_type.type_i)
			ba.append_integer (result_type.sk_value)
				-- Argument count
			ba.append_short_integer (0)
				-- Local count
			ba.append_short_integer (0)
				-- No argument clone
			ba.append (Bc_no_clone_arg)
				-- Feature name
			ba.append_raw_string (feature_name)
				-- Type where the feature is written in
			current_type := byte_context.current_type
			static_type := current_type.type_id - 1
			ba.append_short_integer (static_type)

			-- Put class name in file.
			-- NOTE: May be removed later.

			if System.java_generation then
				ba.append_raw_string (byte_context.current_type.associated_class_type.associated_class.name)
				-- Not a special feature
				ba.append ('%U')
			end

				-- No rescue
			ba.append ('%U')
				-- Access to attribute; Result := <attribute access>
			ba.append (Bc_current)
			base_class := current_type.base_class
			if base_class.is_precompiled then
				r_id := rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				ba.append (Bc_pattribute)
				ba.append_integer (rout_info.origin.id)
				ba.append_integer (rout_info.offset)
			else
				ba.append (Bc_attribute)
					-- Feature id
				ba.append_integer (feature_id)
					-- Static type
				ba.append_short_integer
					(current_type.associated_class_type.id.id - 1)
			end
				-- Attribute meta-type
			ba.append_uint32_integer (result_type.sk_value)
			ba.append (Bc_rassign)
			
				-- End mark
			ba.append (Bc_null)
				
			melted_feature := ba.melted_feature
			melted_feature.set_real_body_id (dispatch.real_body_id)
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Dispatch_table.mark_melted (dispatch)
			Execution_table.mark_melted (exec)
		end

feature {NONE} -- Implementation

	new_api_feature: E_ATTRIBUTE is
			-- API feature creation
		local
			t: TYPE_A
		do
			t ?= type
			if t = Void then
				t := type.actual_type
			end
			!! Result.make (feature_name, feature_id)
			Result.set_type (t)
		end

end
