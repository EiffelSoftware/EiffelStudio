indexing
	description: "Cluster having sorted sub-clusters and sorted classes"
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
			sub_classes: HASH_TABLE [CLASS_I, STRING]
			sorted_classes: SORTABLE_ARRAY [CLASS_I]
			classes_count: INTEGER
			a_cluster: EB_SORTED_CLUSTER
			i: INTEGER
		do
			actual_cluster := data
			sub_clusters := data.sub_clusters
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

			sub_classes := data.classes

				-- Then retrieve all classes and put them into an array
				-- that we will sort.
			create sorted_classes.make (1, sub_classes.count)
			from
				sub_classes.start
				i := 1
			until
				sub_classes.after
			loop
				sorted_classes.put (sub_classes.item_for_iteration, i)

				i := i + 1
				sub_classes.forth
			end

				-- Sort the classes.
			sorted_classes.sort

				-- Build the tree.
			create clusters.make
			create classes.make
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

feature -- Access

	classes: SORTED_TWO_WAY_LIST [CLASS_I]
			-- child classes.

	clusters: SORTED_TWO_WAY_LIST [EB_SORTED_CLUSTER]
			-- sub-clusters.

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

	has_child_class_recursive (a_class: CLASS_I): BOOLEAN is
			-- Is `a_class' recursively child of `Current'?
		local
			a_cluster: CLUSTER_I
		do
			from
				a_cluster := a_class.cluster
			until
				a_cluster = Void or else a_cluster = actual_cluster
			loop
				a_cluster := a_cluster.parent_cluster
			end
			Result := (a_cluster = actual_cluster)
		end

end -- class EB_SORTED_CLUSTER
