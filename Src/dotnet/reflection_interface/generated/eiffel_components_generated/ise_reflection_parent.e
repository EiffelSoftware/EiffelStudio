indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.Parent"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "2dffe28036ebcb3"

external class
	ISE_REFLECTION_PARENT

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.Parent"
		end

feature -- Access

	frozen a_internal_redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"_internal_RedefineClauses"
		end

	get_undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"get_UndefineClauses"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Parent"
		alias
			"get_Name"
		end

	frozen a_internal_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.Parent"
		alias
			"_internal_Name"
		end

	frozen a_internal_select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"_internal_SelectClauses"
		end

	frozen a_internal_undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"_internal_UndefineClauses"
		end

	get_rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"get_RenameClauses"
		end

	frozen a_internal_rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"_internal_RenameClauses"
		end

	get_export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"get_ExportClauses"
		end

	frozen a_internal_export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"_internal_ExportClauses"
		end

	get_select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"get_SelectClauses"
		end

	get_redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Parent"
		alias
			"get_RedefineClauses"
		end

feature -- Basic Operations

	add_redefine_clause (a_clause: ISE_REFLECTION_REDEFINECLAUSE) is
		external
			"IL signature (ISE.Reflection.RedefineClause): System.Void use ISE.Reflection.Parent"
		alias
			"AddRedefineClause"
		end

	add_select_clause (a_clause: ISE_REFLECTION_SELECTCLAUSE) is
		external
			"IL signature (ISE.Reflection.SelectClause): System.Void use ISE.Reflection.Parent"
		alias
			"AddSelectClause"
		end

	make (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.Parent"
		alias
			"Make"
		end

	set_select_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.Parent"
		alias
			"SetSelectClauses"
		end

	set_rename_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.Parent"
		alias
			"SetRenameClauses"
		end

	set_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.Parent"
		alias
			"SetName"
		end

	add_undefine_clause (a_clause: ISE_REFLECTION_UNDEFINECLAUSE) is
		external
			"IL signature (ISE.Reflection.UndefineClause): System.Void use ISE.Reflection.Parent"
		alias
			"AddUndefineClause"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_PARENT) is
		external
			"IL static signature (ISE.Reflection.Parent): System.Void use ISE.Reflection.Parent"
		alias
			"_invariant"
		end

	add_export_clause (a_clause: ISE_REFLECTION_EXPORTCLAUSE) is
		external
			"IL signature (ISE.Reflection.ExportClause): System.Void use ISE.Reflection.Parent"
		alias
			"AddExportClause"
		end

	set_undefine_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.Parent"
		alias
			"SetUndefineClauses"
		end

	set_export_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.Parent"
		alias
			"SetExportClauses"
		end

	add_rename_clause (a_clause: ISE_REFLECTION_RENAMECLAUSE) is
		external
			"IL signature (ISE.Reflection.RenameClause): System.Void use ISE.Reflection.Parent"
		alias
			"AddRenameClause"
		end

	set_redefine_clauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.Parent"
		alias
			"SetRedefineClauses"
		end

end -- class ISE_REFLECTION_PARENT
