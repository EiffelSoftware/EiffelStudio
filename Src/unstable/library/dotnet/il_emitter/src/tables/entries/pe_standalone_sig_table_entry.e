note
	description: "Summary description for {PE_STANDALONE_SIG_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_STANDALONE_SIG_TABLE_ENTRY

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

	make_with_data (a_signature_index: NATURAL)
		do
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	signature_index: PE_BLOB

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tStandaloneSig.value.to_integer_32
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
