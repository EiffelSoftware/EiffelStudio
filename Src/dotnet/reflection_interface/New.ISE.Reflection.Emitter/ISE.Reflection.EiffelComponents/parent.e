indexing
	description: "Class parent"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	PARENT

create
	make, make_implementation

feature {NONE} -- Initialization

	make (a_name: like name) is
		indexing
			description: "Set `name' with `a_name' and initialize inheritance clauses."
		do
			set_name (a_name)
			create rename_clauses.make
			create redefine_clauses.make
			create undefine_clauses.make
			create select_clauses.make
			create export_clauses.make
		ensure
			name_set: name.is_equal (a_name)
			non_void_rename_clauses: rename_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_select_clauses: select_clauses /= Void
			non_void_export_clauses: export_clauses /= Void
		end
		
	make_implementation (a_name: like name; imp: like implementation) is
		indexing
			description: "Set `name' with `a_name' and initialize inheritance clauses."
		require
			non_void_implementation: imp /= Void
		do
			make (a_name)
			implementation := imp
		ensure
			non_void_implementation: implementation /= Void
		end

feature -- Access
	
	name: STRING
		indexing
			description: "Parent name"
		end
		
	implementation: PARENT_IMP
		indexing
			description: "implementation for .net"
		end

	rename_clauses: LINKED_LIST [RENAME_CLAUSE]
			-- | ARRAY_LIST [RENAME_CLAUSE]
		indexing
			description: "Rename clauses for parent with `name'"
		end

	redefine_clauses: LINKED_LIST [REDEFINE_CLAUSE]
			-- | ARRAY_LIST [REDEFINE_CLAUSE]
		indexing
			description: "Redefine clauses for parent with `name'"
		end
 
	undefine_clauses: LINKED_LIST [UNDEFINE_CLAUSE]
			-- | ARRAY_LIST [UNDEFINE_CLAUSE]
		indexing
			description: "Undefine clauses for parent with `name'"
		end

	select_clauses: LINKED_LIST [SELECT_CLAUSE]
			-- | ARRAY_LIST [SELECT_CLAUSE]
		indexing
			description: "Select clauses for parent with `name'"
		end

	export_clauses: LINKED_LIST [EXPORT_CLAUSE]
			-- | ARRAY_LIST [EXPORT_CLAUSE]
		indexing
			description: "Export clauses for parent with `name'"
		end
		
feature -- Status Setting

	set_name (a_name: like name) is
		indexing
			description: "Set `name' with `a_name'."
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end

	set_rename_clauses (a_list: like rename_clauses) is
		indexing
			description: "Set `rename_clauses' with `a_list'."
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
		do
			if not rename_clauses.has (a_clause) then
				rename_clauses.extend (a_clause)
			end
		ensure
			rename_clause_added: rename_clauses.has (a_clause)
		end

	add_redefine_clause (a_clause: REDEFINE_CLAUSE) is
		indexing
			description: "Add `a_clause' to `redefine_clauses'."
		do
			if not redefine_clauses.has(a_clause) then
				redefine_clauses.extend (a_clause)
			end
		ensure
			redefine_clause_added: redefine_clauses.has (a_clause)
		end

	add_undefine_clause (a_clause: UNDEFINE_CLAUSE) is
		indexing
			description: "Add `a_clause' to `undefine_clauses'."
		do
			if not undefine_clauses.has (a_clause) then
				undefine_clauses.extend (a_clause)
			end
		ensure
			undefine_clause_added: undefine_clauses.has (a_clause)
		end

	add_select_clause (a_clause: SELECT_CLAUSE) is
		indexing
			description: "Add `a_clause' to `select_clauses'."
		do
			if not select_clauses.has (a_clause) then
				select_clauses.extend (a_clause)
			end
		ensure
			select_clause_added: select_clauses.has (a_clause)
		end

	add_export_clause (a_clause: EXPORT_CLAUSE) is
		indexing
			description: "Add `a_clause' to `export_clauses'."
		do
			if not export_clauses.has (a_clause) then
				export_clauses.extend (a_clause)
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
