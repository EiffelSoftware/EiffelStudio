note
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
			new_attr_entry, new_rout_entry, melt, access_for_feature, generate, new_rout_id,
			set_type, type, is_attribute, is_transient, is_hidden,
			undefinable, check_expanded, transfer_from,
			assert_id_set, set_assert_id_set
		end

	SHARED_DECLARATIONS

	SHARED_GENERATION

	SHARED_TYPE_I
		export
			{NONE} all
		end

	BYTE_CONST

create
	make

feature -- Access

	type: TYPE_A
			-- Attribute type

	assigner_name_id: INTEGER
			-- Id of `assigner_name' in `Names_heap' table

	extension: IL_EXTENSION_I
			-- Deferred external information

	new_rout_entry: ROUT_ENTRY
			-- New routine unit
		do
			create Result
			Result.set_body_index (body_index)
			Result.set_type_a (type)

			if generate_in = 0 then
				if has_replicated_ast then
					Result.set_access_in (access_in)
				else
					Result.set_access_in (written_in)
				end
				Result.set_written_in (written_in)
			else
				Result.set_written_in (generate_in)
				Result.set_access_in (generate_in)
			end
			Result.set_pattern_id (pattern_id)
			Result.set_feature_id (feature_id)
			Result.set_is_attribute
			if has_body then
				Result.set_has_body
			end
		end

 	new_attr_entry: ATTR_ENTRY
 			-- New attribute unit
 		do
 			create Result
			Result.set_type_a (type)
 			Result.set_feature_id (feature_id)
 			if has_body then
 				Result.set_has_body
 			end
 		end

	undefinable: BOOLEAN
			-- Is an attribute undefinable ?
		do
			-- Do nothing
		end

	assert_id_set: ASSERT_ID_SET
			-- Assertions

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

	is_transient: BOOLEAN
			-- <Precursor>
		do
			Result := feature_flags & is_transient_mask = is_transient_mask
		end

	is_hidden: BOOLEAN
			-- <Precursor>		
		do
			Result := feature_flags & is_hidden_mask = is_hidden_mask
		end

feature -- Status setting

	set_has_function_origin (b: BOOLEAN)
			-- Assign `b' to `has_function_origin'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_function_origin_mask)
		ensure
			has_function_origin_set: has_function_origin = b
		end

	set_has_body (b: BOOLEAN)
			-- Assign `b' to `has_body_mask'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_body_mask)
		ensure
			has_body_set: has_body = b
		end

	set_is_transient (v: BOOLEAN)
			-- Set `is_transient' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, is_transient_mask)
		ensure
			is_transient_set: is_transient = v
		end

	set_is_hidden (v: BOOLEAN)
			-- Set `is_hidden' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, is_hidden_mask)
		ensure
			is_hidden_set: is_hidden = v
		end

feature -- Element Change

	init_assertion_flags (content: ROUTINE_AS)
			-- Initialize assertion flags with `content'.
		require
			content_not_void: content /= Void
		do
			set_is_require_else (content.is_require_else)
			set_is_ensure_then (content.is_ensure_then)
			set_has_precondition (content.has_precondition)
			set_has_postcondition (content.has_postcondition)
			set_has_false_postcondition (content.has_false_postcondition)
		end

	set_assert_id_set (set: like assert_id_set)
			-- Assign `set' to `assert_id_set'.
		do
			assert_id_set := set
		end

	set_extension (an_extension: like extension)
			-- Set `extension' with `an_extension'.
		do
			extension := an_extension
		ensure
			extension_set: extension = an_extension
		end

	set_type (t: like type; a: like assigner_name_id)
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		do
			type := t
			assigner_name_id := a
		end

	new_rout_id: INTEGER
			-- New routine id for attribute
		do
			Result := Routine_id_counter.next_attr_id
		end

	check_expanded (class_c: CLASS_C)
			-- Check the expanded validity rules
		local
			vlec: VLEC
			solved_type: TYPE_A
		do
			Precursor {ENCAPSULATED_I} (class_c)
			solved_type ?= type.conformance_type
			if
				solved_type.is_true_expanded and then
				(solved_type.has_associated_class and then solved_type.base_class = class_c) and then
				(extension = Void or else
					extension.type /= {SHARED_IL_CONSTANTS}.static_field_type)
			then
				create vlec
				vlec.set_class (solved_type.base_class)
				vlec.set_client (class_c)
				Error_handler.insert_error (vlec)
			end
		end

	access_for_feature (access_type: TYPE_A; static_type: TYPE_A; is_qualified: BOOLEAN; is_separate: BOOLEAN): ACCESS_B
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
				if static_type /= Void then
					external_b.set_static_class_type (static_type)
				end
				external_b.set_type (l_type)
				external_b.set_external_name_id (external_name_id)
				external_b.set_extension (extension)
				Result := external_b
			elseif is_qualified and then system.seed_of_routine_id (rout_id_set.first).has_formal then
					-- Call a generic wrapper.
				Result := Precursor (access_type, static_type, is_qualified, is_separate)
			else
				create attribute_b.make (Current)
				attribute_b.set_type (l_type)
				Result := attribute_b
			end
		end

	generate (class_type: CLASS_TYPE; buffer, header_buffer: GENERATION_BUFFER)
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
			typed_field: STRING
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
					<<{C_CONST}.current_name>>, <<"EIF_REFERENCE">>)
				buffer.generate_block_open
				if byte_context.workbench_mode then
					buffer.put_new_line
					buffer.put_string ("EIF_TYPED_VALUE r;")
					buffer.put_new_line
					buffer.put_string ("r.")
					result_type.c_type.generate_typed_tag (buffer)
					buffer.put_character (';')
						-- Record typed field name with a leading dot.
					typed_field := "." + result_type.c_type.typed_field
				else
					if is_initialization_required then
							-- Define variable for result.
						buffer.put_new_line
						buffer.put_string (return_type_name)
						buffer.put_three_character (' ', 'r', ';')
					end
						-- Typed field is not used in finalized mode.
					typed_field := ""
				end
				if is_initialization_required then
					buffer.put_new_line
					buffer.put_character ('r')
					buffer.put_string (typed_field)
					buffer.put_three_character (' ', '=', ' ')
					generate_attribute_access (class_type, buffer)
					buffer.put_character (';')
					buffer.put_new_line
					buffer.put_string ("if (!r")
					buffer.put_string (typed_field)
					buffer.put_string (") {")
					buffer.indent
					if not result_type.is_attached then
							-- Check if type is really attached.
						create_info.generate_start (buffer)
						create_info.generate_gen_type_conversion (0)
						buffer.put_new_line
						buffer.put_string ("if (RTAT(")
						create_info.generate_type_id (buffer, byte_context.final_mode, 0)
						buffer.put_string (")) {")
						buffer.indent
					end
					check has_body end
						-- Define variables used by "RTLI/RTLE".
					buffer.put_new_line
					buffer.put_string ("GTCX")
					buffer.put_new_line
					buffer.put_string ("RTLD;")
						-- Register "Current" with GC.
					buffer.put_new_line
					buffer.put_string ("RTLI(1);")
					buffer.put_new_line
					buffer.put_string ("RTLR(0,Current);")
					buffer.put_new_line
					buffer.put_character ('r')
					buffer.put_string (typed_field)
					buffer.put_four_character (' ', '=', ' ', '(')
					buffer.put_string (internal_name)
					buffer.put_string ("_body (")
					buffer.put_string ({C_CONST}.current_name)
					buffer.put_two_character (')', ')')
					buffer.put_string (typed_field)
					buffer.put_character (';')
					buffer.put_new_line
					generate_attribute_access (class_type, buffer)
					buffer.put_four_character (' ', '=', ' ', 'r')
					buffer.put_string (typed_field)
					buffer.put_character (';')
					buffer.put_new_line
					buffer.put_string ("RTAR(")
					buffer.put_string ({C_CONST}.current_name)
					buffer.put_two_character (',', ' ')
					buffer.put_character ('r')
					buffer.put_string (typed_field)
					buffer.put_two_character (')', ';')
					buffer.put_new_line
					buffer.put_string ("RTLE;")
					if create_info /= Void then
						buffer.generate_block_close
						create_info.generate_end (buffer)
					end
					buffer.generate_block_close
					buffer.put_new_line
					buffer.put_string ("return r;")
				elseif byte_context.workbench_mode then
						-- Assign attribute value to result field.
					buffer.put_new_line
					buffer.put_character ('r')
					buffer.put_string (typed_field)
					buffer.put_string (" = ")
					generate_attribute_access (class_type, buffer)
					buffer.put_character (';')
						-- Return result structure.
					buffer.put_new_line
					buffer.put_string ("return r;")
				else
						-- Return attribute value directly.
					buffer.put_new_line
					buffer.put_string ("return ")
					generate_attribute_access (class_type, buffer)
					buffer.put_character (';')
				end

				buffer.generate_block_close
				buffer.put_new_line
				buffer.put_new_line
				l_byte_context.clear_feature_data
			end
		end

	generate_hidden_attribute_access, generate_attribute_access (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER)
			-- Generates attribute access.
			-- [Redeclaration of a function into an attribute]
		local
			result_type: TYPE_A
			table_name: STRING
			rout_id: INTEGER
			array_index: INTEGER
		do
			result_type := type.adapted_in (class_type)

			if not result_type.is_true_expanded then
				buffer.put_character ('*')
				result_type.c_type.generate_access_cast (buffer)
			else
					-- We do not need to generate a cast since what we are computed is
				-- already good.
			end
			buffer.put_character ('(')
			byte_context.current_register.print_register
			rout_id := rout_id_set.first
			if byte_context.final_mode then
				array_index := Eiffel_table.is_polymorphic (rout_id, class_type.type, class_type, False)
				if array_index >= 0 then
					table_name := Encoder.attribute_table_name (rout_id)

						-- Generate following dispatch:
						-- table [Actual_offset - base_offset]
					buffer.put_three_character (' ', '+', ' ')
					buffer.put_string (table_name)
					buffer.put_character ('[')
					byte_context.generate_current_dtype
					buffer.put_three_character (' ', '-', ' ')
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
			else
				buffer.put_string (" + RTWA(")
				buffer.put_integer (rout_id)
				buffer.put_character (',')
				byte_context.generate_current_dtype
				buffer.put_character (')')
			end;
			buffer.put_character(')')
		end

	replicated (in: INTEGER): FEATURE_I
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

	selected: ATTRIBUTE_I
			-- Selected attribute
		do
			create Result.make
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I
			-- Unselected attribute
		local
			s: D_ATTRIBUTE_I
		do
			create s.make
			transfer_to (s)
			s.set_access_in (in)
			Result := s
		end

	transfer_to (other: like Current)
			-- Transfer data from `Current' to `other'.
		do
			Precursor {ENCAPSULATED_I} (other)
			other.set_type (type, assigner_name_id)
			other.set_has_function_origin (has_function_origin)
			other.set_extension (extension)
			other.set_has_body (has_body)
			other.set_is_require_else (is_require_else)
			other.set_is_ensure_then (is_ensure_then)
			other.set_has_precondition (has_precondition)
			other.set_has_postcondition (has_postcondition)
			other.set_has_false_postcondition (has_false_postcondition)
			other.set_assert_id_set (assert_id_set)
			other.set_has_rescue_clause (has_rescue_clause)
			other.set_is_transient (is_transient)
		end

	transfer_from (other: like Current)
			-- Transfer data from `Current' to `other'.
		do
			Precursor {ENCAPSULATED_I} (other)
			type := other.type
			assigner_name_id := other.assigner_name_id
				-- `has_function_origin' is set in FEATURE_I
			set_has_function_origin (other.has_function_origin)
			assert_id_set := other.assert_id_set
			extension := other.extension
			set_is_transient (other.is_transient)
		end

	melt (exec: EXECUTION_UNIT)
			-- Melt an attribute
		local
			melted_feature: MELT_FEATURE
			ba: BYTE_ARRAY
			result_type: TYPE_A
			current_type: CLASS_TYPE
			l_byte_context: like byte_context
			tmp_body_index: like body_index
			byte_code: BYTE_CODE
		do
			l_byte_context := byte_context
			ba := Byte_array
			ba.clear

			current_type := l_byte_context.class_type
			result_type := type.adapted_in (exec.class_type)
			if not result_type.is_expanded and then has_body then
				tmp_body_index := body_index
				byte_code := tmp_opt_byte_server.disk_item (tmp_body_index)
				if byte_code = Void then
					byte_code := byte_server.disk_item (tmp_body_index)
				end
				l_byte_context.set_byte_code (byte_code)
				l_byte_context.set_current_feature (Current)
				byte_code.make_byte_code (ba)
				l_byte_context.clear_feature_data
			else
					-- Once mark
				ba.append ({BYTE_CODE}.once_mark_attribute)
					-- Start	
				ba.append (Bc_start)
					-- Routine id
				ba.append_integer (rout_id_set.first)
					-- Real body id ( -1 because it's an attribute. We can't set a breakpoint )
				ba.append_integer (-1)
					-- Meta-type of Result
				result_type := l_byte_context.real_type (type)
				ba.append_natural_32 (result_type.sk_value (l_byte_context.context_class_type.type))
					-- Argument count
				ba.append_short_integer (0)
					-- Local count
				ba.append_short_integer (0)
					-- Precise result type (if required)
				if result_type.is_true_expanded then
						-- Generate full type info.
					type.make_full_type_byte_code (ba, l_byte_context.context_class_type.type)
				end
					-- Feature name
				ba.append_raw_string (feature_name)
					-- Type where the feature is written in
				ba.append_short_integer (current_type.type_id - 1)

					-- No rescue
				ba.append_boolean (False)
					-- Access to attribute; Result := <attribute access>
				ba.append (Bc_current)
				ba.append (Bc_attribute)
					-- Routine id
				ba.append_integer (rout_id_set.first)
					-- Attribute meta-type
				ba.append_natural_32 (result_type.sk_value (l_byte_context.context_class_type.type))
				ba.append (Bc_rassign)
					-- End mark
				ba.append (Bc_null)
			end

			melted_feature := ba.melted_feature
			melted_feature.set_real_body_id (exec.real_body_id)
			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Execution_table.mark_melted (exec)
		end

feature {NONE} -- Implementation

	new_api_feature: E_ATTRIBUTE
			-- API feature creation
		do
			create Result.make (feature_name_id, alias_name, has_convert_mark, feature_id)
			Result.set_type (type, assigner_name)
			Result.set_is_attribute_with_body (has_body)
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
