-- Format context for Case storage
class FORMAT_CASE_STORAGE

inherit

	SHARED_WORKBENCH;
	PROJECT_CONTEXT;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS
	SHARED_FORMAT_INFO;
	S_CASE_INFO;
	SHARED_CASE_INFO;
	STORABLE;
	COMPILER_EXPORTER

creation

	make

feature -- Initialization

	make (ow: like output_window) is
			-- Set `output_window' to `ow'.
		do
			output_window := ow
		end;

feature -- Property

	output_window: OUTPUT_WINDOW;

feature -- Execution

	rescued: BOOLEAN;

	execute is
			-- Format storage structures
			-- so it can be read in from EiffelCase.
		local
			d: DIRECTORY;
			f: PLAIN_TEXT_FILE;
			fn: FILE_NAME
		do
			if not rescued then
				output_window.clear_window;
				if workbench.successfull then
					Error_handler.wipe_out;
					Create_case_storage_directory;
					!! d.make (Case_storage_path);
					if not d.exists or else not d.is_readable then
						output_window.put_string ("Directory ");
						output_window.put_string (case_storage_path);
						output_window.put_string ("%Nis not readable. Please check permission.%N")
					else
						!! fn.make_from_string (Case_storage_path);
						fn.set_file_name (System_name);	
						!! f.make (fn);
						if not f.exists or else need_to_reverse_engineer then;
							reset_format_booleans;
							set_order_same_as_text;
							initialize_view_ids;
							process_clusters;
							convert_to_case_format;
							remove_old_classes;
							clear_shared_case_information;
							output_window.put_string ("Finished storing EiffelCase project.%N");
						else
							output_window.put_string ("EiffelCase project is up to date.%N");
						end;
					end;
					output_window.display
				else
					output_window.put_string ("Project is in an unstable state.%N");
					output_window.put_string ("Make sure that the system has been%N");
					output_window.put_string ("successfully compiled.%N");
					output_window.display
				end;
			else
				rescued := False
			end
		rescue
			Case_file_server.remove_tmp_files;
			clear_shared_case_information;
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end;
		end

feature {NONE} -- Implementation

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
			!! s_system_data;
			s_system_data.set_root_cluster (root_cluster);
			s_system_data.set_class_view_number (Old_case_info.class_view_number);
			s_system_data.set_class_id_number (System.class_counter.value);
			s_system_data.set_cluster_view_number (Old_case_info.cluster_view_number);
			Case_file_server.tmp_save_system (s_system_data);
			io.error.putstring ("Saving EiffelCase project to CASEGEN directory.%N");
			Case_file_server.save_eiffelcase_format;
			io.error.putstring ("Updating EiffelBench project.%N");
			update_eiffel_project;
		rescue
			if Case_file_server.had_io_problems then
				io.error.put_string ("Cannot store EiffelCase format to CASEGEN directory.%N");
			elseif Case_file_server.is_saving then
				io.error.put_string ("EiffelCase format maybe corrupted.%N");
			end;
		end;

	remove_old_classes is
			-- Remove class information from disk which have been
			-- removed since last reverse engineering.
		do
			Old_case_info.remove_old_classes;
		rescue
			io.error.put_string ("Error: Could not remove old classes from CASEGEN directory.%N");
		end;

	initialize_view_ids is
			-- Initialize view ids for classes. Retrieve
			-- the existing system and setup a table hashed on
			-- name with the corresponding view_id.
		local
			s_system_data: S_SYSTEM_DATA;
			path: FILE_NAME;
			old_system_file: RAW_FILE
		do
			if not rescued then
				!!path.make_from_string (Case_storage_path);
				path.set_file_name (System_name);
				!! old_system_file.make (path);
				if old_system_file.exists then
					if old_system_file.is_readable then
						old_system_file.open_read;
						s_system_data ?= retrieved (old_system_file);
						check
							valid_s_system_data: s_system_data /= Void
						end;
						Old_case_info.initialize (s_system_data);
						Old_case_info.fill (s_system_data.root_cluster);
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
			root_file_name, file_name: STRING;
			full_path: DIRECTORY_NAME
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
			!! root_file_name.make (s_name.count);
			root_file_name.append (s_name);
			root_file_name.to_lower;
			cluster_info.set_file_name (root_file_name);
			cluster_info.set_full_path_name (root_file_name);
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
					cluster_names_list.start;
					!! full_path.make_from_string (root_file_name);
				until
					cluster_names_list.after
				loop
					file_name := cluster_names_list.item;
					full_path.extend (file_name);
					if parent_cluster_info = Void then
						other_cluster_info := 
							cluster_info.cluster_item (full_path);
					else
						other_cluster_info := 
							parent_cluster_info.cluster_item (full_path);
					end
					if other_cluster_info = Void then
						!! other_cluster_info.make;
						other_cluster_info.set_file_name (file_name);
						other_cluster_info.set_full_path_name (clone (full_path));
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

feature {NONE} -- Implementation

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
		end;

	need_to_reverse_engineer: BOOLEAN is
			-- Do we need to reverse engineer?
		local
			classes: ARRAY [CLASS_C];
			i: INTEGER;
			c: CLASS_C;
		do
			classes := System.id_array;
			from
				i := classes.lower
			until
				i > classes.upper or else Result
			loop
				c := classes.item (i);
				if c /= Void then
					Result := not c.reverse_engineered
				end;
				i := i + 1
			end;
		end;

	update_eiffel_project is
			-- Mark the classes in the EiffelProject as
			-- reversed engineered and save the 
			-- project.
		local
			classes: ARRAY [CLASS_C];
			i: INTEGER;
			c: CLASS_C;
			need_to_save: BOOLEAN
		do
			classes := System.id_array;
			from
				i := classes.lower
			until
				i > classes.upper
			loop
				c := classes.item (i);
				if c /= Void then
					need_to_save := True;
					c.set_reverse_engineered (True)
				end;
				i := i + 1
			end;
			if need_to_save then
				save_workbench_file
			end
		end;

	save_workbench_file is
			-- Save the `.workbench' file.
		local
			file: RAW_FILE
		do
			System.server_controler.wipe_out;
			!!file.make (Project_file_name);
			file.open_write;
			workbench.basic_store (file);
			file.close;
		end;

invariant

	valid_output_window: output_window /= Void

end	
