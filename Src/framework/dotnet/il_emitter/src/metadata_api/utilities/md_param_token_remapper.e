note
	description: "[
		Visitor to update metadata tables using Param token...

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PARAM_TOKEN_REMAPPER

inherit
	MD_ITERATOR
		redefine
			visit_table,
			visit_table_entry,
			visit_index,
			visit_coded_index,
			visit_pointer_index
		end

create
	make

feature {NONE} -- Initialization

	make (a_remapper: MD_REMAP_TOKEN_MANAGER)
		do
			remapper := a_remapper
		end

feature -- Access

	remapper: MD_REMAP_TOKEN_MANAGER

feature -- Visitor

	last_table_id: NATURAL_32
	last_table_entry_index: NATURAL_32
	last_table_entry_token: NATURAL_32

	visit_table (tb: MD_TABLE)
		do
			last_table_id := tb.table_id
			last_table_entry_index := 0
			last_table_entry_token := 0
			inspect
				tb.table_id
			when
				{PE_TABLES}.tmethoddef
			then
				Precursor (tb)
			else
				-- Table not impacted
			end
		end

	visit_table_entry (e: PE_TABLE_ENTRY_BASE)
		do
			last_table_entry_index := last_table_entry_index + 1
			last_table_entry_token := (last_table_id |<< 24) | last_table_entry_index

			if attached {PE_METHOD_DEF_TABLE_ENTRY} e as l_methoddef then
				l_methoddef.param_index.accepts (Current)
			else
				Precursor (e)
			end
		end

	visit_index (idx: PE_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tparam, last_table_entry_token)
		end

	visit_coded_index (idx: PE_CODED_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tparam, last_table_entry_token)
		end

	visit_pointer_index (idx: PE_POINTER_INDEX)
		do
			remapper.remap_index (idx, {PE_TABLES}.tparam, last_table_entry_token)
		end


end
