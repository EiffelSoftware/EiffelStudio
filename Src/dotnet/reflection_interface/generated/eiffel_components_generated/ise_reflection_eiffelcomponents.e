indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	frozen a_internal_eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.EiffelComponents"
		alias
			"_internal_EiffelClass"
		end

	get_undefine_clause: ISE_REFLECTION_UNDEFINECLAUSE is
		external
			"IL signature (): ISE.Reflection.UndefineClause use ISE.Reflection.EiffelComponents"
		alias
			"get_UndefineClause"
		end

	get_rename_clause: ISE_REFLECTION_RENAMECLAUSE is
		external
			"IL signature (): ISE.Reflection.RenameClause use ISE.Reflection.EiffelComponents"
		alias
			"get_RenameClause"
		end

	frozen a_internal_undefine_clause: ISE_REFLECTION_UNDEFINECLAUSE is
		external
			"IL field signature :ISE.Reflection.UndefineClause use ISE.Reflection.EiffelComponents"
		alias
			"_internal_UndefineClause"
		end

	get_redefine_clause: ISE_REFLECTION_REDEFINECLAUSE is
		external
			"IL signature (): ISE.Reflection.RedefineClause use ISE.Reflection.EiffelComponents"
		alias
			"get_RedefineClause"
		end

	frozen a_internal_export_clause: ISE_REFLECTION_EXPORTCLAUSE is
		external
			"IL field signature :ISE.Reflection.ExportClause use ISE.Reflection.EiffelComponents"
		alias
			"_internal_ExportClause"
		end

	get_export_clause: ISE_REFLECTION_EXPORTCLAUSE is
		external
			"IL signature (): ISE.Reflection.ExportClause use ISE.Reflection.EiffelComponents"
		alias
			"get_ExportClause"
		end

	frozen a_internal_select_clause: ISE_REFLECTION_SELECTCLAUSE is
		external
			"IL field signature :ISE.Reflection.SelectClause use ISE.Reflection.EiffelComponents"
		alias
			"_internal_SelectClause"
		end

	frozen a_internal_rename_clause: ISE_REFLECTION_RENAMECLAUSE is
		external
			"IL field signature :ISE.Reflection.RenameClause use ISE.Reflection.EiffelComponents"
		alias
			"_internal_RenameClause"
		end

	get_select_clause: ISE_REFLECTION_SELECTCLAUSE is
		external
			"IL signature (): ISE.Reflection.SelectClause use ISE.Reflection.EiffelComponents"
		alias
			"get_SelectClause"
		end

	get_eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (): ISE.Reflection.EiffelClass use ISE.Reflection.EiffelComponents"
		alias
			"get_EiffelClass"
		end

	frozen a_internal_redefine_clause: ISE_REFLECTION_REDEFINECLAUSE is
		external
			"IL field signature :ISE.Reflection.RedefineClause use ISE.Reflection.EiffelComponents"
		alias
			"_internal_RedefineClause"
		end

feature -- Basic Operations

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelComponents"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_EIFFELCOMPONENTS
