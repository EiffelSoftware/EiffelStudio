-- Format context for Case storage
class FORMAT_CASE_STORAGE

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	WINDOWS;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS
	SPECIAL_AST;
	S_CASE_INFO;
	SHARED_CASE_INFO;
	STORABLE

feature

	rescued: BOOLEAN;

	execute is
			-- Format storage structures
			-- so it can be read in from EiffelCase.
		local
			file_name: STRING;
			file: PLAIN_TEXT_FILE
		do
			if not rescued then
				if workbench.successfull then
					Error_handler.wipe_out;
					Create_case_storage_directory;
					file_name := Case_storage_path;
					!! file.make (file_name);
					if not file.exists or else not file.is_readable then
						error_window.put_string ("Directory ");
						error_window.put_string (case_storage_path);
						error_window.put_string ("%Nis not readable. Please check permission.%N")
					else
						is_short_bool.set_value (False);
						in_bench_mode_bool.set_value (False);
						in_assertion_bool.set_value (False);
						order_same_as_text_bool.set_value (True);
						initialize_view_ids;
						process_clusters;
						convert_to_case_format;
						remove_old_classes;
						error_window.put_string ("Finished storing EiffelCase project.%N");
					end
				else
					error_window.put_string ("Project is in an unstable state.%N");
					error_window.put_string ("Make sure that the system has been%N");
					error_window.put_string ("successfully compiled.%N");
				end;
			else
				rescued := False
			end
		rescue
			flat_ctxt.clear;
			Case_file_server.remove_tmp_files;
			Case_file_server.clear;
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				rescued := True;
			else
				error_window.put_string ("Internal error: Cannot generate EiffelCase project.%N")
			end
			--/*** REMOVEretry
		end

feature {NONE}

	convert_to_case_format is	
			-- Convert all the Eiffelbench structures into
			-- Eiffelcase structures.
		require
			valid_cluster_info: cluster_info /= Void
		local
			root_cluster: S_CLUSTER_DATA;
			s_system_data: S_SYSTEM_DATA;
			view_id: INTEGER
		do
			Case_file_server.init (Case_storage_path);
			root_cluster := cluster_info.storage_info;
			if view_id_info.root_cluster_name.is_equal (root_cluster.name) then
                view_id := View_id_info.root_cluster_view_id
            else
                View_id_info.decrement_cluster_view_number;
                view_id := View_id_info.cluster_view_number;
            end;
			root_cluster.set_view_id (view_id);
			!! s_system_data;
			s_system_data.set_root_cluster (root_cluster);
			s_system_data.set_class_view_number (View_id_info.class_view_number);
			s_system_data.set_class_id_number (System.class_counter.value);
			s_system_data.set_cluster_view_number (View_id_info.cluster_view_number);
			Case_file_server.tmp_save_system (s_system_data);
			io.error.putstring ("Saving EiffelCase project to disk.%N");
			Case_file_server.save_eiffelcase_format;
			Case_file_server.clear;
		rescue
			if Case_file_server.had_io_problems then
				Rescue_status.set_is_error_exception (True);
				error_window.put_string ("Cannot store EiffelCase format to disk.%N");
			elseif Case_file_server.is_saving then
				Rescue_status.set_is_error_exception (True);
				error_window.put_string ("EiffelCase format maybe corrupted.%N");
			end;
		end;

	remove_old_classes is
			-- Remove class information from disk which have been
			-- removed since last reverse engineering.
		do
			View_id_info.remove_old_classes;
		rescue
			Rescue_status.set_is_error_exception (True);
			error_window.put_string ("Error: Could not remove old classes from disk.%N");
		end;

	initialize_view_ids is
			-- Initialize view ids for classes. Retrieve
			-- the existing system and setup a table hashed on
			-- name with the corresponding view_id.
		local
			s_system_data: S_SYSTEM_DATA;
			path: STRING;
			old_system_file: RAW_FILE
		do
			if not rescued then
				path := clone (Case_storage_path);
				path.extend (Directory_separator);
				path.append (System_name);
				!! old_system_file.make (path);
				if old_system_file.exists then
					if old_system_file.is_readable then
						old_system_file.open_read;
						s_system_data ?= retrieved (old_system_file);
						check
							valid_s_system_data: s_system_data /= Void
						end;
						View_id_info.initialize (s_system_data);
						View_id_info.fill (s_system_data.root_cluster);
						old_system_file.close;
					else
						Rescue_status.set_is_error_exception (True);
						raise ("Case error")
					end
				end
			end
		end;
 
	process_clusters is
			-- Process the EiffelBench clusters into 
			-- appropriate structures EiffelCase storage.
		local
			list: SORTED_TWO_WAY_LIST [CLUSTER_I];
			cluster_names_list: LINKED_LIST [STRING];
			other_cluster_info: like cluster_info;
			parent_cluster_info: like cluster_info;
			s_name: STRING;
			file_name: STRING
		do
			io.error.putstring ("Processing clusters%N");
			!! cluster_info.make;
				-- Need to covert to a string since
				-- the dynamic type of cluster name
				-- in cluster_i is ID_SD.
			!! s_name.make (0);
			s_name.append (System.system_name);
			s_name.to_upper;
			cluster_info.set_name (s_name);
			!! file_name.make (s_name.count);
			file_name.append (s_name);
			file_name.to_lower;
			cluster_info.set_file_name (file_name);
			!! list.make;
			list.merge (Universe.clusters);
			from
				list.start
			until
				list.after
			loop
				parent_cluster_info := Void;
				cluster_names_list := extract_clusters (list.item.path);
				from
					cluster_names_list.start
				until
					cluster_names_list.after
				loop
					if parent_cluster_info = Void then
						other_cluster_info := 
							cluster_info.cluster_item (cluster_names_list.item);
					else
						other_cluster_info := 
							parent_cluster_info.cluster_item (cluster_names_list.item);
					end
					if other_cluster_info = Void then
						!! other_cluster_info.make;
						other_cluster_info.set_file_name (cluster_names_list.item);
						if parent_cluster_info = Void then
							cluster_info.add_cluster (other_cluster_info);
						else
							parent_cluster_info.add_cluster (other_cluster_info);
						end
					end;
					parent_cluster_info := other_cluster_info;
					cluster_names_list.forth
				end;
				check
					valid_parent_info: parent_cluster_info /= Void
				end;
				parent_cluster_info.set_cluster_i (list.item);
				list.forth
			end;
			cluster_info := cluster_info.useful_clusters;
			check_cluster_names;
		end;

feature {NONE}

	cluster_info: CASE_CLUSTER_INFO;
	
	extract_clusters (path: STRING): LINKED_LIST [STRING] is
		require
			valid_path: path /= Void and then not path.empty
		local
			stop: BOOLEAN;
			pos, i: INTEGER
		do
			!! Result.make;
			from
				i := 1
			until
				stop or else (i > path.count)
			loop
				pos := path.index_of (Directory_separator, i);
				if pos = i then
					i := i + 1
				elseif pos > i then
					Result.extend (path.substring (i, pos - 1));
					i := pos + 1;
				elseif pos = 0 then
					if i < path.count then
						Result.extend (path.substring (i, path.count));
					elseif path.is_equal (".") then
						Result.extend (path)
					end;
					stop := True
				end
			end
		end;

	check_cluster_names is
			-- Need to check if there are cluster name
			-- clashes. 
		require
			valid_cluster_info: cluster_info /= Void
		local
			clusters: LINKED_LIST [CASE_CLUSTER_INFO];
			cursor: CURSOR;
			has_name_clash: BOOLEAN;
			cluster_name: STRING;
			cluster1, cluster2: CASE_CLUSTER_INFO
		do
				-- WE KNOW that clusters with classes 
				-- in them have unique names (since the compiler
				-- checks for this). However, for clusters
				-- that were derived from directories may
				-- have the same directory names.
			!! clusters.make;
			cluster_info.clusters_without_cluster_i (clusters);
			from
				clusters.start
			until
				clusters.after
			loop
				cluster1 := clusters.item;
				cursor := clusters.cursor;
				cluster_name := clone (cluster1.name);
				from
					clusters.start
				until
					clusters.after 
				loop
					cluster2 := clusters.item;
					if cluster1 /= cluster2 then
						if cluster_name.is_equal (cluster2.name) then
								-- Give new name to cluster1.
								-- Each conflict results in "_X"
								-- begin appended
							cluster_name.append ("_X");
							cluster1.set_name (cluster_name);
							clusters.start;
								-- Check again
						else
							clusters.forth
						end
					else
						clusters.forth
					end;
				end;
				clusters.go_to (cursor);
				clusters.forth
			end
		end

end	
