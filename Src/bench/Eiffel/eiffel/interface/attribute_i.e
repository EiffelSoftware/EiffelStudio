class ATTRIBUTE_I 

inherit
	ENCAPSULATED_I
		redefine
			transfer_to, process_pattern, unselected,
			new_rout_entry, melt, access, generate, new_rout_id,
			in_pass3, is_none_attribute, set_type, type, is_attribute,
			has_entry, undefinable, check_expanded
		end

	SHARED_DECLARATIONS

	SHARED_GENERATION

	BYTE_CONST

feature 

	type: TYPE
			-- Attribute type

	has_function_origin: BOOLEAN
			-- Flag for detecting a redefinition of a function into an
			-- attribute. This flag is set by routine `process' of
			-- class FEATURE_TABLE and will be useful for generating a
			-- access function of this attribute in the C file associated
			-- to the class where this attribute is available.

	set_has_function_origin (b: BOOLEAN) is
			-- Assign `b' to `has_function_origin'.
		do
			has_function_origin := b
		end

	is_attribute: BOOLEAN is True
			-- is the feature an attribute ?

	is_none_attribute: BOOLEAN is
			-- Has the attribute a NONE type ?
		do
			Result := type.actual_type.is_none
		end

	has_entry: BOOLEAN is
			-- Has the attribute an associated polymorphic unit ?
		do
			Result := not is_none_attribute
		end

	extension: EXTERNAL_EXT_I
			-- Deferred external information

	new_rout_entry: ROUT_ENTRY is
			-- New routine unit
		require else
			has_to_be_generated: generate_in > 0
		do
			!!Result
			Result.set_body_index (body_index)
			Result.set_type_a (type.actual_type)
			Result.set_written_in (generate_in)
			Result.set_pattern_id (pattern_id)
			Result.set_feature_id (feature_id)
		end

	undefinable: BOOLEAN is
			-- Is an attribute undefinable ?
		do
			-- Do nothing
		end

feature -- Element Change

	set_extension (an_extension: like extension) is
			-- Set `extension' with `an_extension'.
		require
			an_extension_not_void: an_extension /= Void
		do
			extension := an_extension
		ensure
			extension_set: extension = an_extension
		end

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	in_pass3: BOOLEAN is
			-- Does an attribute support the type check ?
		do
			-- Do nothing
		end

	new_rout_id: INTEGER is
			-- New routine id for attribute
		do
			Result := Routine_id_counter.next_attr_id
		end

	check_expanded (class_c: CLASS_C) is
			-- Check the expanded validity rules
		local
			vlec: VLEC
			solved_type: TYPE_A
		do
			Precursor {ENCAPSULATED_I} (class_c)
			if class_c.is_expanded then
				solved_type ?= type
				if
					solved_type.is_true_expanded and then
					solved_type.associated_class = class_c
				then
					create vlec
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
			external_b: EXTERNAL_B
		do
			if
				context.last_constrained_type /= Void and then
				context.last_constrained_type.is_separate
			then
				create attribute_bs
				attribute_bs.init (Current)
				attribute_bs.set_type (access_type)
				Result := attribute_bs
			else
				if extension /= Void then
					create external_b
					external_b.init (Current)
					external_b.set_type (access_type)
					external_b.set_external_name (external_name)
					external_b.set_extension (extension)
					Result := external_b
				else
					create attribute_b
					attribute_b.init (Current)
					attribute_b.set_type (access_type)
					Result := attribute_b
				end
			end
		end

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generate feature written in `class_type' in `buffer'.
		require else
			valid_file: buffer /= Void
		do
			if (not is_none_attribute) and then used then
				-- Generation of a routine to access the attribute
				generate_attribute_access (class_type, buffer)
			end
		end

	generate_attribute_access (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generates attribute access function.
			-- [Redecalaration of a function into an attribute]
		local
			result_type: TYPE_I
			gen_type: GEN_TYPE_I
			table_name, internal_name: STRING
			rout_id: INTEGER
			rout_info: ROUT_INFO
			array_index: INTEGER
		do
			generate_header (buffer)
			result_type := type.actual_type.type_i
			if result_type.has_formal then
				gen_type ?= class_type.type
				result_type := result_type.instantiation_in (gen_type)
			end
			internal_name := Encoder.feature_name (class_type.static_type_id, body_index)
			add_in_log (class_type, internal_name)

			buffer.generate_function_signature (result_type.c_type.c_string,
				internal_name, True, Byte_context.header_buffer,
				<<"Current">>, <<"EIF_REFERENCE">>)
			buffer.indent
			if not result_type.is_true_expanded and then not result_type.is_bit then
				buffer.putstring ("return *")
				result_type.c_type.generate_access_cast (buffer)
			else
					-- We do not need to generate a cast since what we are computed is
					-- already good.
				buffer.putstring ("return ")
			end
			buffer.putstring ("(Current")
			rout_id := rout_id_set.first
			if byte_context.final_mode then
				array_index := Eiffel_table.is_polymorphic (rout_id, class_type.type_id, False)
				if array_index >= 0 then
					table_name := Encoder.table_name (rout_id)
					buffer.putstring ("+ (")
					buffer.putstring (table_name)
					buffer.putchar ('-')
					buffer.putint (array_index)
					buffer.putstring (")[Dtype(Current)]")
						-- Mark attribute offset table used.
					Eiffel_table.mark_used (rout_id)
						-- Remember external attribute offset declaration
					Extern_declarations.add_attribute_table (table_name)
				else
						--| In this instruction, we put `False' as second
						--| arguments. This means we won't generate anything if there is nothing
						--| to generate. Remember that `True' is used in the generation of attributes
						--| table in Final mode.
					class_type.skeleton.generate_offset (buffer, feature_id, False)
				end
			elseif
				Compilation_modes.is_precompiling or
				class_type.associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id)
				buffer.putstring (" + RTWPA(")
				buffer.generate_class_id (rout_info.origin)
				buffer.putchar (',')
				buffer.putint (rout_info.offset)
				buffer.putstring (", Dtype(Current))")
			else
				buffer.putstring (" + RTWA(")
				buffer.putint (class_type.static_type_id - 1)
				buffer.putchar (',')
				buffer.putint (feature_id)
				buffer.putstring (", Dtype(Current))")
			end;
			buffer.putstring(");")
			buffer.exdent
			buffer.new_line
			buffer.putchar ('}')
			buffer.new_line
			buffer.new_line
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

	unselected (in: INTEGER): FEATURE_I is
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
			-- Transfer data from `Current' to `other'.
		do
			Precursor {ENCAPSULATED_I} (other)
			other.set_type (type)
			other.set_has_function_origin (has_function_origin)
			extension := other.extension
		end

	process_pattern is
			-- Process pattern
		do
			if not is_none_attribute then
				Precursor {ENCAPSULATED_I}
			end
		end

	melt (exec: EXECUTION_UNIT) is
			-- Melt an attribute
		local
			melted_feature: MELT_FEATURE
			ba: BYTE_ARRAY
			result_type: TYPE_I
			static_type: INTEGER
			current_type: CL_TYPE_I
			base_class: CLASS_C
			r_id: INTEGER
			rout_info: ROUT_INFO
		do
			ba := Byte_array
			ba.clear
	
				-- Once mark
			ba.append ('%U')
				-- Start	
			ba.append (Bc_start)
				-- Routine id
			ba.append_integer (rout_id_set.first)
				-- Real body id ( -1 because it's an attribute. We can't set a breakpoint )
			ba.append_integer (-1)
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

				-- No rescue
			ba.append ('%U')
				-- Access to attribute; Result := <attribute access>
			ba.append (Bc_current)
			base_class := current_type.base_class
			if base_class.is_precompiled then
				r_id := rout_id_set.first
				rout_info := System.rout_info_table.item (r_id)
				ba.append (Bc_pattribute)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append (Bc_attribute)
					-- Feature id
				ba.append_integer (feature_id)
					-- Static type
				ba.append_short_integer
					(current_type.associated_class_type.static_type_id - 1)
			end
				-- Attribute meta-type
			ba.append_uint32_integer (result_type.sk_value)
			ba.append (Bc_rassign)
			
				-- End mark
			ba.append (Bc_null)
				
			melted_feature := ba.melted_feature
			melted_feature.set_real_body_id (exec.real_body_id)
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

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
