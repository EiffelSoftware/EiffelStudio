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
		local
			sub_clusters: ARRAYED_LIST [CONF_CLUSTER]
			l_sub_classes: HASH_TABLE [CONF_CLASS, STRING]
			sorted_classes: SORTED_TWO_WAY_LIST [CONF_CLASS]
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_class_i: CLASS_I
			l_lib_target: CONF_TARGET
		do
			actual_group := data

			create clusters.make
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

					-- libraries
				libraries := build_groups (l_lib_target.libraries.linear_representation)

					-- assemblies
				assemblies := build_groups (l_lib_target.assemblies.linear_representation)
			end

				-- handle classes
			create classes.make
			l_sub_classes := data.classes
			if l_sub_classes /= Void then
				create sorted_classes.make
				sorted_classes.append (l_sub_classes.linear_representation)
				sorted_classes.sort

				from
					sorted_classes.start
				until
					sorted_classes.after
				loop
					l_class_i ?= sorted_classes.item
					check
						class_i: l_class_i /= Void
					end
					classes.extend (l_class_i)
					sorted_classes.forth
				end
			end

			generate_subfolder_mapping
		end

feature -- Access

	classes: SORTED_TWO_WAY_LIST [CLASS_I]
			-- child classes.

	clusters: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			-- sub-clusters.

	sub_classes: HASH_TABLE [SORTED_TWO_WAY_LIST [CLASS_I], STRING]
			-- classes mapping for sub folders

	libraries: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			-- libraries.

	assemblies: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			-- assemblies.

	is_writable: BOOLEAN is
			-- Can `Current' be modified?
		do
			Result := not actual_group.is_readonly
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

	build_groups (a_group: LIST [CONF_GROUP]): SORTED_TWO_WAY_LIST [like Current] is
			-- Build a sorted list out of `a_group'.
		require
			a_group_not_void: a_group /= Void
		local
			l_group: like Current
		do
			create Result.make

			from
				a_group.start
			until
				a_group.after
			loop
				create l_group.make (a_group.item)
				Result.extend (l_group)
				if is_cluster then
					l_group.set_parent (Current)
				end
				a_group.forth
			end
			Result.sort
		ensure
			Result_not_void: Result /= Void
		end


	generate_subfolder_mapping is
			-- Generate subfolder mapping out of `a_classes'.
		local
			l_classes: SORTED_TWO_WAY_LIST [CLASS_I]
			l_cl: CLASS_I
			l_lst: SORTED_TWO_WAY_LIST [CLASS_I]
			l_path: STRING
		do
			-- we build a classesmapping that looks like this
			--
			-- sub_classes
			-- a => cl1, cl2
			-- a/b => cl3, cl4
			-- a/b/c => cl5
			create sub_classes.make (5)

			from
				l_classes := classes
				l_classes.start
			until
				l_classes.after
			loop
				l_cl := l_classes.item
				l_path := l_cl.path
				if l_path = Void then
					create l_path.make_empty
				end

					-- add the class to the classes mapping
				l_lst := sub_classes.item (l_path+"/")
				if l_lst = Void then
					create l_lst.make
					sub_classes.force (l_lst, l_path+"/")
				end
				l_lst.extend (l_cl)

				l_classes.forth
			end
		ensure
			sub_classes_set: sub_classes /= Void
		end

invariant
	classes_not_void: classes /= Void
	clusters_not_void: clusters /= Void
	sub_classes_not_void: is_cluster implies sub_classes /= Void
	libraries_not_void: is_library implies libraries /= Void
	assemblies_not_void: is_library implies assemblies /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
