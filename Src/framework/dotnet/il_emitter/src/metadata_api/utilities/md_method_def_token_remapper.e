note
	description: "[
		Visitor to update metadata tables using Field token...
		
		Usage of MethodDef token:
			TypeDef (Methods)
			CustomAttribute (Parent, Type)
			MethodImpl  (MethodBody, MethodDeclaration)
			MethodSpec (Method)
			ImplMap (MemberForwarded)
			DeclSecurity (Parent)
			MemberRef (Class=parent_index)
			GenericParam (Owner)
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_DEF_TOKEN_REMAPPER

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
	make,
	make_using_pointer_table

feature {NONE} -- Initialization

	make (a_remapper: MD_REMAP_TOKEN_MANAGER)
		do
			remapper := a_remapper
		end

	make_using_pointer_table (a_remapper: MD_REMAP_TOKEN_MANAGER)
		do
			remapper := a_remapper
			is_using_method_pointer_table := True
		end

feature -- Access

	remapper: MD_REMAP_TOKEN_MANAGER

	is_using_method_pointer_table: BOOLEAN
			-- Is using MethodPointer table?

feature -- Visitor

	visit_table (tb: MD_TABLE)
		do
			if is_using_method_pointer_table then
				if
					tb.table_id = {PE_TABLES}.ttypedef
					or tb.table_id = {PE_TABLES}.tcustomattribute
				then
						-- Update only the TypeDef, and CustomAttribute tables!
					Precursor (tb)
				end
			else
				inspect
					tb.table_id
				when
					{PE_TABLES}.ttypedef,
					{PE_TABLES}.tcustomattribute,
					{PE_TABLES}.tmethodimpl,
					{PE_TABLES}.tmethodspec,
					{PE_TABLES}.timplmap
	--				,{PE_TABLES}.tdeclsecurity	-- Not Implemented
					,{PE_TABLES}.tmemberref
					,{PE_TABLES}.tgenericparam
				then
					Precursor (tb)
				else
					-- Table not impacted
				end
			end
		end

	visit_table_entry (e: PE_TABLE_ENTRY_BASE)
		do
			if attached {PE_TYPE_DEF_TABLE_ENTRY} e as l_typedef then
				l_typedef.methods.accepts (Current)
			elseif attached {PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY} e as l_ca then
				safe_accepts (l_ca.parent_index)
				safe_accepts (l_ca.type_index)
			elseif attached {PE_METHOD_IMPL_TABLE_ENTRY} e as l_mi then
				safe_accepts (l_mi.method_body)
				safe_accepts (l_mi.method_declaration)
			elseif attached {PE_METHOD_SPEC_TABLE_ENTRY} e as l_ms then
				safe_accepts (l_ms.method)
			elseif attached {PE_IMPL_MAP_TABLE_ENTRY} e as l_imp then
				safe_accepts (l_imp.method_index)
--			elseif attached {PE_DECL_SECURITY_TABLE_ENTRY} e as l_ds then
--				safe_accepts (l_ds.parent)
			elseif attached {PE_MEMBER_REF_TABLE_ENTRY} e as l_mr then
				safe_accepts (l_mr.parent_index)
			elseif attached {PE_GENERIC_PARAM_TABLE_ENTRY} e as l_ge then
				safe_accepts (l_ge.owner)
			else
				Precursor (e)
			end
		end

	visit_index (idx: PE_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tmethoddef)
		end

	visit_coded_index (idx: PE_CODED_INDEX_BASE)
		do
			remapper.remap_index (idx, {PE_TABLES}.tmethoddef)
		end

	visit_pointer_index (idx: PE_POINTER_INDEX)
		do
			remapper.remap_index (idx, {PE_TABLES}.tmethoddef)
		end


end
