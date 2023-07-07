note
	description: "[
		Visitor to update metadata tables using Field token...
		
		Usage of Field token:
			TypeDef
			CustomAttributes (Parent, Type)
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
			visit_index
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
--				, {PE_TABLES}.timplmap -- Not Implement
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
				safe_accepts (l_ca.type_index)
			elseif attached {PE_CONSTANT_TABLE_ENTRY} e as l_cst then
				safe_accepts (l_cst.parent_index)
--			elseif attached {PE_FIELD_MARSHAL_TABLE_ENTRY} e as l_fm then
--				safe_accepts (l_fm.parent_index)
--			elseif attached {PE_IMPL_MAP_TABLE_ENTRY} e as l_impl then
--				safe_accepts (l_impl.member_forward_index)
			else
				Precursor (e)
			end
		end

	safe_accepts (o: detachable MD_VISITABLE)
		do
			if o /= Void then
				o.accepts (Current)
			end
		end

	visit_index (idx: PE_INDEX_BASE)
		do
			-- FIXME jfiat [2023/07/07] : not all indexes are pure Field token
			-- some may be Field or ... indexes.
			-- so this code needs to be smarter and check if this is really a Field token
			remapper.remap_index (idx)
		end


end
