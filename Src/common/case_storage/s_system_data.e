class S_SYSTEM_DATA

inherit

	STORABLE

creation

	make

feature {NONE}

	make (s: STRING) is
			-- Set project_file_name to `s'.
		require
			valid_s: s /= Void
		do
			project_file_name := s
		ensure
			name_set: project_file_name = s
		end;

feature

	cluster_root: S_CLUSTER_DATA;
		-- Cluster root containing all system
		-- entities (classes and clusters).

	project_file_name: STRING;
			-- Name of current project

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

	set_cluster_root (cluster: like cluster_root) is
			-- Set cluster_root to `cluster'.
		require
			not_void_cluster: cluster /= Void;
		do
			cluster_root := cluster
		ensure
			cluster_root_set: cluster_root = cluster;
		end;

feature -- Storing

	 store_to_disk (path: STRING) is
			-- Store a project
		require
			valid_path: path /= Void;
			--slash_at_end: path requires slash at end
		local
			id_file_name, system_file_name: STRING;
			id_file: UNIX_FILE;
			system_file: RAW_FILE;
		do
			id_file_name := clone (path);
			id_file_name.append (".idfile");
			!!id_file.make (id_file_name);
			id_file.open_write;
			id_file.putstring ("ISE.EiffelCase");
			id_file.close;
			system_file_name := clone (path);
			system_file_name.append ("system_file");
			!! system_file.make (system_file_name);
			system_file.open_write;
			independent_store (system_file);
			system_file.close;
		rescue
			if not system_file.is_closed then
				system_file.close;
			end;
		end;


end
