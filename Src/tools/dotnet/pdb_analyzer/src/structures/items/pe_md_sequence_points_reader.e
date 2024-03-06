note
	description: "Summary description for {PE_MD_SEQUENCE_POINTS_READER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MD_SEQUENCE_POINTS_READER

inherit
	PE_MD_BLOB_READER
		rename
			make as make_reader
		end

create
	make

feature {NONE} -- Initialization

	make (mp: MANAGED_POINTER; pe: like associated_pdb_file; e: like associated_table_entry)
		do
			make_reader (mp)
			associated_pdb_file := pe
			associated_table_entry := e
		end

feature -- Access

	associated_pdb_file: detachable PDB_FILE

	associated_table_entry: detachable PDB_MD_TABLE_ENTRY

feature -- Implementation


end
