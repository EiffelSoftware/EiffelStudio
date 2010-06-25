note
	description: "Description of a manifest string constant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_VALUE_I

inherit
	VALUE_I
		rename
			string_value as internal_string_value
		redefine
			is_string, is_string_32, append_signature, is_propagation_equivalent,
			internal_string_value, set_real_type
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	CHARACTER_ROUTINES
		export
			{NONE} all
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

create {INTERNAL_COMPILER_STRING_EXPORTER}
	make

feature {NONE} -- Initialization

	make (s: STRING; a_str32: BOOLEAN; is_dotnet: BOOLEAN)
			-- Set `string_value' with `s'.
			-- Set `is_string_32' with `a_str32'
			-- Set `is_dotnet_string' with `is_dotnet'.
		require
			s_not_void: s /= Void
		do
			string_value := s
			is_string_32 := a_str32
			is_dotnet_string := is_dotnet
		ensure
			string_value_set: string_value = s
			is_dotnet_string_set: is_dotnet_string = is_dotnet
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := string_value.is_equal (other.string_value)
		end

	is_propagation_equivalent (other: like Current): BOOLEAN
			-- Is `Current' equivalent for propagation of pass2/pass3?
		do
			Result := True
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER, STRING_VALUE_I} -- Access

	string_value: STRING
			-- Integer constant value

feature -- Status Report

	is_dotnet_string: BOOLEAN
			-- Is current a manifest System.String constant?

	is_string: BOOLEAN = True
			-- Is the current constant a string one ?

	is_string_32: BOOLEAN
			-- Is the current constant a STRING_32 one?

	valid_type (t: TYPE_A): BOOLEAN
			-- Is the current value compatible with `t' ?
		local
			class_type: CL_TYPE_A
		do
			class_type ?= t
			Result := class_type /= Void and then
				(class_type.class_id = System.string_8_id or
				class_type.class_id = System.string_32_id or
				class_type.class_id = system_string_id)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	internal_string_value: STRING
		do
			Result := eiffel_string (string_value)
		end

feature -- Settings

	set_real_type (t: CL_TYPE_A)
			-- Extract type and set `is_dotnet_string' accordingly.
		local
			l_cl_type: CL_TYPE_A
		do
			l_cl_type ?= t
			if l_cl_type /= Void then
				is_dotnet_string := l_cl_type.class_id = system_string_id
				is_string_32 := l_cl_type.class_id = string_32_id
			end
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER)
			-- Generate value in `buffer'.
		local
			buf: GENERATION_BUFFER
			l_value: like string_value
			l_value_32: STRING_32
		do
				-- RTMS_EX is the macro used to create Eiffel strings from C ones
				-- RTMS32_EX_H is the macro used to create STRING_32 from C ones
			buf := buffer
			l_value := string_value
			if is_string_32 then
				buf.put_string ({C_CONST}.rtms32_ex_h)
			else
				buf.put_string ({C_CONST}.rtms_ex_h)
			end
				-- Convert UTF-8 to UTF-32 and generate UTF-32 bytes directly
				-- for manifest STRING_32.
			if is_string_32 then
				l_value_32 := encoding_converter.utf8_to_utf32 (l_value)
				l_value := encoding_converter.string_32_to_stream (l_value_32)
			end
			buf.put_character ('(')
			buf.put_string_literal (l_value)
			buf.put_character(',')
			if is_string_32 then
				buf.put_integer(l_value_32.count)
			else
				buf.put_integer(l_value.count)
			end
			buf.put_character(',')
			if is_string_32 then
				buf.put_integer (l_value_32.hash_code)
			else
				buf.put_integer (l_value.hash_code)
			end
			buf.put_character(')')
		end

	generate_il
			-- Generate IL code for string constant value.
		do
			if is_dotnet_string then
				il_generator.put_system_string (string_value)
			else
				if is_string_32 then
					il_generator.put_manifest_string_32 (string_value)
				else
					il_generator.put_manifest_string (string_value)
				end
			end
		end

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for a string constant value.
		local
			l_value: STRING
			l_value_32: STRING_32
		do
			if is_string_32 then
				ba.append (Bc_string32)
				l_value_32 := encoding_converter.utf8_to_utf32 (string_value)
					-- Bytes to read
				ba.append_integer (l_value_32.count * 4)
				ba.append_raw_string_32 (l_value_32)
			else
				ba.append (Bc_string)
				l_value := string_value
					-- Bytes to read
				ba.append_integer (l_value.count)
				ba.append_raw_string (l_value)
			end
		end

	dump: STRING
		do
			create Result.make (string_value.count + 2)
			Result.extend ('"')
			Result.append (string_value)
			Result.extend ('"')
		end

	append_signature (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add_char ('"')
			a_text_formatter.add_manifest_string (eiffel_string (string_value))
			a_text_formatter.add_char ('"')
		end

feature {NONE} -- Implementation

	system_string_id: INTEGER
			-- ID of SYSTEM_STRING if we are in IL code generation
			-- Otherwise, -1 (to avoid conflicts with basic type
			-- that have a class_id of 0).
		once
			if System.system_string_class /= Void and System.system_string_class.is_compiled then
				Result := System.system_string_id
			else
				Result := -1
			end
		end

	string_32_id: INTEGER
			-- Id of class STRING_32
		do
			if System.string_32_class /= Void and then System.string_32_class.is_compiled then
				Result := System.string_32_id
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
