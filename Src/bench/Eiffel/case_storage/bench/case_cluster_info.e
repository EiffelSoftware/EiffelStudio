-- Cluster information relevant for EiffelCase
class CASE_CLUSTER_INFO

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

	set_name (n: STRING) is
			-- Set name to `n'.
		require
			valid_name: n /= Void and then not n.empty
		do
			name := clone (n);
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
			if path_element.is_equal (name) then
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
			cluster_name: STRING
		do
			if cluster_i = Void then
				!! Result.make (name);
			else
					-- Need to covert to a string since
					-- the dynamic type of cluster name
					-- in cluster_i is ID_SD.
				!! cluster_name.make (0);
				cluster_name.append (cluster_i.cluster_name);
				!! Result.make (cluster_name)
			end;
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
					Result.set_classes (class_storage_information (classes));
				end
				classes := Void;
			end
			if not clusters.empty then
				!! clust_l.make (clusters.count);
				from
					clusters.start;
					clust_l.start
				until
					clusters.after
				loop
					clust_l.replace (clusters.item.storage_info);
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
			cluster_info: like Current
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
				cluster_info.set_name (name);
				if cluster_i /= Void then
					cluster_info.set_cluster_i (cluster_i);
				end;
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

feature {NONE} -- Class information

	class_storage_information
			 (classes: LINKED_LIST [CLASS_C]): FIXED_LIST [S_CLASS_DATA] is
			-- Storage information for `classes'
		local
			class_c: CLASS_C;
			flat_struct: FLAT_STRUCT;
			class_ast: CLASS_AS;
			i: INTEGER;
			s_class_data: S_CLASS_DATA;
		do
			if classes.count > 1 then
				!! Result.make (1);
			else
				!! Result.make (classes.count);
			end
			--!! Result.make (classes.count);
			!! flat_struct.initialize;
			from
				classes.start;
				Result.start;
				i := 1
			until
				i > 1 or else classes.after
			loop
				class_c := classes.item;
				io.error.putstring ("Analyzing class ");
				io.error.putstring (class_c.class_name);
				io.error.new_line;
				flat_struct.set_class (class_c);
				flat_struct.fill (True);
				class_ast := flat_struct.ast;
				s_class_data := class_ast.header_storage_info;
				flat_struct.store_case_information (s_class_data);
				Result.replace (s_class_data);
				Result.forth;
				classes.forth;
				i := i + 1
			end
		end;

end
