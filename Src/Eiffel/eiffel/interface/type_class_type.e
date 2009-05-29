note
	description: "[
		Description of a generic derivation of class TYPE. It contains
		type of the current generic derivation. All generic derivations are stored
		in TYPE_LIST of CLASS_C
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CLASS_TYPE

inherit
	CLASS_TYPE
		redefine
			generate_feature
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature -- Status report

	first_generic: TYPE_A
			-- First generic parameter type
		require
			has_generics: type.generics /= Void;
			good_generic_count: type.generics.count = 1;
		do
			Result := type.generics.item (1)
		end

feature -- C code generation

	generate_feature (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generate feature `feat' in `buffer'.
		do
			inspect feat.feature_name_id
			when {PREDEFINED_NAMES}.has_default_name_id then
				generate_has_default (feat, buffer)
			when {PREDEFINED_NAMES}.default_name_id then
				generate_default (feat, buffer)
			else
				Precursor (feat, buffer)
			end
		end

feature {NONE} -- Implementation

	generate_has_default (feat: FEATURE_I; buffer: GENERATION_BUFFER)
			-- Generates built-in feature `has_default'.
		require
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.has_default_name_id
			buffer_not_void: buffer /= Void
		local
			gen_param: TYPE_A
			type_c: TYPE_C
			final_mode: BOOLEAN
			result_type_name, encoded_name: STRING
			l_byte_context: like byte_context
		do
			l_byte_context := byte_context
			final_mode := l_byte_context.final_mode

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "has_default", encoded_name)

			type_c := boolean_c_type
			if final_mode then
				result_type_name := type_c.c_string
			else
				result_type_name := "EIF_TYPED_VALUE"
			end

			buffer.generate_function_signature (result_type_name, encoded_name, True,
				l_byte_context.header_buffer, <<"Current">>, <<"EIF_REFERENCE">>)

			buffer.generate_block_open
			buffer.put_gtcx

			if not final_mode then
				buffer.put_new_line
				buffer.put_string ("EIF_TYPED_VALUE r;")
				buffer.put_new_line
				buffer.put_two_character ('r', '.')
				type_c.generate_typed_tag (buffer)
				buffer.put_character (';')
			end

			buffer.put_new_line
			buffer.put_string ("return ")

			if not final_mode then
				buffer.put_three_character ('(', 'r', '.')
				type_c.generate_typed_field (buffer)
				buffer.put_three_character (' ', '=', ' ')
			end
			gen_param := first_generic
			if gen_param.is_expanded then
				buffer.put_string ("EIF_TRUE")
			else
				buffer.put_string ("eif_gen_has_default(eif_gen_param_id(Dftype(Current), 1))")
			end
			if not final_mode then
				buffer.put_four_character (')', ',', ' ', 'r')
			end
			buffer.put_character (';')

			buffer.generate_block_close

				-- Separation for formatting
			buffer.put_new_line
			l_byte_context.clear_feature_data
		end

	generate_default (feat: FEATURE_I; buffer: GENERATION_BUFFER)
		require
			feat_exists: feat /= Void
			consistency: feat.feature_name_id = {PREDEFINED_NAMES}.default_name_id
			buffer_not_void: buffer /= Void
		local
			gen_param: TYPE_A
			type_c: TYPE_C
			l_exp_class_type: CLASS_TYPE
			final_mode: BOOLEAN
			result_type_name, encoded_name: STRING
			l_byte_context: like byte_context
			basic_i: BASIC_A
		do
			l_byte_context := byte_context
			gen_param := first_generic
			type_c := gen_param.c_type
			final_mode := l_byte_context.final_mode

			feat.generate_header (Current, buffer)
			encoded_name := Encoder.feature_name (type_id, feat.body_index)

			System.used_features_log_file.add (Current, "default", encoded_name)

			if final_mode then
				result_type_name := type_c.c_string
			else
				result_type_name := "EIF_TYPED_VALUE"
			end

			buffer.generate_function_signature (result_type_name, encoded_name, True,
				l_byte_context.header_buffer, <<"Current">>, <<"EIF_REFERENCE">>)

			buffer.generate_block_open
			buffer.put_gtcx

			if gen_param.is_true_expanded then
				l_exp_class_type := gen_param.associated_class_type (Void)
				buffer.put_new_line
				buffer.put_string ("EIF_REFERENCE Result;")
			end

			if not final_mode then
				buffer.put_new_line
				buffer.put_string ("EIF_TYPED_VALUE r;")
				buffer.put_new_line
				buffer.put_two_character ('r', '.')
				type_c.generate_typed_tag (buffer)
				buffer.put_character (';')
			end

			if gen_param.is_true_expanded then
					-- Create expanded type based on the actual generic parameter, and not
					-- on the recorded derivation (as it would not work if `gen_param' is
					-- generic.
				l_exp_class_type.generate_expanded_creation (buffer, "Result",
					create {FORMAL_A}.make (False, False, 1), Current)
				buffer.put_new_line
				buffer.put_string ("return ")
				if not final_mode then
					buffer.put_three_character ('(', 'r', '.')
					type_c.generate_typed_field (buffer)
					buffer.put_three_character (' ', '=', ' ')
				end
				buffer.put_string ("Result")
				if not final_mode then
					buffer.put_four_character (')', ',', ' ', 'r')
				end
				buffer.put_character (';')
			else
				buffer.put_new_line
				buffer.put_string ("return ")
				if not final_mode then
					buffer.put_three_character ('(', 'r', '.')
					type_c.generate_typed_field (buffer)
					buffer.put_three_character (' ', '=', ' ')
				end
				type_c.generate_default_value (buffer)
				if not final_mode then
					buffer.put_four_character (')', ',', ' ', 'r')
				end
				buffer.put_character (';')
			end

			buffer.generate_block_close

				-- Separation for formatting
			buffer.put_new_line

			if final_mode then
					-- Generate generic wrapper.
				buffer.generate_function_signature ("EIF_REFERENCE", encoded_name + "1", True,
					Byte_context.header_buffer, <<"Current">>, <<"EIF_REFERENCE">>)
				buffer.generate_block_open
				basic_i ?= gen_param
				buffer.put_new_line
				if basic_i = Void then
					buffer.put_string ("return ")
				else
					buffer.put_string ("EIF_REFERENCE Result;")
					buffer.put_new_line
					basic_i.c_type.generate (buffer)
					buffer.put_string ("r = ")
				end
				if gen_param.is_true_expanded or else associated_class.assertion_level.is_precondition then
						-- It's possible to repeat the code above, but it's complex enough.
					buffer.put_string (encoded_name)
					buffer.put_string (" (Current);")
				else
					type_c.generate_default_value (buffer)
					buffer.put_character (';')
				end
				if basic_i /= Void then
					basic_i.metamorphose (create {NAMED_REGISTER}.make ("Result", reference_c_type), create {NAMED_REGISTER}.make ("r", basic_i.c_type), buffer)
					buffer.put_character (';')
					buffer.put_new_line
					buffer.put_string ("return Result;")
				end
				buffer.generate_block_close
					-- Separation for formatting
				buffer.put_new_line
			end

			l_byte_context.clear_feature_data
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
