indexing
	description: "Eiffel components"
	external_name: "ISE.Reflection.EiffelComponents"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end
--			create {SYSTEM_REFLECTION_ASSEMBLYDELAYSIGNATTRIBUTE}.make_assemblydelaysignattribute (False) end,
--			create {SYSTEM_REFLECTION_ASSEMBLYKEYFILEATTRIBUTE}.make_assemblykeyfileattribute ("Key") end,
--			create {SYSTEM_REFLECTION_ASSEMBLYKEYNAMEATTRIBUTE}.make_assemblykeynameattribute ("") end,
--			create {SYSTEM_OBSOLETEATTRIBUTE}.make_obsoleteattribute end
		
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

	eiffel_assembly_factory: EIFFEL_ASSEMBLY_FACTORY
		indexing
			description: "Eiffel assembly factory"
			external_name: "EiffelAssemblyFactory"
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
		
end -- class EIFFEL_COMPONENTS
