class S_SYSTEM_DATA

inherit

	STORABLE;
	S_CASE_INFO

feature

	root_cluster: S_CLUSTER_DATA;
		-- Cluster root containing all system
		-- entities (classes and clusters).

	is_grid_visible: BOOLEAN;
			-- Is grid visible in a graphical representation on screen ?

	is_grid_magnetic: BOOLEAN;
			-- Do entities glu to the grid as if it was magnetic ?

	grid_spacing: INTEGER;
			-- Size of a grid square

	class_number: INTEGER;
			-- Last number use for default class name

	cluster_number: INTEGER;
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

	set_grid_details (is_vis, is_mag: BOOLEAN; spacing: INTEGER) is
			-- Set is_grid_visible to `is_vis', 
			-- set is_grid_magnetic to `is_mag' and
			-- set grid_spacing to `spacing'.
		require
			valid_spacing: spacing >= 0
		do
			is_grid_visible := is_vis;
			is_grid_magnetic := is_mag;
			grid_spacing := spacing
		ensure
			grid_values_set: is_grid_visible = is_vis and then
								is_grid_magnetic = is_mag and then
								grid_spacing = spacing
		end;

	set_class_number (value: like class_number) is
			-- Set class_number to `value'.
		require
			valid_value: value >= 0
		do
			class_number := value
		ensure
			value_set: class_number = value
		end;

	set_cluster_number (value: like cluster_number) is
			-- Set cluster_number to `value'.
		require
			valid_value: value >= 0
		do
			cluster_number := value
		ensure
			value_set: cluster_number = value
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
			--slash_at_end: path requires slash at end
		local
			id_file_name, file_name: STRING;
			id_file: PLAIN_TEXT_FILE;
			system_file: RAW_FILE;
		do
			id_file_name := clone (path);
			id_file_name.append (System_id_name);
			!!id_file.make (id_file_name);
			id_file.open_write;
			id_file.putstring (EiffelBench_project_type);
			id_file.close;
			file_name := clone (path);
			file_name.append (System_name);
			!! system_file.make (file_name);
			system_file.open_write;
			independent_store (system_file);
			system_file.close;
		rescue
			if not system_file.is_closed then
				system_file.close;
			end;
		end;


end
