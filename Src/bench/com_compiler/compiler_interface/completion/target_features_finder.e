indexing
	description: "Search for matching features in given class (filename)"
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_FEATURES_FINDER

inherit
	COMPLETION_HELPERS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING) is
			-- Set `feature_name' with `a_feature_name'
			-- Set `file_name' with `a_file_name'
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		do
			create file_name.make_from_string (a_file_name)
			file_name.to_lower
			class_i := Eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
			is_initialized := class_i /= Void and then class_i.compiled and then class_i.compiled_class.has_feature_table
			if is_initialized then
				feature_table := class_i.compiled_class.feature_table
			end
			create completion_features.make (0)
			create locals.make (0)
			create arguments.make (0)
			set_standard_call
		ensure
			file_name_set: file_name.is_equal (a_file_name.as_lower)
			standard_call: call_type = Standard_call
		end

feature -- Access

	is_initialized: BOOLEAN
			-- Was finder correctly initialized?

	found: BOOLEAN
			-- Was last call to `find' successful?

	found_items: ARRAYED_LIST [COMPLETION_ENTRY]
			-- Result from last call to `find'

	feature_name: STRING
			-- Feature in which to find target features
			-- This adds local variables and arguments to list of possible identifiers

	file_name: STRING
			-- File containing Eiffel class in which to find target features

feature -- Basic Operations

	find (target: STRING; use_overloading: BOOLEAN) is
		 	-- Find matches for target `target'.
			-- Use overloaded names if `use_overloading'.
		require
			non_void_target: target /= Void
			is_initialized: is_initialized
			is_lower_case: target.as_lower.is_equal (target)
		local
			l_variables_list: SORTABLE_ARRAY [COMPLETION_ENTRY]
			l_features: SORTABLE_ARRAY [FEATURE_DESCRIPTOR]
			l_old_count, l_features_count: INTEGER
			l_targets: LIST [STRING]
			l_target_type: TYPE
			l_feature_table: FEATURE_TABLE
		do
			found := False
			found_items := Void
			Inst_context.set_cluster (class_i.cluster)
			qualified_call := target.occurrences ('.') > 0
			if not qualified_call then
				l_variables_list := identifiers_list
				l_features := features_list_from_table (feature_table, class_i)
				l_features_count := l_features.count
				if l_features_count > 0 then
					l_old_count := l_variables_list.count
					l_variables_list.resize (1, l_old_count + l_features_count)
					l_variables_list.subcopy (l_features, 1, l_features_count, l_old_count + 1)
				end
				l_variables_list.sort					
				create found_items.make_from_array (l_variables_list)
				found := True
			else
				l_targets := target.split ('.')
				if l_targets.last.is_empty then
					l_targets.finish
					l_targets.remove
				end
				l_target_type := target_type (l_targets.first)
				if l_target_type /= Void and then not l_target_type.is_void then
					l_targets.start
					l_targets.remove
					l_feature_table := recursive_lookup (l_target_type, l_targets, feature_table)
					if l_feature_table /= Void then
						create found_items.make_from_array (features_list_from_table (l_feature_table, class_i))
						found := True
					end
				end
			end
		ensure
			results_if_found: found implies found_items /= Void
			no_results_if_not_found: not found implies found_items = Void
		end

feature -- Element settings
	
	set_feature_name (a_feature_name: STRING) is
			-- Set `feature_name' with `a_feature_name'
			--| Update `feature_i' accordingly
		require
			non_void_feature_name: a_feature_name /= Void
			valid_feature_name: not a_feature_name.is_empty
		local
			cf: COMPLETION_FEATURE
		do
			feature_name := a_feature_name
			feature_i := feature_table.item (feature_name)
			if feature_i = Void then
				cf := completion_feature (feature_name)
				if cf /= Void then
					create {R_DYN_FUNC_I} feature_i -- Dummy FEATURE_I for non compiled feature
				end
			end
			is_initialized := feature_i /= Void
		ensure
			feature_name_set: feature_name = a_feature_name
		end
	
	reset_feature_name is
			-- Set `feature_name' to Void.
		do
			feature_name := Void
		ensure
			feature_name_resetted: feature_name = Void
		end

	set_completion_features (a_completion_features: like completion_features) is
			-- Set `completion_features' with `a_completion_features'.
		require
			non_void_completion_features: a_completion_features /= Void
		do
			completion_features := a_completion_features
		ensure
			completion_features_set: completion_features = a_completion_features
		end
		
	set_locals (a_locals: like locals) is
			-- Set `locals' with `a_locals'.
		require
			non_void_locals: a_locals /= Void
		do
			locals := a_locals
		ensure
			locals_set: locals = a_locals
		end
		
	set_arguments (a_arguments: like arguments) is
			-- Set `arguments' with `a_arguments'.
		require
			non_void_arguments: a_arguments /= Void
		do
			arguments := a_arguments
		ensure
			arguments_set: arguments = a_arguments
		end
		
feature {NONE} -- Implementation

	class_i: CLASS_I
			-- Class in which to find target features

	feature_i: FEATURE_I
			-- Feature in which to find target features
			-- Can be Void in case we are completing a feature name in an inheritance clause

	feature_table: FEATURE_TABLE
			-- Feature table of `class_i'

	completion_features: HASH_TABLE [ARRAYED_LIST [COMPLETION_FEATURE], STRING]
			-- Uncompiled features use to solve member completion
			-- Grouped by filename

	locals: HASH_TABLE [STRING, STRING]
			-- Feature locals

	arguments: HASH_TABLE [STRING, STRING]
			-- Feature arguments

	qualified_call: BOOLEAN
			-- Does current target correspond to a qualified call?

feature {NONE} -- Implementation

	completion_feature (a_feature_name: STRING): COMPLETION_FEATURE is
			-- Feature `a_feature_name' from file `a_file_name'
		require
			non_void_feature_name: a_feature_name /= Void
			valid_feature_name: not a_feature_name.is_empty
		local
			l_features: LIST [COMPLETION_FEATURE]
			temp: STRING
			comp_feature: COMPLETION_FEATURE
		do
			completion_features.search (file_name)
			if completion_features.found then
				l_features := completion_features.found_item
				from
					l_features.start
					create temp.make_from_string (a_feature_name)
					temp.to_lower
				until
					l_features.after or Result /= Void
				loop
					comp_feature := l_features.item
					if comp_feature.name.is_equal (temp) then
						Result := comp_feature
					end
					l_features.forth
				end
			end
		end

	identifiers_list: SORTABLE_ARRAY [COMPLETION_ENTRY] is
			-- Merge completion features and variables in one single list
		local
			feature_list: LIST [COMPLETION_FEATURE]
			i: INTEGER
			variables: HASH_TABLE [TYPE, STRING]
		do
			variables := feature_variables (locals, arguments, feature_i, feature_table)
			create Result.make (1, variables.count + completion_features.count * 10)	-- Magic number, we're hoping there is about 10 features per filename
			from																		-- If more then array will be resized (see usage of `force' below)
				variables.start															-- Calculating the exact count would be too expensive
				i := 1
			until
				variables.after
			loop
				Result.put (create {VARIABLE_DESCRIPTOR}.make (variables.key_for_iteration, variables.key_for_iteration + ": " + variables.item_for_iteration.dump), i)
				i := i + 1									
				variables.forth
			end
			from
				completion_features.start
			until
				completion_features.after
			loop
				feature_list := completion_features.item_for_iteration
				from
					feature_list.start
				until
					feature_list.after
				loop
					Result.force (feature_list.item, i)
					i := i + 1
					feature_list.forth								
				end
				completion_features.forth
			end
			if i <= Result.count then
				Result := Result.subarray (1, i - 1) -- Set count appropriatly so that we can sort later on
			end
		end

	target_type (a_target: STRING): TYPE is
			-- Type of `a_target' in current context
			-- Set `call_type' accordingly
		require
			non_void_target: a_target /= Void
			valid_target: not a_target.is_empty
		local
			cf: COMPLETION_FEATURE
			variables: HASH_TABLE [TYPE, STRING]
		do
			variables := feature_variables (locals, arguments, feature_i, feature_table)
			variables.search (a_target)
			if variables.found then
				Result := variables.found_item
				set_standard_call
			else
				feature_table.search (a_target)
				if feature_table.found then
					Result := feature_table.found_item.type
					set_standard_call
				else
					Result := type_of_target (a_target, feature_table, variables, class_i)
				end
			end
			if Result = Void then
				cf := completion_feature (a_target)
				if cf /= Void then
					Result := type_from_type_name (cf.return_type)	
				end
			end
		end
		
invariant
	results_if_found: found implies found_items /= Void
	no_results_if_not_found: not found implies found_items = Void
	non_void_completion_features: completion_features /= Void
	non_void_locals: locals /= Void
	non_void_arguments: arguments /= Void
	class_i_if_initialized: is_initialized implies class_i /= Void
	feature_table_if_initialized: is_initialized implies feature_table /= Void

end -- class TARGET_FEATURES_FINDER
