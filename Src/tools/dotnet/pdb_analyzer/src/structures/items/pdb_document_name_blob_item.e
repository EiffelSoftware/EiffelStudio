note
	description: "Summary description for {PDB_DOCUMENT_NAME_BLOB_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_DOCUMENT_NAME_BLOB_ITEM

inherit
	PE_BLOB_ITEM
		redefine
			to_string
		end

create
	make_from_item

convert
	dump: {READABLE_STRING_8, STRING_8}

feature -- Additional access

	associated_pdb_file: detachable PDB_FILE

	set_associated_pdb_file (pe: like associated_pdb_file)
		do
			associated_pdb_file := pe
		end

	associated_table_entry: detachable PDB_MD_TABLE_ENTRY

	set_associated_table_entry (e: like associated_table_entry)
		do
			associated_table_entry := e
		end

feature -- Conversion

	to_string: STRING_32
		local
			l_reader: PE_MD_DOCUMENT_NAME_READER
			n8: NATURAL_8
			sep: CHARACTER_8
			blob_idx: NATURAL_32
		do
			if Result = Void then
				create l_reader.make (pointer, associated_pdb_file, associated_table_entry)
				if attached associated_pdb_file as pdb_file then
					n8 := l_reader.read_natural_8_le
					sep := n8.to_character_8
					from
						create Result.make_empty
					until
						l_reader.exhausted
					loop
						blob_idx := l_reader.uncompressed_value.to_natural_32
						if blob_idx = 0 then
							Result.append_character (sep)
						elseif attached pdb_file.blob_heap_item_at (blob_idx) as l_blob_item then
							if Result.count > 0 then
								Result.append_code (n8)
							end
							Result.append ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_blob_item.as_utf8_string))
						end
					end
				else
					Result := {STRING_32} " <<" + l_reader.dump + ">>"
				end
			end
			if Result [1] = ' ' then
				Result.remove_head (1)
			end
		rescue
			Result := "!<<" + dump + ">>"
			retry
		end

end

