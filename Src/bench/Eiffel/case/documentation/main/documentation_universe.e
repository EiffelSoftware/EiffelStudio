indexing
	description:
		"Cluster selection for documentation."
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
			-- Initialize with no clusters in system.
		do
			create clusters.make
			any_cluster_format_generated := True
			any_class_format_generated := True
			any_feature_format_generated := True
		end

	make_all is
			-- Initialize with all clusters in system.
		do
			make
			include_all
		end

feature -- Element change

	include_cluster (cl: CLUSTER_I; include_subclusters: BOOLEAN) is
			-- Add `cl' (if not yet present) to universe.
			-- Add subclusters based on `include_subclusters'.
		require
			cl_not_void: cl /= Void
		local
			sc: LIST [CLUSTER_I]
		do
			if not clusters.has (cl) then
				clusters.extend (cl)
			end
			sc := cl.sub_clusters
			if include_subclusters and then sc /= Void then
				from sc.start until sc.after loop
					include_cluster (sc.item, True)
					sc.forth
				end
			end
		end

	exclude_cluster (cl: CLUSTER_I; exclude_subclusters: BOOLEAN) is
			-- Remove `cl' if present.
			-- Remove subclusters based on `exclude_subclusters'.
		require
			cl_not_void: cl /= Void
		local
			sc: LIST [CLUSTER_I]
		do
			clusters.prune_all (cl)
			sc := cl.sub_clusters
			if sc /= Void and then exclude_subclusters then
				from sc.start until sc.after loop
					exclude_cluster (sc.item, True)
					sc.forth
				end
			end
		end

	include_all is
			-- Include all clusters from the universe in the documentation.
		local
			cl: LINKED_LIST [CLUSTER_I]
		do
			cl := Universe.clusters
			from cl.start until cl.after loop
				clusters.extend (cl.item)
				cl.forth
			end
		end

feature -- Access

	clusters: SORTED_TWO_WAY_LIST [CLUSTER_I]
			-- All clusters in universe.

	classes: SORTED_TWO_WAY_LIST [CLASS_I] is
			-- All classes from `clusters'.
		local
			cl: EXTEND_TABLE [CLASS_I, STRING]
		do
			create Result.make
			from clusters.start until clusters.after loop
				cl := clusters.item.classes
				from
					cl.start
				until
					cl.after
				loop
					if cl.item_for_iteration.compiled then
						Result.extend (cl.item_for_iteration)
					end
					cl.forth
				end
				clusters.forth
			end
		end

	classes_in_cluster (cluster: CLUSTER_I): like classes is
			-- List of all items from `classes' whose cluster is `cluster'.
		require
			cluster_not_void: cluster /= Void
		local
			cl: EXTEND_TABLE [CLASS_I, STRING]
		do
			create Result.make
			cl := cluster.classes
			from
				cl.start
			until
				cl.after
			loop
				if cl.item_for_iteration.compiled then
					Result.extend (cl.item_for_iteration)
				end
				cl.forth
			end
		end

	any_cluster_format_generated: BOOLEAN
			-- Is a format generated where a cluster link can be redirected to?

	any_class_format_generated: BOOLEAN
			-- Is a format generated where a class link can be redirected to?

	any_feature_format_generated: BOOLEAN
			-- Is a format generated where a feature link can be redirected to?

feature -- Status report

	is_cluster_generated (a_cluster: CLUSTER_I): BOOLEAN is
			-- Is documentation for `cluster' generated?
		do
			Result := any_cluster_format_generated and then clusters.has (a_cluster)
		end

	is_class_generated (a_class: CLASS_I): BOOLEAN is
			-- Is documentation for `cl' generated?
		do
			Result := any_class_format_generated and then clusters.has (a_class.cluster)
		end

	is_feature_generated (a_feature: E_FEATURE): BOOLEAN is
			-- Is documentation for `cl' generated?
		do
			Result := any_feature_format_generated and then clusters.has (
				a_feature.written_class.lace_class.cluster
			)
		end

	is_cluster_leaf_generated (cluster: CLUSTER_I): BOOLEAN is
			-- Is `cluster' or recursively any of its subclusters generated?
			-- Used for cluster hierarchy view.
		local
			sc: LIST [CLUSTER_I]
		do
			Result := any_cluster_format_generated and then clusters.has (cluster)
			sc := cluster.sub_clusters
			if sc /= Void then
				from sc.start until Result or else sc.after loop
					if is_cluster_leaf_generated (sc.item) then
						Result := True
					end
					sc.forth
				end
			end
		end

feature -- Status setting

	set_any_cluster_format_generated (f: BOOLEAN) is
		do
			any_cluster_format_generated := f
		end

	set_any_class_format_generated (f: BOOLEAN) is
		do
			any_class_format_generated := f
		end

	set_any_feature_format_generated (f: BOOLEAN) is
		do
			any_feature_format_generated := f
		end

end -- class DOCUMENTATION_UNIVERSE
