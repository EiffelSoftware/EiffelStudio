indexing
	description: "Common engine for both the features lister and the feature retriever"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLETION_ENGINE

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

feature {NONE} -- Initialization

	make (a_file_name: STRING) is
			-- Set `feature_name' with `a_feature_name'
			-- Set `file_name' with `a_file_name'
			-- (export status {NONE})
		require
			non_void_file_name: a_file_name /= void
			valid_file_name: not a_file_name.is_empty
		do
			file_name := a_file_name.as_lower
			class_i := eiffel_universe.class_with_file_name (create {FILE_NAME}.make_from_string (file_name))
			is_initialized := class_i /= void and then class_i.compiled and then class_i.compiled_class.has_feature_table
			if is_initialized then
				feature_table := class_i.compiled_class.feature_table
			end
			create completion_features.make (0)
			create locals.make (0)
			create arguments.make (0)
			set_standard_call
		ensure
			file_name_set: file_name.is_equal (a_file_name.as_lower)
			standard_call: call_type = standard_call
		end

feature -- Access

	found_item: ANY is
			-- Result from last call to `find'
			--| Specialize in descendant
		deferred
		end

	is_initialized: BOOLEAN
			-- Was engine correctly initialized?

	found: BOOLEAN
			-- Was last call to `find' successful?

	feature_name: STRING
			-- Feature in which to find target features
			-- This adds local variables and arguments to list of possible identifiers

	file_name: STRING
			-- File containing Eiffel class in which to find target features

feature -- Basic Operations
		
	find (target: STRING; use_overloading: BOOLEAN; a_ignore_call_type: BOOLEAN; a_fetch_description: BOOLEAN) is
			-- Lookup `target' and set `found_item' according to `use_overloading'.
		require
			non_void_target: target /= Void
			is_initialized: is_initialized
			is_lower_case: target.as_lower.is_equal (target)
		deferred
		ensure
			results_if_found: found implies found_item /= Void
			no_results_if_not_found: not found implies found_item = Void
		end

feature -- Element settings

	set_feature_name (a_feature_name: STRING) is
			-- Set `feature_name' with `a_feature_name'
		require
			non_void_feature_name: a_feature_name /= void
			valid_feature_name: not a_feature_name.is_empty
			lower_case: a_feature_name.as_lower.is_equal (a_feature_name)
		local
			cf: COMPLETION_FEATURE
		do
			feature_name := a_feature_name
			feature_i := feature_table.item (feature_name.as_lower)
			if feature_i = Void then
				cf := uncompiled_completion_feature (feature_name.as_lower)
				if cf /= Void then
					create {R_DYN_FUNC_I} feature_i
				end
			end
		ensure
			feature_name_set: feature_name = a_feature_name
		end

	reset_feature_name is
			-- Set `feature_name' to Void.
		do
			feature_name := void
		ensure
			feature_name_resetted: feature_name = void
		end

	set_completion_features (a_completion_features: like completion_features) is
			-- Set `completion_features' with `a_completion_features'.
		require
			non_void_completion_features: a_completion_features /= void
		do
			completion_features := a_completion_features
		ensure
			completion_features_set: completion_features = a_completion_features
		end

	set_locals (a_locals: like locals) is
			-- Set `locals' with `a_locals'.
		require
			non_void_locals: a_locals /= void
		do
			locals := a_locals
		ensure
			locals_set: locals = a_locals
		end

	set_arguments (a_arguments: like arguments) is
			-- Set `arguments' with `a_arguments'.
		require
			non_void_arguments: a_arguments /= void
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
	
feature {NONE} -- Implementation

	uncompiled_completion_feature (a_feature_name: STRING): COMPLETION_FEATURE is
			-- Feature `a_feature_name' from file `a_file_name'
		require
			non_void_feature_name: a_feature_name /= void
			valid_feature_name: not a_feature_name.is_empty
			lower_case: a_feature_name.as_lower.is_equal (a_feature_name)
		local
			l_features: LIST [COMPLETION_FEATURE]
			comp_feature: COMPLETION_FEATURE
		do
			completion_features.search (file_name)
			if completion_features.found then
				l_features := completion_features.found_item
				from
					l_features.start
				until
					l_features.after or Result /= void
				loop
					comp_feature := l_features.item
					if comp_feature.name.is_equal (a_feature_name) then
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
			variables: HASH_TABLE [TYPE_AS, STRING]
		do
			variables := feature_variables (locals, arguments, feature_i, feature_table)
			create Result.make (1, variables.count + completion_features.count * 10)
			from
				variables.start
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
				Result := Result.subarray (1, i - 1)
			end
		end

	target_type (a_target: STRING): TYPE_AS is
			-- Type of `a_target' in current context
			-- Set `call_type' accordingly
		require
			non_void_target: a_target /= void
			valid_target: not a_target.is_empty
			lower_case: a_target.as_lower.is_equal (a_target)
		local
			cf: COMPLETION_FEATURE
			variables: HASH_TABLE [TYPE_AS, STRING]
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
			if Result = void then
				cf := uncompiled_completion_feature (a_target)
				if cf /= void then
					Result := type_from_type_name (cf.return_type)
				end
			end
		end

invariant
	non_void_completion_features: completion_features /= void
	non_void_locals: locals /= void
	non_void_arguments: arguments /= void
	class_i_if_initialized: is_initialized implies class_i /= void
	feature_table_if_initialized: is_initialized implies feature_table /= void
	results_if_found: found implies found_item /= Void
	no_results_if_not_found: not found implies found_item = Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class COMPLETION_ENGINE
