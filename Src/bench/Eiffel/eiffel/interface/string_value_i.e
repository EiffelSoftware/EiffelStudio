indexing
	description: "Description of a manifest string constant."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_VALUE_I 

inherit
	VALUE_I
		rename
			string_value as internal_string_value
		redefine
			is_string, append_signature,
			internal_string_value
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	CHARACTER_ROUTINES
		export
			{NONE} all
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := string_value.is_equal (other.string_value)
		end

feature -- Access

	string_value: STRING
			-- Integer constant value

feature -- Status Report

	is_dotnet_string: BOOLEAN
			-- Is current a manifest System.String constant?

	is_string: BOOLEAN is True
			-- Is the current constant a string one ?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t' ?
		local
			class_type: CL_TYPE_A
		do
			class_type ?= t
			check
				class_type /= Void
			end
			Result := class_type /= Void and then class_type.class_id = System.string_id
		end

	internal_string_value: STRING is
		do
			Result := eiffel_string (string_value)
		end

feature -- Settings

	set_string_value (s: STRING) is
			-- Set `string_value' with `s'.
		require
			s_not_void: s /= Void
		do
			string_value := s
		ensure
			string_value_set: string_value = s
		end

	set_system_string_value (s: STRING) is
			-- Set `string_value' with `s' and
			-- set `is_dotnet_string' to True.
		require
			s_not_void: s /= Void
		do
			is_dotnet_string := True
			string_value := s
		ensure
			is_dotnet_string: is_dotnet_string
			string_value_set: string_value = s
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring ("RTMS_EX(%"")
			buffer.escape_string (buffer,string_value)
			buffer.putchar('"')
			buffer.putchar(',')
			buffer.putint(string_value.count)
			buffer.putchar (')')
		end

	generate_il is
			-- Generate IL code for string constant value.
		do
			il_generator.put_manifest_string (string_value)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a string constant value.
		do
			ba.append (Bc_string)
			ba.append_integer (string_value.count)
			ba.append_raw_string (string_value)
		end

	dump: STRING is
		do
			create Result.make (string_value.count + 2)
			Result.extend ('"')
			Result.append (string_value)
			Result.extend ('"')
		end

	append_signature (st: STRUCTURED_TEXT) is
		do
			st.add_char ('"')
			st.add_string (eiffel_string (string_value))
			st.add_char ('"')
		end

end
