indexing
	description: "Class parent"
--	attribute: create {CLASS_INTERFACE_ATTRIBUTE}.make_class_interface_attribute ((create {CLASS_INTERFACE_TYPE}).auto_dual) end

class
	PARENT_IMP

create
	make

feature {NONE} -- Initialization

	make (a_name: like name) is
		indexing
			description: "Set `name' with `a_name' and initialize inheritance clauses."
		do
			create converter
			create class_interface.make_implementation ( converter.to_eiffel_string (a_name), Current )
		end
		
feature -- Access
	
	class_interface: PARENT
		indexing
			description: "The Eiffel interface"
		end
		
	converter: GLOBAL_CONVERSATION [ANY]
	
	name: SYSTEM_STRING is
		indexing
			description: "Parent name"
		do
			Result := converter.from_eiffel_string (class_interface.name)
		end

	rename_clauses: ARRAY_LIST is
			-- | ARRAY_LIST [RENAME_CLAUSE]
		indexing
			description: "Rename clauses for parent with `name'"
		local
			c: GLOBAL_CONVERSATION [RENAME_CLAUSE]
		do
			create c
			Result := c.from_eiffel_linked_list (class_interface.rename_clauses)
		end

	redefine_clauses: ARRAY_LIST is
			-- | ARRAY_LIST [REDEFINE_CLAUSE]
		indexing
			description: "Redefine clauses for parent with `name'"
		local
			c: GLOBAL_CONVERSATION [REDEFINE_CLAUSE]
		do
			create c
			Result := c.from_eiffel_linked_list (class_interface.redefine_clauses)
		end
 
	undefine_clauses: ARRAY_LIST is
			-- | ARRAY_LIST [UNDEFINE_CLAUSE]
		indexing
			description: "Undefine clauses for parent with `name'"
		local
			c: GLOBAL_CONVERSATION [UNDEFINE_CLAUSE]
		do
			create c
			Result := c.from_eiffel_linked_list (class_interface.undefine_clauses)
		end

	select_clauses: ARRAY_LIST is
			-- | ARRAY_LIST [SELECT_CLAUSE]
		indexing
			description: "Select clauses for parent with `name'"
		local
			c: GLOBAL_CONVERSATION [SELECT_CLAUSE]
		do
			create c
			Result := c.from_eiffel_linked_list (class_interface.select_clauses)
		end

	export_clauses: ARRAY_LIST is
			-- | ARRAY_LIST [EXPORT_CLAUSE]
		indexing
			description: "Export clauses for parent with `name'"
		local
			c: GLOBAL_CONVERSATION [EXPORT_CLAUSE]
		do
			create c
			Result := c.from_eiffel_linked_list (class_interface.export_clauses)
		end
		
feature -- Status Setting

	set_name (a_name: like name) is
		indexing
			description: "Set `name' with `a_name'."
		do
			class_interface.set_name ( converter.to_eiffel_string (a_name) )
		end

	set_rename_clauses (a_list: like rename_clauses) is
		indexing
			description: "Set `rename_clauses' with `a_list'."
		local
			c: GLOBAL_CONVERSATION [RENAME_CLAUSE]
		do
			create c
			class_interface.set_rename_clauses ( c.to_eiffel_linked_list (a_list) )
		end

	set_redefine_clauses (a_list: like redefine_clauses) is
		indexing
			description: "Set `redefine_clauses' with `a_list'."
		local
			c: GLOBAL_CONVERSATION [REDEFINE_CLAUSE]
		do
			create c
			class_interface.set_redefine_clauses ( c.to_eiffel_linked_list (a_list) )
		end

	set_undefine_clauses (a_list: like undefine_clauses) is
		indexing
			description: "Set `undefine_clauses' with `a_list'."
		local
			c: GLOBAL_CONVERSATION [UNDEFINE_CLAUSE]
		do
			create c
			class_interface.set_undefine_clauses ( c.to_eiffel_linked_list (a_list) )
		end

	set_select_clauses (a_list: like select_clauses) is
		indexing
			description: "Set `select_clauses' with `a_list'."
		local
			c: GLOBAL_CONVERSATION [SELECT_CLAUSE]
		do
			create c
			class_interface .set_select_clauses ( c.to_eiffel_linked_list (a_list) )
		end

	set_export_clauses (a_list: like export_clauses) is
		indexing
			description: "Set `export_clauses' with `a_list'."
		local
			c: GLOBAL_CONVERSATION [EXPORT_CLAUSE]
		do
			create c
			class_interface.set_export_clauses ( c.to_eiffel_linked_list (a_list) )
		end
		
feature {PARENT} -- Status Setting

	set_interface (i: like class_interface) is
		indexing
			description: "Set `name' with `a_name' and initialize inheritance clauses."
		require
			non_void_interface: i /= Void
		do
			class_interface := i
		ensure
			non_void_interface: class_interface /= Void
		end
		
feature -- Element Change

	add_rename_clause (a_clause: RENAME_CLAUSE) is
		indexing
			description: "Add `a_clause' to `rename_clauses'."
		do
			class_interface.add_rename_clause (a_clause)
		end

	add_redefine_clause (a_clause: REDEFINE_CLAUSE) is
		indexing
			description: "Add `a_clause' to `redefine_clauses'."
		do
			class_interface.add_redefine_clause (a_clause)
		end

	add_undefine_clause (a_clause: UNDEFINE_CLAUSE) is
		indexing
			description: "Add `a_clause' to `undefine_clauses'."
		do
			class_interface.add_undefine_clause (a_clause)
		end

	add_select_clause (a_clause: SELECT_CLAUSE) is
		indexing
			description: "Add `a_clause' to `select_clauses'."
		do
			class_interface.add_select_clause (a_clause)
		end

	add_export_clause (a_clause: EXPORT_CLAUSE) is
		indexing
			description: "Add `a_clause' to `export_clauses'."
		do
			class_interface.add_export_clause (a_clause)
		end

invariant
	non_void_rename_clauses: rename_clauses /= Void
	non_void_redefine_clauses: redefine_clauses /= Void
	non_void_undefine_clauses: undefine_clauses /= Void
	non_void_select_clauses: select_clauses /= Void
	non_void_export_clauses: export_clauses /= Void
	
end -- class PARENT_IMP
