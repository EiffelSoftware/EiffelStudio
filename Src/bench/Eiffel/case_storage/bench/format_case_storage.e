-- Format context for Case storage
class FORMAT_CASE_STORAGE

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	WINDOWS;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS
	SPECIAL_AST

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
						process_clusters;
						convert_to_case_format;
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
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			else
				error_window.put_string ("Internal error: Cannot generate case format.%N")
			end
		end

feature {NONE}

	convert_to_case_format is	
			-- Convert all the Eiffelbench structures into
			-- Eiffelcase structures.
		require
			valid_cluster_info: cluster_info /= Void
		local
			root_cluster: S_CLUSTER_DATA;
			system_data: S_SYSTEM_DATA;
		do
			if not rescued then
				root_cluster := cluster_info.storage_info;
				!! system_data;
				system_data.set_root_cluster (root_cluster);
				system_data.set_was_generated_from_bench;
				system_data.set_grid_details (False, False, 20);
				store_project_to_disk (system_data);
			else
				rescued := False
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				if cluster_info /= Void and then
					cluster_info.had_io_problems 
				then
					error_window.put_string ("Cannot store EiffelCase format to disk.%N");
				end
				rescued := True
			end
		end;

	store_project_to_disk (system_data: S_SYSTEM_DATA) is	
			-- Store project `system_data' to disk.
		local
			path: STRING
		do
			if not rescued then
				io.error.putstring ("Storing information to disk ...%N");
				path := clone (Case_storage_path);
				path.extend (Directory_separator);
				system_data.store_to_disk (path);
				error_window.put_string ("Storing EiffelCase format finished%N")
			else
				error_window.put_string ("Cannot store EiffelCase format to disk.%N");
				rescued := False	
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				rescued := True;
				retry
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
			system_name: STRING;
			file_name: STRING
		do
			io.error.putstring ("Processing clusters%N");
			!! cluster_info.make;
				-- Need to covert to a string since
				-- the dynamic type of cluster name
				-- in cluster_i is ID_SD.
			!! system_name.make (0);
			system_name.append (System.system_name);
			system_name.to_upper;
			cluster_info.set_name (system_name);
			!! file_name.make (system_name.count);
			file_name.append (system_name);
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
