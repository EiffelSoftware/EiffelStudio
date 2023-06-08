note
	description: "Object representing The ExportedType table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ExportedType", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=248&zoom=100,116,324", "protocol=uri"

class
	PE_EXPORTED_TYPE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

	PE_TYPE_DEF_FLAGS

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: NATURAL_32; a_type_def_id: NATURAL_32; a_type_name: NATURAL_32; a_type_name_space: NATURAL_32; a_implementation: PE_IMPLEMENTATION)
		do
			flags := a_flags
			create type_def_id.make_with_index (a_type_def_id)
			create type_name.make_with_index (a_type_name)
			create type_name_space.make_with_index (a_type_name_space)
			implementation := a_implementation
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			-- There shall be no duplicate rows, in this concatenated table, based upon FullName
			--| The term FullName: refers to the string created as follows: if the TypeNamespace is null, then
			--| use the TypeName, otherwise use the concatenation of Typenamespace, '.', and TypeName.
		do
			Result := Precursor (e)
				or else (
					e.type_name.is_equal (type_name) and then
					e.type_name_space.is_equal (type_name_space)
				)
		end

feature -- Access

	flags: NATURAL_32
			-- Defined as a DWord four bytes.
			-- see TypeAttributes https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=280&zoom=100,116,400

	type_def_id: PE_TYPE_DEF
			-- a 4-byte index into a TypeDef

	type_name: PE_STRING
			-- an index into the String heap.

	type_name_space: PE_STRING
			-- an index into the String heap.

	implementation: PE_IMPLEMENTATION
			-- an index into one of the following tables
			-- File, ExportedType, AssemblyRef

feature -- Operations

	table_index: INTEGER
		once
			fixme ("Double check if tManifestResource its ok or tExportedType is the correct one. ")
			Result := {PE_TABLES}.tExportedtype.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
			{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, flags, 0)

			l_bytes := 4

				-- Write type_def_id, type_name, type_name_space, implemenation and update bytes

			l_bytes := l_bytes + type_def_id.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + type_name_space.render (a_sizes, a_dest, l_bytes.to_integer_32)
			l_bytes := l_bytes + implementation.render (a_sizes, a_dest, l_bytes.to_integer_32)

			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
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
