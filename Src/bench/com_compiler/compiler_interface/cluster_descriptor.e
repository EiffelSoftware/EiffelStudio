indexing
	description: "Description of a cluster in the system"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_DESCRIPTOR

inherit
	IEIFFEL_CLUSTER_DESCRIPTOR_IMPL_STUB
		redefine
			name,
			description,
			classes,
			class_count,
			clusters,
			cluster_count,
			cluster_path
		end
		
create
	make_with_cluster_i
	
feature {NONE} -- Initialization

	make_with_cluster_i (a_cluster: CLUSTER_I) is
			-- Initialize with `a_cluster'.
		require
			a_cluster_exists: a_cluster /= Void
		do
			compiler_cluster := a_cluster
		end
		
feature -- Access

	name: STRING is
			-- Cluster name.
		do
			Result := compiler_cluster.cluster_name
		ensure then
			result_exists: Result /= Void
		end

	description: STRING is
			-- Cluster description.
		do
				--| FIXME what to put here ?
			create Result.make_from_string ("")
		ensure then
			result_exists: Result /= Void
		end

	classes: CLASS_ENUMERATOR is
			-- List of classes in cluster.
		local
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			l: EXTEND_TABLE [CLASS_I, STRING]
			class_desc: CLASS_DESCRIPTOR
		do
			l := compiler_cluster.classes
			create res.make (l.count)
			from
				l.start
			until
				l.after
			loop
				create class_desc.make_with_class_i (l.item_for_iteration)
				res.extend (class_desc)
				l.forth
			end
			create Result.make (res)
		ensure then
			result_exists: Result /= Void
		end

	class_count: INTEGER is
			-- Number of classes in cluster.
		do
			Result := compiler_cluster.classes.count
		end

	clusters: CLUSTER_ENUMERATOR is
			-- List of subclusters in cluster.
		local
			res: ARRAYED_LIST [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
			cluster_desc: CLUSTER_DESCRIPTOR
			l: ARRAYED_LIST [CLUSTER_I]
		do
			l := compiler_cluster.sub_clusters
			create res.make (l.count)
			from
				l.start
			until
				l.after
			loop
				create cluster_desc.make_with_cluster_i (l.item)
				res.extend (cluster_desc)
				l.forth
			end
			create Result.make (res)
		ensure then
			result_exists: Result /= Void
		end

	cluster_count: INTEGER is
			-- Number of subclusters in cluster.
		do
			Result := compiler_cluster.sub_clusters.count
		end

	cluster_path: STRING is
			-- Full path to cluster.
		do
			Result := compiler_cluster.path
		ensure then
			result_exists: Result /= Void
		end
		
feature {NONE} -- Implementation

	compiler_cluster: CLUSTER_I
			-- Associated compiler structure.
	
end -- class CLUSTER_DESCRIPTOR
