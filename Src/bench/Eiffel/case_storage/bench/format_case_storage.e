-- Format context for Case storage
class FORMAT_CASE_STORAGE

inherit

	SHARED_WORKBENCH;
	SYSTEM_CONSTANTS;
	WINDOWS;
	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS
	SPECIAL_AST

feature

	rescued: BOOLEAN;

	execute is
			-- Format storage structures
			-- so it can be read in from EiffelCase.
		do
			if not rescued then
				is_short_bool.set_value (False);
				in_bench_mode_bool.set_value (False);
				in_assertion_bool.set_value (False);
				order_same_as_text_bool.set_value (True);
				process_clusters;
				convert_to_case_format;
			else
				rescued := False
			end
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				Error_handler.trace;
				rescued := True;
				retry
			end
		end

feature {NONE}

	convert_to_case_format is	
			-- Convert all the Eiffelbench structures into
			-- Eiffelcase structures.
		require
			valid_cluster_info: cluster_info /= Void
		local
			cluster_root: S_CLUSTER_DATA;
			system_data: S_SYSTEM_DATA;
			storer: S_STORER;
		do
			cluster_root := cluster_info.storage_info;
			!! system_data.make ("toto");
			system_data.set_cluster_root (cluster_root);
			system_data.set_was_generated_from_bench;
			system_data.set_grid_details (False, False, 20);
			system_data.set_class_number (System.class_counter.value);
			system_data.set_cluster_number (Universe.clusters.count);	
			io.error.putstring ("Storing information to disk ...%N");

			store_project_to_disk (system_data);
		end;

	store_project_to_disk (system_data: S_SYSTEM_DATA) is	
			-- Store project `system_data' to disk.
		local
			storer: S_STORER;
		do
			if not rescued then
				!! storer.make ("/tmp/toto");
				storer.execute (system_data);
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
		do
			io.error.putstring ("Processing clusters%N");
			!! cluster_info.make;
			cluster_info.set_name (System.system_name);
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
						other_cluster_info.set_name (cluster_names_list.item);
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

end	
