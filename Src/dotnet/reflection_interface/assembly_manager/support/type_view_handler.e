indexing
	description: "Check class and feature names validity and update eiffel class."
	external_name: "ISE.AssemblyManager.TypeViewHandler"

class
	TYPE_VIEW_HANDLER

inherit
	EDIT_ERROR_MESSAGES
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_eiffel_class: like eiffel_class; a_type_modification: like type_modifications; a_type_view: like type_view) is
		indexing
			description: "[
						Set `eiffel_class' with `an_eiffel_class'.
						Set `type_modifications' with `a_type_modification'.
						Set `type_view' with `a_type_view'.
					  ]"
			external_name: "Make"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_type_modification: a_type_modification /= Void
			non_void_type_view: a_type_view /= Void
		do
			eiffel_class := an_eiffel_class
			type_modifications := a_type_modification
			type_view := a_type_view
			is_valid := True
			children := type_view.children
			new_inheritance_clauses ?= eiffel_class.parents.clone (eiffel_class.parents)
			create errors_in_features.make (0)
			create errors_in_arguments.make (0)
			create errors_in_arguments_mappings.make (0)
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
			type_modifications_set: type_modifications = a_type_modification
			type_view_set: type_view = a_type_view
			is_valid: is_valid
			non_void_inheritance_clauses: new_inheritance_clauses /= Void
			non_void_children: children /= Void
			non_void_errors_in_features: errors_in_features /= Void
			non_void_errors_in_arguments: errors_in_arguments /= Void
			non_void_errors_in_arguments_mapping: errors_in_arguments_mappings /= Void
		end
		
feature -- Access
	
	eiffel_class: EIFFEL_CLASS
		indexing
			description: "Eiffel class `inheritance_clauses' should belong to"
			external_name: "EiffelClass"
		end
	
	type_modifications: TYPE_MODIFICATIONS
		indexing
			description: "Type modifications"
			external_name: "TypeModifications"
		end
		
	type_view: TYPE_VIEW
		indexing
			description: "Type view"
			external_name: "TypeView"
		end
		
	class_error_message: STRING 
		indexing
			description: "Error message in case the class name is not valid"
			external_name: "ClassErrorMessage"
		end
	
	children: LINKED_LIST [EIFFEL_CLASS]
		indexing
			description: "Children of `eiffel_class'"
			external_name: "Children"
		end
	
	assembly_types: LINKED_LIST [EIFFEL_CLASS]  is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Assembly types"
			external_name: "AssemblyTypes"
		do
			Result := type_view.assembly_types
		ensure
			non_void_types: Result /= Void
		end
		
	errors_in_features: HASH_TABLE [STRING, EIFFEL_FEATURE]
		indexing
			description: "Key: `EIFFELFEATURE'; Value: Error message'"
			external_name: "ErrorsInFeatures"
		end

	errors_in_arguments: HASH_TABLE [STRING, INTEGER]
		indexing
			description: "Key: [EIFFELFEATURE, NAMEDSIGNATURETYPE], Value: Error message"
			external_name: "ErrorsInArguments"
		end
		
	errors_in_arguments_mappings: HASH_TABLE [ARRAY [ANY], INTEGER]
		indexing
			description: "Key "
		end
		
feature -- Status Report

	is_valid: BOOLEAN 
		indexing
			description: "Is valid? (Result of `check_validity')"
			external_name: "IsValid"
		end
	
feature -- Basic Operations

	check_and_update is
		indexing
			description: "[
						Check modifications are valid. Make Result available in `is_valid' and put error messages in `errors_table'.
						If `is_valid' then update `eiffel_class'.
					  ]"
			external_name: "Check_and_update"
		local
			features_changes: HASH_TABLE [FEATURE_MODIFICATIONS, EIFFEL_FEATURE]
			a_feature: EIFFEL_FEATURE
			a_feature_modifications: FEATURE_MODIFICATIONS
			changes: LINKED_LIST [ARRAY [ANY]]
			tmp_changes: LINKED_LIST [ARRAY [ANY]]
			an_array: ARRAY [ANY]
			added: INTEGER
		do
				-- Update class name (in current class and descendants)
		--	if type_modifications.new_name /= Void then
		--		if type_modifications.new_name.get_length > 0 then
		--			update_class
		--		else
		--			is_valid := False
		--			class_error_message := Empty_class_name
		--		end
		--	end			
				-- Update class features 
			features_changes := type_modifications.features_modifications
			if features_changes /= Void and then features_changes.count > 0 then
				from
					create changes.make 
					features_changes.start
				until
					features_changes.after
				loop
					a_feature ?= features_changes.key_for_iteration
					if a_feature /= Void then
						a_feature_modifications ?= features_changes.item (a_feature)
						if a_feature_modifications /= Void then
							create an_array.make (0, 1)
							an_array.put (a_feature, 0)
							an_array.put (a_feature_modifications, 1)
							changes.extend (an_array)
						end
					end
					features_changes.forth
				end
				tmp_changes := changes.clone(changes)
				from
					changes.start
				until
					changes.after
				loop
					an_array := tmp_changes.item
					if an_array /= Void then
						a_feature ?= an_array.item (0)
						a_feature_modifications ?= an_array.item (1)
						if a_feature /= Void and a_feature_modifications /= Void then
							update_features (a_feature_modifications, a_feature)
						end
					end
					changes.forth
				end
			end
		end

feature {NONE} -- Implementation

	update_class is
		indexing
			description: "[
						Check for name clashes and update class name if name is valid.
						Make result of check available in `is_valid'.
					  ]"
			external_name: "UpdateClass"
		require
			non_void_new_name: type_modifications.new_name /= Void
		local
			new_name: STRING
		do
			new_name := type_modifications.new_name
			if class_exists (new_name) then
				is_valid := False
				class_error_message := Class_exists_error
			else
				is_valid := is_valid and True
				rename_children_parent (new_name)
				rename_class (new_name)
			end
		end
		
	update_features (a_feature_modifications: FEATURE_MODIFICATIONS; a_feature: EIFFEL_FEATURE) is
		indexing
			description: "[
						Check for name clashes and update feature name, create clauses and inheritance clauses (if needed) if name is valid. 
						Make result of check available in `is_valid'.
					  ]"
			external_name: "UpdateFeatures"
		require
			non_void_feature_modifications: a_feature_modifications /= Void
			non_void_feature: a_feature /= Void
		local
			old_name: STRING
			new_name: STRING
			arguments_changes: HASH_TABLE [STRING, NAMED_SIGNATURE_TYPE_INTERFACE]
			an_argument: NAMED_SIGNATURE_TYPE
			i: INTEGER
			added: INTEGER
			changes: LINKED_LIST [ARRAY [ANY]]
			tmp_changes: LINKED_LIST [ARRAY [ANY]]
			an_array: ARRAY [ANY]
			name: STRING
		do
				-- Update feature name
			if a_feature_modifications.new_feature_name /= Void then
				if a_feature_modifications.new_feature_name.count > 0 then
					new_name := a_feature_modifications.new_feature_name
					new_name := new_name.clone (new_name)
					if recursive_exists (new_name) then
						is_valid := False
						if errors_in_features.has (a_feature) then
							errors_in_features.remove (a_feature)
						end
						errors_in_features.extend (Feature_exists_error, a_feature)
					else
						new_name.to_lower
						if reserved_words.has (new_name) then
							is_valid := False
							if errors_in_features.has (a_feature) then
								errors_in_features.remove (a_feature)
							end					
							errors_in_features.extend (Feature_clash_with_reserved_word, a_feature)
						else
							is_valid := is_valid and True
							old_name := a_feature_modifications.old_feature_name					
							--recursive_update_inheritance_clauses (old_name, new_name)
							--update_children_inheritance_clauses (old_name, new_name)
							rename_feature_in_children (old_name, new_name)
							a_feature.set_eiffel_name (new_name)
							a_feature.set_modified (True)
						end
					end
				else
					is_valid := False
					if errors_in_features.has (a_feature) then
						errors_in_features.remove (a_feature) 
					end
					errors_in_features.extend (Empty_feature_name, a_feature)
				end 
			end
				-- Update feature arguments
			arguments_changes := a_feature_modifications.arguments_modifications
			if arguments_changes /= Void and then arguments_changes.count > 0 then
				--enumerator := arguments_changes.get_keys.get_enumerator
				from
					create changes.make
					arguments_changes.start
				until
					arguments_changes.after
				loop
					an_argument ?= arguments_changes.key_for_iteration
					if an_argument /= Void then
						new_name ?= arguments_changes.item (an_argument)
						if new_name /= Void then
							create an_array.make (0, 1)
							an_array.put (an_argument, 0)
							an_array.put (new_name, 1)
							changes.extend (an_array)
						end
					end
					arguments_changes.forth
				end			
				tmp_changes := changes.clone (changes)
				from
					tmp_changes.start
				until
					tmp_changes.after
				loop
					an_array ?= tmp_changes.item
					if an_array /= Void then
						an_argument ?= an_array.item (0)
						new_name ?= an_array.item (1)
						if an_argument /= Void and new_name /= Void then
							update_arguments (new_name, an_argument, a_feature)
						end
					end
					tmp_changes.forth
				end
			end
		end
	
	update_arguments (new_name: STRING; an_argument: NAMED_SIGNATURE_TYPE; a_feature: EIFFEL_FEATURE) is
		indexing
			description: "[
						Check for name clashes with other arguments or feature names and update argument name.
						Make result of check available in `is_valid'.
					  ]"
			external_name: "UpdateArguments"
		require
			non_void_new_name: new_name /= Void
			non_void_argument: an_argument /= Void
			non_void_feature: a_feature /= Void
		local
			an_array: ARRAY [ANY]
			name: STRING
		do
			if new_name.count > 0 then
				if recursive_exists (new_name) then
					is_valid := False
					create an_array.make (0, 1)
					an_array.put (a_feature, 0)
					an_array.put (an_argument, 1)
					if errors_in_arguments.has (an_array.get_hash_code) then
						errors_in_arguments.remove (an_array.get_hash_code)
					end
					errors_in_arguments.extend (Clash_with_feature_name, an_array.get_hash_code)
					errors_in_arguments_mappings.extend (an_array, an_array.get_hash_code)
				else
					name := new_name.clone (new_name)
					name.to_lower
					if reserved_words.has (name) then
						is_valid := False
						create an_array.make (0, 1)
						an_array.put (a_feature, 0)
						an_array.put (an_argument, 1)
						if errors_in_arguments.has (an_array.get_hash_code) then
							errors_in_arguments.remove (an_array.get_hash_code)
						end
						errors_in_arguments.extend (Argument_clash_with_reserved_word, an_array.get_hash_code)
						errors_in_arguments_mappings.extend (an_array, an_array.get_hash_code)
					elseif argument_exists (new_name, a_feature) then
						is_valid := False
						create an_array.make (0, 1)
						an_array.put (a_feature, 0)
						an_array.put (an_argument, 1)
						if errors_in_arguments.has (an_array.get_hash_code) then
							errors_in_arguments.remove (an_array.get_hash_code)
						end
						errors_in_arguments.extend (Argument_name_exists, an_array.get_hash_code)
						errors_in_arguments_mappings.extend (an_array, an_array.get_hash_code)
					else
						is_valid := is_valid and True
						an_argument.set_eiffel_name (new_name)
						a_feature.set_modified (True)
					end
				end
			else
				is_valid := False
				create an_array.make (0, 1)
				an_array.put (a_feature, 0)
				an_array.put (an_argument, 1)
				if errors_in_arguments.has (an_array.get_hash_code) then
					errors_in_arguments.remove (an_array.get_hash_code)
				end
				errors_in_arguments.extend (Empty_argument_name, an_array.get_hash_code)
				errors_in_arguments_mappings.extend (an_array, an_array.get_hash_code)
			end
		end
		
	new_inheritance_clauses: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			-- Key: Parent name
			-- Value: List of inheritance clauses
		indexing
			description: "New inheritance clauses"
			external_name: "NewInheritanceClauses"
		end
		
	class_exists (a_class_name: STRING): BOOLEAN is
		indexing
			description: "Does a class with name `a_class_name' already exist in assembly types?"
			external_name: "ClassExists"
		require
			non_void_class_name: a_class_name /= Void
		local
			i: INTEGER
			a_type: EIFFEL_CLASS
			class_name: STRING
			eiffel_type_name: STRING
		do
			from
				assembly_types.start
			until
				assembly_types.after
			loop
				a_type ?= assembly_types.item
				if a_type /= Void then
					class_name := a_class_name.clone (a_class_name)
					class_name.to_lower
					eiffel_type_name := a_type.eiffel_name.clone (a_type.eiffel_name)
					eiffel_type_name.to_lower
					
					Result := eiffel_type_name.is_equal (class_name)
				end
				assembly_types.forth
			end
		end
	
	rename_class (new_name: STRING) is
		indexing
			description: "Rename `eiffel_class' with `new_name' and update `assembly_types'."
			external_name: "RenameClass"
		require
			non_void_name: new_name /= Void
		local
			i: INTEGER
			a_class: EIFFEL_CLASS
			class_found: BOOLEAN
			class_name: STRING
			eiffel_type_name: STRING
		do
			from
				assembly_types.start
			until
				assembly_types.after
			loop
				a_class ?= assembly_types.item
				class_name := eiffel_class.eiffel_name.clone (eiffel_class.eiffel_name)
				class_name.to_lower
				eiffel_type_name := a_class.eiffel_name.clone (a_class.eiffel_name)
				eiffel_type_name.to_lower
				if eiffel_type_name.is_equal (class_name) then
					a_class.set_eiffel_name (new_name)
					class_found := True
				end
				assembly_types.forth
			end
			eiffel_class.set_eiffel_name (new_name)
		ensure
			new_name_set: eiffel_class.eiffel_name.is_equal (new_name)
		end

	rename_children_parent (new_name: STRING) is
		indexing
			description: "Rename `children' according to `new_name' of `eiffel_class'."
			external_name: "RenameChildrenParent"
		require
			non_void_new_name: new_name /= Void
		local
			i: INTEGER
			a_child: EIFFEL_CLASS
			parents: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			clauses: ARRAY [LINKED_LIST [INHERITANCE_CLAUSE]]			
		do
			from
				children.start
			until
				children.after
			loop
				a_child ?= children.item
				if a_child /= Void then
					parents := a_child.parents
					if parents.has (eiffel_class.eiffel_name) then
						clauses ?= parents.item (eiffel_class.eiffel_name)
						if clauses /= Void then
							parents.remove (eiffel_class.eiffel_name)
							parents.extend (clauses, new_name)
						end
					end
				end
				children.forth
			end
		end
	
	exists (a_class: EIFFEL_CLASS; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does a feature with `a_feature_name' exist in `eiffel_class'?"
			external_name: "Exists"
		require
			non_void_class: a_class /= Void
			non_void_feature_name: a_feature_name /= Void
		local
			support: ASSEMBLY_SUPPORT
		do
			create support.make
			Result := support.exists (a_class, a_feature_name)
			eiffel_feature := support.eiffel_feature
		end
	
	recursive_exists (a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Call `exists' on each child of `children' list."
			external_name: "RecursiveExists"
		require
			non_void_feature_name: a_feature_name /= Void
			non_void_children_list: children /= Void
		local
			i: INTEGER
			a_child: EIFFEL_CLASS
		do
			if exists (eiffel_class, a_feature_name) then
				Result := True
			else
				from
					children.start
				until
					children.after
				loop
					a_child ?= children.item
					if a_child /= Void then
						Result := exists (a_child, a_feature_name)
					end
					children.forth
				end
			end
		end
		
	eiffel_feature: EIFFEL_FEATURE
		indexing
			description: "Eiffel feature (Result of `has_feature')"
			external_name: "EiffelFeature"
		end
	
	rename_feature_in_children (old_name, new_name: STRING) is
		indexing
			description: "Rename feature implemented in children with `new_name'."
			external_name: "RenameFeatureInChildren"
		require
			non_void_new_name: new_name /= Void
		local
			children_to_change: HASH_TABLE [EIFFEL_FEATURE, EIFFEL_CLASS]
			i: INTEGER
			a_child: EIFFEL_CLASS
			a_feature: EIFFEL_FEATURE
		do
			from
				create children_to_change.make (0)
				children.start
			until
				children.after
			loop
				a_child ?= children.item
				if a_child /= Void and then exists (a_child, old_name) then
					children_to_change.extend(eiffel_feature, a_child)
				end
				children.forth
			end
			
			from
				children_to_change.start
			until
				children_to_change.after
			loop
				a_feature ?= children_to_change.item_for_iteration
				if a_feature /= Void then
					a_feature.set_eiffel_name (new_name)
					a_feature.set_modified (True)
				end
				children_to_change.forth
			end
		end
		
	recursive_update_inheritance_clauses (old_name, new_name: STRING) is
		indexing
			description: "Update of all inheritance clauses to tke `new_name' into acget_count."
			external_name: "RecursiveUpdateInheritanceClauses"
		require
			non_void_old_name: old_name /= Void
			non_void_new_name: new_name /= Void
		local
			a_parent_name: STRING
			i: INTEGER
			added: INTEGER
			parent_names: LINKED_LIST [STRING]
			tmp_parent_names: LINKED_LIST [STRING]
		do
			from
				create parent_names.make
				eiffel_class.parents.start
			until
				eiffel_class.parents.after
			loop
				a_parent_name ?= eiffel_class.parents.key_for_iteration
				if a_parent_name /= Void and then a_parent_name.count > 0 then
					parent_names.extend (a_parent_name)
					--update_inheritance_clauses (a_parent_name, old_name, new_name)
				end
			end
			tmp_parent_names ?= parent_names.clone (parent_names)
			from
				parent_names.start
			until
				parent_names.after
			loop
				a_parent_name ?= tmp_parent_names.item
				if a_parent_name /= Void then
					update_inheritance_clauses (a_parent_name, old_name, new_name)
				end
				parent_names.forth
			end
			commit (eiffel_class)
		end
		
	update_inheritance_clauses (parent_name, old_name, new_name: STRING) is
		indexing
			description: "Update `rename_clauses', `undefine_clauses', `redefine_clauses', `select_clauses' by replacing `old_name' by `new_name'."
			external_name: "UpdateInheritanceClauses"
		require
			non_void_parent_name: parent_name /= Void
			non_void_new_name: new_name /= Void
			non_void_old_name: old_name /= Void
		local
			a_rename_clause: RENAME_CLAUSE
			added: INTEGER
		do
			build_inheritance_clauses (parent_name)
			if not has_rename_clause (old_name) and then (is_in_list (undefine_clauses, old_name) or is_in_list (redefine_clauses, old_name) or is_in_list (select_clauses, old_name)) then
				create a_rename_clause
				a_rename_clause.set_source_name (old_name)
				a_rename_clause.set_target_name (new_name)
				rename_clauses.extend (a_rename_clause)
			end
			intern_update_inheritance_clauses (old_name, new_name)
			commit_parent_changes (parent_name, eiffel_class)
		ensure
			not_in_undefine_clauses: not is_in_list (undefine_clauses, old_name)
			not_in_redefine_clauses: not is_in_list (redefine_clauses, old_name)
			not_in_select_clauses: not is_in_list (select_clauses, old_name)
		end
		
	intern_update_inheritance_clauses (old_name, new_name: STRING) is
		indexing
			description: "Update inheritance clauses by replacing `old_name' by `new_name'."
			external_name: "InternUpdateInheritanceClauses"
		require
			non_void_old_name: old_name /= Void
			non_void_new_name: new_name /= Void
		local
			added: INTEGER
			a_rename_clause: RENAME_CLAUSE
			an_undefine_clause: UNDEFINE_CLAUSE
			a_redefine_clause: REDEFINE_CLAUSE
			a_select_clause: SELECT_CLAUSE
		do
		--	if has_rename_clause (old_name) then
		--		rename_clauses.prune_i_th (index_in_list)
		--		create a_rename_clause.make_renameclause
		--		a_rename_clause.makefrominfo (rename_source, new_name)
		--		added := rename_clauses.extend (a_rename_clause)
		--	end
			if is_in_list (undefine_clauses, old_name) then
				undefine_clauses.go_i_th (index_in_list)
				undefine_clauses.remove
				create an_undefine_clause
				an_undefine_clause.set_source_name (new_name)
				undefine_clauses.extend (an_undefine_clause)
			end
			if is_in_list (redefine_clauses, old_name) then
				redefine_clauses.go_i_th (index_in_list)
				redefine_clauses.remove
				create a_redefine_clause
				a_redefine_clause.set_source_name (new_name)				
				redefine_clauses.extend (a_redefine_clause)			
			end
			if is_in_list (select_clauses, old_name) then
				select_clauses.go_i_th (index_in_list)
				select_clauses.remove
				create a_select_clause
				a_select_clause.set_source_name (new_name)
				select_clauses.extend (a_select_clause)			
			end
		ensure
			not_in_undefine_clauses: not is_in_list (undefine_clauses, old_name)
			not_in_redefine_clauses: not is_in_list (redefine_clauses, old_name)
			not_in_select_clauses: not is_in_list (select_clauses, old_name)
		end

	commit_parent_changes (parent_name: STRING; a_class: EIFFEL_CLASS) is
		indexing
			description: "Set new inheritance clauses to parent of `eiffel_class' with name `parent_name'."
			external_name: "CommitParentChanges"
		require
			non_void_parent_name: parent_name /= Void
			non_void_inheritance_clauses: new_inheritance_clauses /= Void
			non_void_class: a_class /= Void
		do
			if new_inheritance_clauses.has (parent_name) then
				new_inheritance_clauses.remove (parent_name)
				if a_class.parents.has (parent_name) and not a_class.eiffel_name.is_equal (parent_name) then
					new_inheritance_clauses.extend (inheritance_clauses, parent_name)
				end
			end
		end
	 
	commit (an_eiffel_class: EIFFEL_CLASS) is
		indexing
			description: "Commit changes in parents inheritance clauses"
			external_name: "Commit"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			an_eiffel_class.set_parents (new_inheritance_clauses)	
		end
		
	inheritance_clauses: ARRAY [ LINKED_LIST [INHERITANCE_CLAUSE]] is
			-- | Built from `rename_clauses', `undefine_clauses', `redefine_clauses' and `select_clauses'.
		indexing
			description: "Inheritance clauses"
			external_name: "InheritanceClauses"		
		local
			a_list: LINKED_LIST [INHERITANCE_CLAUSE]
		do
			create Result.make (0, 4)
			Result.put (rename_clauses, 0)
			Result.put (undefine_clauses, 1)
			Result.put (redefine_clauses, 2)
			Result.put (select_clauses, 3)
			create a_list.make
			Result.put (a_list, 4)
		ensure
			inheritance_clauses_created: Result /= Void
			valid_inheritance_clauses: Result.count = 5
		end
		
	update_children_inheritance_clauses (old_name, new_name: STRING) is
		indexing
			description: "[
						Update children inheritance clauses in case some of them references the renamed feature:
						replace `old_name' by `new_name'.
					  ]"
			external_name: "UpdateChildrenInheritanceClauses"
		require
			non_void_old_name: old_name /= Void
			non_void_new_name: new_name /= Void
		local
			tmp_children: like children
			i: INTEGER
			a_child: EIFFEL_CLASS
			tmp_child: EIFFEL_CLASS
			parents: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			clauses: ARRAY [LINKED_LIST [INHERITANCE_CLAUSE]]
		do
			from
				tmp_children ?= children.clone (children)
				children.start
			until
				children.after
			loop
				a_child ?= children.item
				if a_child /= Void then
					parents := a_child.parents
					if parents.has (eiffel_class.eiffel_name) then
						new_inheritance_clauses ?= parents.clone (parents)
						clauses ?= parents.item (eiffel_class.eiffel_name) 
						if clauses /= Void and then clauses.count = 5 then
							rename_clauses := clauses.item (0)
							undefine_clauses := clauses.item (1)		
							redefine_clauses := clauses.item (2)	
							select_clauses := clauses.item (3)	
							intern_update_inheritance_clauses (old_name, new_name)
							commit_parent_changes (eiffel_class.eiffel_name, a_child)
						end
					end
				end
				tmp_children.go_i_th (children.index)
				tmp_child ?= tmp_children.item
				if tmp_child /= Void then
					commit (tmp_child)
				end
				children.forth
			end
			children := tmp_children
		end
	
	build_inheritance_clauses (parent_name: STRING) is
		indexing
			description: "Build `undefine_clauses', `redefine_clauses', `select_clauses' for parent with name `parent_name'."
			external_name: "BuildInheritanceClauses"
		require
			non_void_parent_name: parent_name /= Void
		local
			parents: HASH_TABLE [ARRAY[LINKED_LIST [INHERITANCE_CLAUSE]], STRING]
			clauses: ARRAY [LINKED_LIST [INHERITANCE_CLAUSE]]
		do
			parents := eiffel_class.parents
			clauses ?= parents.item (parent_name)
			if clauses /= Void and then clauses.count = 5 then
				rename_clauses := clauses.item (0)
				undefine_clauses := clauses.item (1)		
				redefine_clauses := clauses.item (2)	
				select_clauses := clauses.item (3)		
			end
		ensure
			non_void_rename_clauses: rename_clauses /= Void
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_select_clauses: select_clauses /= Void
		end

	rename_clauses: LINKED_LIST [INHERITANCE_CLAUSE]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCECLAUSE]
		indexing
			description: "Rename clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "RenameClauses"
		end
		
	undefine_clauses:  LINKED_LIST [INHERITANCE_CLAUSE]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCECLAUSE]
		indexing
			description: "Undefine clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "UndefineClauses"
		end

	redefine_clauses:  LINKED_LIST [INHERITANCE_CLAUSE]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCECLAUSE]
		indexing
			description: "Redefine clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "RedefineClauses"
		end

	select_clauses:  LINKED_LIST [INHERITANCE_CLAUSE]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCECLAUSE]
		indexing
			description: "Select clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "SelectClauses"
		end
		
	is_in_list (a_list:  LINKED_LIST [INHERITANCE_CLAUSE]; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "[
						Does `a_feature_name' appear in `a_list'?
						Make index of feature name available in `index_in_list'.
					  ]"
			external_name: "IsInList"
		require
			non_void_feature_name: a_feature_name /= Void
			non_void_clauses: a_list /= Void
		local
			a_clause: INHERITANCE_CLAUSE
			clause_string, feature_string: STRING
		do
			from
				a_list.start
			until
				a_list.after
			loop
				a_clause ?= a_list.item
				clause_string := a_clause.source_name.clone (a_clause.source_name)
				clause_string.to_lower
				feature_string := a_feature_name.clone (a_feature_name)
				feature_string.to_lower
				if a_clause /= Void and then clause_string.is_equal (feature_string) then
					index_in_list := a_list.index
					Result := True
				end
				a_list.forth
			end		
		end
	
	index_in_list: INTEGER 
		indexing
			description: "Index in inheritance clauses list (Result of `is_in_list' or `has_rename_clause')"
			external_name: "IndexInList"
		end
	
	has_rename_clause (a_name: STRING): BOOLEAN is
		indexing
			description: "Does a name appear as target of a rename clause of `eiffel_class'?"
			external_name: "HasRenameClause"
		require
			non_void_name: a_name /= Void
		local
			i: INTEGER
			an_get_item: RENAME_CLAUSE	
			target_name, name: STRING
		do
			from
				rename_clauses.start
			until
				rename_clauses.after or Result
			loop
				an_get_item ?= rename_clauses.item
				if an_get_item /= Void then
					target_name := an_get_item.target_name.clone (an_get_item.target_name)
					target_name.to_lower
					name := a_name.clone (a_name)
					name.to_lower
					
					if target_name.is_equal (name) then
						index_in_list := i
						rename_source := an_get_item.source_name.clone (an_get_item.source_name)
						Result := True
					end
				end
				rename_clauses.forth
			end
		end

	rename_source: STRING 
		indexing
			description: "Rename clause source (Result of `has_rename_clause')"
			external_name: "RenameSource"
		end
		
	argument_exists (new_name: STRING; a_feature: EIFFEL_FEATURE): BOOLEAN is
		indexing
			description: "Does `a_feature' has an argument with name `new_name'?"
			external_name: "ArgumentExists"
		require
			non_void_new_name: new_name /= Void
			non_void_feature: a_feature /= Void	
		local
			arguments: LINKED_LIST [NAMED_SIGNATURE_TYPE_INTERFACE]
			an_argument: NAMED_SIGNATURE_TYPE_INTERFACE
			i: INTEGER
			eiffel_name, name: STRING
		do
			arguments := a_feature.arguments
			from
				arguments.start
			until
				arguments.after or Result
			loop
				an_argument ?= arguments.item
				if an_argument /= Void and then an_argument.eiffel_name /= Void then
					eiffel_name := an_argument.eiffel_name.clone (an_argument.eiffel_name)
					eiffel_name.to_lower
					name := new_name.clone (new_name)
					name.to_lower
					Result := eiffel_name.is_equal (name)
				end
				arguments.forth
			end
		end

	reserved_words: LINKED_LIST [STRING] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "Reserved words in Eiffel"
			external_name: "ReservedWords"
		local
			added: INTEGER
		once
			create Result.make
			Result.extend ("current")
			Result.extend ("class")
			Result.extend ("end")
			Result.extend ("indexing")
			Result.extend ("deferred")
			Result.extend ("expanded")
			Result.extend ("obsolete")
			Result.extend ("feature")
			Result.extend ("is")
			Result.extend ("frozen")
			Result.extend ("prefix")
			Result.extend ("infix")
			Result.extend ("not")
			Result.extend ("and")
			Result.extend ("or")
			Result.extend ("xor")
			Result.extend ("else")
			Result.extend ("implies")
			Result.extend ("do")
			Result.extend ("once")
			Result.extend ("local")
			Result.extend ("old")
			Result.extend ("like")
			Result.extend ("if")
			Result.extend ("elseif")
			Result.extend ("create")
			Result.extend ("then")
			Result.extend ("inspect")
			Result.extend ("when")
			Result.extend ("from")
			Result.extend ("loop")
			Result.extend ("precursor")
			Result.extend ("until")
			Result.extend ("debug")
			Result.extend ("rescue")
			Result.extend ("retry")
			Result.extend ("unique")
			Result.extend ("creation")
			Result.extend ("inherit")
			Result.extend ("rename")
			Result.extend ("as")
			Result.extend ("export")
			Result.extend ("all")
			Result.extend ("redefine")
			Result.extend ("undefine")
			Result.extend ("select")
			Result.extend ("strip")
			Result.extend ("external")
			Result.extend ("alias")
			Result.extend ("require")
			Result.extend ("ensure")
			Result.extend ("invariant")
			Result.extend ("check")
			Result.extend ("variant")
			Result.extend ("true")
			Result.extend ("false")
			Result.extend ("result")
			Result.extend ("bit")
		ensure
			list_created: Result /= Void
		end
	
invariant
	non_void_errors_in_features: errors_in_features /= Void
	non_void_errors_in_arguments: errors_in_arguments /= Void
			
end -- class TYPE_VIEW_HANDLER
