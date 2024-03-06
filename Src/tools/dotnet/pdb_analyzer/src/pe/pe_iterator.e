note
	description: "Summary description for {PE_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ITERATOR

inherit
	PE_VISITOR
		redefine
			visit_pdb_file,
			visit_root,
			visit_tables,
			visit_table,
			visit_table_entry,
			visit_item,
			visit_string_heap,
			visit_user_string_heap,
			visit_guid_heap,
			visit_blob_heap
		end

feature -- Visitor

	visit_pdb_file (o: PDB_FILE)
		do
			o.metadata_root.accepts (Current)
			o.metadata_tables.accepts (Current)
			o.metadata_string_heap.accepts (Current)
			o.metadata_user_string_heap.accepts (Current)
			o.metadata_guid_heap.accepts (Current)
			o.metadata_blob_heap.accepts (Current)
		end

	visit_root (o: PDB_ROOT)
		do
		end

	visit_tables (o: PDB_MD_TABLES)
		do
			across
				o.tables as ic
			loop
				if attached ic.item as tb then
					tb.accepts (Current)
				end
			end
		end

	visit_table (o: PDB_MD_TABLE [PDB_MD_TABLE_ENTRY])
		local
			i: NATURAL_32
		do
			across
				o.entries as ic
			loop
				if attached ic.item as e then
					e.accepts (Current)
				end
				i := i + 1
			end
		end

	visit_table_entry (o: PDB_MD_TABLE_ENTRY)
		do
			if attached {PE_MD_TABLE_ENTRY_WITH_STRUCTURE} o as e then
				across
					e.structure.items as ic
				loop
					if attached ic.item as i then
						i.accepts (Current)
					end
				end
			end
		end

	visit_item (o: PE_ITEM)
		do
		end

	visit_string_heap (o: PE_STRING_HEAP)
		do
		end
	visit_user_string_heap (o: PE_USER_STRING_HEAP)
		do
		end
	visit_guid_heap (o: PE_GUID_HEAP)
		do
		end
	visit_blob_heap (o: PE_BLOB_HEAP)
		do
		end


end
