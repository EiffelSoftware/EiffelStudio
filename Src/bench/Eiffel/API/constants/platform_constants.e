indexing

	description: 
		"Platform specific constants.";
	date: "$Date$";
	revision: "$Revision $"

class PLATFORM_CONSTANTS

inherit

	OPERATING_ENVIRONMENT

feature -- Externals

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

end -- class PLATFORM_CONSTANTS
