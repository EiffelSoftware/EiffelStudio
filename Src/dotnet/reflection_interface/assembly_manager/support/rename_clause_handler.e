indexing
	description: "Check rename clause validity and update feature list."
	external_name: "ISE.AssemblyManager.RenameClauseHandler"

class
	RENAME_CLAUSE_HANDLER

create
	make

feature {NONE} -- Initialization

	make (an_eiffel_class: like eiffel_class; a_parent_name: like parent_name; a_viewer: like rename_clauses_viewer) is
			-- Set `eiffel_class' with `an_eiffel_class'.
			-- Set `parent_name' with `a_parent_name'.
			-- Set `rename_clauses_viewer' with `a_viewer'.
		indexing
			external_name: "Make"
		require
			non_void_eiffel_class: an_eiffel_class /= Void
			non_void_parent_name: a_parent_name /= Void
			not_empty_parent_name: a_parent_name.length > 0
			non_void_viewer: a_viewer /= Void
		do
			eiffel_class := an_eiffel_class
			parent_name := a_parent_name
			rename_clauses_viewer := a_viewer
			build_inheritance_clauses
		ensure
			eiffel_class_set: eiffel_class = an_eiffel_class
			parent_name_set: parent_name = a_parent_name
			rename_clauses_viewer_set: rename_clauses_viewer = a_viewer
		end
		
feature -- Access
	
	eiffel_class: ISE_REFLECTION_EIFFELCLASS
			-- Eiffel class `inheritance_clauses' should belong to
		indexing
			external_name: "EiffelClass"
		end
	
	parent_name: STRING 
			-- Parent name (Eiffel name)
		indexing
			external_name: "ParentName"
		end

	rename_clauses_viewer: RENAME_CLAUSES_VIEWER
			-- Rename clauses viewer
		indexing
			external_name: "RenameClausesViewer"
		end
	
	children: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Children of `eiffel_class'
		indexing
			external_name: "Children"
		once
			Result := rename_clauses_viewer.type_view.children
		end
	
	error_message: STRING 
			-- Error message in case the rename clause is not valid
		indexing
			external_name: "ErrorMessage"
		end
		
feature -- Constants

	No_source: STRING is "The source feature does not exist. Please check the spelling of this feature."
			-- Error message in case the source feature does not exist
		indexing
			external_name: "NoSource"
		end
	
	Has_target: STRING is "The target feature name already exists in the current class or one of its descendants. Please choose another name."
			-- Error message in case the target feature is a name of an existing feature of the class or of the children
		indexing
			external_name: "HasTarget"
		end

feature -- Status Report

	is_valid: BOOLEAN 
			-- Is `inheritance_clauses' valid? (Result of `check_validity')
		indexing
			external_name: "IsValid"
		end
		
feature -- Basic Operations
	
	remove_rename_clause (a_clause_text: STRING) is
			-- Remove `a_clause_text' from `rename_clauses'.
		indexing
			external_name: "RemoveRenameClause"
		require
			non_void_text: a_clause_text /= Void
			not_empty_text: a_clause_text.length > 0
		do
			check
				is_rename_clause: is_in_list (rename_clauses, a_clause_text)
			end
			rename_clauses.removeat (index_in_list)
		ensure
			rename_clause_removed: not is_in_list (rename_clauses, a_clause_text)
		end
		
	update_features (a_clause: RENAME_CLAUSE) is
			-- Check `a_clause' validity (make result available in `is_valid' and update features list accordingly.
			-- | A rename clause is valid if:
			-- | source exists and target does not exist OR
			-- | source exists and source is deferred (maybe through an undefine clause) and source signature is the same as target signature.
		indexing
			external_name: "UpdateFeatures"
		local
			source_feature: ISE_REFLECTION_EIFFELFEATURE
			target_feature: ISE_REFLECTION_EIFFELFEATURE
		do
			if not exists (eiffel_class, a_clause.source) then
				is_valid := False
				error_message := No_source
			else			
				source_feature := eiffel_feature
				if recursive_exists (a_clause.target) then
					is_valid := False
					error_message := Has_target
				else
					is_valid := True
					rename_feature (source_feature, a_clause.target)
					update_inheritance_clauses (a_clause.source, a_clause.target)
				end
			end
		end

	new_inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST] is
			-- New inheritance clauses 
			-- | Built from `rename_clauses', `undefine_clauses', `redefine_clauses' and `select_clauses'.
		indexing
			external_name: "NewInheritanceClauses"		
		local
			a_list: SYSTEM_COLLECTIONS_ARRAYLIST
		do
			create Result.make (5)
			Result.put (0, rename_clauses)
			Result.put (1, undefine_clauses)
			Result.put (2, redefine_clauses)
			Result.put (3, select_clauses)
			--Result.put (4, create {SYSTEM_COLLECTIONS_ARRAYLIST}.make)
			create a_list.make
			Result.put (4, a_list)
		ensure
			new_inheritance_clauses_created: Result /= Void
			valid_inheritance_clauses: Result.count = 5
		end
		
feature {NONE} -- Implementation

	rename_feature (a_feature: ISE_REFLECTION_EIFFELFEATURE; new_name: STRING) is
			-- Rename `a_feature' with `new_name'.
		indexing
			external_name: "RenameFeature"
		require
			non_void_feature: a_feature /= Void
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.length > 0
		do
			a_feature.seteiffelname (new_name)
		ensure
			new_name_set: a_feature.eiffelname.equals_string (new_name)
		end
	
	update_inheritance_clauses (old_name, new_name: STRING) is
			-- Update `rename_clauses', `undefine_clauses', `redefine_clauses', `select_clauses' by replacing `old_name' by `new_name'.
		indexing
			external_name: "UpdateInheritanceClauses"
		require
			non_void_old_name: old_name /= Void
			non_void_new_name: new_name /= Void
			not_empty_old_name: old_name.length > 0
			not_empty_new_name: new_name.length > 0
			non_void_rename_clause_viewer: rename_clauses_viewer /= Void
			non_void_rename_clauses: rename_clauses /= Void
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_select_clauses: select_clauses /= Void
		local
			rename_clause_text: STRING
			added: INTEGER
		do
			rename_clause_text := rename_clauses_viewer.rename_clause_text_from_info (old_name, new_name)
			added := rename_clauses.add (rename_clause_text)
			if is_in_list (undefine_clauses, old_name) then
				undefine_clauses.removeat (index_in_list)
				added := undefine_clauses.add (new_name)
			end
			if is_in_list (redefine_clauses, old_name) then
				redefine_clauses.removeat (index_in_list)
				added := redefine_clauses.add (new_name)			
			end
			if is_in_list (select_clauses, old_name) then
				select_clauses.removeat (index_in_list)
				added := select_clauses.add (new_name)			
			end
		ensure
			not_in_undefine_clauses: not is_in_list (undefine_clauses, old_name)
			not_in_redefine_clauses: not is_in_list (redefine_clauses, old_name)
			not_in_select_clauses: not is_in_list (select_clauses, old_name)
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
	
	build_inheritance_clauses is
			-- Build `undefine_clauses', `redefine_clauses', `select_clauses'.
		indexing
			external_name: "BuildInheritanceClauses"
		local
			parents: SYSTEM_COLLECTIONS_HASHTABLE
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			parents := eiffel_class.parents
			inheritance_clauses ?= parents.item (parent_name)
			if inheritance_clauses /= Void and then inheritance_clauses.count = 5 then
				rename_clauses := inheritance_clauses.item (0)
				undefine_clauses := inheritance_clauses.item (1)		
				redefine_clauses := inheritance_clauses.item (2)	
				select_clauses := inheritance_clauses.item (3)		
			end
		ensure
			non_void_rename_clauses: rename_clauses /= Void
			non_void_undefine_clauses: undefine_clauses /= Void
			non_void_redefine_clauses: redefine_clauses /= Void
			non_void_select_clauses: select_clauses /= Void
		end

	rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Rename clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			external_name: "RenameClauses"
		end
		
	undefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Undefine clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			external_name: "UndefineClauses"
		end

	redefine_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Redefine clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
		indexing
			external_name: "RedefineClauses"
		end

	select_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Select clauses for parent with `parent_name' in `eiffel_class'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [STRING]
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
			a_clause: STRING
		do
			from
			until
				i = a_list.count or Result
			loop
				a_clause ?= a_list.item (i)
				if a_clause /= Void and then a_clause.tolower.equals_string (a_feature_name.tolower) then
					index_in_list := i
					Result := True
				end
				i := i + 1
			end		
		end
	
	index_in_list: INTEGER 
			-- Index in inheritance clauses list (Result of `is_in_list')
		indexing
			external_name: "IndexInList"
		end
		
end -- class RENAME_CLAUSE_HANDLER