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
	COMPILER_EXPORTER;
	SHARED_COUNTER;
	SHARED_EIFFEL_PROJECT;
	SHARED_INST_CONTEXT;
	SHARED_EXEC_ENVIRONMENT

creation

	make

feature {NONE} -- Initialization

	make (ow: like output_window; rew: like reverse_engineering_window;
			generate_all_clusters: BOOLEAN) is
			-- Set `output_window' to `ow'.
		do
			output_window := ow
			reverse_engineering_window := rew
			generate_all := generate_all_clusters
		end;

feature -- Access

	output_window: OUTPUT_WINDOW;

	reverse_engineering_window: DEGREE_OUTPUT
			-- Reverse engineering window

	generate_all: BOOLEAN
			-- Do we generate all the clusters?

	list_clusters : ARRAYED_LIST [CLUSTER_I]

feature -- Execution

	rescued: BOOLEAN;

	execute is
			-- Format storage structures
			-- so it can be read in from EiffelCase.
		local
			d: DIRECTORY;
			f: PLAIN_TEXT_FILE;
			fn: FILE_NAME;
			prev_class: CLASS_C;
			prev_cluster: CLUSTER_I
			case_tool: CASE_INTERFACE
		do
			if not rescued then
				if not Workbench.system_defined then
					output_window.put_string ("Project has not been compiled.");
					output_window.new_line;
					output_window.put_string ("The project must be compiled ");
					output_window.put_string ("before it can be reverse engineered.");
					output_window.new_line;
					output_window.display
				else
					prev_class := System.current_class;
					prev_cluster := Inst_context.cluster;
					output_window.clear_window;
					if workbench.successful then
						Create_case_storage_directory;
						!! d.make (Case_storage_path);
						if not d.exists or else not d.is_readable then
							output_window.put_string ("Directory ");
							output_window.put_string (case_storage_path);
							output_window.new_line;
							output_window.put_string ("is not readable. Please check permission.")
							output_window.new_line;
						else
							!! fn.make_from_string (Case_storage_path);
							fn.set_file_name (System_name);	
							!! f.make (fn);
							if not f.exists or else need_to_reverse_engineer then;
								reset_format_booleans;
								set_order_same_as_text;
								initialize_view_ids;
								if generate_all then
									process_clusters;
								else
									process_specific_clusters
								end
								Reverse_engineering_window.put_start_reverse_engineering (System.classes.count);
								convert_to_case_format;
								remove_old_classes;
								clear_shared_case_information;
								output_window.put_string ("Finished storing EiffelCase project.");
							else
								output_window.put_string ("EiffelCase project is up to date.");
							end;
							output_window.new_line;
						end;
						output_window.display
					else
						output_window.put_string ("Project is in an unstable state.");
						output_window.new_line;
						output_window.put_string ("Make sure that the system has been");
						output_window.new_line;
						output_window.put_string ("successfully compiled.");
						output_window.new_line;
						output_window.display
					end;
				end
			else
				rescued := False;
				output_window.display
			end;
			if Workbench.system_defined then	
				System.set_current_class (prev_class);
				Inst_context.set_cluster (prev_cluster);
			end
		rescue
			Case_file_server.remove_tmp_files;
			clear_shared_case_information;
			Reverse_engineering_window.finish_degree_output;
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end;
		end

feature -- Update

	set_list_clusters (l: LINKED_LIST [CLUSTER_I]) is
		do
			!! list_clusters.make_filled (l.count)
			from 
				l.start
			until 
				l.after
			loop
				list_clusters.extend (l.item)
				l.forth
			end
		end

feature {NONE} -- Implementation

	convert_to_case_format is	
			-- Convert all the Eiffelbench structures into
			-- Eiffelcase structures.
		require
			valid_cluster_info: root_cluster_info /= Void
		local
			root_cluster: S_CLUSTER_DATA;
			s_system_data: S_SYSTEM_DATA;
			view_id: INTEGER
		do
			Case_file_server.init (Case_storage_path);
			root_cluster := root_cluster_info.storage_info (Reverse_engineering_window);
			!! s_system_data;
			s_system_data.set_root_cluster (root_cluster);
			s_system_data.set_class_view_number (Old_case_info.class_view_number);
			s_system_data.set_class_id_number (System.class_counter.total_count);
			s_system_data.set_cluster_view_number (Old_case_info.cluster_view_number);
			Case_file_server.tmp_save_system (s_system_data);
			Reverse_engineering_window.put_case_message 
				("Saving EiffelCase project to CASEGEN directory.");
			Case_file_server.save_eiffelcase_format;
			Reverse_engineering_window.put_case_message 
				("Updating EiffelBench project.");
			update_eiffel_project;
			Reverse_engineering_window.finish_degree_output
		rescue
			if Case_file_server.had_io_problems then
				output_window.put_string ("Cannot store EiffelCase format to CASEGEN directory.");
			elseif Case_file_server.is_saving then
				output_window.put_string ("EiffelCase format maybe corrupted.");
			end;
			output_window.new_line
		end;

	remove_old_classes is
			-- Remove class information from disk which have been
			-- removed since last reverse engineering.
		do
			Old_case_info.remove_old_classes;
		rescue
			output_window.put_string ("Error: Could not remove old classes from CASEGEN directory.");
			output_window.new_line
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
			other_cluster_info: like root_cluster_info;
			parent_cluster_info: like root_cluster_info;
			s_name: STRING;
			root_file_name, file_name: STRING;
			full_path: DIRECTORY_NAME
		do
			Reverse_engineering_window.put_case_message ("Reverse engineering project.");
			!! root_cluster_info.make;
				-- Need to covert to a string since
				-- the dynamic type of cluster name
				-- in cluster_i is ID_SD.
			!! s_name.make (0);
			s_name.append (System.system_name);
			s_name.to_upper;
			root_cluster_info.set_name (s_name);
			!! root_file_name.make (s_name.count);
			root_file_name.append (s_name);
			root_file_name.to_lower;
			root_cluster_info.set_file_name (root_file_name);

			create_cluster_hierarchy (root_cluster_info, Eiffel_system.sub_clusters);	
		end;

	process_specific_clusters is
		local
			list: SORTED_TWO_WAY_LIST [CLUSTER_I];
			cluster_names_list: LINKED_LIST [STRING];
			other_cluster_info: like root_cluster_info;
			parent_cluster_info: like root_cluster_info;
			s_name: STRING;
			root_file_name, file_name: STRING;
			full_path: DIRECTORY_NAME
		do
			!! root_cluster_info.make;
			-- Need to covert to a string since
			-- the dynamic type of cluster name
			-- in cluster_i is ID_SD.
			!! s_name.make (0);
			s_name.append (System.system_name);
			s_name.to_upper;
			root_cluster_info.set_name (s_name);
			!! root_file_name.make (s_name.count);
			root_file_name.append (s_name);
			root_file_name.to_lower;
			root_cluster_info.set_file_name (root_file_name);
			create_cluster_hierarchy (root_cluster_info, list_clusters);
		end

	create_cluster_hierarchy (a_parent_info: CASE_CLUSTER_INFO;
				sub_clusters: ARRAYED_LIST [CLUSTER_i]) is
			-- Create the cluster hierarchy for processing EiffelCase
			-- structures.
		local
			other_cluster_info: CASE_CLUSTER_INFO;
			cluster_i: CLUSTER_I;
			paths: LINKED_LIST [STRING]
		do
			from
				sub_clusters.start
			until
				sub_clusters.after
			loop
				cluster_i := sub_clusters.item;
				if cluster_i /= Void then
					paths := extract_directories (cluster_i.path);
					!! other_cluster_info.make;
					other_cluster_info.set_file_name (paths.last);
					other_cluster_info.set_cluster_i (cluster_i);
					a_parent_info.add_cluster (other_cluster_info);
					create_cluster_hierarchy (other_cluster_info, 
					cluster_i.sub_clusters);
				end
				sub_clusters.forth
			end;
		end;

feature {NONE} -- Implementation

	root_cluster_info: CASE_CLUSTER_INFO;
			-- Case cluster info for root cluster of system

	extract_directories (path: STRING): LINKED_LIST [STRING] is
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
		ensure
			valid_result: Result /= Void and then not Result.empty
		end;

	need_to_reverse_engineer: BOOLEAN is
			-- Do we need to reverse engineer?
		local
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER
			c: CLASS_C;
		do
			classes := System.classes;
			from
				classes.start
			until
				classes.after or else Result
			loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
				from
					i := 1
				until
					i > nb or Result
				loop
					c := class_array.item (i)
					if c /= Void then
						Result := not c.reverse_engineered;
					end
					i := i + 1
				end
				classes.forth
			end;
		end;

	update_eiffel_project is
			-- Mark the classes in the EiffelProject as
			-- reversed engineered and save the 
			-- project.
		local
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
			c: CLASS_C;
			need_to_save: BOOLEAN
		do
			classes := System.classes;
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					c := class_array.item (i)
					if c /= Void then
						need_to_save := True;
						c.set_reverse_engineered (True);
					end
					i := i + 1
				end
				classes.forth
			end;
			if need_to_save then
				Eiffel_project.save_project
			end
		end;

invariant

	valid_output_window: output_window /= Void

end	
