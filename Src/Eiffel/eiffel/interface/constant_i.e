indexing
	description: "Representation of a constant"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONSTANT_I

inherit
	ENCAPSULATED_I
		rename
			check_types as old_check_types,
			equiv as basic_equiv
		redefine
			assigner_name_id, transfer_to, access_for_feature, melt, generate,
			is_once, redefinable, is_constant,
			set_type, type, generate_il, to_generate_in,
			new_rout_entry, extension
		end

	ENCAPSULATED_I
		redefine
			assigner_name_id, transfer_to, check_types, access_for_feature, equiv,
			melt, generate, is_once, redefinable, is_constant,
			set_type, type, generate_il, to_generate_in,
			new_rout_entry, extension
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

feature -- Access

	type: TYPE_A
			-- Type of the constant

	assigner_name_id: INTEGER
			-- Id of `assigner_name' in `Names_heap' table

	value: VALUE_I
			-- Constant value

	extension: IL_EXTENSION_I
			-- External information.

feature -- Status report

	is_constant: BOOLEAN is True
			-- Is the current feature a constant one ?

	redefinable: BOOLEAN is False
			-- Is a constant redefinable ?

feature -- Settings

	set_type (t: like type; a: like assigner_name_id) is
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		do
			type := t
			assigner_name_id := a
		end

	set_value (v: like value) is
			-- Assign `v' to `value'.
		require
			good_argument: v /= Void
		do
			value := v
		end

	set_extension (an_extension: like extension) is
			-- Set `extension' with `an_extension'.
		require
			an_extension_not_void: an_extension /= Void
		do
			extension := an_extension
		ensure
			extension_set: extension = an_extension
		end

	check_types (feat_tbl: FEATURE_TABLE) is
			-- Check Result and argument types
		local
			actual_type: TYPE_A
			vqmc: VQMC
		do
			Precursor {ENCAPSULATED_I} (feat_tbl)
			if not type.is_attached then
					-- Type of constant is always attached.
				if feat_tbl.associated_class.lace_class.is_void_safe then
					type := type.as_attached
				elseif not type.is_implicitly_attached then
					type := type.as_implicitly_attached
				end
			end
			actual_type := type.actual_type
			if value.valid_type (actual_type) then
				value.set_real_type (actual_type)
			else
				create vqmc
				vqmc.set_class (written_class)
				vqmc.set_feature_name (feature_name)
				vqmc.set_constant_type (value)
				vqmc.set_expected_type (actual_type)
				vqmc.set_location (body.start_location)
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
			type_c: TYPE_C
			internal_name: STRING
			return_type_name: STRING
			local_byte_context: BYTE_CONTEXT
			local_is_once: BOOLEAN
			header_buffer: GENERATION_BUFFER
		do
			if used then
				local_byte_context := byte_context
				generate_header (class_type, buffer)
				type_c := type.c_type
				internal_name := Encoder.feature_name (class_type.type_id, body_index)
				add_in_log (class_type, internal_name)

					-- If constant is a string, it is the semantic of a once
				if is_once then
					local_is_once := True
					local_byte_context.add_thread_relative_once (type_c, body_index)
					buffer.put_new_line
					if local_byte_context.workbench_mode then
						buffer.put_string ("RTOID (")
						buffer.put_string (internal_name)
						buffer.put_character (')')
						buffer.put_new_line
						buffer.put_new_line
					elseif not System.has_multithreaded then
						header_buffer := local_byte_context.header_buffer
						header_buffer.put_string ("RTOSHF (EIF_REFERENCE, ")
						header_buffer.put_integer (body_index)
						header_buffer.put_character (')')
						header_buffer.put_new_line
						header_buffer.put_new_line
					end
				end

					-- Generation of function's header
				if local_byte_context.workbench_mode then
					return_type_name := once "EIF_TYPED_VALUE"
				else
					return_type_name := type_c.c_string
				end
				buffer.generate_function_signature (return_type_name,
						internal_name, True, local_byte_context.header_buffer,
						<<"Current">>, <<"EIF_REFERENCE">>)

					-- Function's body
				buffer.generate_block_open
				buffer.put_gtcx

					-- If constant is a string, it is the semantic of a once
				if local_is_once then
					buffer.put_new_line
					if local_byte_context.workbench_mode then
						buffer.put_string ("RTOTC (")
						buffer.put_string (internal_name)
						buffer.put_character (',')
						buffer.put_integer (real_body_id (class_type))
					elseif System.has_multithreaded then
						buffer.put_string ("RTOUC (")
						buffer.put_integer (local_byte_context.thread_relative_once_index (body_index))
					else
						buffer.put_string ("RTOSC (")
						buffer.put_integer (body_index)
					end
					buffer.put_character (',')
					value.generate (buffer)
					buffer.put_character (')')
				else
					buffer.put_new_line
					if local_byte_context.workbench_mode then
						buffer.put_string ("EIF_TYPED_VALUE r;")
						buffer.put_new_line
						buffer.put_string ("r.")
						type_c.generate_typed_tag (buffer)
						buffer.put_character (';')
						buffer.put_new_line
						buffer.put_string ("r.")
						type_c.generate_typed_field (buffer)
						buffer.put_string (" = ")
					else
						buffer.put_string ("return ")
					end
					type_c.generate_cast (buffer)
					value.generate (buffer)
					if local_byte_context.workbench_mode then
						buffer.put_character (';')
						buffer.put_new_line
						buffer.put_string ("return r")
					end
				end
				buffer.put_character (';')
				buffer.generate_block_close
				buffer.put_new_line
			elseif not System.is_used (Current) then
				System.removed_log_file.add (class_type, feature_name)
			end
		end

	access_for_feature (access_type: TYPE_A; static_type: TYPE_A; is_qualified: BOOLEAN): ACCESS_B is
			-- Byte code access for constant. Dynamic binding if
			-- `static_type' is Void, otherwise static binding on `static_type'.
		local
			constant_b: CONSTANT_B
			external_b: EXTERNAL_B
			l_type: TYPE_A
		do
			if is_once then
					-- Cannot hardwire string constants, ever.
				Result := Precursor (access_type, static_type, is_qualified)
			else
				if is_qualified then
						-- To fix eweasel test#term155 we remove all anchors from
						-- calls after the first dot in a call chain.
					l_type := access_type.deep_actual_type
				else
					l_type := access_type
				end
				if extension /= Void then
					create external_b
					external_b.init (Current)
					if static_type /= Void then
						external_b.set_static_class_type (static_type)
					end
					external_b.set_type (l_type)
					external_b.set_external_name_id (external_name_id)
					external_b.set_extension (extension)
					Result := external_b
				else
						-- Constants are hardwired in final mode
					create constant_b.make (value)
					constant_b.set_access (Precursor (access_type, static_type, is_qualified))
					Result := constant_b
				end
			end
		end

feature -- IL Code generation

	generate_il is
			-- Generate IL code for constant.
		local
			type_i: TYPE_A
			l_byte_context: like byte_context
		do
			l_byte_context := byte_context
			l_byte_context.set_byte_code (create {STD_BYTE_CODE})
			l_byte_context.set_current_feature (Current)
			type_i := type
			if is_once then
				il_generator.generate_once_prologue
				value.generate_il
				il_generator.generate_once_store_result
				il_generator.generate_once_epilogue
			else
				il_generator.put_result_info (type_i)
				value.generate_il
				il_generator.generate_return (True)
			end
			l_byte_context.clear_feature_data
		end

feature -- Byte code generation

	melt (exec: EXECUTION_UNIT) is
			-- Generate byte code for constant.
			-- [Remember there is no byte code tree for constant].
		local
			melted_feature: MELT_FEATURE
			ba: BYTE_ARRAY
			result_type: TYPE_A
			static_type: INTEGER
		do
			ba := Byte_array
			ba.clear

				-- Once mark and reserved space for once key.
			if is_once then
					-- The once mark
				ba.append ({ONCE_BYTE_CODE}.once_mark_thread_relative)
					-- Record routine body index
				ba.append_integer_32 (body_index)
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
			result_type := byte_context.real_type (type)
			ba.append_integer (result_type.sk_value (byte_context.context_class_type.type))
				-- Argument count
			ba.append_short_integer (0)

				-- Local count
			ba.append_short_integer (0)
				-- Feature name
			ba.append_raw_string (feature_name)
				-- Type where the feature is written in
			static_type := byte_context.class_type.type_id - 1
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
		local
			l_val: STRING_VALUE_I
		do
			Result := value.is_string
			if Result then
				l_val ?= value
				check
					l_val_not_void: l_val /= Void
				end
				Result := not l_val.is_dotnet_string
			else
				Result := value.is_bit
			end
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
			other.set_type (type, assigner_name_id)
			other.set_value (value)
			extension := other.extension
		end

feature {NONE} -- Implementation

	new_api_feature: E_CONSTANT is
			-- API feature creation
		do
			create Result.make (feature_name_id, alias_name, has_convert_mark, feature_id)
			Result.set_type (type, assigner_name)
			Result.set_value (value.string_value)
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

end
