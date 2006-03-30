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
			sorted_clusters: SORTABLE_ARRAY [CONF_CLUSTER]
			clusters_count: INTEGER
			l_sub_classes: HASH_TABLE [CONF_CLASS, STRING]
			sorted_classes: SORTABLE_ARRAY [CONF_CLASS]
			classes_count: INTEGER
			a_cluster: EB_SORTED_CLUSTER
			i: INTEGER
			l_cluster: CONF_CLUSTER
			l_class_i: CLASS_I
		do
			actual_group := data
			if actual_group.is_cluster then
				l_cluster ?= data
				check
					cluster: l_cluster /= Void
				end
				sub_clusters := l_cluster.children
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
					l_class_i ?= sorted_classes[i]
					check
						class_i: l_class_i /= Void
					end
					classes.extend (l_class_i)
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

	is_writable: BOOLEAN is
			-- Can `Current' be modified?
		do
			Result := actual_group.is_readonly
		end

	actual_group: CONF_GROUP
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
			Result := actual_group.name < other.actual_group.name
		end

feature {NONE} -- Implementation

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
