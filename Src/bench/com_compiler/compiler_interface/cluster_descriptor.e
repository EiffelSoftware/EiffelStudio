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

	classes: ECOM_VARIANT is
			-- List of classes in cluster.
		local
			res: ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			l: EXTEND_TABLE [CLASS_I, STRING]
			class_desc: CLASS_DESCRIPTOR
			i: INTEGER
		do
			l := compiler_cluster.classes
			create res.make (1, l.count)
			from
				l.start
				i := 1
			until
				l.after
			loop
				create class_desc.make_with_class_i (l.item_for_iteration)
				res.put (class_desc, i)
				i := i + 1
				l.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end

	class_count: INTEGER is
			-- Number of classes in cluster.
		do
			Result := compiler_cluster.classes.count
		end

	clusters: ECOM_VARIANT is
			-- List of subclusters in cluster.
		local
			res: ARRAY [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
			cluster_desc: CLUSTER_DESCRIPTOR
			l: ARRAYED_LIST [CLUSTER_I]
			i:INTEGER
		do
			l := compiler_cluster.sub_clusters
			create res.make (1, l.count)
			from
				l.start
				i := 1
			until
				l.after
			loop
				create cluster_desc.make_with_cluster_i (l.item)
				res.put (cluster_desc, i)
				i := i + 1
				l.forth
			end
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
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
