indexing
	description: "Eiffel type whose source code is to be generated"
	date: "$$"
	revision: "$$"	

class
	ECD_GENERATED_TYPE
	
inherit
	ECD_TYPE
		redefine
			ready,
			code
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECD_TYPE}
			-- Initialize attributes
		do
			default_create
			create indexing_clauses.make
			create parents.make
			create creation_routines.make
			create features.make
		ensure then
			non_void_indexing_clauses: indexing_clauses /= Void
			non_void_parents: parents /= Void
			non_void_creation_routines: creation_routines /= Void
			non_void_features: features /= Void
		end
		
feature -- Access

	indexing_clauses: LINKED_LIST [ECD_INDEXING_CLAUSE]
			-- Type indexing clauses
		
	parents: LINKED_LIST [ECD_PARENT]
			-- List of parents

	creation_routines: LINKED_LIST [ECD_CREATION_ROUTINE]
			-- Type creation routines

	features: LINKED_LIST [ECD_FEATURE]
			-- Type features
			
	code: STRING is
			-- | Call `header', `body' and `footer' successively.
			-- Eiffel code of type
		do
			Result := header
			Result.append (body)
			Result.append (footer)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is named entity ready to be generated?
		do
			Result := Precursor {ECD_TYPE}
		end

	has_immediate_feature (a_feature_name: STRING): BOOLEAN is
			-- Does `features' or `creation_routines' contain `a_feature_name'?
		local
			l_feature_name: STRING
			old_cursor: CURSOR
		do
			from
				old_cursor := creation_routines.cursor
				creation_routines.start
			until
				creation_routines.after or Result
			loop
				Result := creation_routines.item.name.is_equal (a_feature_name)
				creation_routines.forth
			end
			creation_routines.go_to (old_cursor)
			
			from
				old_cursor := features.cursor
				features.start
			until
				features.after or Result
			loop
				l_feature_name := features.item.name
				Result := l_feature_name /= Void and then l_feature_name.is_equal (a_feature_name)
				features.forth
			end
			features.go_to (old_cursor)
		end	
	
	has_feature (a_feature_name: STRING; arguments: LINKED_LIST [ECD_EXPRESSION]): BOOLEAN is
			-- Does `features' or `creation_routines' or `parents' contain `a_feature'?
		local
			l_old_cursor: CURSOR
		do
			Result := has_immediate_feature (a_feature_name)
			
			if not Result then
				from
					l_old_cursor := parents.cursor
					parents.start
				until
					parents.after or Result
				loop
					Result := Feature_finder.has_feature (parents.item.name, a_feature_name, arguments)
					parents.forth
				end
				parents.go_to (l_old_cursor)
			end
		end

feature -- Basic Operations

	add_item (an_item: ANY; a_list: LINKED_LIST [ANY]) is
			-- Add `an_item' to `a_list' if `a_list' doesn't have `an_item' yet.
		require
			non_void_item: an_item /= Void
			non_void_list: a_list /= Void
		do
			if not a_list.has (an_item) then
				a_list.extend (an_item)
			end
		ensure
			item_added: a_list.has (an_item)
		end

	add_indexing_clause (a_clause: ECD_INDEXING_CLAUSE) is
			-- Add `a_clause' to `indexing_clauses'.
		require
			non_void_indexing_clause: a_clause /= Void
		do
			add_item (a_clause, indexing_clauses)
		ensure
			a_clause_added: indexing_clauses.has (a_clause)
		end

	add_parent (a_parent: ECD_PARENT) is
			-- Add `a_parent' to `parents'.
		require
			non_void_parent: a_parent /= Void
		do
			parents.extend (a_parent)
		ensure
			parent_added: parents.has (a_parent)
		end
		
	add_feature (a_feature: ECD_FEATURE) is
			-- Add `a_feature' to `features'.
		require
			non_void_feature: a_feature /= Void
		do
			add_item (a_feature, features)
		ensure
			feature_added: features.has (a_feature)
		end

	add_creation_routine (a_creation_routine: ECD_CREATION_ROUTINE) is
			-- Add `a_creation_routine' to `creation_routines'.
		require
			non_void_creation_routine: a_creation_routine /= Void
		do
			add_item (a_creation_routine, creation_routines)
		ensure
			creation_routine_added: creation_routines.has (a_creation_routine)
		end

feature -- Basics Operations on inheritance clauses

	parent (a_name: STRING): ECD_PARENT is
			-- Parent with name `a_name' if any
		require
			non_void_name: a_name /= Void
		do
			from
				parents.start
			until
				parents.after or Result /= Void
			loop
				if parents.item.name.is_equal (a_name) then
					Result := parents.item
				end
				parents.forth
			end
		end

	add_rename_clause (a_dotnet_parent_name, a_feature_name, a_new_feature_name: STRING) is
			-- Add rename clause for parent `a_dotnet_parent_name'.
		require
			non_void_dotnet_parent_name: a_dotnet_parent_name /= Void
			non_empty_dotnet_parent_name: not a_dotnet_parent_name.is_empty
			non_void_feature_name: a_feature_name /= Void
			non_empty_feature_name: not a_feature_name.is_empty
			non_void_new_feature_name: a_new_feature_name /= Void
			non_empty_new_feature_name: not a_new_feature_name.is_empty
		local
			l_parent: ECD_PARENT
			l_clause: ECD_RENAME_CLAUSE
		do
			l_parent := parent (a_dotnet_parent_name)
			if l_parent /= Void then
				create l_clause.make
				l_clause.set_name (a_feature_name)
				l_clause.set_new_name (a_new_feature_name)
				l_parent.add_rename_clause (l_clause)
			end			
		end

	add_undefine_clause (a_dotnet_parent_name: STRING; a_feature_name: STRING) is
			-- Add undefine clause for parent `a_dotnet_parent_name' and feature `a_feature_name'.
		require
			non_void_dotnet_parent_name: a_dotnet_parent_name /= Void
			non_empty_dotnet_parent_name: not a_dotnet_parent_name.is_empty
			non_void_a_feature_name: a_feature_name /= Void
			non_empty_a_feature_name: not a_feature_name.is_empty
		local
			l_parent: ECD_PARENT
			l_clause: ECD_UNDEFINE_CLAUSE
		do
			l_parent := parent (a_dotnet_parent_name)
			if l_parent /= Void then
				create l_clause.make (a_feature_name)
				l_parent.add_undefine_clause (l_clause)
			end			
		end
		
	add_redefine_clause (a_dotnet_parent_name: STRING; a_feature_name: STRING) is
			-- Add redefine clause for parent `a_dotnet_parent_name' and feature `a_feature_name'.
		require
			non_void_dotnet_parent_name: a_dotnet_parent_name /= Void
			non_empty_dotnet_parent_name: not a_dotnet_parent_name.is_empty
			non_void_a_feature_name: a_feature_name /= Void
			non_empty_a_feature_name: not a_feature_name.is_empty
		local
			l_parent: ECD_PARENT
			l_clause: ECD_REDEFINE_CLAUSE
		do
			l_parent := parent (a_dotnet_parent_name)
			if l_parent /= Void then
				create l_clause.make (a_feature_name)
				l_parent.add_redefine_clause (l_clause)
			end			
		end
	
	add_redefine_clause_from_dotnet (a_dotnet_feature_name: STRING; arguments: LINKED_LIST [ECD_PARAMETER_DECLARATION_EXPRESSION]): STRING is
			-- Add `a_feature_name' to the parent that contains `a_feature_name'.
			-- Loop on parents.
		require
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			non_empty_a_dotnet_feature_name: not a_dotnet_feature_name.is_empty
		local
			l_feature_name: STRING
		do
			from
				parents.start
			until
				parents.after or Result /= Void
			loop
				if Feature_finder.has_feature (parents.item.name, a_dotnet_feature_name, arguments) then
					if Resolver.is_generated_type (parents.item.name) then
						l_feature_name := a_dotnet_feature_name
					else
						l_feature_name := Feature_finder.eiffel_feature_name_from_dynamic_args (Dotnet_types.dotnet_type (parents.item.name), a_dotnet_feature_name, arguments)
					end
					add_redefine_clause (parents.item.name, l_feature_name)
					Result := l_feature_name
				end
				parents.forth
			end
			check
				parent_has_feature_name: Result /= Void
			end
		end
			
feature -- Code generation

	header: STRING is
			-- | Call `indexing_clauses', `parents' and `creation_routines_declaration' if any.

			-- Eiffel code of type header (from indexing clause to creation routine declaration)
		require
			ready: ready
		do	
			create Result.make (5000)
				-- indexing
			if indexing_clauses /= Void and then indexing_clauses.count > 0 then
				Result.append (indexing_clause)
			end
				-- class
			Result.append (class_declaration)
			
				-- inherit
			if parents /= Void and then parents.count > 0 then
				Result.append (inheritance_clause)
				Result.append (dictionary.New_line)
			end
				-- create
			Result.append (creation_clause)
		ensure
			header_generated: Result /= Void and not Result.is_empty
		end

	indexing_clause: STRING is
			-- | Loop on `indexing_clauses': call `indexing_clause' for each item.

			-- Indexing clauses code (include `indexing' keyword)
		require
			ready: ready
			not_empty_indexing_clauses: indexing_clauses.count > 0
		local
			l_indexing_clause: ECD_INDEXING_CLAUSE
		do
			create Result.make (250)
			Result.append (dictionary.Indexing_keyword)
			Result.append (dictionary.New_line)
			from
				indexing_clauses.start
			until
				indexing_clauses.after		
			loop
				l_indexing_clause := indexing_clauses.item
				if l_indexing_clause /= Void then
					Result.append (dictionary.Tab)
					Result.append (l_indexing_clause.code)
					Result.append (dictionary.New_line)
				end
				indexing_clauses.forth
			end
			Result.append (dictionary.New_line)
		ensure
			a_clause_generated: Result /= Void and Result.count > 0
		end
	
	class_declaration: STRING is 
			-- Class declaration (including class name and qualifiers like deferred, expanded or frozen)
		require
			ready: ready
		local
			formatter: NAME_FORMATTER
		do
			create Result.make (120)
			Result.append (dictionary.Class_keyword)
			Result.append (dictionary.New_line)
			Result.append (dictionary.Tab)
			create formatter
			name.prune ('.')
			Result.append (formatter.full_formatted_type_name (name))
			Result.append (dictionary.New_line)
			Result.append (dictionary.New_line)
		ensure
			non_void_class_declaration: Result /= Void
			not_empty_class_declaration: Result.count > 0
		end
		
	inheritance_clause: STRING is 
			-- | loop on parents, then loop on feature_clause of parent

			-- Parents code (include `inherit' keyword, parent names and associated inheritance clauses)
		require
			ready: ready
			not_empty_parents: parents.count > 0
		do
			create Result.make (200)
			Result.append (dictionary.Inherit_keyword)
			Result.append (dictionary.New_line)
			from
				parents.start
			until 
				parents.after
			loop
				Result.append (parents.item.code)
				parents.forth
			end
		ensure
			parents_generated: Result /= Void and not Result.is_empty
		end
								
	inheritance_clauses_code (a_list: LINKED_LIST [ECD_INHERITANCE_CLAUSE]): STRING is
			-- Code corresponding to `a_list'
		require
			non_void_list: a_list /= Void
			not_empty_list: a_list.count > 0
		do
			create Result.make (120)
			from
				a_list.start
				if not a_list.after then
					Result.append (Dictionary.Tab)
					Result.append (Dictionary.Tab)
					Result.append (Dictionary.Tab)
					Result.append (a_list.item.code)
					a_list.forth
				end
			until
				a_list.after
			loop
				Result.append (Dictionary.Comma)
				Result.append (Dictionary.New_line)
				Result.append (Dictionary.Tab)
				Result.append (Dictionary.Tab)
				Result.append (Dictionary.Tab)
				Result.append (a_list.item.code)
			end
			Result.append (Dictionary.New_line)
		ensure
			generated: Result /= Void and then not Result.is_empty
		end
	
	creation_clause: STRING is 
			-- Code of creation clause
		require
			ready: ready
		do
			if creation_routines.count = 0 then
				create Result.make (100)
				Result.append (dictionary.Create_keyword)
				Result.append (dictionary.Space)
				Result.append (dictionary.Opening_brace_bracket)
				Result.append (Dictionary.None_type)
				Result.append (dictionary.Closing_brace_bracket)
				Result.append (dictionary.New_line)
				Result.append (dictionary.New_line)
			else
				if not special_classes.has (name) then
					Result := creation_routines_declaration + dictionary.New_line
				end
			end			
		end
		
	creation_routines_declaration: STRING is
			-- | Loop on `creation_routines' names

			-- Creation routines code (include `create' keyword)
		require
			ready: ready
			not_empty_creation_routines: creation_routines.count > 0
		do
			create Result.make (100)
			Result.append (dictionary.Create_keyword)
			Result.append (dictionary.New_line)
			Result.append (Dictionary.Tab)
			from
				creation_routines.start
				if not creation_routines.after then
					Result.append (Resolver.eiffel_entity_name (creation_routines.item.name))
					creation_routines.forth
				end
			until
				creation_routines.after
			loop
				Result.append (Dictionary.Comma)
				Result.append (Resolver.eiffel_entity_name (creation_routines.item.name))
				Result.append (Dictionary.New_line)
				Result.append (Dictionary.Tab)
				creation_routines.forth
			end
		ensure
			creation_routines_declaration_generated: Result /= Void and then not Result.is_empty
		end

	special_classes: HASH_TABLE [STRING, STRING]is
			-- Kernel classes
		do
			create Result.make (9)
			Result.put (dictionary.Any_type_name, dictionary.Any_type_name)
			Result.put (dictionary.Integer_type_name, dictionary.Integer_type_name)
			Result.put (dictionary.Integer_64_type_name, dictionary.Integer_64_type_name)
			Result.put (dictionary.Integer_16_type_name, dictionary.Integer_16_type_name)
			Result.put (dictionary.Integer_8_type_name, dictionary.Integer_8_type_name)
			Result.put (dictionary.Character_type_name, dictionary.Character_type_name)
			Result.put (dictionary.Double_type_name, dictionary.Double_type_name)
			Result.put (dictionary.Real_type_name, dictionary.Real_type_name)
			Result.put (dictionary.Boolean_type_name, dictionary.Boolean_type_name)
		ensure
			non_void_table: Result /= Void
			valid_table: Result.count = 9
		end
		
	body: STRING is
			-- | Call `internal_features (creation_routines)'.
			-- | Call `internal_features (features)'.

			-- Eiffel code of type body (without invariants)
		require
			ready: ready
		do
			create Result.make (100)
			if creation_routines /= Void and then creation_routines.count > 0 then
				Result.append (features_code (creation_routines))
			end
			if features /= Void and then features.count > 0 then
				Result.append (features_code (features))
			end
		ensure
			body_generated: Result /= Void and then not Result.is_empty
		end

	features_code (a_list: LINKED_LIST [ECD_FEATURE]): STRING is 
			-- Code corresponding to `a_list' of features.
		require
			non_void_list: a_list /= Void
		local
			l_clauses: HASH_TABLE [LINKED_LIST [ECD_FEATURE], STRING]
			l_features: LINKED_LIST [ECD_FEATURE]
		do
			create Result.make (1000)
			l_clauses := features_per_clauses (a_list)
			from
				l_clauses.start
			until
				l_clauses.after
			loop
				l_features := l_clauses.item_for_iteration
				from
					l_features.start
					if not l_features.after then
						Result.append (l_clauses.key_for_iteration)
						Resolver.clear_all_local_variables
						Result.append (l_features.item.code)
						l_features.forth
					end
				until
					l_features.after
				loop
					Resolver.clear_all_local_variables
					Result.append (l_features.item.code)
					l_features.forth
				end
				l_clauses.forth
			end
		end
		
	footer: STRING is
			-- | Call `invariants'.

			-- Eiffel code of type footer (from `invariant' keyword to end of type)
		require
			ready: ready
		do
			create Result.make (200)
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.End_keyword)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Dashes)
			Result.append (Dictionary.Space)
			Result.append (name.as_upper)
		ensure
			footer_generated: Result /= Void and then not Result.is_empty
		end

	features_per_clauses (a_list: LINKED_LIST [ECD_FEATURE]): HASH_TABLE [LINKED_LIST [ECD_FEATURE], STRING] is
			-- Order features by clause.
		require
			non_void_list: a_list /= Void
		local
			l_clause: STRING
		do
			create Result.make (a_list.count)
			from
				a_list.start
			until
				a_list.after
			loop
				l_clause := a_list.item.feature_clause
				if not Result.has (l_clause) then
					Result.extend (create {LINKED_LIST [ECD_FEATURE]}.make, l_clause)
				end
				check
					has_clause: Result.has (l_clause)
				end
				Result.item (l_clause).extend (a_list.item)
				a_list.forth
			end
		ensure
			non_void_result: Result /= Void
		end

invariant
	non_void_indexing_clauses: indexing_clauses /= Void
	non_void_parents: parents /= Void
	non_void_creation_routines: creation_routines /= Void
	non_void_features: features /= Void

end -- class ECD_GENERATED_TYPE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------