note
	description: "Summary description for {MD_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ITERATOR

inherit
	MD_VISITOR
		redefine
			visit_emitter,
			visit_table,
			visit_table_entry,
			visit_index,
			visit_coded_index,
			visit_pointer_index
		end

feature -- Access

	visit_emitter (o: MD_EMIT)
		do
			across
				o.tables as t
			loop
				if attached {MD_TABLE} t as tb then
					tb.accepts (Current)
				end
			end
		end

	visit_table (o: MD_TABLE)
		do
			across
				o as e
			loop
				e.accepts (Current)
			end
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

	visit_pointer_index (o: PE_POINTER_INDEX)
		do
		end

feature {NONE} -- Helpers		

	safe_accepts (o: detachable MD_VISITABLE)
		do
			if o /= Void then
				o.accepts (Current)
			end
		end

end

