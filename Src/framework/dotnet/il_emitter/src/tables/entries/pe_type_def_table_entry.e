note
	description: "Summary description for {PE_TYPEDEF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_DEF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

	PE_TYPE_DEF_FLAGS

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_type_name_index: NATURAL_64; a_type_name_space_index: NATURAL_64;
			a_extends: PE_TYPEDEF_OR_REF; a_field_index: NATURAL_64; a_method_index: NATURAL_64)
		do
			flags := a_flags
			create type_name_index.make_with_index (a_type_name_index)
			create type_name_space_index.make_with_index (a_type_name_space_index)
			extends := a_extends
			create fields.make_with_index (a_field_index)
			create methods.make_with_index (a_method_index)
		end

feature -- Access

	flags: INTEGER

	type_name_index: PE_STRING

	type_name_space_index: PE_STRING

	extends: PE_TYPEDEF_OR_REF

	fields: PE_FIELD_LIST

	methods: PE_METHOD_LIST

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.ttypedef.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
			-- <Precursor>
		local
			l_bytes: NATURAL_64
		do
				-- Write the flags to the destination buffer `a_dest`.
			{BYTE_ARRAY_HELPER}.put_array_natural_32_with_integer_32 (a_dest.to_special, flags, 0)

				-- Initialize the number of bytes written
			l_bytes := 4

				-- Write the type_name_index, type_name_space_index, extends, fields and methods
				-- to the buffer and update the number of bytes.

			l_bytes := l_bytes + type_name_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space_index.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + extends.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + fields.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + methods.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the total number of bytes written.
			Result := l_bytes
		 end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Set the flags (from a_src)  to the flags.
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_integer_32 (a_src, 0)

				-- Initialize the number of bytes readed.
			l_bytes := 4

				-- Get the type_name_index, type_namespace_index, extends, fields, and methods and
				-- update the number of bytes.

			l_bytes := l_bytes + type_name_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space_index.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + extends.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + fields.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + methods.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes readed.
			Result := l_bytes
		end

end
