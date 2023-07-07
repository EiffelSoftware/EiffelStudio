note
	description: "[
		Visitor to update metadata tables using Field token...
		
		Updated usages of Field and Method tokens
		Usage of Field token:
			TypeDef
			CustomAttributes (Parent, Type)
			Constant (Parent)
			FieldMarshal (Parent)
			ImplMap (MemberForwarded)
			FieldLayout (Not Used)
			FieldRVA (Not Used)
		Usage of MethodDef token:
			TypeDef
			CustomAttribute (Parent, Type)
			MethodImpl  (MethodBody, MethodDeclaration)
			MethodSpec (Method)
			ImplMap (MemberForwarded)
			Constant (Parent)
			FieldMarshal (Parent)
			DeclSecurity (Parent)
			MemberRef (Class)
			GenericParam (Owner)
			Event (Not Used)
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
			visit_index
		end

create
	make

feature {NONE} -- Initialization

	make (a_remapper: MD_REMAP_TOKEN_MANAGER)
		do

		end

feature -- Access

	remapper: MD_REMAP_TOKEN_MANAGER

feature -- Visitor

	visit_table (tb: MD_TABLE)
		do
			inspect
				tb.table_id.to_natural_32
			when {PE_TABLES}.ttypedef then
				Precursor (tb)
			else
				-- Table not impacted
			end
		end

	visit_table_entry (e: PE_TABLE_ENTRY_BASE)
		do
			if attached {PE_TYPE_DEF_TABLE_ENTRY} e as l_typedef then
				l_typedef.methods.accepts (Current)
			else
				Precursor (e)
			end
		end

	visit_index (idx: PE_INDEX_BASE)
		do
			-- FIXME jfiat [2023/07/07] : not all indexes are pure MethodDef token
			-- some may be MethodDef or ... indexes.
			-- so this code needs to be smarter and check if this is really a MethodDef token
			
			remapper.remap_index (idx)
		end


end
