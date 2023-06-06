note
	description: "Object representing theTypeSpe table"
	date: "$Date$"
	revision: "$Revision$"
	see:  "II.22.39 TypeSpec : 0x1B "


class
	PE_TYPE_SPEC_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_signature_index: NATURAL_64)
		do
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			n: NATURAL_64
		do
			n := 0
			across
				tables as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					e.signature_index.is_equal (signature_index)
				then
					Result := n
				end
			end
		end

feature -- Access

	signature_index: PE_BLOB
			-- index into the Blob heap.

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.ttypespec.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		do
			Result := signature_index.render (a_sizes, a_dest, 0)
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		do
			Result := signature_index.get (a_sizes, a_src, 0)
		end

end
