note
	description: "[
		Visitor to update metadata tables using Field token...
		
		Usage of Field token:
			TypeDef (Fields)
			CustomAttributes (Parent)
			Constant (Parent)
			FieldMarshal (Parent)
			ImplMap (MemberForwarded)
			FieldLayout (Not Used)
			FieldRVA (Not Used)
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_FIELD_TOKEN_REMAPPER

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
				{PE_TABLES}.ttypedef,
				{PE_TABLES}.tcustomattribute,
				{PE_TABLES}.tconstant
--				, {PE_TABLES}.tfieldmarshal -- Not Implemented
--				, {PE_TABLES}.timplmap -- Not Implemented
--				, {PE_TABLES}.tfieldlayout -- Not Used
--				, {PE_TABLES}.tfieldrva    -- Not Used
			then
				Precursor (tb)
			else
				-- Table not impacted
			end
		end

	visit_table_entry (e: PE_TABLE_ENTRY_BASE)
		do
			if attached {PE_TYPE_DEF_TABLE_ENTRY} e as l_typedef then
				safe_accepts (l_typedef.fields)
			elseif attached {PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY} e as l_ca then
				safe_accepts (l_ca.parent_index)
			elseif attached {PE_CONSTANT_TABLE_ENTRY} e as l_cst then
				safe_accepts (l_cst.parent_index)
--			elseif attached {PE_FIELD_MARSHAL_TABLE_ENTRY} e as l_fm then
--				safe_accepts (l_fm.parent_index)
			elseif attached {PE_IMPL_MAP_TABLE_ENTRY} e as l_impl then
				safe_accepts (l_impl.method_index)
			else
				Precursor (e)
			end
		end

	visit_index (idx: PE_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tfield)
		end

	visit_coded_index (idx: PE_CODED_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tfield)
		end


end
