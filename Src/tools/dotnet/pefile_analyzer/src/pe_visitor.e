note
	description: "Summary description for {PE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_VISITOR

feature -- Visitor

	visit_pe_file (o: PE_FILE)
		do
		end

	visit_root (o: PE_MD_ROOT)
		do
		end


	visit_tables (o: PE_MD_TABLES)
		do
		end

	visit_table (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
		do
		end

	visit_table_entry (o: PE_MD_TABLE_ENTRY)
		do
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
