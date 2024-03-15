note
	description: "Summary description for {PDB_IMPORTS_BLOB_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_IMPORTS_BLOB_ITEM

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
			l_reader: PE_MD_IMPORTS_READER
			err: BOOLEAN
			blob_idx: NATURAL_32
			l_kind: NATURAL_32
			n32: NATURAL_32
		do
			if Result = Void then
				create Result.make_empty
				Result.append (dump)
				if attached associated_pdb_file as pdb_file then
					create l_reader.make (pointer, pdb_file, associated_table_entry)
					from
					until
						l_reader.exhausted or err
					loop
						l_kind := l_reader.uncompressed_value.to_natural_32
						Result.append (" (")
						inspect
							l_kind
						when 1 then -- Imports members of target-namespace.
							Result.append ("Imports members of target-namespace ")
							n32 := l_reader.uncompressed_value.to_natural_32
							if attached pdb_file.blob_heap_item_at (n32) as l_blob_item then
								Result.append (" %"")
								Result.append ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_blob_item.as_utf8_string))
								Result.append ("%"")
							else
								Result.append (" Blob[0x" + n32.to_hex_string + "]")
							end
						when 2 then -- Imports members of target-namespace defined in assembly target-assembly.
							Result.append ("Imports members of target-namespace defined in assembly target-assembly.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						when 3 then -- Imports members of target-type.
							Result.append ("Imports members of target-type.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" TypeDefOrRefOrSpecEncoded [0x" + n32.to_hex_string + "]")
						when 4 then -- Imports members of XML namespace target-namespace with prefix alias.
							Result.append ("Imports members of XML namespace target-namespace with prefix alias.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						when 5 then -- Imports assembly reference alias defined in an ancestor scope.
							Result.append ("Imports assembly reference alias defined in an ancestor scope.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						when 6 then -- Defines an alias for assembly target-assembly.
							Result.append ("Defines an alias for assembly target-assembly.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						when 7 then -- Defines an alias for the target-namespace.
							Result.append ("Defines an alias for the target-namespace.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						when 8 then -- Defines an alias for the part of target-namespace defined in assembly target-assembly.
							Result.append ("Defines an alias for the part of target-namespace defined in assembly target-assembly.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						when 9 then -- Defines an alias for the target-type.
							Result.append ("Defines an alias for the target-type.")
							n32 := l_reader.uncompressed_value.to_natural_32
							Result.append (" Blob[0x" + n32.to_hex_string + "]")
						else
							Result.append ("Unknown kind")
							err := True
						end
						Result.append (")")
					end
--					from
--						create Result.make_empty
--					until
--						l_reader.exhausted
--					loop
--						blob_idx := l_reader.uncompressed_value.to_natural_32
--						if attached pdb_file.blob_heap_item_at (blob_idx) as l_blob_item then
--							if Result.count > 0 then
--								Result.append_code (n8)
--							end
--							Result.append ({UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_blob_item.as_utf8_string))
--						end
--					end
				else
					Result := {STRING_32} " <<" + dump + ">>"
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

