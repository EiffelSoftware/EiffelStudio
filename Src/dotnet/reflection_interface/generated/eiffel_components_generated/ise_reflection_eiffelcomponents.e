indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.EiffelComponents"
external class
	ISE_REFLECTION_EIFFELCOMPONENTS

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelComponents"
		end

feature -- Access

	frozen rename_clause: ISE_REFLECTION_RENAMECLAUSE is
		external
			"IL field signature :ISE.Reflection.RenameClause use ISE.Reflection.EiffelComponents"
		alias
			"RenameClause"
		end

	frozen redefine_clause: ISE_REFLECTION_REDEFINECLAUSE is
		external
			"IL field signature :ISE.Reflection.RedefineClause use ISE.Reflection.EiffelComponents"
		alias
			"RedefineClause"
		end

	frozen export_clause: ISE_REFLECTION_EXPORTCLAUSE is
		external
			"IL field signature :ISE.Reflection.ExportClause use ISE.Reflection.EiffelComponents"
		alias
			"ExportClause"
		end

	frozen select_clause: ISE_REFLECTION_SELECTCLAUSE is
		external
			"IL field signature :ISE.Reflection.SelectClause use ISE.Reflection.EiffelComponents"
		alias
			"SelectClause"
		end

	frozen eiffel_assembly_factory: ISE_REFLECTION_EIFFELASSEMBLYFACTORY is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyFactory use ISE.Reflection.EiffelComponents"
		alias
			"EiffelAssemblyFactory"
		end

	frozen undefine_clause: ISE_REFLECTION_UNDEFINECLAUSE is
		external
			"IL field signature :ISE.Reflection.UndefineClause use ISE.Reflection.EiffelComponents"
		alias
			"UndefineClause"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelComponents"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_EIFFELCOMPONENTS
