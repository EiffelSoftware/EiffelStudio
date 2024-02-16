note
	description: "[
			Class describing the CustomDebugInformation table.
			The CustomDebugInformation table has several columns and specific requirements.
			The table is required to be sorted by Parent.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=CustomDebugInformation", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#customdebuginformation-table-0x37", "protocol=uri"

class
	PE_CUSTOM_DEBUG_INFORMATION_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_parent_coded_index: NATURAL_32; a_tag: INTEGER_32; a_kind_index: NATURAL_32; a_value_index: NATURAL_32)
		do
			create parent_coded_index.make_with_tag_and_index (a_tag, a_parent_coded_index)
			create kind_index.make_with_index (a_kind_index)
			create value_index.make_with_index (a_value_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| The table is required to be sorted by Parent.

		do
			Result := Precursor (e)
				or else (
					e.parent_coded_index.is_equal (parent_coded_index) and then
					e.kind_index.is_equal (kind_index) and then
					e.value_index.is_equal (value_index)
				)
		end

feature -- Access

	parent_coded_index: PE_CODED_INDEX_BASE
			-- HasCustomDebugInformation coded index.
			-- https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#HasCustomDebugInformation

	kind_index: PE_GUID
			-- Guid heap index.

	value_index: PE_BLOB
			-- Blob heap index.

feature -- Custom Debug Information

	MethodDef: INTEGER = 0
	Field: INTEGER = 1
	TypeRef: INTEGER = 2
	TypeDef: INTEGER = 3
	Param: INTEGER = 4
	InterfaceImpl: INTEGER = 5
	MemberRef: INTEGER = 6
	Module: INTEGER = 7
	DeclSecurity: INTEGER = 8
	Property: INTEGER = 9
	Event: INTEGER = 10
	StandAloneSig: INTEGER = 11
	ModuleRef: INTEGER = 12
	TypeSpec: INTEGER = 13
	Assembly: INTEGER = 14
	AssemblyRef: INTEGER = 15
	File: INTEGER = 16
	ExportedType: INTEGER = 17
	ManifestResource: INTEGER = 18
	GenericParam: INTEGER = 19
	GenericParamConstraint: INTEGER = 20
	MethodSpec: INTEGER = 21
	Document: INTEGER = 22
	LocalScope: INTEGER = 23
	LocalVariable: INTEGER = 24
	LocalConstant: INTEGER = 25
	ImportScope: INTEGER = 26

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PDB_TABLES}.tcustomdebuginformation
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes_written: NATURAL_32
		do
				-- Initialize the number of bytes written to 0
			l_bytes_written := 0

				-- Render the parent_coded_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + parent_coded_index.render (a_sizes, a_dest, l_bytes_written)

				-- Render the kind_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + kind_index.render (a_sizes, a_dest, l_bytes_written)

				-- Render the value_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + value_index.render (a_sizes, a_dest, l_bytes_written)

				-- Return the total number of bytes written
			Result := l_bytes_written
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Initialize the number of bytes read to 0
			l_bytes := 0

				-- Read the parent_coded_index
			l_bytes := l_bytes + parent_coded_index.get (a_sizes, a_src, l_bytes)

				-- Read the kind_index
			l_bytes := l_bytes + kind_index.get (a_sizes, a_src, l_bytes)

				-- Read the value_index
			l_bytes := l_bytes + value_index.get (a_sizes, a_src, l_bytes)

				-- Return the total number of bytes read
			Result := l_bytes
		end

end

