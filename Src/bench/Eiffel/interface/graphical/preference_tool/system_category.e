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
			!! default_window_position.make ("default_window_position", 
					rt.get_boolean ("default_window_position", False));
			!! parse_class_after_saving.make ("parse_class_after_saving", 
					rt.get_boolean ("parse_class_after_saving", True));
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

feature -- Resources

	parse_class_after_saving: BOOLEAN_RESOURCE;
	default_window_position: BOOLEAN_RESOURCE;
	automatic_backup: BOOLEAN_RESOURCE;
	temporary_dir: STRING_RESOURCE;
	profiler_dir: STRING_RESOURCE;
	filter_dir: STRING_RESOURCE;
	history_size: INTEGER_RESOURCE

end -- class SYSTEM_CATEGORY
