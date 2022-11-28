note
	description: "Summary description for {PE_ASSEMBLY_REF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ASSEMBLY_REF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_flags: INTEGER; a_major, a_minor, a_build, a_revision: NATURAL_16; a_name_index: NATURAL_64; a_key_index: NATURAL_64)
		do
			flags := a_flags
			major := a_major
			minor := a_minor
			build := a_build
			revision := a_revision
			create name_index.make_with_index (a_name_index)
			create public_key_index.make_with_index (a_key_index)

		end

feature -- Access

	major: NATURAL_16

	minor: NATURAL_16

	build: NATURAL_16

	revision: NATURAL_16

	flags: INTEGER

	public_key_index: PE_BLOB

	name_index: PE_STRING

	culture_index: detachable PE_STRING

	hash_index: detachable PE_BLOB


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tassemblyref.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end
