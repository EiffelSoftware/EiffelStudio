indexing
	description:
		"Groups selection for documentation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION_UNIVERSE

inherit
	SHARED_WORKBENCH

create
	make,
	make_all

feature {NONE} -- Initialization

	make is
			-- Initialize with no groups in system.
		do
			create groups.make (10)
			any_group_format_generated := True
			any_class_format_generated := True
			any_feature_format_generated := True
			create class_sorter.make (create {KL_COMPARABLE_COMPARATOR [CONF_CLASS]}.make)
			create group_sorter.make (create {KL_COMPARABLE_COMPARATOR [CONF_GROUP]}.make)
		end

	make_all is
			-- Initialize with all groups in system.
		do
			make
			include_all
		end

feature -- Element change

	include_group (gr: CONF_GROUP) is
			-- Add `gr' (if not yet present) to universe.
		require
			gr_not_void: gr /= Void
			not_is_universe_completed: not is_universe_completed
		do
			if not groups.has (gr) then
				groups.force_last (gr)
			end
		end

	include_all is
			-- Include all groups from the universe in the documentation.
		require
			not_is_universe_completed: not is_universe_completed
		local
			gr: ARRAYED_LIST [CONF_GROUP]
		do
			gr := Universe.groups
			from gr.start until gr.after loop
				groups.force_last (gr.item)
				gr.forth
			end
		end

feature -- Setting

	complete_universe is
			-- Set `is_universe_completed' to True.
		do
			groups.sort (group_sorter)
			is_universe_completed := True
		ensure
			is_universe_completed_set: is_universe_completed
			groups_sorter: groups.sorted (group_sorter)
		end

feature -- Access

	groups: DS_ARRAYED_LIST [CONF_GROUP]
			-- All groups in universe.

	classes: DS_ARRAYED_LIST [CONF_CLASS] is
			-- All classes from `groups' sorted.
		local
			cl: HASH_TABLE [CONF_CLASS, STRING]
			l_class_i: CLASS_I
		do
			create Result.make (100)
			from groups.start until groups.after loop
				cl := groups.item_for_iteration.classes
				if cl /= Void then
					from
						cl.start
					until
						cl.after
					loop
						l_class_i ?= cl.item_for_iteration
						check
							l_class_i /= Void
						end
						if l_class_i.is_compiled then
							Result.force_last (cl.item_for_iteration)
						end
						cl.forth
					end
				end
				groups.forth
			end
			Result.sort (class_sorter)
		ensure
			classes_not_void: Result /= Void
			sorted: Result.sorted (class_sorter)
		end

	classes_in_group (group: CONF_GROUP): like classes is
			-- List of all items from `classes' whose group is `group' and alphabetically sorted.
		require
			group_not_void: group /= Void
		do
			Result := unsorted_classes_in_group (group)
			Result.sort (class_sorter)
		ensure
			classes_in_group_not_void: Result /= Void
			sorted: Result.sorted (class_sorter)
		end

	any_group_format_generated: BOOLEAN
			-- Is a format generated where a group link can be redirected to?

	any_class_format_generated: BOOLEAN
			-- Is a format generated where a class link can be redirected to?

	any_feature_format_generated: BOOLEAN
			-- Is a format generated where a feature link can be redirected to?

feature -- Status report

	is_universe_completed: BOOLEAN
			-- Is setting of `groups' completed?

	is_group_generated (a_group: CONF_GROUP): BOOLEAN is
			-- Is documentation for `a_group' generated?
		do
			Result := any_group_format_generated and then groups.has (a_group)
		end

	is_class_generated (a_class: CLASS_I): BOOLEAN is
			-- Is documentation for `a_class' generated?
		do
			Result := any_class_format_generated and then is_class_in_group (a_class)
		end

	is_feature_generated (a_feature: E_FEATURE): BOOLEAN is
			-- Is documentation for `cl' generated?
		do
			Result := any_feature_format_generated and then is_class_in_group (a_feature.written_class.lace_class)
		end

	is_group_leaf_generated (group: CONF_GROUP): BOOLEAN is
			-- Is `group' or recursively any of its subgroups generated?
			-- Used for cluster hierarchy view.
		do
			Result := any_group_format_generated and then groups.has (group)
		end

	is_class_in_group (a_class: CLASS_I): BOOLEAN is
			-- Does `a_class' belongs to one of the group in `groups'.
		local
			l_group: CONF_GROUP
			l_cursor: DS_ARRAYED_LIST_CURSOR [CONF_GROUP]
		do
			from
				l_cursor := groups.new_cursor
				l_cursor.start
			until
				l_cursor.after or Result
			loop
				l_group := l_cursor.item
				if l_group.classes_set then
					Result := l_group.class_by_name (a_class.name, False).has (a_class.config_class)
				end
				l_cursor.forth
			end
		end

feature -- Status setting

	set_any_group_format_generated (f: BOOLEAN) is
		do
			any_group_format_generated := f
		end

	set_any_class_format_generated (f: BOOLEAN) is
		do
			any_class_format_generated := f
		end

	set_any_feature_format_generated (f: BOOLEAN) is
		do
			any_feature_format_generated := f
		end

feature {NONE} -- Implementation

	unsorted_classes_in_group (group: CONF_GROUP): like classes is
			-- List of all items from `classes' whose group is `group'.
		require
			group_not_void: group /= Void
		local
			cl: HASH_TABLE [CONF_CLASS, STRING]
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_subclusters: ARRAYED_LIST [CONF_CLUSTER]
			l_lib_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_class_i: CLASS_I
		do
			create Result.make (100)
			if group.classes_set then
				cl := group.classes
				from
					cl.start
				until
					cl.after
				loop
					l_class_i ?= cl.item_for_iteration
					check
						l_class_i_not_void: l_class_i /= Void
					end
					if l_class_i.is_compiled then
						Result.force_last (cl.item_for_iteration)
					end
					cl.forth
				end
				if group.is_cluster then
					l_cluster ?= group
					l_subclusters := l_cluster.children
					if l_subclusters /= Void then
						from
							l_subclusters.start
						until
							l_subclusters.after
						loop
							Result.append_last (unsorted_classes_in_group (l_subclusters.item))
							l_subclusters.forth
						end
					end
				elseif group.is_library then
					l_lib ?= group
					check
						l_lib_not_void: l_lib /= Void
						library_target_not_void: l_lib.library_target /= Void
					end
					l_lib_clusters := l_lib.library_target.clusters
					from
						l_lib_clusters.start
					until
						l_lib_clusters.after
					loop
						Result.append_last (unsorted_classes_in_group (l_lib_clusters.item_for_iteration))
						l_lib_clusters.forth
					end
				end
			end
		ensure
			unsorted_classes_in_group_not_void: Result /= Void
		end

feature {NONE} -- Implementation: Access

	class_sorter: DS_QUICK_SORTER [CONF_CLASS]
			-- Sorter object for classes.

	group_sorter: DS_QUICK_SORTER [CONF_GROUP]
			-- Sorter object for groups.

invariant
	groups_not_void: groups /= Void
	class_sorter_not_void: class_sorter /= Void
	group_sorter_not_void: group_sorter /= Void

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

end -- class DOCUMENTATION_UNIVERSE
