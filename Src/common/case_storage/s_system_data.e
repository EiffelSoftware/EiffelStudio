class S_SYSTEM_DATA

inherit

	STORABLE;
	S_CASE_INFO

feature

	root_cluster: S_CLUSTER_DATA;
		-- Cluster root containing all system
		-- entities (classes and clusters).

	class_id_number: INTEGER;
			-- Last number use for default class name

	class_view_number: INTEGER;
			-- Last number use for views

	cluster_view_number: INTEGER;
			-- Last number use for default cluster name

	was_generated_from_bench: BOOLEAN;
			-- Was Current generated from bench?

feature -- Setting values

	set_was_generated_from_bench is
			-- Set was_generated_from_bench to True.
		do
			was_generated_from_bench := True;
		ensure
			was_generated_from_bench: was_generated_from_bench
		end;

	set_class_id_number (value: like class_id_number) is
			-- Set class_id_number to `value'.
		require
			valid_value: value >= 0
		do
			class_id_number := value
		ensure
			value_set: class_id_number = value
		end;

	set_class_view_number (value: like class_view_number) is
			-- Set class_view_number to `value'.
		require
			valid_value: value >= 0
		do
			class_view_number := value
		ensure
			value_set: class_view_number = value
		end;

	set_cluster_view_number (value: like cluster_view_number) is
			-- Set cluster_view_number to `value'.
		require
			valid_value: value <= 0
		do
			cluster_view_number := value
		ensure
			value_set: cluster_view_number = value
		end;

	set_root_cluster (cluster: like root_cluster) is
			-- Set root_cluster to `cluster'.
		require
			not_void_cluster: cluster /= Void;
		do
			root_cluster := cluster
		ensure
			root_cluster_set: root_cluster = cluster;
		end;

feature -- Storing

	 store_to_disk (path: STRING) is
			-- Store a project
		require
			valid_path: path /= Void;
		local
			id_file_name, file_name: STRING;
			id_file: PLAIN_TEXT_FILE;
			system_file: RAW_FILE;
		do
			id_file_name := clone (path);
			id_file_name.extend (Operating_environment.directory_separator);
			id_file_name.append (System_id_name);
			!!id_file.make_open_write (id_file_name);
			id_file.putstring (EiffelCase_project_type);
			id_file.close;
			file_name := clone (path);
			file_name.extend (Operating_environment.directory_separator);
			file_name.append (System_name);
			!! system_file.make_open_write (file_name);
			independent_store (system_file);
			system_file.close;
		end;


end
