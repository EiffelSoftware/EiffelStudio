note
	description: "Summary description for {PE_ASSEMBLY_DEF_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ASSEMBLY_DEF_TABLE_ENTRY

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

	make_with_data (a_flags: INTEGER; a_major, a_minor, a_build, a_revision: NATURAL_16; a_name_index: NATURAL)
		do
			hash_alg_id := DefaultHashAlgId.to_natural_16
			flags := a_flags
			major := a_major
			minor := a_minor
			build := a_build
			revision := a_revision
			create name_index.make_with_index (a_name_index)
		end

feature -- Access

	hash_alg_id: NATURAL_16
			-- Defined as word two bytes.

	major, minor, build, revision: NATURAL_16
			-- Defined as word two bytes.
	flags: INTEGER

	public_key_index: detachable PE_BLOB
	name_index: PE_STRING
	culture_index: detachable PE_STRING

feature -- flags

	DefaultHashAlgId: INTEGER = 0x8004

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tAssemblyDef.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

end
