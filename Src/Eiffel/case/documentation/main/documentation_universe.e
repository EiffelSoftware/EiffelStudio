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
			create groups.make
			any_group_format_generated := True
			any_class_format_generated := True
			any_feature_format_generated := True
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
		do
			if not groups.has (gr) then
				groups.extend (gr)
			end
		end

	exclude_group (gr: CONF_GROUP) is
			-- Remove `gr' if present.
		require
			gr_not_void: gr /= Void
		do
			groups.prune_all (gr)
		end

	include_all is
			-- Include all groups from the universe in the documentation.
		local
			gr: ARRAYED_LIST [CONF_GROUP]
		do
			gr := Universe.groups
			from gr.start until gr.after loop
				groups.extend (gr.item)
				gr.forth
			end
		end

feature -- Access

	groups: SORTED_TWO_WAY_LIST [CONF_GROUP]
			-- All groups in universe.

	classes: SORTED_TWO_WAY_LIST [CONF_CLASS] is
			-- All classes from `groups'.
		local
			cl: HASH_TABLE [CONF_CLASS, STRING]
			l_class_i: CLASS_I
		do
			create Result.make
			from groups.start until groups.after loop
				cl := groups.item.classes
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
						Result.extend (cl.item_for_iteration)
					end
					cl.forth
				end
				groups.forth
			end
		end

	classes_in_group (group: CONF_GROUP): like classes is
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
			create Result.make
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
					Result.extend (cl.item_for_iteration)
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
						Result.merge (classes_in_group (l_subclusters.item))
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
					Result.merge (classes_in_group (l_lib_clusters.item_for_iteration))
					l_lib_clusters.forth
				end
			end
		end

	any_group_format_generated: BOOLEAN
			-- Is a format generated where a group link can be redirected to?

	any_class_format_generated: BOOLEAN
			-- Is a format generated where a class link can be redirected to?

	any_feature_format_generated: BOOLEAN
			-- Is a format generated where a feature link can be redirected to?

feature -- Status report

	is_group_generated (a_group: CONF_GROUP): BOOLEAN is
			-- Is documentation for `a_group' generated?
		do
			Result := any_group_format_generated and then groups.has (a_group)
		end

	is_class_generated (a_class: CLASS_I): BOOLEAN is
			-- Is documentation for `a_class' generated?
		do
			Result := any_class_format_generated and then groups.has (a_class.group)
		end

	is_feature_generated (a_feature: E_FEATURE): BOOLEAN is
			-- Is documentation for `cl' generated?
		do
			Result := any_feature_format_generated and then groups.has (
				a_feature.written_class.lace_class.group
			)
		end

	is_group_leaf_generated (group: CONF_GROUP): BOOLEAN is
			-- Is `group' or recursively any of its subgroups generated?
			-- Used for cluster hierarchy view.
		do
			Result := any_group_format_generated and then groups.has (group)
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
