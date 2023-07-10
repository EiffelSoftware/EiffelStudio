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
			visit_coded_index
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

	visit_table (tb: MD_TABLE)
		do
			inspect
				tb.table_id.to_natural_32
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
			if attached {PE_METHOD_DEF_TABLE_ENTRY} e as l_methoddef then
				l_methoddef.param_index.accepts (Current)
			else
				Precursor (e)
			end
		end

	visit_index (idx: PE_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tparam)
		end

	visit_coded_index (idx: PE_CODED_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tparam)
		end


end
