note
	description: "Summary description for {PE_FILE_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FILE_TABLE_ENTRY

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

	make_with_data (a_flags: NATURAL; a_name: NATURAL; a_hash: NATURAL)
		do
			flags := a_flags
			create name.make_with_index (a_name)
			create hash.make_with_index (a_hash)
		end

feature -- Access

	flags: NATURAL
			-- Defined as a DWord four bytes.

	name: PE_STRING

	hash: PE_BLOB

feature -- Flags

	ContainsMetaData: INTEGER = 0
	
	ContainsNoMetaData: INTEGER = 1

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tfile.value.to_integer_32
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
