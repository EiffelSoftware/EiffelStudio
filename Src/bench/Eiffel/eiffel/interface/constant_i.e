indexing
	description: "Representation of a constant"
	date: "$Date$"
	revision: "$Revision$"

class CONSTANT_I 

inherit
	ENCAPSULATED_I
		rename
			check_types as old_check_types,
			equiv as basic_equiv
		redefine
			transfer_to, access_for_feature, melt, generate,
			is_once, in_pass3, redefinable, is_constant,
			set_type, type, generate_il, to_generate_in,
			new_rout_entry
		end

	ENCAPSULATED_I
		redefine
			transfer_to, check_types, access_for_feature, equiv,
			melt, generate, is_once, in_pass3, redefinable, is_constant,
			set_type, type, generate_il, to_generate_in,
			new_rout_entry
		select
			check_types, equiv
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

	BYTE_CONST
		export
			{NONE} all
		end

create
	make
	
feature 

	type: TYPE
			-- Type of the constant

	value: VALUE_I
			-- Constant value

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	set_value (v: VALUE_I) is
			-- Assign `v' to `value'.
		require
			good_argument: v /= Void
		do
			value := v
		end

	is_constant: BOOLEAN is True
			-- Is the current feature a constant one ?

	redefinable: BOOLEAN is False
			-- Is a constant redefinable ?

	in_pass3: BOOLEAN is
			-- Does a constant support the type check ?
		do
			-- Do nothing
		end

	check_types (feat_tbl: FEATURE_TABLE) is
			-- Check Result and argument types 
		local
			actual_type	: TYPE_A
			vqmc: VQMC
		do
			Precursor {ENCAPSULATED_I} (feat_tbl)
			actual_type := type.actual_type
			if value.valid_type (actual_type) then
				value.set_real_type (actual_type)
			else
				create vqmc
				vqmc.set_class (written_class)
				vqmc.set_feature_name (feature_name)
				vqmc.set_constant_type (value)
				vqmc.set_expected_type (actual_type)
				Error_handler.insert_error (vqmc)
			end
		end

	new_rout_entry: ROUT_ENTRY is
			-- New routine unit
		require else
			has_to_be_generated: generate_in > 0
		do
			create Result
			Result.set_body_index (body_index)
			Result.set_type_a (type.actual_type)
			if
				not byte_context.workbench_mode and then generate_in /= 0
			then
				Result.set_written_in (generate_in)
			else
				Result.set_written_in (written_in)
			end
			Result.set_pattern_id (pattern_id)
			Result.set_feature_id (feature_id)
		end

feature -- Status

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has current feature in class `a_class" to be generated ?
		local
			class_id: INTEGER
			once_feat: BOOLEAN
		do
			class_id := a_class.class_id
			if
				not byte_context.workbench_mode
			then 
					-- We need to generate current constant if:
					-- 1 - `generate_in' has the same value as `class_id': in this
					--     an encapsulation is needed because `a_class' has some
					--     redefinition into a constant.
					-- 2 - current constant is not a once and needs to be generated
					--     because `a_class' has some visible features.
					-- 3 - current constant is a once written in `a_class'.
				Result := (class_id = generate_in)
				if not Result then
					once_feat := is_once
					Result := (not once_feat and then a_class.has_visible)
						or else (once_feat and then class_id = written_in)
				end
			else
				Result := class_id = written_in
			end
		end

feature -- Incrementality

	equiv (other: FEATURE_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
		local
			other_constant: like Current
		do
			other_constant ?= other
			if other_constant /= Void then
				Result := Precursor {ENCAPSULATED_I} (other_constant)
						and then value.is_propagation_equivalent (other_constant.value)
			end
		end
	
feature -- C code generation

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generate feature written in `class_type' in `buffer'.
		require else
			valid_buffer: buffer /= Void
			not_deferred: not is_deferred
			to_generate_in: to_generate_in (class_type.associated_class)
		local
			type_i: TYPE_I
			internal_name: STRING
			local_byte_context: BYTE_CONTEXT
			class_id: INTEGER
			header_buffer: GENERATION_BUFFER
			special_once_generation: BOOLEAN
		do
			if used then
				local_byte_context := byte_context
				generate_header (buffer)
				type_i := type.actual_type.type_i
				internal_name := Encoder.feature_name (class_type.static_type_id, body_index)
				add_in_log (class_type, internal_name)
					-- Generation of function's header
				buffer.generate_function_signature ( type_i.c_type.c_string,
						internal_name, True, local_byte_context.header_buffer,
						<<"Current">>, <<"EIF_REFERENCE">>)

					-- Function's body
					-- If constant is a string, it is the semantic of a once
				if is_once then
					if local_byte_context.workbench_mode or else System.has_multithreaded then
						class_id := byte_context.original_class_type.static_type_id
						buffer.putstring ("%TEIF_REFERENCE *PResult;%N%
							%%Tif (MTOG((EIF_REFERENCE *),*(EIF_once_values + EIF_oidx_off")
						buffer.putint (class_id)
						buffer.putstring (" + ")
						buffer.putint (local_byte_context.once_index)
						buffer.putstring ("),PResult)) return *PResult;")
						buffer.putstring (";%N%
							%%TPResult = (EIF_REFERENCE *) RTOC(0);%N%
							%%TMTOS(*(EIF_once_values + EIF_oidx_off")
						buffer.putint (class_id)
						buffer.putstring (" + ")
						buffer.putint (local_byte_context.once_index)
						buffer.putstring ("),PResult);%N%
							%%T*PResult = ")
						value.generate (buffer)
						buffer.putchar (';')
						buffer.new_line

						if local_byte_context.workbench_mode then
								-- Real body id to be stored in the id list of 
								-- already called once routines.
							buffer.putstring ("%TRTWO(")
							buffer.generate_real_body_id (real_body_id)
							buffer.putstring (");")
							buffer.new_line
						end
						buffer.putstring ("%Treturn *PResult")
					else
						special_once_generation := True
						header_buffer := local_byte_context.header_buffer
						header_buffer.new_line
						header_buffer.putstring ("extern EIF_REFERENCE ")
						header_buffer.putstring (internal_name)
						header_buffer.putstring ("_result;")
						header_buffer.new_line
						header_buffer.putstring ("extern EIF_BOOLEAN ")
						header_buffer.putstring (internal_name)
						header_buffer.putstring ("_done;")
						header_buffer.new_line
						header_buffer.new_line
					
						buffer.indent
						buffer.putstring ("if (")
						buffer.putstring (internal_name)
						buffer.putstring ("_done) return ")
						buffer.putstring (internal_name)
						buffer.putstring ("_result;")
						buffer.new_line
						buffer.putstring (internal_name)
						buffer.putstring ("_done = EIF_TRUE;")
						buffer.new_line
						buffer.putstring (internal_name)
						buffer.putstring ("_result = ")
						value.generate (buffer)
						buffer.putchar (';')
						buffer.new_line
						buffer.putstring ("RTOC_NEW(")
						buffer.putstring (internal_name)
						buffer.putstring ("_result);")
						buffer.new_line
						buffer.putstring ("return ")
						buffer.putstring (internal_name)
						buffer.putstring ("_result;")
						buffer.exdent
					end
				else
					buffer.indent
					buffer.putstring ("return ")
					type_i.c_type.generate_cast (buffer)
					value.generate (buffer)
					buffer.exdent
				end
				buffer.putstring (";%N}%N")
				if special_once_generation then
					buffer.new_line
					buffer.putstring ("EIF_REFERENCE ")
					buffer.putstring (internal_name)
					buffer.putstring ("_result = NULL;")
					buffer.new_line
					buffer.putstring ("EIF_BOOLEAN ")
					buffer.putstring (internal_name)
					buffer.putstring ("_done = EIF_FALSE;")
					buffer.new_line
					buffer.new_line
				end
			elseif not System.is_used (Current) then
				System.removed_log_file.add (class_type, feature_name)
			end
		end

	access_for_feature (access_type: TYPE_I; static_type: CL_TYPE_I): ACCESS_B is
			-- Byte code access for constant. Dynamic binding if
			-- `static_type' is Void, otherwise static binding on `static_type'.
		local
			constant_b: CONSTANT_B
		do
			if is_once then
					-- Cannot hardwire string constants, ever.
				Result := Precursor {ENCAPSULATED_I} (access_type, static_type)
			else
					-- Constants are hardwired in final mode
				create constant_b.make (value)
				constant_b.set_access (Precursor {ENCAPSULATED_I} (access_type, static_type))
				Result := constant_b
			end
		end

feature -- IL Code generation

	generate_il is
			-- Generate IL code for constant.
		local
			type_i: TYPE_I
			il_label_compute: IL_LABEL
		do
			type_i := type.actual_type.type_i
			if is_once then
				il_generator.set_once_generation (True)
				il_generator.generate_once_done_info (feature_name)
				il_generator.generate_once_result_info (feature_name, type_i)
				il_label_compute := il_label_factory.new_label
				il_generator.generate_once_test
				il_generator.branch_on_false (il_label_compute)
				il_generator.generate_once_result
				il_generator.generate_return
				il_generator.mark_label (il_label_compute)
				il_generator.generate_once_computed
				value.generate_il
				il_generator.duplicate_top
				il_generator.generate_once_store_result
				il_generator.generate_return
				il_generator.set_once_generation (False)
			else
				il_generator.put_result_info (type_i)
				value.generate_il
				il_generator.generate_return
			end
		end

feature -- Byte code generation

	melt (exec: EXECUTION_UNIT) is
			-- Generate byte code for constant.
			-- [Remember there is no byte code tree for constant].
		local
			melted_feature: MELT_FEATURE
			ba: BYTE_ARRAY
			result_type: TYPE_I
			static_type: INTEGER
		do
			ba := Byte_array
			ba.clear

				-- Once mark and reserved space for once key.
			if is_once then
					-- The once mark
				ba.append ('%/001/')
					-- Allocate space for once key
				ba.allocate_space (Long_c_type)
			else
					-- Not a once routine
				ba.append ('%U')
			end

				-- Start	
			ba.append (Bc_start)
				-- Routine id
			ba.append_integer (rout_id_set.first)
				-- Real body id ( -1 because it's a constant. We can't set a breakpoint )
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
			static_type := byte_context.current_type.type_id - 1
			ba.append_short_integer (static_type)

				-- No rescue
			ba.append ('%U')

				-- Access to attribute; Result := <attribute access>
			value.make_byte_code (ba)
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

	is_once: BOOLEAN is
			-- is the constant (implemented like) a once function ?
		do
			Result := value.is_string or else value.is_bit
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_CONSTANT_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_CONSTANT_I
		do
			create unselect.make
			transfer_to (unselect)
			unselect.set_access_in (in)
			Result := unselect
		end

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			Precursor {ENCAPSULATED_I} (other)
			other.set_type (type)
			other.set_value (value)
		end

feature {NONE} -- Implementation

	new_api_feature: E_CONSTANT is
			-- API feature creation
		local
			t: TYPE_A
		do
			t ?= type
			create Result.make (feature_name, feature_id)
			if t = Void then
				t := type.actual_type
			end
			Result.set_type (t)
			Result.set_value (value.string_value)
		end

end
