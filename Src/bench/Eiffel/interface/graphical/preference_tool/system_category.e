indexing

	description:
		"Resources valid for the total application.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_CATEGORY

inherit
	RESOURCE_NAMES
	RESOURCE_CATEGORY

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			!! users.make;
			!! modified_resources.make
		end

feature {RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all rsources valid for Current.
		do
			!! automatic_backup.make (r_AutomaticBackup,
					rt.get_boolean (r_AutomaticBackup, False));
			!! temporary_dir.make (r_Tmp_directory,
					rt.get_string (r_Tmp_directory, "/tmp"));
			!! profiler_dir.make (r_Profiler_path,
					rt.get_string (r_Profiler_path, "$EIFFEL3/bench/profiler"));
			!! filter_dir.make (r_Filter_path,
					rt.get_string (r_Filter_path, "$EIFFEL3/bench/filters"));
			!! history_size.make (r_History_size,
					rt.get_integer (r_History_size, 10))
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Access

	linear_representation: LINKED_LIST [RESOURCE] is
			-- All resources within Current
		do
			!! Result.make;
			Result.extend (temporary_dir);
			Result.extend (profiler_dir);
			Result.extend (filter_dir);
			Result.extend (history_size)
		end

feature -- Resources

	automatic_backup: BOOLEAN_RESOURCE;
	temporary_dir: STRING_RESOURCE;
	profiler_dir: STRING_RESOURCE;
	filter_dir: STRING_RESOURCE;
	history_size: INTEGER_RESOURCE

end -- class SYSTEM_CATEGORY
