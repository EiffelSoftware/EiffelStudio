note
	description: "Summary description for {PE_RESOLVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RESOLVER

inherit
	PE_ITERATOR
		redefine
			visit_pe_file,
			visit_root,
			visit_tables,
			visit_table,
			visit_table_entry,
			visit_item
		end

create
	make

feature {NONE} -- Access

	make (pe: PE_FILE)
		do
			pe_file := pe
		end

	pe_file: PE_FILE

feature -- Visitor

	visit_pe_file (o: PE_FILE)
		do
			check o = pe_file end
			o.metadata_root.accepts (Current)
			o.metadata_string_heap.accepts (Current)
			o.metadata_user_string_heap.accepts (Current)
			o.metadata_guid_heap.accepts (Current)
			o.metadata_blob_heap.accepts (Current)
			o.metadata_tables.accepts (Current)
		end

	visit_root (o: PE_MD_ROOT)
		do

			Precursor (o)
		end

	visit_tables (o: PE_MD_TABLES)
		do
			Precursor (o)
		end

	visit_table (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
		do
			Precursor (o)
		end

	table_entry_index: INTEGER

	visit_table_entry (o: PE_MD_TABLE_ENTRY)
		do
			Precursor (o)
		end

	visit_item (o: PE_ITEM)
		do
			Precursor (o)
		end

end
