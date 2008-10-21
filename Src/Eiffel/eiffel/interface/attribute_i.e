indexing
	description: "Representation of an attribute of a class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ATTRIBUTE_I

inherit
	ENCAPSULATED_I
		redefine
			assigner_name_id, transfer_to, unselected, extension,
			new_rout_entry, melt, access_for_feature, generate, new_rout_id,
			set_type, type, is_attribute,
			undefinable, check_expanded, transfer_from
		end

	SHARED_DECLARATIONS

	SHARED_GENERATION

	SHARED_TYPE_I
		export {NONE}
			all
		end

	BYTE_CONST

create
	make

feature

	type: TYPE_A
			-- Attribute type

	assigner_name_id: INTEGER
			-- Id of `assigner_name' in `Names_heap' table

	extension: IL_EXTENSION_I
			-- Deferred external information

	new_rout_entry: ROUT_ENTRY is
			-- New routine unit
		do
			create Result
			Result.set_body_index (body_index)
			Result.set_type_a (type.actual_type)

			if generate_in = 0 then
				if has_replicated_ast then
					Result.set_access_in (access_in)
					Result.set_written_in (written_in)
				else
					Result.set_written_in (written_in)
					Result.set_access_in (written_in)
				end
			else
				Result.set_written_in (generate_in)
				Result.set_access_in (generate_in)
			end
			Result.set_pattern_id (pattern_id)
			Result.set_feature_id (feature_id)
			Result.set_is_attribute
		end

	undefinable: BOOLEAN is
			-- Is an attribute undefinable ?
		do
			-- Do nothing
		end

feature -- Status report

	is_attribute: BOOLEAN = True
			-- Is the feature an attribute?

	has_function_origin: BOOLEAN
			-- Flag for detecting a redefinition of a function into an
			-- attribute. This flag is set by routine `process' of
			-- class FEATURE_TABLE and will be useful for generating a
			-- access function of this attribute in the C file associated
			-- to the class where this attribute is available.
		do
			Result := feature_flags & has_function_origin_mask = has_function_origin_mask
		end

	has_body: BOOLEAN
			-- Is there an explicit attribute body?
		do
			Result := feature_flags & has_body_mask = has_body_mask
		end

feature -- Status setting

	set_has_function_origin (b: BOOLEAN) is
			-- Assign `b' to `has_function_origin'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_function_origin_mask)
		ensure
			has_function_origin_set: has_function_origin = b
		end

	set_has_body (b: BOOLEAN) is
			-- Assign `b' to `has_body_mask'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_body_mask)
		ensure
			has_body_set: has_body = b
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

	set_type (t: like type; a: like assigner_name_id) is
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		do
			type := t
			assigner_name_id := a
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
			solved_type ?= type.conformance_type
			if
				solved_type.is_true_expanded and then
				(solved_type.has_associated_class and then solved_type.associated_class = class_c) and then
				(extension = Void or else
					extension.type /= {SHARED_IL_CONSTANTS}.static_field_type)
			then
				create vlec
				vlec.set_class (solved_type.associated_class)
				vlec.set_client (class_c)
				Error_handler.insert_error (vlec)
			end
		end

	access_for_feature (access_type: TYPE_A; static_type: TYPE_A; is_qualified: BOOLEAN): ACCESS_B is
			-- Byte code access for current feature
		local
			attribute_b: ATTRIBUTE_B
			external_b: EXTERNAL_B
			l_type: TYPE_A
		do
			if is_qualified then
					-- To fix eweasel test#term155 we remove all anchors from
					-- calls after the first dot in a call chain.
				l_type := access_type.context_free_type
			else
				l_type := access_type
			end
			if extension /= Void then
				create external_b
				external_b.init (Current)
				external_b.set_type (l_type)
				external_b.set_external_name_id (external_name_id)
				external_b.set_extension (extension)
				Result := external_b
			elseif is_qualified and then system.seed_of_routine_id (rout_id_set.first).has_formal then
					-- Call a generic wrapper.
				Result := Precursor (access_type, static_type, is_qualified)
			else
				create attribute_b
				attribute_b.init (Current)
				attribute_b.set_type (l_type)
				Result := attribute_b
			end
		end

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generate feature written in `class_type' in `buffer'.
		require else
			valid_file: buffer /= Void
		local
			result_type: TYPE_A
			internal_name: STRING
			return_type_name: STRING
			l_byte_code: BYTE_CODE
			tmp_body_index: INTEGER
			l_byte_context: like byte_context
			create_info: CREATE_FEAT
			is_initialization_required: BOOLEAN
		do
			if used then
				generate_header (class_type, buffer)

					-- Code generation of an explicit attribute body.
				if has_body then
					tmp_body_index := body_index
					l_byte_code := tmp_opt_byte_server.disk_item (tmp_body_index)
					if l_byte_code = Void then
						l_byte_code := byte_server.disk_item (tmp_body_index)
					end

						-- Generation of C code for an Eiffel feature written in
						-- the associated class of the current type.
					l_byte_context := byte_context

					if System.in_final_mode and then System.inlining_on then
							-- We need to set `{BYTE_CONTEXT}.byte_code', since it is used
							-- in `inlined_byte_code'.
						l_byte_context.set_byte_code (l_byte_code)
						l_byte_code := l_byte_code.inlined_byte_code
					end

						-- Generation of the C routine
					l_byte_context.set_byte_code (l_byte_code)
					l_byte_context.set_current_feature (Current)
					l_byte_code.analyze
					l_byte_code.set_real_body_id (real_body_id (class_type))
					l_byte_code.generate
					l_byte_context.clear_feature_data
				end

					-- Generation of a routine to access the attribute
				result_type := type.adapted_in (class_type)

				if not result_type.is_expanded and then has_body then
					if not result_type.is_attached then
							-- Whether the type is attached or not should be detected at run-time.
						create create_info.make (feature_id, rout_id_set.first)
						create_info.analyze
					end
					is_initialization_required := True
				end

				internal_name := Encoder.feature_name (class_type.type_id, body_index)
				add_in_log (class_type, internal_name)

				l_byte_context := byte_context
				if l_byte_context.workbench_mode then
					return_type_name := once "EIF_TYPED_VALUE"
				else
					return_type_name := result_type.c_type.c_string
				end
				buffer.generate_function_signature (return_type_name,
					internal_name, True, l_byte_context.header_buffer,
					<<"Current">>, <<"EIF_REFERENCE">>)
				buffer.generate_block_open
				buffer.put_new_line
				if byte_context.workbench_mode then
					buffer.put_string ("EIF_TYPED_VALUE r;")
					buffer.put_new_line
					buffer.put_string ("r.")
					result_type.c_type.generate_typed_tag (buffer)
					buffer.put_character (';')
				end
				if is_initialization_required then
					buffer.put_new_line
					buffer.put_string ("if (!")
					generate_attribute_access (class_type, buffer, "Current")
					buffer.put_string (") {")
					buffer.indent
					if not result_type.is_attached then
							-- Check if type is really attached.
						buffer.put_new_line
						create_info.generate_start (buffer)
						create_info.generate_gen_type_conversion (0)
						buffer.put_new_line
						buffer.put_string ("if (RTAT(")
						create_info.generate_type_id (buffer, byte_context.final_mode, 0)
						buffer.put_string (")) {")
						buffer.indent
					end
					if has_body then
						buffer.put_new_line
						generate_attribute_access (class_type, buffer, "Current")
						buffer.put_string (" = (")
						buffer.put_string (internal_name)
						buffer.put_string ("_body (Current))")
						if byte_context.workbench_mode then
							buffer.put_character ('.')
							result_type.c_type.generate_typed_field (buffer)
						end
						buffer.put_character (';')
					end
					if create_info /= Void then
						buffer.generate_block_close
						create_info.generate_end (buffer)
					end
					buffer.generate_block_close
				end

				if byte_context.workbench_mode then
					buffer.put_new_line
					buffer.put_string ("r.")
					result_type.c_type.generate_typed_field (buffer)
					buffer.put_string (" = ")
				else
					buffer.put_string ("return ")
				end

				generate_attribute_access (class_type, buffer, "Current")
				buffer.put_character (';')
				buffer.put_new_line

				if l_byte_context.workbench_mode then
					buffer.put_string ("return r;")
					buffer.put_new_line
				end

				buffer.generate_block_close
				buffer.put_new_line
				buffer.put_new_line
				l_byte_context.clear_feature_data
			end
		end

	generate_attribute_access (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER; cur: STRING) is
			-- Generates attribute access.
			-- [Redecalaration of a function into an attribute]
		local
			result_type: TYPE_A
			table_name: STRING
			rout_id: INTEGER
			rout_info: ROUT_INFO
			array_index: INTEGER
		do
			result_type := type.adapted_in (class_type)

			if not result_type.is_true_expanded and then not result_type.is_bit then
				buffer.put_character ('*')
				result_type.c_type.generate_access_cast (buffer)
			else
					-- We do not need to generate a cast since what we are computed is
				-- already good.
			end
			buffer.put_character ('(')
			buffer.put_string (cur);
			rout_id := rout_id_set.first
			if byte_context.final_mode then
				array_index := Eiffel_table.is_polymorphic (rout_id, class_type.type, class_type, False)
				if array_index >= 0 then
					table_name := Encoder.attribute_table_name (rout_id)

						-- Generate following dispatch:
						-- table [Actual_offset - base_offset]
					buffer.put_three_character (' ', '+', ' ')
					buffer.put_string (table_name)
					buffer.put_string ("[Dtype(")
					buffer.put_string (cur)
					buffer.put_four_character (')', ' ', '-', ' ')
					buffer.put_integer (array_index)
					buffer.put_character (']')
						-- Mark attribute offset table used.
					Eiffel_table.mark_used (rout_id)
						-- Remember external attribute offset declaration
					Extern_declarations.add_attribute_table (table_name)
				else
						--| In this instruction, we put `False' as second
						--| arguments. This means we won't generate anything if there is nothing
						--| to generate. Remember that `True' is used in the generation of attributes
						--| table in Final mode.
					class_type.skeleton.generate_offset (buffer, feature_id, False, True)
				end
			elseif
				Compilation_modes.is_precompiling or
				class_type.associated_class.is_precompiled
			then
				rout_info := System.rout_info_table.item (rout_id)
				buffer.put_string (" + RTWPA(")
				buffer.put_class_id (rout_info.origin)
				buffer.put_character (',')
				buffer.put_integer (rout_info.offset)
				buffer.put_string (", Dtype(")
				buffer.put_string (cur)
				buffer.put_two_character (')', ')')
			else
				buffer.put_string (" + RTWA(")
				buffer.put_static_type_id (class_type.static_type_id)
				buffer.put_character (',')
				buffer.put_integer (feature_id)
				buffer.put_string (", Dtype(")
				buffer.put_string (cur)
				buffer.put_two_character (')', ')')
			end;
			buffer.put_character(')')
		end

	replicated (in: INTEGER): FEATURE_I is
			-- Replication
		local
			rep: R_ATTRIBUTE_I
		do
			create rep.make
			transfer_to (rep)
			rep.set_has_property_getter (has_property_getter)
			rep.set_has_property_setter (has_property_setter)
			rep.set_code_id (new_code_id)
			rep.set_access_in (in)
			Result := rep
		end

	selected: ATTRIBUTE_I is
			-- Selected attribute
		do
			create Result.make
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected attribute
		local
			s: D_ATTRIBUTE_I
		do
			create s.make
			transfer_to (s)
			s.set_access_in (in)
			Result := s
		end

	transfer_to (other: like Current) is
			-- Transfer data from `Current' to `other'.
		do
			Precursor {ENCAPSULATED_I} (other)
			other.set_type (type, assigner_name_id)
			other.set_has_function_origin (has_function_origin)
			extension := other.extension
		end

	transfer_from (other: like Current) is
			-- Transfer data from `Current' to `other'.
		do
			Precursor {ENCAPSULATED_I} (other)
			type := other.type
			assigner_name_id := other.assigner_name_id
				-- `has_function_origin' is set in FEATURE_I
--			has_function_origin := other.has_function_origin
			extension := other.extension
		end

	melt (exec: EXECUTION_UNIT) is
			-- Melt an attribute
		local
			melted_feature: MELT_FEATURE
			ba: BYTE_ARRAY
			result_type: TYPE_A
			current_type: CLASS_TYPE
			r_id: INTEGER
			rout_info: ROUT_INFO
			l_byte_context: like byte_context
		do
			l_byte_context := byte_context
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
			result_type := l_byte_context.real_type (type)
			ba.append_integer (result_type.sk_value (l_byte_context.context_class_type.type))
				-- Argument count
			ba.append_short_integer (0)
				-- Local count
			ba.append_short_integer (0)
				-- Precise result type (if required)
			if result_type.is_true_expanded and then not result_type.is_bit then
					-- Generate full type info.
				type.make_full_type_byte_code (ba, l_byte_context.context_class_type.type)
			end
				-- Feature name
			ba.append_raw_string (feature_name)
				-- Type where the feature is written in
			current_type := l_byte_context.class_type
			ba.append_short_integer (current_type.type_id - 1)

				-- No rescue
			ba.append ('%U')
				-- Access to attribute; Result := <attribute access>
			ba.append (Bc_current)
			if current_type.associated_class.is_precompiled then
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
				ba.append_short_integer (current_type.static_type_id - 1)
			end
				-- Attribute meta-type
			ba.append_uint32_integer (result_type.sk_value (l_byte_context.context_class_type.type))
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
		do
			create Result.make (feature_name_id, alias_name, has_convert_mark, feature_id)
			Result.set_type (type, assigner_name)
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

end
