note
	description: "Object representing the table StandAloneSig"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=StandAloneSig", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=269&zoom=100,116,169", "protocol=uri"

class
	PE_STANDALONE_SIG_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_signature_index: NATURAL_32)
		do
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	signature_index: PE_BLOB
			-- an index into the Blob heap.

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| Duplicate rows are allowed.
		do
			Result := Precursor (e)
				or else (
					e.signature_index.is_equal (signature_index)
				)
		end

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tStandaloneSig
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		do
				-- Write signature_index and return the number of bytes.
			Result := signature_index.render (a_sizes, a_dest, 0)
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		do
				-- Read the signature_index fromt he buffer and return the number of bytes.
			Result := signature_index.rendering_size (a_sizes)
		end

end
