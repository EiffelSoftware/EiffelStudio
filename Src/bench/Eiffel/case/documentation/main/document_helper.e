indexing
	description: "Retrieve system infomation for documentation generation use."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOCUMENT_HELPER

inherit
	SHARED_EIFFEL_PROJECT

feature -- Helper

	group_name_presentation (sep: STRING; a_name: STRING; a_group: CONF_GROUP): STRING is
			-- Name presentation of `a_group' + `sep' + `a_name'. i.e. "a.a_name"
		require
			sep_not_void: sep /= Void
			a_name_not_void: a_name /= Void
			a_group_not_void: a_group /= Void
		local
			l_cluster: CONF_CLUSTER
			l_name: STRING
			l_sep: BOOLEAN
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
					Result := l_name
				end
			elseif a_group.is_library or a_group.is_assembly then
				if l_sep then
					Result := a_group.name + sep + a_name
				else
					Result := a_group.name
				end
			end
		ensure
			group_name_presentation_not_void: Result /= Void
		end

	path_representation (sep: STRING; a_name: STRING; a_group: CONF_GROUP; dotdot_path: BOOLEAN): STRING is
			-- Path representation
			-- If dotdot, we do ../../ instead of name/name/
		require
			sep_not_void: sep /= Void
			a_name_not_void: a_name /= Void
			a_group_not_void: a_group /= Void
			dotdot_implies_a_name_dotdot: dotdot_path implies (a_name.is_empty or a_name.has_substring (".."))
		local
			l_cluster: CONF_CLUSTER
			l_name: STRING
		do
			if a_group.is_cluster then
				l_cluster ?= a_group
				if l_cluster.parent /= Void then
					if dotdot_path then
						l_name := once ".."
					else
						l_name := l_cluster.parent.name
					end
					Result := path_representation (sep, l_name + sep, l_cluster.parent, dotdot_path)
				else
					if not dotdot_path then
						Result := a_name
					else
						Result := a_name
					end
				end
			elseif a_group.is_library or a_group.is_assembly then
				Result := a_name
			end
		ensure
			path_representation_not_void: Result /= Void
		end

	subclusters_of_group (a_group: CONF_GROUP): SORTED_TWO_WAY_LIST [CONF_CLUSTER] is
			-- Subclusters of a group.
		require
			a_group_not_void: a_group /= Void
		local
			l_cluster: CONF_CLUSTER
			l_assem: CONF_ASSEMBLY
			l_lib: CONF_LIBRARY
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
			l_clu: ARRAYED_LIST [CONF_CLUSTER]
		do
			create Result.make
			if a_group.is_cluster then
				l_cluster ?= a_group
				l_clu := l_cluster.children
				if l_clu /= Void then
					from
						l_clu.start
					until
						l_clu.after
					loop
						Result.extend (l_clu.item)
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
					Result.extend (l_clusters.item_for_iteration)
					l_clusters.forth
				end
			elseif a_group.is_assembly then
				l_assem ?= a_group
				l_clusters := l_assem.application_target.clusters
				from
					l_clusters.start
				until
					l_clusters.after
				loop
					Result.extend (l_clusters.item_for_iteration)
					l_clusters.forth
				end
			end
		ensure
			subclusters_of_group_not_void: Result /= Void
		end

	top_level_clusters: SORTED_TWO_WAY_LIST [CONF_GROUP] is
			-- Top level clusters in the system
		local
			l_groups: ARRAYED_LIST [CONF_GROUP]
			l_cluster: CONF_CLUSTER
		do
			create Result.make
			l_groups := eiffel_universe.groups
			from
				l_groups.start
			until
				l_groups.after
			loop
				if l_groups.item.is_cluster then
					l_cluster ?= l_groups.item
					if l_cluster.parent /= Void then
						Result.extend (l_cluster)
					end
				else
					Result.extend (l_groups.item)
				end
				l_groups.forth
			end
		ensure
			top_level_clusters_not_void: Result /= Void
		end

end
