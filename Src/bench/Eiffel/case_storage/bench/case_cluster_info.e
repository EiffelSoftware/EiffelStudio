-- Cluster information relevant for EiffelCase
class CASE_CLUSTER_INFO

inherit
	
	SHARED_INST_CONTEXT;
	SHARED_WORKBENCH;
	SHARED_SERVER;
	PROJECT_CONTEXT;
	SHARED_RESCUE_STATUS;
	S_CASE_INFO;
	SHARED_CASE_INFO;
	COMPILER_EXPORTER;
	SHARED_EIFFEL_PROJECT;
	SHARED_ERROR_HANDLER
	SHARED_CASE_DISPLAY_INFO

creation

	make

feature {NONE}

	make is
		do
			!! clusters.make
		end;

feature {FORMAT_CASE_STORAGE, CASE_CLUSTER_INFO}

	clusters: LINKED_LIST [CASE_CLUSTER_INFO];
			-- Sub clusters info

	cluster_i: CLUSTER_I;
			-- Cluster_i associated with path name `name'	

	name: STRING;
			-- Cluster name

	file_name: STRING;
			-- Cluster file name (not including path)

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

	generate_doc (cl : S_CLUSTER_DATA_r332) is
		local
			fi : PLAIN_TEXT_FILE
			file_n : FILE_NAME
			st : STRING
			exp : S_FREE_TEXT_DATA
		do
			if cluster_i /= Void then 
				!! file_n.make
				file_n.extend(cluster_i.path)
				file_n.extend("doc.eif")
					!! fi.make(file_n)
				!! st.make (40)
				if fi.exists then
					from
						fi.open_read
						!! exp.make(20)
					until
						fi.end_of_file
					loop
						fi.read_line
						st := deep_clone(fi.last_string)
						exp.extend (st)
					end
					fi.close
					cl.set_description(exp)
				end
			end 
		end

	storage_info (window: DEGREE_OUTPUT): S_CLUSTER_DATA_R332 is
		local
			clust_l: FIXED_LIST [S_CLUSTER_DATA];
			sorted_clust_l: SORTED_TWO_WAY_LIST [S_CLUSTER_DATA];
			classes_i: EXTEND_TABLE [CLASS_I, STRING];
			classes: LINKED_LIST [CLASS_C];
			class_c: CLASS_C;
			s_cluster_data: S_CLUSTER_DATA;
			view_id: INTEGER;
			old_cluster_info: OLD_CASE_LINKABLE_INFO;
			s_chart: S_CHART;
			dollar_path: STRING;
		do
				-- Need to covert to a string since
				-- the dynamic type of cluster name
				-- in cluster_i is ID_SD.
			if cluster_i /= Void then
				!! name.make (cluster_i.cluster_name.count);
				name.append (cluster_i.cluster_name)
			end;
			name.to_upper;
			!! Result.make (name);
			Result.set_file_name (file_name);
			if cluster_i /= Void then
				!! dollar_path.make (cluster_i.dollar_path.count);
				dollar_path.append (cluster_i.dollar_path);
				Result.set_reversed_engineered_file_name (dollar_path)
			end;
				-- Get old descrition for data (if any) and update
			   	-- s_class_data
			old_cluster_info := Old_case_info.old_cluster (name);
			if old_cluster_info /= Void then
				view_id := old_cluster_info.view_id;
				if old_cluster_info.description /= Void then
					Result.set_description (old_cluster_info.description)
				end
				if old_cluster_info.explanation /= Void then
					Result.set_explanation (old_cluster_info.explanation)
				end
			end;

			generate_doc (Result)

			if view_id = 0 then
				-- Cluster never existed so give it a
				-- new id count
				Old_case_info.decrement_cluster_view_number;
				view_id := Old_case_info.cluster_view_number;
			end;
			Result.set_view_id (view_id);
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
					window.put_case_cluster_message (name);
					Result.set_classes (class_storage_information (classes, window))
				end;
				classes := Void;
			end
			if not clusters.empty then
					-- Keep view ids of cluster if it has the same parent
				!! sorted_clust_l.make;
				from
					clusters.start;
				until
					clusters.after
				loop
					sorted_clust_l.put_front (clusters.item.storage_info (window));
					clusters.forth
				end;
				sorted_clust_l.sort;
				!! clust_l.make_filled (sorted_clust_l.count);
				from
					clust_l.start;
					sorted_clust_l.start
				until
					sorted_clust_l.after
				loop
					clust_l.replace (sorted_clust_l.item);
					sorted_clust_l.forth;
					clust_l.forth
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

	class_storage_information (classes: LINKED_LIST [CLASS_C]; window: DEGREE_OUTPUT): 
			FIXED_LIST [S_CLASS_DATA] is
			-- Storage information for `classes'
		require
			valid_classes: classes /= Void and then not classes.empty;
		local
			classc: CLASS_C;
			stored_classes: SORTED_TWO_WAY_LIST [S_CLASS_DATA];
			format_reg: FORMAT_REGISTRATION;
			class_ast: CLASS_AS;
			i: INTEGER;
			old_class_data, s_class_data: S_CLASS_DATA;
			class_path: STRING;
			old_classes: HASH_TABLE [S_CLASS_DATA, STRING];
			class_info: CASE_CLASS_INFO;
			new_class_views: LINKED_LIST [S_CLASS_DATA];
			view_id: INTEGER;
			re_class: BOOLEAN;
			c_name: STRING;
		do
			old_classes := Old_case_info.old_classes_with_cluster_name (name);
			!! stored_classes.make;
			!! format_reg.initialize;
			!! new_class_views.make;
			from
				classes.start;
				Positioner.init (classes.count)
			until
				classes.after
			loop
				classc := classes.item;
				c_name := clone (classc.name);
				c_name.to_upper;
				re_class := True;
				view_id := 0;
				if old_classes /= Void then
					old_class_data := old_classes.item (c_name);
					if old_class_data /= Void then
							-- Remove the class so we can detect left over
							-- classes that need to be removed
							-- from the system.
						view_id := old_class_data.view_id;
						if classc.reverse_engineered and then 
							old_class_data.id = classc.id.id
						then
								-- Need to make sure that the id's match.
								-- This approach is not fool proof. I didn't
								-- want to do extensive checking to make sure
								-- old_class_data is the same as class_c.
								-- However, the likelyhood that another project
								-- having the same class name and id and in the
								-- same cluster is remote. I wanted this check
								-- to be as optimal as possible -- dinov.
							s_class_data := old_class_data
							re_class := False;
debug ("CASE")
	io.error.putstring ("%T%T%Treusing old s_class_data.%N");
end
						end;
						old_classes.remove (c_name);
					end;
				end;
				if re_class then
					window.put_case_class_message (classc);
						-- Need to reverse engineer class for eiffelcase.
					!! class_info.make (classc);
					class_info.formulate_class_data (format_reg);
					format_reg.wipe_out;
					s_class_data := class_info.s_class_data;
					if old_class_data /= Void then
						if old_class_data.description /= Void then
							s_class_data.set_description (old_class_data.description)
						end
						if old_class_data.explanation /= Void then
							s_class_data.set_explanation
								(old_class_data.explanation)
						end;
						old_class_data := Void
					end;
					Error_handler.checksum
				else
					window.skip_case_class
				end;	
debug ("CASE_ID")
	io.error.putstring ("id: ");
	io.error.putint (s_class_data.id);
	io.error.putstring (" reusing view id: ");
	io.error.putint (s_class_data.view_id);
	io.error.new_line;
end
				if view_id = 0 then
					Old_case_info.increment_class_view_number;
					view_id := Old_case_info.class_view_number;
debug ("CASE_ID")
	io.error.putstring (" id: ");
	io.error.putint (s_class_data.id);
	io.error.putstring (" with new view id: ");
	io.error.putint (s_class_data.view_id);
	io.error.new_line;
end
				end;
				s_class_data.set_view_id (view_id);
				stored_classes.put_front (s_class_data);
				if re_class then
					Case_file_server.tmp_save_class (s_class_data);
				end;
				classes.forth;
			end;
			stored_classes.sort;
			!! Result.make_filled (stored_classes.count);
			from
				Result.start;
				stored_classes.start
			until
				stored_classes.after
			loop
				Result.replace (stored_classes.item);
				stored_classes.forth
				Result.forth;
			end
		ensure
			valid_result: result /= Void;
			same_count_as_classes: classes.count = Result.count
		end;

end
