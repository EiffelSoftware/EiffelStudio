note
	description: "Object representing theTypeSpe table"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=TypeSpec", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=274&zoom=100,116,540", "protocol=uri"

class
	PE_TYPE_SPEC_TABLE_ENTRY

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

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| There shall be no duplicate rows, based upon Signature
		do
			Result := Precursor (e)
				or else (
					e.signature_index.is_equal (signature_index)
				)
		end

feature -- Access

	signature_index: PE_BLOB
			-- index into the Blob heap.

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.ttypespec
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		do
			Result := signature_index.render (a_sizes, a_dest, 0)
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		do
			Result := signature_index.rendering_size (a_sizes)
		end

end
