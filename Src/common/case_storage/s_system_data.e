indexing

	description: 
		"Data describing the whole system for a given project.";
	date: "$Date$";
	revision: "$Revision $"

class S_SYSTEM_DATA

inherit

	STORABLE;
	S_CASE_INFO

feature -- Properties

	hyper_system_classes : HASH_TABLE [ STRING, INTEGER ]
		-- All the names of classes of the initial system that contained
		-- the current system; it avoids loss of information during the
		-- retrieving phase ...


	root_cluster: S_CLUSTER_DATA;
			-- Cluster root containing all system
			-- entities (classes and clusters).

	class_id_number: INTEGER;
			-- Last number use for default class name

	class_view_number: INTEGER;
			-- Last number use for views

	cluster_view_number: INTEGER;
			-- Last number use for default cluster name

feature -- Setting 

	set_hyper ( arg : HASH_TABLE [ STRING, INTEGER ] ) is
		do
			hyper_system_classes := arg
		end

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

	save_information (path: STRING) is
			-- Save Current.
			--| (Rename tmp file to normal file name);
		require
			valid_path: path /= Void;
		local
			system_file: RAW_FILE;
			old_name, new_name: FILE_NAME;
		do
			!!new_name.make_from_string (path);
			new_name.set_file_name (System_name);

			!!old_name.make_from_string (path);
			old_name.set_file_name (System_name);
			old_name.add_extension (Tmp_file_name_ext);

			!! system_file.make (old_name);
			system_file.change_name (new_name);
		end;
	
	tmp_store_to_disk (path: STRING) is
			-- Store a project temporarily
		require
			valid_path: path /= Void;
		local
			id_file_name, file_name: FILE_NAME;
			id_file: PLAIN_TEXT_FILE;
			system_file: RAW_FILE;
		do
			!!id_file_name.make_from_string (path);
			id_file_name.set_file_name (System_id_name);
			!!id_file.make_open_write (id_file_name);
			id_file.putstring (EiffelCase_project_type);
			id_file.close;
			!!file_name.make_from_string (path);
			file_name.set_file_name (System_name);
			file_name.add_extension (Tmp_file_name_ext);
			!! system_file.make_open_write (file_name);
			independent_store (system_file);
			system_file.close;
		end;

end -- class S_SYSTEM_DATA
