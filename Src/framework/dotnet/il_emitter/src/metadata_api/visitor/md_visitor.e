note
	description: "Summary description for {MD_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_VISITOR

feature -- Access

	visit_emitter (o: MD_EMIT)
		do
		end

	visit_table (o: MD_TABLE)
		do
		end

	visit_table_entry (o: PE_TABLE_ENTRY_BASE)
		do
		end

	visit_index (o: PE_INDEX_BASE)
		do
		end

	visit_coded_index (o: PE_CODED_INDEX_BASE)
		do
		end

end
