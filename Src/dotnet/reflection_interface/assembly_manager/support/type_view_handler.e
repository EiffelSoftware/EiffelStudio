indexing
	description: "Check class and feature names validity and update eiffel class."
	external_name: "ISE.AssemblyManager.TypeViewHandler"

class
	TYPE_VIEW_HANDLER

create
	make

feature {NONE} -- Initialization

	make (an_eiffel_class: like eiffel_class; a_type_view: like type_view) is
			-- Set `eiffel_class' with `an_eiffel_class'.
			-- Set `type_view' with `a_type_view'.
		indexing
			external_name: "Make"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_type_view: a_type_view /= Void
		do
			eiffel_class := an_eiffel_class
			type_view := a_type_view
			is_valid := True
			children := type_view.children
			create new_inheritance_clauses.make
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
			type_view_set: type_view = a_type_view
			is_valid: is_valid
			non_void_inheritance_clauses: new_inheritance_clauses /= Void
			non_void_children: children /= Void
		end
		
feature -- Access
	
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
			-- Eiffel class `inheritance_clauses' should belong to
		indexing
			external_name: "EiffelClass"
		end
	
	type_view: TYPE_VIEW
			-- Type view
		indexing
			external_name: "TypeView"
		end
		
	error_message: STRING 
			-- Error message in case the class or feature name is not valid
		indexing
			external_name: "ErrorMessage"
		end
	
	children: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Children of `eiffel_class'
		indexing
			external_name: "Children"
		end
	
	assembly_types: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Assembly types
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			external_name: "AssemblyTypes"
		once
			Result := type_view.assembly_types
		ensure
			non_void_types: Result /= Void
		end
	
	old_name: STRING
			-- Name to be changed by user.
		indexing
			external_name: "OldName"
		end
		
feature -- Constants

	Class_exists_error: STRING is "A class of the assembly has the same name. Please choose another name."
			-- Error message in case the class name already exists.
		indexing
			external_name: "ClassExistsError"
		end
	
	Feature_exists_error: STRING is "The feature name already exists in the current class or one of its descendants. Please choose another name."
			-- Error message in case the feature name is the name of an existing feature of the class or of the children
		indexing
			external_name: "FeatureExistsError"
		end

	Clash_with_feature_name: STRING is "The argument has the same name of an existing feature of the class or one of its descendant. Please choose another name."
			-- Error message in case of clash between argument and features names
		indexing
			external_name: "ClashWithFeatureName"
		end	
	
	Argument_name_exists: STRING is "The feature already has an argument with the same name. Please choose another name."
			-- Error message in case the feature already has an argument with the same name
		indexing
			external_name: "ArgumentNameExists"
		end
		
	As_keyword: STRING is "as"
			-- As keyword
		indexing
			external_name: "AsKeyword"
		end

	Space: STRING is " "
			-- Space as a string
		indexing
			external_name: "Space"
		end

	Initialization: INTEGER is 1
			-- Constant corresponding to initialization feature clause
		indexing
			external_name: "Initialization"
		end

	Access: INTEGER is 2
			-- Constant corresponding to access feature clause
		indexing
			external_name: "Access"
		end	

	Element_change: INTEGER is 3
			-- Constant corresponding to element change feature clause
		indexing
			external_name: "ElementChange"
		end

	Basic_operations: INTEGER is 4
			-- Constant corresponding to basic operations feature clause
		indexing
			external_name: "BasicOperations"
		end		

	Unary_operators: INTEGER is 5
			-- Constant corresponding to unary operators feature clause
		indexing
			external_name: "UnaryOperators"
		end

	Binary_operators: INTEGER is 6
			-- Constant corresponding to binary operators feature clause
		indexing
			external_name: "BinaryOperators"
		end	

	Specials: INTEGER is 7
			-- Constant corresponding to specials feature clause
		indexing
			external_name: "Specials"
		end	

	Implementation: INTEGER is 8
			-- Constant corresponding to implementation feature clause
		indexing
			external_name: "Implementation"
		end	
		
feature -- Status Report

	is_valid: BOOLEAN 
			-- Is valid? (Result of `check_validity')
		indexing
			external_name: "IsValid"
		end
	
feature -- Status Setting

	set_old_name (a_name: like old_name) is
			-- Set `old_name' with `a_name'.
		indexing
			external_name: "SetOldName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		do
			old_name := a_name
		ensure
			name_set: old_name.equals_string (a_name)
		end
	
	set_valid is
			-- Set `is_valid' with `True'.
		indexing
			external_name: "SetValid"
		do
			is_valid := True
		ensure
			is_valid: is_valid
		end
		
feature -- Basic Operations
	
	update_class (new_name: STRING) is
			-- Check for name clashes and update class name if name is valid. 
			-- Make result of check available in `is_valid'.
		indexing
			external_name: "UpdateClass"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
		do
			if class_exists (new_name) then
				is_valid := False
				error_message := Class_exists_error
			else
				is_valid := True
				rename_children_parent (new_name)
				rename_class (new_name)
			end
		end
		
	update_features (new_name: STRING; feature_clause, feature_number: INTEGER) is
			-- Check for name clashes and update feature name, create clauses and inheritance clauses (if needed) if name is valid. 
			-- Make result of check available in `is_valid'.
		indexing
			external_name: "UpdateFeatures"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
			valid_feature_number: feature_number >= 0
		do
			if recursive_exists (new_name) then
				is_valid := False
				error_message := Feature_exists_error
			else
				is_valid := True
				recursive_update_inheritance_clauses (new_name)
				update_create_clauses (new_name)
				update_children_inheritance_clauses (new_name)
				changed_feature := modified_feature (feature_clause, feature_number)
				if changed_feature.isabstract then
					rename_feature_in_children (new_name)
				end
				rename_feature (new_name)
			end
		end
	
	update_arguments (new_name: STRING; feature_clause, feature_number, argument_number: INTEGER) is
			-- Check for name clashes with other arguments or feature names and update argument name.
			-- Make result of check available in `is_valid'.
		indexing
			external_name: "UpdateArguments"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
			valid_feature_number: feature_number >= 0
			valid_argument_number: argument_number >= 0
		do
			if recursive_exists (new_name) then
				is_valid := False
				error_message := Clash_with_feature_name
			else
				if argument_exists (new_name, feature_clause, feature_number) then
					is_valid := False
					error_message := Argument_name_exists
				else
					is_valid := True
					rename_argument (new_name, feature_clause, feature_number, argument_number)
				end
			end
		end
	
feature {NONE} -- Implementation

	new_inheritance_clauses: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Parent name
			-- Value: List of inheritance clauses
		indexing
			external_name: "NewInheritanceClauses"
		end
	
	changed_feature: ISE_REFLECTION_EIFFELFEATURE
			-- Feature whose eiffel name has changed
		indexing
			external_name: "ChangedFeature"
		end
		
	class_exists (a_class_name: STRING): BOOLEAN is
			-- Does a class with name `a_class_name' already exist in assembly types?
		indexing
			external_name: "ClassExists"
		require
			non_void_class_name: a_class_name /= Void
			not_empty_class_name: a_class_name.length > 0
		local
			i: INTEGER
			a_type: ISE_REFLECTION_EIFFELCLASS
		do
			from
			until
				i = assembly_types.count or Result
			loop
				a_type ?= assembly_types.item (i)
				if a_type /= Void then
					Result := a_type.eiffelname.tolower.equals_string (a_class_name.tolower)
				end
				i := i + 1
			end
		end
	
	rename_class (new_name: STRING) is
			-- Rename `eiffel_class' with `new_name' and update `assembly_types'.
		indexing
			external_name: "RenameClass"
		require
			non_void_name: new_name /= Void
			not_empty_name: new_name.length > 0 
		local
			i: INTEGER
			a_class: ISE_REFLECTION_EIFFELCLASS
			class_found: BOOLEAN
		do
			from
			until
				i = assembly_types.count or class_found
			loop
				a_class ?= assembly_types.item (i)
				if a_class.eiffelname.tolower.equals_string (eiffel_class.eiffelname.tolower) then
					a_class.seteiffelname (new_name)
					class_found := True
				end
				i := i + 1
			end
			eiffel_class.seteiffelname (new_name)
		ensure
			new_name_set: eiffel_class.eiffelname.equals_string (new_name)
		end

	rename_children_parent (new_name: STRING) is
			-- Rename `children' according to `new_name' of `eiffel_class'.
		indexing
			external_name: "RenameChildrenParent"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
		local
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]			
		do
			from
			until
				i = children.count
			loop
				a_child ?= children.item (i)
				if a_child /= Void then
					parents := a_child.parents
					if parents.contains (eiffel_class.eiffelname) then
						clauses ?= parents.item (eiffel_class.eiffelname)
						if clauses /= Void then
							parents.remove (eiffel_class.eiffelname)
							parents.add (new_name, clauses)
						end
					end
				end
				i := i + 1
			end
		end
	
	exists (a_class: ISE_REFLECTION_EIFFELCLASS; a_feature_name: STRING): BOOLEAN is
			-- Does a feature with `a_feature_name' exist in `eiffel_class'?
		indexing
			external_name: "Exists"
		require
			non_void_class: a_class /= Void
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
		do
			Result := has_feature (a_class.initializationfeatures, a_feature_name)
					or has_feature (a_class.accessfeatures, a_feature_name)
					or has_feature (a_class.elementchangefeatures, a_feature_name)
					or has_feature (a_class.basicoperations, a_feature_name)
					or has_feature (a_class.unaryoperatorsfeatures, a_feature_name)
					or has_feature (a_class.binaryoperatorsfeatures, a_feature_name)
					or has_feature (a_class.specialfeatures, a_feature_name)
					or has_feature (a_class.implementationfeatures, a_feature_name)
		end
	
	recursive_exists (a_feature_name: STRING): BOOLEAN is
			-- Call `exists' on each child of `children' list.
		indexing
			external_name: "RecursiveExists"
		require
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
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
					i = children.count or Result
				loop
					a_child ?= children.item (i)	
					if a_child /= Void then
						Result := exists (a_child, a_feature_name)
					end
					i := i + 1
				end
			end
		end
		
	has_feature (a_list: SYSTEM_COLLECTIONS_ARRAYLIST; a_feature_name: STRING): BOOLEAN is
			-- Does `a_list' contain feature with name `a_feature_name'?
		indexing
			external_name: "HasFeature"
		require
			non_void_list: a_list /= Void
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
		local
			i: INTEGER
			a_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			from
			until
				i = a_list.count or Result
			loop
				a_feature ?= a_list.item (i)
				if a_feature /= Void and then a_feature.eiffelname.tolower.equals_string (a_feature_name.tolower) then
					eiffel_feature := a_feature
					Result := True
				end
				i := i + 1
			end
		end

	eiffel_feature: ISE_REFLECTION_EIFFELFEATURE
			-- Eiffel feature (Result of `has_feature')
		indexing
			external_name: "EiffelFeature"
		end
	
	modified_feature (feature_clause, feature_number: INTEGER): ISE_REFLECTION_EIFFELFEATURE is
			-- Modified feature:`feature_number'-th feature in clause `feature_clause'
		indexing
			external_name: "ModifiedFeature"
		require
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
			valid_feature_number: feature_number >= 0		
		local
			retried: BOOLEAN
		do
			if not retried then
				if feature_clause = Initialization then
					Result ?= eiffel_class.initializationfeatures.item (feature_number)
				elseif feature_clause = Access then
					Result ?= eiffel_class.accessfeatures.item (feature_number)
				elseif feature_clause = Element_change then
					Result ?= eiffel_class.elementchangefeatures.item (feature_number)
				elseif feature_clause = Basic_operations then
					Result ?= eiffel_class.basicoperations.item (feature_number)
				elseif feature_clause = Unary_operators then
					Result ?= eiffel_class.unaryoperatorsfeatures.item (feature_number)
				elseif feature_clause = Binary_operators then
					Result ?= eiffel_class.binaryoperatorsfeatures.item (feature_number)
				elseif feature_clause = Specials then
					Result ?= eiffel_class.specialfeatures.item (feature_number)
				elseif feature_clause = Implementation then
					Result ?= eiffel_class.implementationfeatures.item (feature_number)
				end
			else
				create Result.make1
				Result.make
			end
		rescue
			retried := True
			retry
		end
	
	rename_feature (new_name: STRING) is
			-- Rename `changed_feature' with `new_name'.
		indexing
			external_name: "RenameFeature"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0		
		do
			changed_feature.seteiffelname (new_name)
		end
	
	rename_feature_in_children (new_name: STRING) is
			-- Rename feature implemented in children with `new_name'.
		indexing
			external_name: "RenameFeatureInChildren"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
		local
			children_to_change: SYSTEM_COLLECTIONS_HASHTABLE
			i: INTEGER
			a_child: ISE_REFLECTION_EIFFELCLASS
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			moved: BOOLEAN
			a_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			from
				create children_to_change.make
			until
				i = children.count
			loop
				a_child ?= children.item (i)
				if a_child /= Void and then exists (a_child, old_name) then
					children_to_change.add (a_child, eiffel_feature)
				end
				i := i + 1
			end
			enumerator := children_to_change.values.getenumerator
			from
			until
				not enumerator.movenext
			loop
				a_feature ?= enumerator.current_
				if a_feature /= Void then
					a_feature.seteiffelname (new_name)
				end
				moved := enumerator.movenext
			end
		end
		
	recursive_update_inheritance_clauses (new_name: STRING) is
			-- Update of all inheritance clauses to tke `new_name' into account.
		indexing
			external_name: "RecursiveUpdateInheritanceClauses"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0	
		local
			parents_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_parent_name: STRING
			moved: BOOLEAN
		do
			parents_enumerator := eiffel_class.parents.keys.getenumerator
			from
			until
				not parents_enumerator.movenext
			loop
				a_parent_name ?= parents_enumerator.current_
				if a_parent_name /= Void and then a_parent_name.length > 0 then
					update_inheritance_clauses (a_parent_name, new_name)
				end
				moved := parents_enumerator.movenext
			end
			commit (eiffel_class)
		end
	
	update_inheritance_clauses (parent_name, new_name: STRING) is
			-- Update `rename_clauses', `undefine_clauses', `redefine_clauses', `select_clauses' by replacing `old_name' by `new_name'.
		indexing
			external_name: "UpdateInheritanceClauses"
		require
			non_void_parent_name: parent_name /= Void
			not_empty_parent_name: parent_name.length > 0
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
		local
			rename_clause_text: STRING
			added: INTEGER
		do
			build_inheritance_clauses (parent_name)
			intern_update_inheritance_clauses (new_name)
			commit_parent_changes (parent_name)
		ensure
			not_in_undefine_clauses: not is_in_list (undefine_clauses, old_name)
			not_in_redefine_clauses: not is_in_list (redefine_clauses, old_name)
			not_in_select_clauses: not is_in_list (select_clauses, old_name)
		end
		
	intern_update_inheritance_clauses (new_name: STRING) is
			-- Update inheritance clauses by replacing `old_name' by `new_name'.
		indexing
			external_name: "InternUpdateInheritanceClauses"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
		local
			added: INTEGER
			a_rename_clause: ISE_REFLECTION_RENAMECLAUSE
			an_undefine_clause: ISE_REFLECTION_UNDEFINECLAUSE
			a_redefine_clause: ISE_REFLECTION_REDEFINECLAUSE
			a_select_clause: ISE_REFLECTION_SELECTCLAUSE
		do
			if has_rename_clause (old_name) then
				rename_clauses.removeat (index_in_list)
				create a_rename_clause.make_renameclause
				a_rename_clause.makefrominfo (rename_source, new_name)
				added := rename_clauses.add (a_rename_clause)
			end
			if is_in_list (undefine_clauses, old_name) then
				undefine_clauses.removeat (index_in_list)
				create an_undefine_clause.make_undefineclause
				an_undefine_clause.make (new_name)
				added := undefine_clauses.add (an_undefine_clause)
			end
			if is_in_list (redefine_clauses, old_name) then
				redefine_clauses.removeat (index_in_list)
				create a_redefine_clause.make_redefineclause
				a_redefine_clause.make (new_name)				
				added := redefine_clauses.add (a_redefine_clause)			
			end
			if is_in_list (select_clauses, old_name) then
				select_clauses.removeat (index_in_list)
				create a_select_clause.make_selectclause
				a_select_clause.make (new_name)
				added := select_clauses.add (a_select_clause)			
			end
		ensure
			not_in_undefine_clauses: not is_in_list (undefine_clauses, old_name)
			not_in_redefine_clauses: not is_in_list (redefine_clauses, old_name)
			not_in_select_clauses: not is_in_list (select_clauses, old_name)
		end

	commit_parent_changes (parent_name: STRING) is
			-- Set new inheritance clauses to parent of `eiffel_class' with name `parent_name'.
		indexing
			external_name: "CommitParentChanges"
		require
			non_void_parent_name: parent_name /= Void
			not_empty_parent_name: parent_name.length > 0
			non_void_inheritance_clauses: new_inheritance_clauses /= Void
		do
			if not new_inheritance_clauses.contains (parent_name) then
				new_inheritance_clauses.add (parent_name, inheritance_clauses)
			else
				new_inheritance_clauses.remove (parent_name)
				new_inheritance_clauses.add (parent_name, inheritance_clauses)
			end
		end
	 
	commit (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
			-- Commit changes in parents inheritance clauses
		indexing
			external_name: "Commit"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
		local
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			moved: BOOLEAN
			a_parent_name: STRING
			new_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			parents := an_eiffel_class.parents
			enumerator := parents.keys.getenumerator
			from
			until
				not enumerator.movenext
			loop
				a_parent_name ?= enumerator.current_
				if a_parent_name /= Void and then new_inheritance_clauses.containskey (a_parent_name) then
					new_clauses ?= new_inheritance_clauses.item (a_parent_name) 
					if new_clauses /= Void then
						parents.remove (a_parent_name)
						parents.add (a_parent_name, new_clauses)
					end
				end
				moved := enumerator.movenext
			end		
		end
		
	inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST] is
			-- New inheritance clauses 
			-- | Built from `rename_clauses', `undefine_clauses', `redefine_clauses' and `select_clauses'.
		indexing
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
			new_inheritance_clauses_created: Result /= Void
			valid_inheritance_clauses: Result.count = 5
		end
		
	update_children_inheritance_clauses (new_name: STRING) is
			-- Update children inheritance clauses in case some of them references the renamed feature:
			-- replace `old_name' by `new_name'.
		indexing
			external_name: "UpdateChildrenInheritanceClauses"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
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
				i = children.count
			loop
				a_child ?= children.item (i)
				if a_child /= Void then
					parents := a_child.parents
					if parents.contains (eiffel_class.eiffelname) then
						clauses ?= parents.item (eiffel_class.eiffelname) 
						if clauses /= Void and then clauses.count = 5 then
							rename_clauses := clauses.item (0)
							undefine_clauses := clauses.item (1)		
							redefine_clauses := clauses.item (2)	
							select_clauses := clauses.item (3)	
							intern_update_inheritance_clauses (new_name)
							commit_parent_changes (eiffel_class.eiffelname)
						end
					end
				end
				tmp_child ?= tmp_children.item (i)
				if tmp_child /= Void then
					commit (tmp_child)
				end
				i := i + 1
			end
			children := tmp_children
		end
			
	update_create_clauses (new_name: STRING) is
			-- Update create clauses.
		indexing
			external_name: "UpdateCreateClauses"
		require
			non_void_name: new_name /= Void
			not_empty_name: new_name.length > 0
		local
			added: INTEGER
		do
			if has_feature (eiffel_class.initializationfeatures, old_name) and then has_create_clause then
				eiffel_class.creationroutines.removeat (index_in_list)
				added := eiffel_class.creationroutines.add (new_name)
			end
		end
	
	has_create_clause: BOOLEAN is
			-- Is `old_name' a creation routine name of `eiffel_class'?
			-- If found, make indice of create clause available in `index_in_list'.
		indexing
			external_name: "HasCreateClause"
		require
			non_void_old_name: old_name /= Void
			not_empty_old_name: old_name.length > 0
		local
			creation_routines: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			a_routine_name: STRING
		do
			creation_routines := eiffel_class.creationroutines
			from
			until
				i = creation_routines.count or Result
			loop	
				a_routine_name ?= creation_routines.item (i)
				if a_routine_name /= Void and then a_routine_name.length > 0 then
					if a_routine_name.tolower.equals_string (old_name.tolower) then
						index_in_list := i
						Result := True
					end
				end
				i := i + 1
			end
		end
	
	build_inheritance_clauses (parent_name: STRING) is
			-- Build `undefine_clauses', `redefine_clauses', `select_clauses' for parent with name `parent_name'.
		indexing
			external_name: "BuildInheritanceClauses"
		require
			non_void_parent_name: parent_name /= Void
			not_empty_parent_name: parent_name.length > 0
		local
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			parents := eiffel_class.parents
			clauses ?= parents.item (parent_name)
			if clauses /= Void and then inheritance_clauses.count = 5 then
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
			-- Rename clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			external_name: "RenameClauses"
		end
		
	undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Undefine clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			external_name: "UndefineClauses"
		end

	redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Redefine clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			external_name: "RedefineClauses"
		end

	select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Select clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_INHERITANCECLAUSE]
		indexing
			external_name: "SelectClauses"
		end
		
	is_in_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST; a_feature_name: STRING): BOOLEAN is
			-- Does `a_feature_name' appear in `a_list'?
			-- Make index of feature name available in `index_in_list'.
		indexing
			external_name: "IsInList"
		require
			non_void_feature_name: a_feature_name /= Void
			not_empty_feature_name: a_feature_name.length > 0
			non_void_clauses: a_list /= Void
		local
			i: INTEGER
			a_clause: ISE_REFLECTION_INHERITANCECLAUSE
		do
			from
			until
				i = a_list.count or Result
			loop
				a_clause ?= a_list.item (i)
				if a_clause /= Void and then a_clause.sourcename.tolower.equals_string (a_feature_name.tolower) then
					index_in_list := i
					Result := True
				end
				i := i + 1
			end		
		end
	
	index_in_list: INTEGER 
			-- Index in inheritance clauses list (Result of `is_in_list' or `has_rename_clause' or `has_create_clause')
		indexing
			external_name: "IndexInList"
		end
	
	has_rename_clause (a_name: STRING): BOOLEAN is
			-- Does a name appear as target of a rename clause of `eiffel_class'?
		indexing
			external_name: "HasRenameClause"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
		local
			i: INTEGER
			an_item: ISE_REFLECTION_RENAMECLAUSE			
		do
			from
			until
				i = rename_clauses.count or Result
			loop
				an_item ?= rename_clauses.item (i)
				if an_item /= Void then
					if an_item.targetname.tolower.equals_string (a_name.tolower) then
						index_in_list := i
						rename_source := an_item.sourcename
						Result := True
					end
				end
				i := i + 1
			end
		end

	rename_source: STRING 
			-- Rename clause source (Result of `has_rename_clause')
		indexing
			external_name: "RenameSource"
		end

	source_from_text (a_text: STRING): STRING is
			-- Rename clause source from `a_text'
		indexing
			external_name: "SourceFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := Space
			test_string := test_string.concat_string_string_string (test_string, As_keyword, Space)
			as_index := a_text.indexof_string_int32 (test_string, 0)
			if as_index > 0 then
				Result := a_text.substring_int32_int32 (0, as_index)
			end
		ensure
			source_built: Result /= Void
		end 
		
	target_from_text (a_text: STRING): STRING is
			-- Rename clause target from `a_text'
		indexing
			external_name: "TargetFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.length > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := Space
			test_string := test_string.concat_string_string_string (test_string, As_keyword, Space)
			as_index := a_text.indexof_string_int32 (test_string, 0)
			if as_index > 0 then
				Result := a_text.substring (as_index + test_string.length + 1)
			end
		ensure
			source_built: Result /= Void
		end 
		
	argument_exists (new_name: STRING; feature_clause, feature_number: INTEGER): BOOLEAN is
			-- Does argument `feature_number'-th feature in `feature_clause' has an argument with name `new_name'?
		indexing
			external_name: "ArgumentExists"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
			valid_feature_number: feature_number >= 0		
		local
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			an_argument: ARRAY [STRING]
			i: INTEGER
		do
			if feature_clause = Initialization then
				a_feature ?= eiffel_class.initializationfeatures.item (feature_number)
			elseif feature_clause = Access then
				a_feature ?= eiffel_class.accessfeatures.item (feature_number)
			elseif feature_clause = Element_change then
				a_feature ?= eiffel_class.elementchangefeatures.item (feature_number)
			elseif feature_clause = Basic_operations then
				a_feature ?= eiffel_class.basicoperations.item (feature_number)
			elseif feature_clause = Unary_operators then
				a_feature ?= eiffel_class.unaryoperatorsfeatures.item (feature_number)
			elseif feature_clause = Binary_operators then
				a_feature ?= eiffel_class.binaryoperatorsfeatures.item (feature_number)
			elseif feature_clause = Specials then
				a_feature ?= eiffel_class.specialfeatures.item (feature_number)
			elseif feature_clause = Implementation then
				a_feature ?= eiffel_class.implementationfeatures.item (feature_number)
			end
			if a_feature /= Void then
				arguments := a_feature.arguments
				from
				until
					i = arguments.count or Result
				loop
					an_argument ?= arguments.item (i)
					if an_argument /= Void and then an_argument.count = 4 then
						Result := an_argument.item (0).tolower.equals_string (new_name.tolower)
					end
					i := i + 1
				end
			end
		end

	rename_argument (new_name: STRING; feature_clause, feature_number, argument_number: INTEGER) is
			-- Rename `argument_number'-th argument of `feature_number'-th feature in `feature_clause' with `new_name'.
		indexing
			external_name: "RenameArgument"
		require
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
			valid_feature_clause: feature_clause >= Initialization and feature_clause <= Implementation
			valid_feature_number: feature_number >= 0	
			valid_argument_number: argument_number >= 0
		local
			a_feature: ISE_REFLECTION_EIFFELFEATURE
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			an_argument: ARRAY [STRING]
		do
			if feature_clause = Initialization then
				a_feature ?= eiffel_class.initializationfeatures.item (feature_number)
			elseif feature_clause = Access then
				a_feature ?= eiffel_class.accessfeatures.item (feature_number)
			elseif feature_clause = Element_change then
				a_feature ?= eiffel_class.elementchangefeatures.item (feature_number)
			elseif feature_clause = Basic_operations then
				a_feature ?= eiffel_class.basicoperations.item (feature_number)
			elseif feature_clause = Unary_operators then
				a_feature ?= eiffel_class.unaryoperatorsfeatures.item (feature_number)
			elseif feature_clause = Binary_operators then
				a_feature ?= eiffel_class.binaryoperatorsfeatures.item (feature_number)
			elseif feature_clause = Specials then
				a_feature ?= eiffel_class.specialfeatures.item (feature_number)
			elseif feature_clause = Implementation then
				a_feature ?= eiffel_class.implementationfeatures.item (feature_number)
			end
			if a_feature /= Void then
				arguments := a_feature.arguments
				an_argument ?= arguments.item (argument_number)
				if an_argument /= Void and then an_argument.count = 4 then
					an_argument.put (0, new_name)
				end
			end
		end
		
end -- class TYPE_VIEW_HANDLER