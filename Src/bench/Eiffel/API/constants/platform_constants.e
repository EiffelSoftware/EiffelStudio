indexing

	description: 
		"Platform specific constants.";
	date: "$Date$";
	revision: "$Revision $"

class PLATFORM_CONSTANTS

inherit

	OPERATING_ENVIRONMENT

feature -- Access

	Dot_e: STRING is external "C" alias "eif_dot_e" end;

	Dot_o: STRING is external "C" alias "eif_dot_o" end;

	Driver: STRING is external "C" alias "eif_driver" end;

	Executable_suffix: STRING is external "C" alias "eif_exec_suffix" end;

	Finish_freezing_script: STRING is 
		external 
			"C" 
		alias 
			"eif_finish_freezing" 
		end;

	Preobj: STRING is external "C" alias "eif_preobj" end;

	Copy_cmd: STRING is external "C" alias "eif_copy_cmd" end;

	is_os2: BOOLEAN is
			-- Is the platform OS/2?
		external
			"C"
		alias
			"eif_is_os2"
		end

	is_unix: BOOLEAN is
			-- Is it a Unix platform?
		once
			Result := not (
				is_os2 or is_vms or is_windows
				)
		end

	is_vms: BOOLEAN is
			-- Is the platform VMS?
		external
			"C"
		alias
			"eif_is_vms"
		end

	is_windows: BOOLEAN is
			-- Is the platform a windows platform?
		external
			"C"
		alias
			"eif_is_windows"
		end

	is_win32: BOOLEAN is
			-- Is the platform Windows 95/NT
		external
			"C"
		alias
			"eif_is_win32"
		end

	is_windows_3_1: BOOLEAN is
			-- Is the platform Windows 3.1?
		external
			"C"
		alias
			"eif_is_windows_3_1"
		end

end -- class PLATFORM_CONSTANTS
