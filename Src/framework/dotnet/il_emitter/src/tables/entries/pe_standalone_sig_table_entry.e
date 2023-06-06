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
			token_from_tables
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_signature_index: NATURAL_64)
		do
			create signature_index.make_with_index (a_signature_index)
		end

feature -- Access

	signature_index: PE_BLOB
			-- an index into the Blob heap.

feature -- Status

	token_from_tables (tables: MD_TABLES): NATURAL_64
			-- If Current was already defined in `tables` return the associated token.
		local
			lst: LIST [PE_TABLE_ENTRY_BASE]
			n: NATURAL_64
		do
			lst := tables.table
			n := 0
			across
				lst as i
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

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tStandaloneSig.to_integer_32
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
