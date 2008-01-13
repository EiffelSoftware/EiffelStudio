indexing
	description: "Routines generally used on Eiffel_project clients."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_PROJECT_FACILITIES

inherit
	SHARED_EIFFEL_PROJECT

feature -- Access

	class_by_name (name: STRING): CLASS_I is
			-- Return class with `name'. `Void' if not in system.
		require
			name_not_void: name /= Void
			is_class_name: (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (name) and name.as_upper.is_equal (name)
		local
			cl: LIST [CLASS_I]
		do
			cl := Eiffel_universe.classes_with_name (name)
			if cl /= Void and then not cl.is_empty then
				Result := cl.first
			end
		end

	cluster_by_name (name: STRING): CLUSTER_I is
			-- Return cluster with `name'. `Void' if not in system.
		require
			name_not_void: name /= Void
		do
			Result := Eiffel_universe.cluster_of_name (name)
		end

	feature_by_name (name: STRING): E_FEATURE is
			-- Return feature in current class with `name'. `Void' if not in system.
		local
			cc: CLASS_C
		do
			cc := Eiffel_system.System.current_class
			if cc /= Void then
				Result := cc.feature_with_name (name)
			end
		end

feature -- Helper		

	group_name_presentation (sep: STRING_32; a_name: STRING_32; a_group: CONF_GROUP): STRING_32 is
			-- Name presentation of `a_group' + `sep' + `a_name'. i.e. "a.a_name"
		require
			sep_not_void: sep /= Void
			a_name_not_void: a_name /= Void
			a_group_not_void: a_group /= Void
		local
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_name: STRING
			l_sep: BOOLEAN
			l_target: CONF_TARGET
			l_libs: ARRAYED_LIST [CONF_LIBRARY]
		do
			l_sep := not a_name.is_empty
			if a_group.is_cluster then
				l_cluster ?= a_group
				if l_sep then
					l_name := l_cluster.name + sep + a_name
				else
					l_name := l_cluster.name
				end
				if l_cluster.parent /= Void then
					Result := group_name_presentation (sep, l_name, l_cluster.parent)
				else
					l_target := a_group.target
					l_libs := l_target.system.used_in_libraries
					if l_libs /= Void and then not l_libs.is_empty then
						l_lib := l_libs.first
					end
					if l_lib /= Void then
						Result := group_name_presentation (sep, l_name, l_lib)
					else
						Result := l_name
					end
				end
			elseif a_group.is_library or a_group.is_assembly or a_group.is_physical_assembly then
				l_target := a_group.target
				l_libs := l_target.system.used_in_libraries
				if l_libs /= Void and then not l_libs.is_empty then
					l_lib := l_libs.first
				end
				if l_sep then
					l_name := a_group.name + sep + a_name
				else
					l_name := a_group.name
				end
				if l_lib /= Void then
					Result := group_name_presentation (sep, l_name, l_lib)
				else
					Result := l_name
				end
			end
		ensure
			group_name_presentation_not_void: Result /= Void
		end

	path_representation (sep: STRING_32; a_name: STRING_32; a_group: CONF_GROUP; dotdot_path: BOOLEAN): STRING_32 is
			-- Path representation
			-- If dotdot, we do ../../ instead of name/name/
		require
			sep_not_void: sep /= Void
			a_name_not_void: a_name /= Void
			a_group_not_void: a_group /= Void
			dotdot_implies_a_name_dotdot: dotdot_path implies (a_name.is_empty or a_name.has_substring (".."))
		local
			l_cluster: CONF_CLUSTER
			l_name: STRING_32
		do
			if a_group.is_cluster then
				l_cluster ?= a_group
				if l_cluster.parent /= Void then
					if dotdot_path then
						l_name := once ".."
					else
						l_name := l_cluster.parent.name
					end
					Result := path_representation (sep, l_name, l_cluster.parent, dotdot_path) + sep + a_name
				else
					Result := a_name
				end
			elseif a_group.is_library or a_group.is_assembly or a_group.is_physical_assembly then
				Result := a_name
			end
		ensure
			path_representation_not_void: Result /= Void
		end

	subclusters_of_group (a_group: CONF_GROUP): DS_ARRAYED_LIST [CONF_CLUSTER] is
			-- Subclusters of a group.
		require
			a_group_not_void: a_group /= Void
		local
			l_cluster: CONF_CLUSTER
			l_lib: CONF_LIBRARY
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_clu: ARRAYED_LIST [CONF_CLUSTER]
			l_groups: DS_ARRAYED_LIST [CONF_GROUP]
		do
			create Result.make (10)
			if a_group.classes_set then
				if a_group.is_cluster then
					l_cluster ?= a_group
					l_clu := l_cluster.children
					if l_clu /= Void then
						from
							l_clu.start
						until
							l_clu.after
						loop
							Result.force_last (l_clu.item)
							l_clu.forth
						end
					end
				elseif a_group.is_library then
					l_lib ?= a_group
					l_clusters := l_lib.library_target.clusters
					from
						l_clusters.start
					until
						l_clusters.after
					loop
						Result.force_last (l_clusters.item_for_iteration)
						l_clusters.forth
					end
				end
			end
				-- Sort `Result', but using `group_sorter' forces us to use
				-- a DS_ARRAYED_LIST [CONF_GROUP] local.
			l_groups := Result
			l_groups.sort (group_sorter)
		ensure
			subclusters_of_group_not_void: Result /= Void
			sorted: (({DS_ARRAYED_LIST [CONF_GROUP]}) [Result]).sorted (group_sorter)
		end

	top_level_clusters: DS_ARRAYED_LIST [CONF_GROUP] is
			-- Top level clusters in the system
		local
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_cluster: CONF_CLUSTER
		do
			create Result.make (10)
			l_groups := eiffel_universe.groups
			from
				l_groups.start
			until
				l_groups.after
			loop
				if l_groups.item.is_cluster then
					l_cluster ?= l_groups.item
					if l_cluster.parent /= Void then
						Result.force_last (l_cluster)
					end
				else
					Result.force_last (l_groups.item)
				end
				l_groups.forth
			end
			Result.sort (group_sorter)
		ensure
			top_level_clusters_not_void: Result /= Void
			sorted: Result.sorted (group_sorter)
		end

feature {NONE} -- Implementation

	group_sorter: DS_QUICK_SORTER [CONF_GROUP] is
			-- Sorter of group in alphabetical order.
		once
			create Result.make (create {KL_COMPARABLE_COMPARATOR [CONF_GROUP]}.make)
		ensure
			group_sorter_not_void: Result /= Void
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

end -- class DOCUMENTATION_FACILITIES
