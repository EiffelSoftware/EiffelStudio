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

	make (data: CLUSTER_I) is
			-- Associate `data' to `Current' and sort children.
		local
			sub_clusters: ARRAYED_LIST [CLUSTER_I]
			sorted_clusters: SORTABLE_ARRAY [CLUSTER_I]
			clusters_count: INTEGER
			l_sub_classes: HASH_TABLE [CLASS_I, STRING]
			sorted_classes: SORTABLE_ARRAY [CLASS_I]
			classes_count: INTEGER
			a_cluster: EB_SORTED_CLUSTER
			i: INTEGER
		do
			actual_cluster := data
			sub_clusters := data.sub_clusters
			create clusters.make
			if sub_clusters /= Void then
					-- First retrieve all sub-clusters and put them into an array
					-- that we will sort.
				create sorted_clusters.make (1, sub_clusters.count)
				from
					sub_clusters.start
					i := 1
				until
					sub_clusters.after
				loop
					sorted_clusters.put (sub_clusters.item, i)

					i := i + 1
					sub_clusters.forth
				end

					-- Sort the clusters.
				sorted_clusters.sort

					-- Build the tree.
				from
					clusters_count := sorted_clusters.count
					i := clusters_count
				until
					i = 0
				loop
					create a_cluster.make (sorted_clusters @ i)
					clusters.extend (a_cluster)
					a_cluster.set_parent (Current)
					i := i - 1
				end
			end

			create classes.make
			l_sub_classes := data.classes
			if l_sub_classes /= Void then
					-- Then retrieve all classes and put them into an array
					-- that we will sort.
				create sorted_classes.make (1, l_sub_classes.count)
				from
					l_sub_classes.start
					i := 1
				until
					l_sub_classes.after
				loop
					sorted_classes.put (l_sub_classes.item_for_iteration, i)

					i := i + 1
					l_sub_classes.forth
				end

					-- Sort the classes.
				sorted_classes.sort

					-- Build the tree.
				from
					classes_count := sorted_classes.count
					i := classes_count
				until
					i = 0
				loop
					classes.extend (sorted_classes @ i)
					i := i - 1
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

	sub_folders: HASH_TABLE [DS_HASH_SET [STRING], STRING];
			-- subfolder mapping for sub folders

	is_writable: BOOLEAN is
			-- Can `Current' be modified?
		do
			if (parent = Void) then
				Result := not actual_cluster.is_library
			else
				Result := (not actual_cluster.is_library) and parent.is_writable
			end
		end

	actual_cluster: CLUSTER_I
			-- cluster associated to `Current'.

	parent: EB_SORTED_CLUSTER
			-- sorted cluster in which `Current' is.


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
			Result := actual_cluster.cluster_name < other.actual_cluster.cluster_name
		end

feature {NONE} -- Implementation

	generate_subfolder_mapping is
			-- Generate subfolder mapping out of `a_classes'.
		local
			l_classes: SORTED_TWO_WAY_LIST [CLASS_I]
			l_cl: CLASS_I
			l_lst: SORTED_TWO_WAY_LIST [CLASS_I]
			l_folders: DS_HASH_SET [STRING]
			l_path_comp: LIST [STRING]
			l_path, l_part_path: STRING
		do
			-- we build a classes and folder mapping that looks like this
			--
			-- sub_classes
			-- a => cl1, cl2
			-- a/b => cl3, cl4
			-- a/b/c => cl5
			--
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

					-- add the path to the folders mapping
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

				l_classes.forth
			end
		ensure
			sub_classes_set: sub_classes /= Void
			sub_folders_set: sub_folders /= Void
		end

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

end -- class EB_SORTED_CLUSTER
