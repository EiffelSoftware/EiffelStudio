indexing
	description: "Class parent"
	external_name: "ISE.Reflection.Parent"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	PARENT

create
	make

feature {NONE} -- Initialization

	make (a_name: like name) is
		indexing
			description: "Set `name' with `a_name' and initialize inheritance clauses."
			external_name: "Make"
		do
			set_name (a_name)
			create rename_clauses.make
			create redefine_clauses.make
			create undefine_clauses.make
			create select_clauses.make
			create export_clauses.make
		ensure
			name_set: name.equals_string (a_name)
			non_void_rename_clauses: rename_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_select_clauses: select_clauses /= Void
			non_void_export_clauses: export_clauses /= Void			
		end

feature -- Access
	
	name: STRING
		indexing
			description: "Parent name"
			external_name: "Name"
		end

	rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [RENAME_CLAUSE]
		indexing
			description: "Rename clauses for parent with `name'"
			external_name: "RenameClauses"
		end

	redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [REDEFINE_CLAUSE]
		indexing
			description: "Redefine clauses for parent with `name'"
			external_name: "RedefineClauses"
		end

	undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [UNDEFINE_CLAUSE]
		indexing
			description: "Undefine clauses for parent with `name'"
			external_name: "UndefineClauses"
		end

	select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SELECT_CLAUSE]
		indexing
			description: "Select clauses for parent with `name'"
			external_name: "SelectClauses"
		end

	export_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EXPORT_CLAUSE]
		indexing
			description: "Export clauses for parent with `name'"
			external_name: "ExportClauses"
		end
		
feature -- Status Setting

	set_name (a_name: like name) is
		indexing
			description: "Set `name' with `a_name'."
			external_name: "SetName"
		do
			name := a_name
		ensure
			name_set: name.equals_string (a_name)
		end

	set_rename_clauses (a_list: like rename_clauses) is
		indexing
			description: "Set `rename_clauses' with `a_list'."
			external_name: "SetRenameClauses"
		require
			non_void_list: a_list /= Void
		do
			rename_clauses := a_list
		ensure
			rename_clauses_set: rename_clauses = a_list
		end

	set_redefine_clauses (a_list: like redefine_clauses) is
		indexing
			description: "Set `redefine_clauses' with `a_list'."
			external_name: "SetRedefineClauses"
		require
			non_void_list: a_list /= Void
		do
			redefine_clauses := a_list
		ensure
			redefine_clauses_set: redefine_clauses = a_list
		end

	set_undefine_clauses (a_list: like undefine_clauses) is
		indexing
			description: "Set `undefine_clauses' with `a_list'."
			external_name: "SetUndefineClauses"
		require
			non_void_list: a_list /= Void
		do
			undefine_clauses := a_list
		ensure
			undefine_clauses_set: undefine_clauses = a_list
		end

	set_select_clauses (a_list: like select_clauses) is
		indexing
			description: "Set `select_clauses' with `a_list'."
			external_name: "SetSelectClauses"
		require
			non_void_list: a_list /= Void
		do
			select_clauses := a_list
		ensure
			select_clauses_set: select_clauses = a_list
		end

	set_export_clauses (a_list: like export_clauses) is
		indexing
			description: "Set `export_clauses' with `a_list'."
			external_name: "SetExportClauses"
		require
			non_void_list: a_list /= Void
		do
			export_clauses := a_list
		ensure
			export_clauses_set: export_clauses = a_list
		end
		
feature -- Element Change

	add_rename_clause (a_clause: RENAME_CLAUSE) is
		indexing
			description: "Add `a_clause' to `rename_clauses'."
			external_name: "AddRenameClause"
		local
			added: INTEGER
		do
			if not rename_clauses.has (a_clause) then
				added := rename_clauses.extend (a_clause)
			end
		ensure
			rename_clause_added: rename_clauses.has (a_clause)
		end

	add_redefine_clause (a_clause: REDEFINE_CLAUSE) is
		indexing
			description: "Add `a_clause' to `redefine_clauses'."
			external_name: "AddRedefineClause"
		local
			added: INTEGER
		do
			if not redefine_clauses.has (a_clause) then
				added := redefine_clauses.extend (a_clause)
			end
		ensure
			redefine_clause_added: redefine_clauses.has (a_clause)
		end

	add_undefine_clause (a_clause: UNDEFINE_CLAUSE) is
		indexing
			description: "Add `a_clause' to `undefine_clauses'."
			external_name: "AddUndefineClause"
		local
			added: INTEGER
		do
			if not undefine_clauses.has (a_clause) then
				added := undefine_clauses.extend (a_clause)
			end
		ensure
			undefine_clause_added: undefine_clauses.has (a_clause)
		end

	add_select_clause (a_clause: SELECT_CLAUSE) is
		indexing
			description: "Add `a_clause' to `select_clauses'."
			external_name: "AddSelectClause"
		local
			added: INTEGER
		do
			if not select_clauses.has (a_clause) then
				added := select_clauses.extend (a_clause)
			end
		ensure
			select_clause_added: select_clauses.has (a_clause)
		end

	add_export_clause (a_clause: EXPORT_CLAUSE) is
		indexing
			description: "Add `a_clause' to `export_clauses'."
			external_name: "AddExportClause"
		local
			added: INTEGER
		do
			if not export_clauses.has (a_clause) then
				added := export_clauses.extend (a_clause)
			end
		ensure
			export_clause_added: export_clauses.has (a_clause)
		end

invariant
	non_void_rename_clauses: rename_clauses /= Void
	non_void_redefine_clauses: redefine_clauses /= Void
	non_void_undefine_clauses: undefine_clauses /= Void
	non_void_select_clauses: select_clauses /= Void
	non_void_export_clauses: export_clauses /= Void
	
end -- class PARENT
