indexing

	description: 
		"EiffelCase information before performing reverse engineering.%
		%Everything is stored base on the name since this is only way%
		%to match information from bench to case.";
	date: "$Date$";
	revision: "$Revision $"

class OLD_CASE_INFO

inherit

	PROJECT_CONTEXT;
	S_CASE_INFO;
	SHARED_CASE_INFO

creation

	make

feature -- Initialization

	initialize (s_system_data: S_SYSTEM_DATA) is
			-- Initialize Current with cluster `s_system_data'.
		require
			valid_data: s_system_data /= Void;
			has_root_cluster: s_system_data.root_cluster /= Void
		local
			old_cluster_info: OLD_CASE_LINKABLE_INFO
		do
			class_view_number := s_system_data.class_view_number;
			cluster_view_number := s_system_data.cluster_view_number;
			!! old_cluster_info.make (s_system_data.root_cluster);
			old_clusters.put (old_cluster_info, s_system_data.root_cluster.name);
		ensure
			set: class_view_number 
					= s_system_data.class_view_number and then
				cluster_view_number
					= s_system_data.cluster_view_number;
				has_root_cluster: old_clusters.has (s_system_data.root_cluster.name)
		end

	make is
			-- Create Current.
		do
			!! old_classes.make (10);
			!! old_clusters.make (10);
		ensure
			init: old_classes /= Void and then old_clusters /= Void;
		end

feature -- Properties

	class_view_number: INTEGER;
			-- Class view number
			--| Used to set view number for new classes

	cluster_view_number: INTEGER;
			-- Cluster view number
			--| Used to set view number for new clusters

	old_classes: HASH_TABLE [HASH_TABLE [S_CLASS_DATA, STRING], STRING];
			-- Hashed on cluster name. Item is then hashed on
			-- class name which the previous class data is stored

	old_clusters: HASH_TABLE [OLD_CASE_LINKABLE_INFO, STRING];
			-- Hashed on cluster name. Item is then hashed on
			-- cluster name which the old cluster data is stored

feature -- Access
 
	old_classes_with_cluster_name 
			(cluster_name: STRING): HASH_TABLE [S_CLASS_DATA, STRING] is
			-- Old classes with cluster parent name `name'
		do
			Result := old_classes.item (cluster_name)
		end;	

	old_cluster (cluster_name: STRING): OLD_CASE_LINKABLE_INFO is
			-- Old cluster info with cluster name `name'
		do
			Result := old_clusters.item (cluster_name)
		end;	

feature -- Update

	fill (cluster: S_CLUSTER_DATA) is
			-- Fill Current with `cluster' information.
		require
			valid_cluster: cluster /= Void
		local
			clusters: FIXED_LIST [S_CLUSTER_DATA];
			classes: FIXED_LIST [S_CLASS_DATA];
			class_table: HASH_TABLE [S_CLASS_DATA, STRING];
			s_class_data: S_CLASS_DATA;
			s_cluster_data: S_CLUSTER_DATA;
			old_cluster_info: OLD_CASE_LINKABLE_INFO
		do
			classes := cluster.classes;
			if classes /= Void then
				!! class_table.make (classes.count);
				old_classes.put (class_table, cluster.name);
				from
					classes.start	
				until
					classes.after	
				loop 
					s_class_data := classes.item;
					class_table.put (s_class_data, s_class_data.name);
					classes.forth	
				end;
			end;
			clusters := cluster.clusters;
			if clusters /= Void then
				from
					clusters.start
				until
					clusters.after
				loop
					s_cluster_data := clusters.item;
					!! old_cluster_info.make (s_cluster_data);
					old_clusters.put (old_cluster_info, s_cluster_data.name);
					fill (s_cluster_data);
					clusters.forth
				end
			end	
		end;

feature -- Removal

	clear is
			-- Clear structures.
		do
			old_classes.clear_all;
			old_clusters.clear_all;
		end;

	remove_old_classes is
			-- Remove class information from disk which have been
			-- removed since last reverse engineering.
		local
			class_table: HASH_TABLE [S_CLASS_DATA, STRING];
			file: RAW_FILE;
			file_name: FILE_NAME;
			old_class: S_CLASS_DATA;
			path: STRING
		do
			path := Case_storage_path;
			from
				old_classes.start
			until
				old_classes.after
			loop
				class_table := old_classes.item_for_iteration;
				from
					class_table.start
				until
					class_table.after
				loop
					old_class := class_table.item_for_iteration;
					old_class.remove_file (path);
					class_table.forth
				end
				old_classes.forth
			end
		end

feature -- Element change

	increment_class_view_number is
			-- Increment class view number.
		do
			class_view_number := class_view_number + 1
		ensure
			incremented: class_view_number = old class_view_number + 1
		end;

	decrement_cluster_view_number is
			-- Increment cluster view number.
		do
			cluster_view_number := cluster_view_number - 1
		ensure
			incremented: cluster_view_number = old cluster_view_number - 1
		end;

end
