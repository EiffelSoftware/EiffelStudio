indexing
	description: "Cluster having sorted sub-clusters and sorted classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SORTED_CLUSTER

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (data: like actual_group) is
			-- Associate `data' to `Current' and sort children.
		do
			actual_group := data
		end

feature -- Status

	is_initialized: BOOLEAN
			-- Is current initialized?

feature -- Statusupdate

	initialize is
			-- Initialize current
		require
			not_initialized: not is_initialized
		local
			sub_clusters: ARRAYED_LIST [CONF_CLUSTER]
			l_sub_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_classes: LIST [CONF_CLASS]
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_class_i: CLASS_I
			l_lib_target: CONF_TARGET
			l_ass_dep: LINKED_SET [CONF_ASSEMBLY]
		do
			create clusters.make_default
				-- handle subclusters
			if is_cluster then
				l_cluster := actual_cluster
				sub_clusters := l_cluster.children
				if sub_clusters /= Void then
					clusters := build_groups (sub_clusters)
				end
				-- handle libraries
			elseif is_library then
				l_library := actual_library
				l_lib_target := l_library.library_target

					-- clusters
				clusters := build_groups (l_lib_target.clusters.linear_representation)

					-- overrides
				overrides := build_groups (l_lib_target.overrides.linear_representation)

					-- libraries
				libraries := build_groups (l_lib_target.libraries.linear_representation)

					-- assemblies
				assemblies := build_groups (l_lib_target.assemblies.linear_representation)
				-- handle assemblies
			elseif is_assembly then
				l_ass_dep := actual_assembly.dependencies
				if l_ass_dep /= Void then
					assemblies := build_groups (l_ass_dep)
				else
					create assemblies.make_default
				end
			end

				-- handle classes
			l_sub_classes := actual_group.classes
			if l_sub_classes /= Void then
				create classes.make (l_sub_classes.count)
				from
					l_classes := l_sub_classes.linear_representation
					l_classes.start
				until
					l_classes.after
				loop
					l_class_i ?= l_classes.item
					check
						class_i: l_class_i /= Void
					end
					classes.force_last (l_class_i)
					l_classes.forth
				end
				classes.sort (create {DS_QUICK_SORTER [CLASS_I]}.make (create {KL_COMPARABLE_COMPARATOR [CLASS_I]}.make))
			else
				create classes.make_default
			end

			generate_subfolder_mapping
			is_initialized := True
		ensure
			initialized: is_initialized
		end


feature -- Access

	classes: DS_ARRAYED_LIST [CLASS_I]
			-- child classes in a sorted order.

	clusters: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- sub-clusters in a sorted order.

	sub_classes: HASH_TABLE [DS_ARRAYED_LIST [CLASS_I], STRING]
			-- classes mapping for sub folders

	sub_folders: HASH_TABLE [DS_HASH_SET [STRING], STRING];
			-- subfolder mapping for sub folders (for assembly namespaces)

	overrides: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- overrides in a sorted order.

	libraries: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- libraries in a sorted order.

	assemblies: DS_ARRAYED_LIST [EB_SORTED_CLUSTER]
			-- assemblies in a sorted order.

	is_writable: BOOLEAN is
			-- Can `Current' be modified?
		do
			Result := not actual_group.is_readonly
		end

	has_children: BOOLEAN is
			-- Does `Current' have any children (classes, clusters, assemblies, libraries, overrides)?
		local
			l_sub_clusters: ARRAYED_LIST [CLUSTER_I]
			l_library_target: CONF_TARGET
			l_assembly_deps: LINKED_SET [CONF_ASSEMBLY]
		do
			Result := (actual_group.classes /= Void and then not actual_group.classes.is_empty)
			if not Result then
				if is_cluster then
					l_sub_clusters := actual_cluster.sub_clusters
					Result :=  l_sub_clusters /= Void and then not l_sub_clusters.is_empty
				elseif is_assembly then
					l_assembly_deps := actual_assembly.dependencies
					Result := l_assembly_deps /= Void and then not l_assembly_deps.is_empty
				elseif is_library then
					l_library_target := actual_library.library_target
					Result := l_library_target /= Void and then (not l_library_target.clusters.is_empty or
							not l_library_target.libraries.is_empty or not l_library_target.assemblies.is_empty or
							not l_library_target.overrides.is_empty)
				end
			end
		end

	actual_group: CONF_GROUP
			-- group associated to `Current'.

	actual_cluster: CLUSTER_I is
			-- cluster associated to `Current'.
		require
			is_cluster: is_cluster
		do
			Result ?= actual_group
		ensure
			Result_not_void: Result /= Void
		end

	actual_library: CONF_LIBRARY is
			-- library associated to `Current'.
		require
			is_library: is_library
		do
			Result ?= actual_group
		ensure
			Result_not_void: Result /= Void
		end

	actual_assembly: ASSEMBLY_I is
			-- assembly associated to `Current'.
		require
			is_assembly: is_assembly
		do
			Result ?= actual_group
		ensure
			Result_not_void: Result /= Void
		end

	parent: EB_SORTED_CLUSTER
			-- sorted cluster in which `Current' is.

	is_cluster: BOOLEAN is
			-- Does `Current' represent a cluster?
		require
			actual_group_not_void: actual_group /= Void
		do
			Result := actual_group.is_cluster
		end

	is_library: BOOLEAN is
			-- Does `Current' represent a library?
		require
			actual_group_not_void: actual_group /= Void
		do
			Result := actual_group.is_library
		end

	is_assembly: BOOLEAN is
			-- Does `Current' represent an assembly?
		require
			actual_group_not_void: actual_group /= Void
		do
			Result := actual_group.is_assembly
		end


feature -- Status setting

	set_parent (a_parent: EB_SORTED_CLUSTER) is
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		end

feature -- Basic operations

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other' according to their names?
		do
			Result := actual_group.name < other.actual_group.name
		end

feature {NONE} -- Implementation

	build_groups (a_group: LIST [CONF_GROUP]): DS_ARRAYED_LIST [like Current] is
			-- Build a sorted list out of `a_group'.
		require
			a_group_not_void: a_group /= Void
		local
			l_group: like Current
		do
			create Result.make (a_group.count)

			from
				a_group.start
			until
				a_group.after
			loop
				create l_group.make (a_group.item)
				Result.force_last (l_group)
				if is_cluster then
					l_group.set_parent (Current)
				end
				a_group.forth
			end
			Result.sort (create {DS_QUICK_SORTER [like Current]}.make (create {KL_COMPARABLE_COMPARATOR [like Current]}.make))
		ensure
			Result_not_void: Result /= Void
		end


	generate_subfolder_mapping is
			-- Generate subfolder mapping out of `a_classes'.
		local
			l_classes: DS_ARRAYED_LIST [CLASS_I]
			l_cl: CLASS_I
			l_lst: DS_ARRAYED_LIST [CLASS_I]
			l_folders: DS_HASH_SET [STRING]
			l_path_comp: LIST [STRING]
			l_path, l_part_path: STRING
		do
			-- we build a classesmapping for paths on normal systems and namespaces on dotnet that looks like this
			--
			-- sub_classes
			-- a => cl1, cl2
			-- a/b => cl3, cl4
			-- a/b/c => cl5
			--
			-- and for assembly namespaces
			-- sub_folders
			-- a => b
			-- a/b => c			
			create sub_classes.make (5)
			create sub_folders.make (5)

			from
				l_classes := classes
				l_classes.start
			until
				l_classes.after
			loop
				l_cl := l_classes.item_for_iteration
				l_path := l_cl.path
				if l_path = Void then
					create l_path.make_empty
				end

					-- add the class to the classes mapping
				l_lst := sub_classes.item (l_path+"/")
				if l_lst = Void then
					create l_lst.make (5)
					sub_classes.force (l_lst, l_path+"/")
				end
				l_lst.force_last (l_cl)

					-- for assembly namespaces add the path to the folders mapping
				if is_assembly then
					l_path_comp := l_path.split ('/')
					check
						at_least_one_element: l_path_comp.count >= 1
					end
					from
						l_path_comp.start
							-- ignore first element
						l_path_comp.forth
						create l_part_path.make_empty
					until
						l_path_comp.after
					loop
						l_folders := sub_folders.item (l_part_path+"/")
						if l_folders = Void then
							create l_folders.make_equal (1)
							sub_folders.force (l_folders, l_part_path+"/")
						end
						l_folders.force (l_path_comp.item)
						l_part_path := l_part_path.twin
						l_part_path.append ("/"+l_path_comp.item)
						l_path_comp.forth
					end
				end

				l_classes.forth
			end
		ensure
			sub_classes_set: sub_classes /= Void
			sub_folders_set: is_assembly implies sub_folders /= Void
		end

invariant
	classes_not_void: is_initialized implies classes /= Void
	clusters_not_void: is_initialized implies clusters /= Void
	sub_classes_not_void: is_initialized implies is_cluster implies sub_classes /= Void
	libraries_not_void: is_initialized implies is_library implies libraries /= Void
	assemblies_not_void: is_initialized implies is_library implies assemblies /= Void

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

end
