indexing
	description: "Search for matching features in given class (filename)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURES_LISTER

inherit
	COMPLETION_ENGINE
		rename
			found_item as found_items
		end

create
	make

feature -- Access

	found_items: ARRAYED_LIST [COMPLETION_ENTRY]
			-- Result from last call to `find'

feature -- Basic Operations

	find (target: STRING; use_overloading: BOOLEAN; a_ignore_call_type: BOOLEAN; a_fetch_description: BOOLEAN) is
		 	-- Find matches for target `target'.
			-- Use overloaded names if `use_overloading'.
		local
			l_variables_list: SORTABLE_ARRAY [COMPLETION_ENTRY]
			l_features: SORTABLE_ARRAY [FEATURE_DESCRIPTOR]
			l_old_count, l_features_count, i, j, renames_count: INTEGER
			l_targets: LIST [STRING]
			l_target_type: TYPE_AS
			l_feature_table: FEATURE_TABLE
			l_desc: FEATURE_DESCRIPTOR
		do
			found := False
			found_items := Void
			Inst_context.set_cluster (class_i.cluster)
			qualified_call := target.occurrences ('.') > 0
			if not qualified_call then
				l_variables_list := identifiers_list
				l_features := features_list_from_table (feature_table, class_i, use_overloading)
				l_features_count := l_features.count
				if l_features_count > 0 then
					if rename_sources /= Void then
						from
							i := 1
						until
							i > l_features_count
						loop
							l_desc := l_features.item (i)
							from
								j := 0
								renames_count := rename_sources.count
							until
								j >= renames_count
							loop
								if rename_sources.item (j).is_equal (l_desc.name) then
									l_desc.set_name (rename_targets.item (j))
									j := renames_count
								end
								j := j + 1
							end
							i := i + 1
						end
					end
					l_old_count := l_variables_list.count
					l_variables_list.conservative_resize (1, l_old_count + l_features_count)
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
				if l_target_type = Void then
					l_target_type := type_of_target (l_targets.first, feature_table, feature_variables (locals, arguments, feature_i, feature_table), class_i)
				end
				if target.occurrences ('.') > 1 and then call_type = static_call or call_type = precursor_call then
					set_standard_call
				end
				if l_target_type /= Void and then not l_target_type.is_void then
					if target.occurrences ('.') > 1 and then call_type = static_call or call_type = precursor_call then
						set_standard_call
					end
					l_targets.start
					l_targets.remove
					l_feature_table := recursive_lookup (class_i, instantiated_type (class_i, Void, l_target_type), l_targets, feature_table, False)
					if l_feature_table /= Void then
						l_variables_list := features_list_from_table (l_feature_table, class_i, use_overloading)
						l_variables_list.sort
						create found_items.make_from_array (l_variables_list)
						found := True
					end
				end
			end
		end

feature -- Element Settings

	set_renames (sources, targets: ARRAY [STRING]) is
			-- Set `rename_sources' and `rename_targets'.
		require
			non_void_sources: sources /= Void
			non_void_targets: targets /= Void
			valid_count: sources.count = targets.count
		do
			rename_sources := sources
			rename_targets := targets
		ensure
			sources_set: rename_sources = sources
			targets_set: rename_targets = targets
		end

	reset_renames is
			-- Reset `rename_sources' and `rename_targets'.
		do
			rename_sources := Void
			rename_targets := Void
		ensure
			rename_sources_resetted: rename_sources = Void
			rename_targets_resetted: rename_targets = Void
		end

feature {NONE} -- Implementation

	rename_sources: ARRAY [STRING]
			-- Old name of features that are renamed in this context
			-- `rename_sources' is only useful when completing text in an inheritance clause
			-- where the feature list comes from the parent

	rename_targets: ARRAY [STRING]
			-- New name of features that are renamed in this context
			-- `rename_targets' is only useful when completing text in an inheritance clause
			-- where the feature list comes from the parent

invariant
	rename_arrays_in_sync: (rename_sources /= Void and rename_targets /= Void) or (rename_sources = Void and rename_targets = Void)

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
end -- class FEATURES_LISTER
