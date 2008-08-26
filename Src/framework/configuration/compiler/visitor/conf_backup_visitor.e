indexing
	description: "Visitor that adapts a configuration so that it accesses the information from the backup directory."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_BACKUP_VISITOR

inherit
	CONF_ITERATOR
		redefine
			process_cluster,
			process_override,
			process_library,
			process_precompile,
			process_assembly
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

	CONF_ACCESS

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

feature -- Access

	backup_directory: DIRECTORY_NAME
			-- Location of the backup.

feature -- Update

	set_backup_directory (a_dir: like backup_directory) is
			-- Set `backup_directory' to `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
		do
			backup_directory := a_dir
		ensure
			backup_directory_set: backup_directory = a_dir
		end

feature -- Visit nodes

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		local
			l_loc: CONF_DIRECTORY_LOCATION
			l_dir: KL_DIRECTORY
			l_path: STRING
		do
			create l_loc.make (a_cluster.name, a_cluster.target)
			a_cluster.set_location (l_loc)
			l_path := l_loc.evaluated_path
			check
				l_path_not_empty: not l_path.is_empty
			end
			if {PLATFORM}.is_windows and then l_path.item (l_path.count) = '\' then
					-- Special handling on windows where a path terminating with a directory separator
					-- sign would be declared to not exist even if it really exists.
				l_path := l_path.twin
				l_path.remove_tail (1)
			end
			create l_dir.make (l_path)
			l_dir.recursive_create_directory
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		do
			process_cluster (an_override)
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		local
			l_loc: CONF_FILE_LOCATION
			l_load: CONF_LOAD
			l_fact: CONF_FACTORY
		do
			create l_fact
			create l_load.make (l_fact)
			l_load.retrieve_uuid (a_library.location.evaluated_path)
			if not l_load.is_error then
				create l_loc.make ("..\"+l_load.last_uuid.out+"\"+backup_adapted_config_file, a_library.target)
				a_library.set_location (l_loc)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
			process_library (a_precompile)
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		local
			l_as, l_new_as: STRING
			l_loc: CONF_FILE_LOCATION
			l_file: FILE_NAME
		do
			l_as := an_assembly.location.evaluated_path
			if not l_as.is_empty then
				l_new_as := an_assembly.location.evaluated_file
				create l_loc.make ("..\"+l_new_as, an_assembly.target)
				an_assembly.set_location (l_loc)
				create l_file.make_from_string (backup_directory)
				l_file.set_file_name (l_new_as)
					-- copy assembly
				file_system.copy_file (l_as, l_file)
			end
		end
end
