indexing
	description: "Eiffel components"
	external_name: "ISE.Reflection.EiffelComponents"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end
		
class
	EIFFEL_COMPONENTS
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do
		end
		
feature -- Access

	assembly_factory: EIFFEL_ASSEMBLY_FACTORY
		indexing
			description: "Assembly factory"
			external_name: "AssemblyFactory"
		end
		
	eiffel_class: EIFFEL_CLASS
		indexing
			description: "Eiffel class"
			external_name: "EiffelClass"
		end
		
	rename_clause: RENAME_CLAUSE
		indexing
			description: "Rename clause"
			external_name: "RenameClause"
		end	

	undefine_clause: UNDEFINE_CLAUSE
		indexing
			description: "Undefine clause"
			external_name: "UndefineClause"
		end

	redefine_clause: REDEFINE_CLAUSE
		indexing
			description: "Redefine clause"
			external_name: "RedefineClause"
		end

	select_clause: SELECT_CLAUSE
		indexing
			description: "Select clause"
			external_name: "SelectClause"
		end

	export_clause: EXPORT_CLAUSE
		indexing
			description: "Export clause"
			external_name: "ExportClause"
		end

	named_signature_type: NAMED_SIGNATURE_TYPE
		indexing
			description: "Named signature type"
			external_name: "NamedSignatureType"
		end
		
	formal_named_signature_type: FORMAL_NAMED_SIGNATURE_TYPE
		indexing
			description: "Formal named signature type"
			external_name: "FormalNamedSignatureType"
		end
		
end -- class EIFFEL_COMPONENTS
