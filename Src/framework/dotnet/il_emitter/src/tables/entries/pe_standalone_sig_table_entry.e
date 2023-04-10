note
	description: "Object representing the table StandAloneSig"
	date: "$Date$"
	revision: "$Revision$"
	see: "II.22.36 StandAloneSig : 0x11 "

class
	PE_STANDALONE_SIG_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_signature_index: NATURAL_64)
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

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		do
				-- Write signature_index and return the number of bytes.
			Result := signature_index.render (a_sizes, a_dest, 0)
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		do
				-- Read the signature_index fromt he buffer and return the number of bytes.
			Result := signature_index.get (a_sizes, a_src, 0)
		end

end
