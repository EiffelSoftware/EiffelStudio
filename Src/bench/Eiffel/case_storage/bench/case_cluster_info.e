-- Cluster information relevant for EiffelCase
class CASE_CLUSTER_INFO

inherit
	
	SHARED_INST_CONTEXT;
	SHARED_WORKBENCH;
	SHARED_SERVER;
	PROJECT_CONTEXT;
	SHARED_RESCUE_STATUS;
	S_CASE_INFO;
	SHARED_CASE_INFO

creation

	make

feature {NONE}

	make is
		do
			!! clusters.make
		end;

feature {FORMAT_CASE_STORAGE, CASE_CLUSTER_INFO}

	clusters: LINKED_LIST [CASE_CLUSTER_INFO];

	cluster_i: CLUSTER_i;
			-- Cluster_i associated with path name `name'	

	name: STRING;
			-- Cluster name

	file_name: STRING;
			-- Cluster file name (not include path)

	set_file_name (n: STRING) is
			-- Set file_name to `n'.
		require
			valid_name: n /= Void and then not n.empty
		do
			!! file_name.make (n.count);
			file_name.append (n);
		ensure
			file_name_set: file_name.is_equal (n)
		end;

	set_name (n: STRING) is
			-- Set name to `n'.
		require
			valid_name: n /= Void and then not n.empty
		do
			!! name.make (n.count);
			name.append (n);
		ensure
			name_set: name.is_equal (n)
		end;

	set_cluster_i (c: like cluster_i) is
			-- Set cluster_i to `i'.
		require
			valid_cluster: c /= Void 
		do
			cluster_i := c
		ensure
			cluster_set: cluster_i = c
		end;

	add_cluster (cluster: CASE_CLUSTER_INFO) is
			-- Add `cluster' to clusters.
		require
			valid_cluster: cluster /= Void;
		do
			clusters.extend (cluster)
		end;

	cluster_item (path_element: STRING): CASE_CLUSTER_INFO is
			-- Does name equal to `path_element'?
		require
			valid_path_element: path_element /= Void
		do
			if path_element.is_equal (file_name) then
				Result := Current
			else
				from
					clusters.start
				until
					Result /= Void or else clusters.after 
				loop
					Result := clusters.item.cluster_item (path_element)
					clusters.forth
				end
			end
		end;

	storage_info: S_CLUSTER_DATA is
		local
			clust_l: FIXED_LIST [S_CLUSTER_DATA];
			classes_i: EXTEND_TABLE [CLASS_I, STRING];
			classes: LINKED_LIST [CLASS_C];
			class_c: CLASS_C;
			s_cluster_data: S_CLUSTER_DATA;
			view_id: INTEGER
		do
				-- Need to covert to a string since
				-- the dynamic type of cluster name
				-- in cluster_i is ID_SD.
			if cluster_i /= Void then
				!! name.make (0);
				name.append (cluster_i.cluster_name);
			end;
			name.to_upper;
			!! Result.make (name);
			Result.set_file_name (file_name);
			if cluster_i /= Void then
				classes_i := cluster_i.classes;
				!! classes.make;
				from
					classes_i.start
				until
					classes_i.after
				loop
					class_c := classes_i.item_for_iteration.compiled_class;
					if class_c /= Void then
						classes.put_front (class_c);
					end;
					classes_i.forth
				end;
				classes_i := Void;
				if not classes.empty then
io.error.putstring ("Analyzing cluster: ");
io.error.putstring (name);
io.error.new_line;
					Result.set_classes (class_storage_information (classes))
				end;
				classes := Void;
			end
			if not clusters.empty then
					-- Keep view ids of cluster if it has the same parent
				!! clust_l.make (clusters.count);
				from
					clusters.start;
					clust_l.start
				until
					clusters.after
				loop
					s_cluster_data := clusters.item.storage_info;
					view_id := View_id_info.old_cluster_view_id (s_cluster_data.name);
					if view_id = 0 then
							-- Cluster never existed so give it a
							-- new id count
						View_id_info.decrement_cluster_view_number;
						view_id := View_id_info.cluster_view_number;
					end
					s_cluster_data.set_view_id (view_id);
					clust_l.replace (s_cluster_data);
					clust_l.forth;
					clusters.forth
				end;
				Result.set_clusters (clust_l);
			end
		end;

feature {CASE_CLUSTER_INFO}

	process_clusters (useful_cl: CASE_CLUSTER_INFO) is
			-- Process clusters in Current. Add useful clusters for
			-- EiffelCase in `useful_clusters'.
		require
			valid_useful_cluster: useful_cl /= Void
		local
			has_cluster_i: BOOLEAN;
			cluster_info: like Current;
			cluster_name: STRING
		do
			if cluster_i = Void then
				from
					clusters.start
				until
					has_cluster_i or else clusters.after
				loop
					has_cluster_i := clusters.item.cluster_i /= Void
					clusters.forth
				end;
			else
				has_cluster_i := True
			end;
			if has_cluster_i then
				!! cluster_info.make;
				cluster_info.set_file_name (file_name);
				if cluster_i = Void then
					cluster_name := file_name;
				else
					cluster_info.set_cluster_i (cluster_i);
					!! cluster_name.make (cluster_i.cluster_name.count);
					cluster_name.append (cluster_i.cluster_name);
				end;
				cluster_info.set_name (cluster_name);
				useful_cl.add_cluster (cluster_info);
			end;
			from
				clusters.start
			until
				clusters.after 
			loop
				if cluster_info = Void then
					clusters.item.process_clusters (useful_cl)
				else
					clusters.item.process_clusters (cluster_info)
				end;
				clusters.forth
			end
		end;

feature {FORMAT_CASE_STORAGE}

	useful_clusters: like Current is
			-- Relevant clusters for EiffelCase
		do
			!! Result.make;
			Result.set_file_name (file_name);
			Result.set_name (name);
			from
				clusters.start
			until
				clusters.after 
			loop
				clusters.item.process_clusters (Result)
				clusters.forth
			end;
		end;

feature {FORMAT_CASE_STORAGE, CASE_CLUSTER_INFO} -- Debug

	clusters_without_cluster_i (list: LINKED_LIST [CASE_CLUSTER_INFO]) is
			-- Add to `list' classes that do not have an 
			-- associated cluster_i.
		require
			valid_list: list /= Void
		do
			if cluster_i = Void then
				list.put_front (Current);	
			end;
			from
				clusters.start
			until
				clusters.after 
			loop
				clusters.item.clusters_without_cluster_i (list);
				clusters.forth
			end;
		end;

	trace is
		do
			io.error.putstring ("parent name: ");
			io.error.putstring (name);
			io.error.new_line;
			from
				clusters.start
			until
				clusters.after
			loop
				clusters.item.trace;
				clusters.forth
			end
		end;

	had_io_problems: BOOLEAN;

feature {NONE} -- Class information

	class_storage_information (classes: LINKED_LIST [CLASS_C]): FIXED_LIST [S_CLASS_DATA] is
			-- Storage information for `classes'
		require
			valid_classes: classes /= Void and then not classes.empty;
		local
			classc: CLASS_C;
			flat_struct: FLAT_STRUCT;
			class_ast: CLASS_AS;
			i: INTEGER;
			s_class_data: S_CLASS_DATA;
			class_path: STRING;
			old_classes: HASH_TABLE [INTEGER, STRING];
			class_info: CASE_CLASS_INFO;
			new_class_views: LINKED_LIST [S_CLASS_DATA];
			view_id: INTEGER
		do
			old_classes := View_id_info.old_classes_with_cluster_name (name);
			!! Result.make (classes.count);
			!! flat_struct.initialize;
			!! new_class_views.make;
			from
				classes.start;
				Result.start;
			until
				classes.after
			loop
				classc := classes.item;
				io.error.putstring ("%TAnalyzing class ");
				io.error.putstring (classc.class_name);
				io.error.new_line;
				!! class_info.make (classc);
				class_info.formulate_class_data (flat_struct);
				flat_struct.wipe_out;
				s_class_data := class_info.s_class_data;
				view_id := 0;
				if old_classes /= Void then
					view_id := old_classes.item (s_class_data.name);
					if view_id /= 0 then
							-- Remove the class so we can detect old
							-- classes that needs to be removed
							-- from the system
						old_classes.remove (s_class_data.name)
					end
				end;
					-- Record parent cluster
				if view_id = 0 then
					View_id_info.increment_class_view_number;
					view_id := View_id_info.class_view_number;
					new_class_views.extend (s_class_data)
				else
debug ("CASE_ID")
	io.error.putstring ("id: ");
	io.error.putint (s_class_data.id);
	io.error.putstring (" reusing view id: ");
	io.error.putint (s_class_data.view_id);
	io.error.new_line;
end
					Result.replace (s_class_data);
					Result.forth;
				end;
				s_class_data.set_view_id (view_id);
				Case_file_server.tmp_save_class (s_class_data);
				classes.forth;
			end;
			from
				new_class_views.start
			until
				new_class_views.after
			loop
				View_id_info.increment_class_view_number;
				view_id := View_id_info.class_view_number;
				Result.replace (new_class_views.item);
debug ("CASE_ID")
	io.error.putstring (" id: ");
	io.error.putint (s_class_data.id);
	io.error.putstring (" with new view id: ");
	io.error.putint (s_class_data.view_id);
	io.error.new_line;
end
				Result.forth;
				new_class_views.forth
			end
		ensure
			valid_result: result /= Void;
			same_count_as_classes: classes.count = Result.count
		end;

end
