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
			new_inheritance_clauses ?= eiffel_class.get_parents.clone
			create errors_in_features.make
			create errors_in_arguments.make
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
			type_modifications_set: type_modifications = a_type_modification
			type_view_set: type_view = a_type_view
			is_valid: is_valid
			non_void_inheritance_clauses: new_inheritance_clauses /= Void
			non_void_children: children /= Void
			non_void_errors_in_features: errors_in_features /= Void
			non_void_errors_in_arguments: errors_in_arguments /= Void
		end
		
feature -- Access
	
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
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
	
	children: SYSTEM_COLLECTIONS_ARRAYLIST
		indexing
			description: "Children of `eiffel_class'"
			external_name: "Children"
		end
	
	assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Assembly types"
			external_name: "AssemblyTypes"
		do
			Result := type_view.assembly_types
		ensure
			non_void_types: Result /= Void
		end
		
	errors_in_features: SYSTEM_COLLECTIONS_HASHTABLE
		indexing
			description: "Key: `ISE_REFLECTION_EIFFELFEATURE'; Value: Error message'"
			external_name: "ErrorsInFeatures"
		end

	errors_in_arguments: SYSTEM_COLLECTIONS_HASHTABLE
		indexing
			description: "Key: [ISE_REFLECTION_EIFFELFEATURE, ISE_REFLECTION_NAMEDSIGNATURETYPE], Value: Error message"
			external_name: "ErrorsInArguments"
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
			features_changes: SYSTEM_COLLECTIONS_HASHTABLE
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			a_feature_modifications: FEATURE_MODIFICATIONS
			changes: SYSTEM_COLLECTIONS_ARRAYLIST
			tmp_changes: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
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
			if features_changes /= Void and then features_changes.get_count > 0 then
				enumerator := features_changes.get_keys.get_enumerator
				from
					create changes.make 
				until
					not enumerator.move_next
				loop
					a_feature ?= enumerator.get_current
					if a_feature /= Void then
						a_feature_modifications ?= features_changes.get_item (a_feature)
						if a_feature_modifications /= Void then
							create an_array.make (2)
							an_array.put (0, a_feature)
							an_array.put (1, a_feature_modifications)
							added := changes.add (an_array)
						end
					end
				end
				tmp_changes ?= changes.clone
				from
				until
					i = changes.get_count
				loop
					an_array ?= tmp_changes.get_item (i)
					if an_array /= Void then
						a_feature ?= an_array.item (0)
						a_feature_modifications ?= an_array.item (1)
						if a_feature /= Void and a_feature_modifications /= Void then
							update_features (a_feature_modifications, a_feature)
						end
					end
					i := i + 1
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
		
	update_features (a_feature_modifications: FEATURE_MODIFICATIONS; a_feature: ISE_REFLECTION_EIFFELFEATURE) is
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
			arguments_changes: SYSTEM_COLLECTIONS_HASHTABLE
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE
			i: INTEGER
			added: INTEGER
			changes: SYSTEM_COLLECTIONS_ARRAYLIST
			tmp_changes: SYSTEM_COLLECTIONS_ARRAYLIST
			an_array: ARRAY [ANY]
		do
				-- Update feature name
			if a_feature_modifications.new_feature_name /= Void then
				if a_feature_modifications.new_feature_name.get_length > 0 then
					new_name := a_feature_modifications.new_feature_name
					if recursive_exists (new_name) then
						is_valid := False
						if errors_in_features.contains (a_feature) then
							errors_in_features.remove (a_feature)
						end
						errors_in_features.add (a_feature, Feature_exists_error)
					elseif reserved_words.contains (new_name.to_lower) then
						is_valid := False
						if errors_in_features.contains (a_feature) then
							errors_in_features.remove (a_feature)
						end					
						errors_in_features.add (a_feature, Feature_clash_with_reserved_word)
					else
						is_valid := is_valid and True
						old_name := a_feature_modifications.old_feature_name					
						--recursive_update_inheritance_clauses (old_name, new_name)
						--update_children_inheritance_clauses (old_name, new_name)
						rename_feature_in_children (old_name, new_name)
						a_feature.set_eiffel_name (new_name)
						a_feature.set_modified (True)
					end
				else
					is_valid := False
					if errors_in_features.contains (a_feature) then
						errors_in_features.remove (a_feature) 
					end
					errors_in_features.add (a_feature, Empty_feature_name)
				end 
			end
				-- Update feature arguments
			arguments_changes := a_feature_modifications.arguments_modifications
			if arguments_changes /= Void and then arguments_changes.get_count > 0 then
				enumerator := arguments_changes.get_keys.get_enumerator
				from
					create changes.make
				until
					not enumerator.move_next
				loop
					an_argument ?= enumerator.get_current
					if an_argument /= Void then
						new_name ?= arguments_changes.get_item (an_argument)
						if new_name /= Void then
							create an_array.make (2)
							an_array.put (0, an_argument)
							an_array.put (1, new_name)
							added := changes.add (an_array)						
						end
					end
				end			
				tmp_changes ?= changes.clone
				from
				until
					i = changes.get_count
				loop
					an_array ?= tmp_changes.get_item (i)
					if an_array /= Void then
						an_argument ?= an_array.item (0)
						new_name ?= an_array.item (1)
						if an_argument /= Void and new_name /= Void then
							update_arguments (new_name, an_argument, a_feature)
						end
					end
					i := i + 1
				end
			end
		end
	
	update_arguments (new_name: STRING; an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE; a_feature: ISE_REFLECTION_EIFFELFEATURE) is
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
		do
			if new_name.get_length > 0 then
				if recursive_exists (new_name) then
					is_valid := False
					create an_array.make (2)
					an_array.put (0, a_feature)
					an_array.put (1, an_argument)
					if errors_in_arguments.contains (an_array) then
						errors_in_arguments.remove (an_array)
					end
					errors_in_arguments.add (an_array, Clash_with_feature_name)
				elseif reserved_words.contains (new_name.to_lower) then
					is_valid := False
					create an_array.make (2)
					an_array.put (0, a_feature)
					an_array.put (1, an_argument)
					if errors_in_arguments.contains (an_array) then
						errors_in_arguments.remove (an_array)
					end
					errors_in_arguments.add (an_array, Argument_clash_with_reserved_word)	
				elseif argument_exists (new_name, a_feature) then
					is_valid := False
					create an_array.make (2)
					an_array.put (0, a_feature)
					an_array.put (1, an_argument)
					if errors_in_arguments.contains (an_array) then
						errors_in_arguments.remove (an_array)
					end
					errors_in_arguments.add (an_array, Argument_name_exists)
				else
					is_valid := is_valid and True
					an_argument.set_eiffel_name (new_name)
					a_feature.set_modified (True)
				end
			else
				is_valid := False
				create an_array.make (2)
				an_array.put (0, a_feature)
				an_array.put (1, an_argument)
				if errors_in_arguments.contains (an_array) then
					errors_in_arguments.remove (an_array)
				end
				errors_in_arguments.add (an_array, Empty_argument_name)
			end
		end
		
	new_inheritance_clauses: SYSTEM_COLLECTIONS_HASHTABLE
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
			a_type: ISE_REFLECTION_EIFFELCLASS
		do
			from
			until
				i = assembly_types.get_count or Result
			loop
				a_type ?= assembly_types.get_item (i)
				if a_type /= Void then
					Result := a_type.get_eiffel_name.to_lower.equals_string (a_class_name.to_lower)
				end
				i := i + 1
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
			a_class: ISE_REFLECTION_EIFFELCLASS
			class_found: BOOLEAN
		do
			from
			until
				i = assembly_types.get_count or class_found
			loop
				a_class ?= assembly_types.get_item (i)
				if a_class.get_eiffel_name.to_lower.equals_string (eiffel_class.get_eiffel_name.to_lower) then
					a_class.set_eiffel_name (new_name)
					class_found := True
				end
				i := i + 1
			end
			eiffel_class.set_eiffel_name (new_name)
		ensure
			new_name_set: eiffel_class.get_eiffel_name.equals_string (new_name)
		end

	rename_children_parent (new_name: STRING) is
		indexing
			description: "Rename `children' according to `new_name' of `eiffel_class'."
			external_name: "RenameChildrenParent"
		require
			non_void_new_name: new_name /= Void
		local
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]			
		do
			from
			until
				i = children.get_count
			loop
				a_child ?= children.get_item (i)
				if a_child /= Void then
					parents := a_child.get_parents
					if parents.contains (eiffel_class.get_eiffel_name) then
						clauses ?= parents.get_item (eiffel_class.get_eiffel_name)
						if clauses /= Void then
							parents.remove (eiffel_class.get_eiffel_name)
							parents.add (new_name, clauses)
						end
					end
				end
				i := i + 1
			end
		end
	
	exists (a_class: ISE_REFLECTION_EIFFELCLASS; a_feature_name: STRING): BOOLEAN is
		indexing
			description: "Does a feature with `a_feature_name' exist in `eiffel_class'?"
			external_name: "Exists"
		require
			non_void_class: a_class /= Void
			non_void_feature_name: a_feature_name /= Void
		local
			support: SUPPORT
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
			a_child: ISE_REFLECTION_EIFFELCLASS
		do
			if exists (eiffel_class, a_feature_name) then
				Result := True
			else
				from
				until
					i = children.get_count or Result
				loop
					a_child ?= children.get_item (i)	
					if a_child /= Void then
						Result := exists (a_child, a_feature_name)
					end
					i := i + 1
				end
			end
		end
		
	eiffel_feature: ISE_REFLECTION_EIFFELFEATURE
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
			children_to_change: SYSTEM_COLLECTIONS_HASHTABLE
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			from
				create children_to_change.make
			until
				i = children.get_count
			loop
				a_child ?= children.get_item (i)
				if a_child /= Void and then exists (a_child, old_name) then
					children_to_change.add (a_child, eiffel_feature)
				end
				i := i + 1
			end
			enumerator := children_to_change.get_values.get_enumerator
			from
			until
				not enumerator.move_next
			loop
				a_feature ?= enumerator.get_current
				if a_feature /= Void then
					a_feature.set_eiffel_name (new_name)
					a_feature.set_modified (True)
				end
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
			parents_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_parent_name: STRING
			i: INTEGER
			added: INTEGER
			parent_names: SYSTEM_COLLECTIONS_ARRAYLIST
			tmp_parent_names: SYSTEM_COLLECTIONS_ARRAYLIST
		do
			parents_enumerator := eiffel_class.get_parents.get_keys.get_enumerator
			from
				create parent_names.make
			until
				not parents_enumerator.move_next
			loop
				a_parent_name ?= parents_enumerator.get_current
				if a_parent_name /= Void and then a_parent_name.get_length > 0 then
					added := parent_names.add (a_parent_name)
					--update_inheritance_clauses (a_parent_name, old_name, new_name)
				end
			end
			tmp_parent_names ?= parent_names.clone
			from
			until
				i = parent_names.get_count
			loop
				a_parent_name ?= tmp_parent_names.get_item (i)
				if a_parent_name /= Void then
					update_inheritance_clauses (a_parent_name, old_name, new_name)
				end
				i := i + 1
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
			a_rename_clause: ISE_REFLECTION_RENAMECLAUSE
			added: INTEGER
		do
			build_inheritance_clauses (parent_name)
			if not has_rename_clause (old_name) and then (is_in_list (undefine_clauses, old_name) or is_in_list (redefine_clauses, old_name) or is_in_list (select_clauses, old_name)) then
				create a_rename_clause.make_renameclause
				a_rename_clause.make_from_info (old_name, new_name)
				added := rename_clauses.add (a_rename_clause)
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
			a_rename_clause: ISE_REFLECTION_RENAMECLAUSE
			an_undefine_clause: ISE_REFLECTION_UNDEFINECLAUSE
			a_redefine_clause: ISE_REFLECTION_REDEFINECLAUSE
			a_select_clause: ISE_REFLECTION_SELECTCLAUSE
		do
		--	if has_rename_clause (old_name) then
		--		rename_clauses.removeat (index_in_list)
		--		create a_rename_clause.make_renameclause
		--		a_rename_clause.makefrominfo (rename_source, new_name)
		--		added := rename_clauses.add (a_rename_clause)
		--	end
			if is_in_list (undefine_clauses, old_name) then
				undefine_clauses.remove_at (index_in_list)
				create an_undefine_clause.make_undefineclause
				an_undefine_clause.make (new_name)
				added := undefine_clauses.add (an_undefine_clause)
			end
			if is_in_list (redefine_clauses, old_name) then
				redefine_clauses.remove_at (index_in_list)
				create a_redefine_clause.make_redefineclause
				a_redefine_clause.make (new_name)				
				added := redefine_clauses.add (a_redefine_clause)			
			end
			if is_in_list (select_clauses, old_name) then
				select_clauses.remove_at (index_in_list)
				create a_select_clause.make_selectclause
				a_select_clause.make (new_name)
				added := select_clauses.add (a_select_clause)			
			end
		ensure
			not_in_undefine_clauses: not is_in_list (undefine_clauses, old_name)
			not_in_redefine_clauses: not is_in_list (redefine_clauses, old_name)
			not_in_select_clauses: not is_in_list (select_clauses, old_name)
		end

	commit_parent_changes (parent_name: STRING; a_class: ISE_REFLECTION_EIFFELCLASS) is
		indexing
			description: "Set new inheritance clauses to parent of `eiffel_class' with name `parent_name'."
			external_name: "CommitParentChanges"
		require
			non_void_parent_name: parent_name /= Void
			non_void_inheritance_clauses: new_inheritance_clauses /= Void
			non_void_class: a_class /= Void
		do
			if new_inheritance_clauses.contains (parent_name) then
				new_inheritance_clauses.remove (parent_name)
				if a_class.get_parents.contains (parent_name) and not a_class.get_eiffel_name.equals_string (parent_name) then
					new_inheritance_clauses.add (parent_name, inheritance_clauses)
				end
			end
		end
	 
	commit (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		indexing
			description: "Commit changes in parents inheritance clauses"
			external_name: "Commit"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		do
			an_eiffel_class.set_parents (new_inheritance_clauses)	
		end
		
	inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST] is
			-- | Built from `rename_clauses', `undefine_clauses', `redefine_clauses' and `select_clauses'.
		indexing
			description: "Inheritance clauses"
			external_name: "InheritanceClauses"		
		local
			a_list: SYSTEM_COLLECTIONS_ARRAYLIST
		do
			create Result.make (5)
			Result.put (0, rename_clauses)
			Result.put (1, undefine_clauses)
			Result.put (2, redefine_clauses)
			Result.put (3, select_clauses)
			create a_list.make
			Result.put (4, a_list)
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
			tmp_children: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			tmp_child: ISE_REFLECTION_EIFFELCLASS
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]	
		do
			from
				tmp_children ?= children.clone
			until
				i = children.get_count
			loop
				a_child ?= children.get_item (i)
				if a_child /= Void then
					parents := a_child.get_parents
					if parents.contains (eiffel_class.get_eiffel_name) then
						new_inheritance_clauses ?= parents.clone
						clauses ?= parents.get_item (eiffel_class.get_eiffel_name) 
						if clauses /= Void and then clauses.count = 5 then
							rename_clauses := clauses.item (0)
							undefine_clauses := clauses.item (1)		
							redefine_clauses := clauses.item (2)	
							select_clauses := clauses.item (3)	
							intern_update_inheritance_clauses (old_name, new_name)
							commit_parent_changes (eiffel_class.get_eiffel_name, a_child)
						end
					end
				end
				tmp_child ?= tmp_children.get_item (i)
				if tmp_child /= Void then
					commit (tmp_child)
				end
				i := i + 1
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
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			parents := eiffel_class.get_parents
			clauses ?= parents.get_item (parent_name)
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

	rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			description: "Rename clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "RenameClauses"
		end
		
	undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			description: "Undefine clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "UndefineClauses"
		end

	redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			description: "Redefine clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "RedefineClauses"
		end

	select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			description: "Select clauses for parent with `parent_name' in `eiffel_class'"
			external_name: "SelectClauses"
		end
		
	is_in_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST; a_feature_name: STRING): BOOLEAN is
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
			i: INTEGER
			a_clause: ISE_REFLECTION_INHERITANCECLAUSE
		do
			from
			until
				i = a_list.get_count or Result
			loop
				a_clause ?= a_list.get_item (i)
				if a_clause /= Void and then a_clause.get_source_name.to_lower.equals_string (a_feature_name.to_lower) then
					index_in_list := i
					Result := True
				end
				i := i + 1
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
			an_get_item: ISE_REFLECTION_RENAMECLAUSE			
		do
			from
			until
				i = rename_clauses.get_count or Result
			loop
				an_get_item ?= rename_clauses.get_item (i)
				if an_get_item /= Void then
					if an_get_item.get_target_name.to_lower.equals_string (a_name.to_lower) then
						index_in_list := i
						rename_source := an_get_item.get_source_name
						Result := True
					end
				end
				i := i + 1
			end
		end

	rename_source: STRING 
		indexing
			description: "Rename clause source (Result of `has_rename_clause')"
			external_name: "RenameSource"
		end
		
	argument_exists (new_name: STRING; a_feature: ISE_REFLECTION_EIFFELFEATURE): BOOLEAN is
		indexing
			description: "Does `a_feature' has an argument with name `new_name'?"
			external_name: "ArgumentExists"
		require
			non_void_new_name: new_name /= Void
			non_void_feature: a_feature /= Void	
		local
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			an_argument: ISE_REFLECTION_INAMEDSIGNATURETYPE
			i: INTEGER
		do
			arguments := a_feature.get_arguments
			from
			until
				i = arguments.get_count or Result
			loop
				an_argument ?= arguments.get_item (i)
				if an_argument /= Void and then an_argument.eiffel_name /= Void then
					Result := an_argument.eiffel_name.to_lower.equals_string (new_name.to_lower)
				end
				i := i + 1
			end
		end

	reserved_words: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			description: "Reserved words in Eiffel"
			external_name: "ReservedWords"
		local
			added: INTEGER
		once
			create Result.make
			added := Result.add ("current")
			added := Result.add ("class")
			added := Result.add ("end")
			added := Result.add ("indexing")
			added := Result.add ("deferred")
			added := Result.add ("expanded")
			added := Result.add ("obsolete")
			added := Result.add ("feature")
			added := Result.add ("is")
			added := Result.add ("frozen")
			added := Result.add ("prefix")
			added := Result.add ("infix")
			added := Result.add ("not")
			added := Result.add ("and")
			added := Result.add ("or")
			added := Result.add ("xor")
			added := Result.add ("else")
			added := Result.add ("implies")
			added := Result.add ("do")
			added := Result.add ("once")
			added := Result.add ("local")
			added := Result.add ("old")
			added := Result.add ("like")
			added := Result.add ("if")
			added := Result.add ("elseif")
			added := Result.add ("create")
			added := Result.add ("then")
			added := Result.add ("inspect")
			added := Result.add ("when")
			added := Result.add ("from")
			added := Result.add ("loop")
			added := Result.add ("precursor")
			added := Result.add ("until")
			added := Result.add ("debug")
			added := Result.add ("rescue")
			added := Result.add ("retry")
			added := Result.add ("unique")
			added := Result.add ("creation")
			added := Result.add ("inherit")
			added := Result.add ("rename")
			added := Result.add ("as")
			added := Result.add ("export")
			added := Result.add ("all")
			added := Result.add ("redefine")
			added := Result.add ("undefine")
			added := Result.add ("select")
			added := Result.add ("strip")
			added := Result.add ("external")
			added := Result.add ("alias")
			added := Result.add ("require")
			added := Result.add ("ensure")
			added := Result.add ("invariant")
			added := Result.add ("check")
			added := Result.add ("variant")
			added := Result.add ("true")
			added := Result.add ("false")
			added := Result.add ("result")
			added := Result.add ("bit")
		ensure
			list_created: Result /= Void
		end
	
invariant
	non_void_errors_in_features: errors_in_features /= Void
	non_void_errors_in_arguments: errors_in_arguments /= Void
			
end -- class TYPE_VIEW_HANDLER
