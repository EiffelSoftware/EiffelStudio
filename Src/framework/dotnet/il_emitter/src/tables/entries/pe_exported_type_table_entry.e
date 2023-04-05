note
	description: "Summary description for {PE_EXPORTED_TYPE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EXPORTED_TYPE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

	PE_TYPE_DEF_FLAGS

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: NATURAL_32; a_type_def_id: NATURAL_64; a_type_name: NATURAL_64; a_type_name_space: NATURAL_64; a_implementation: PE_IMPLEMENTATION)
		do
			flags := a_flags
			create type_def_id.make_with_index (a_type_def_id)
			create type_name.make_with_index (a_type_name)
			create type_name_space.make_with_index (a_type_name_space)
			implementation := a_implementation
		end

feature -- Access

	flags: NATURAL_32
			-- Defined as a DWord four bytes.

	type_def_id: PE_TYPE_DEF

	type_name: PE_STRING

	type_name_space: PE_STRING

	implementation: PE_IMPLEMENTATION

feature -- Operations

	table_index: INTEGER
		do
			fixme ("Double check if tManifestResource its ok or tExportedType is the correct one. ")
			Result := {PE_TABLES}.tExportedtype.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest.to_special, flags, 0)

			l_bytes := 4

				-- Write type_def_id, type_name, type_name_space, implemenation and update bytes

			l_bytes := l_bytes + type_def_id.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + implementation.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
			flags := {BYTE_ARRAY_HELPER}.byte_array_to_natural_32 (a_src, 0)

			l_bytes := 4

				-- Get type_def_id, type_name, type_name_space, implemenation and update bytes

			l_bytes := l_bytes + type_def_id.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space.get (a_sizes, a_src, l_bytes.to_integer_32)
			l_bytes := l_bytes + implementation.get (a_sizes, a_src, l_bytes.to_integer_32)

			Result := l_bytes
		end

end
