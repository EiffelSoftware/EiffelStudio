indexing
	description: "Eiffel components"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end
		
class
	EIFFEL_COMPONENTS
		
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
		do
		end
		
feature -- Access

	assembly_factory: EIFFEL_ASSEMBLY_FACTORY
		indexing
			description: "Assembly factory"
		end
		
	eiffel_class: EIFFEL_CLASS
		indexing
			description: "Eiffel class"
		end
		
	rename_clause: RENAME_CLAUSE
		indexing
			description: "Rename clause"
		end	

	undefine_clause: UNDEFINE_CLAUSE
		indexing
			description: "Undefine clause"
		end

	redefine_clause: REDEFINE_CLAUSE
		indexing
			description: "Redefine clause"
		end

	select_clause: SELECT_CLAUSE
		indexing
			description: "Select clause"
		end

	export_clause: EXPORT_CLAUSE
		indexing
			description: "Export clause"
		end

	named_signature_type: NAMED_SIGNATURE_TYPE
		indexing
			description: "Named signature type"
		end
		
	formal_named_signature_type: FORMAL_NAMED_SIGNATURE_TYPE
		indexing
			description: "Formal named signature type"
		end
		
end -- class EIFFEL_COMPONENTS
