indexing

	description: 
		"System level constants.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_CONSTANTS

inherit
	SHARED_PLATFORM_CONSTANTS

feature {NONE}

	Backup: STRING is "BACKUP";

	Backup_info: STRING is "Info";

	Casegen: STRING is "CASEGEN";

	Case_storage: STRING is "Storage";

	Class_suffix: STRING is "C";

	Continuation: CHARACTER is '\'

	Comp: STRING is "COMP"

	Copy_cmd: STRING is
		once
			Result := Platform_constants.Copy_cmd
		end;

	Default_Ace_file: STRING is "default.ace";

	Default_Class_filename: STRING is "default.cls";

	Descriptor_file_suffix: CHARACTER is 'd'

	Descriptor_suffix: STRING is "D"

	Directory_separator: CHARACTER is
		once
			Result := Operating_environment.Directory_separator
		end

	Documentation: STRING is "Documentation"

	Dot: CHARACTER is '.'

	Dot_c: STRING is ".c"

	Dot_cpp: STRING is ".cpp"

	Dot_e: STRING is
		once
			Result := Platform_constants.Dot_e
		end;

	Dot_h: STRING is ".h"

	Dot_o: STRING is
		once
			Result := Platform_constants.Dot_o
		end;

	Dot_workbench: STRING is "precomp.epr"

	Dot_x: STRING is ".x"

	Dot_xpp: STRING is ".xpp"

	Dot_profile_information: STRING is "pfi"

	Driver: STRING is
		once
			Result := Platform_constants.Driver
		end;

	Eattr: STRING is "eattr"

	Ecall: STRING is "ecall"

	Ececil: STRING is "ececil"

	Econform: STRING is "econform"

	Edescriptor: STRING is "edesc"

	Edispatch: STRING is "edisptch"

	Edle: STRING is "edle"

	Efrozen: STRING is "efrozen"

	Ehisto: STRING is "ehisto"

	Eiffelgen: STRING is "EIFGEN"

	Einit: STRING is "einit"

	Emain: STRING is "emain"

	Eoption: STRING is "eoption"

	Epattern: STRING is "epattern"

	Eplug: STRING is "eplug"

	Eref: STRING is "eref"

	Erout: STRING is "erout"

	Esize: STRING is "esize"

	Eskelet: STRING is "eskelet"

	Evisib: STRING is "evisib"

	Executable_suffix: STRING is
		once
			Result := Platform_constants.Executable_suffix
		end;

	F_code: STRING is "F_code"

	Finish_freezing_script: STRING is
		once
			Result := Platform_constants.Finish_freezing_script
		end;

	Feature_table_file_suffix: CHARACTER is 'f'

	Feature_table_suffix: STRING is "F"

	Makefile_SH: STRING is "Makefile.SH"

	updt_dle: STRING is "melted.dle";

	Precomp_eif: STRING is "precomp.eif"

	Prelink_script: STRING is "prelink"

	Preobj: STRING is
		once
			Result := Platform_constants.Preobj
		end

	Profiler: STRING is "Profiler"

	Removed_log_file_name: STRING is "REMOVED";

	Static_log_file_name: STRING is "STATIC";

	System_object_prefix: STRING is "E";

	Translation_log_file_name: STRING is "TRANSLAT";

	Updt: STRING is "melted.eif"

	W_code: STRING is "W_code"

	project_extension: STRING is ".epr"

	info_flag_begin: STRING is "-- System name is "

	info_flag_end: STRING is "-- end of info"

feature {NONE} -- Versioning

	Precompilation_id_tag: STRING is "precompilation_id"
	Version_number: STRING is "4.3 F"
	Version_number_tag: STRING is "version_number"
	Storable_version_number: STRING is "4.3 F"
	Storable_version_number_tag: STRING is "storable_version_number"

feature {NONE}

	Max_non_encrypted: INTEGER is 2
		-- Maximum number of non encrypted characters during
		-- code generation
		--| The class FEATURE_I will be generated in the file 'fe<n>.c'

end -- class SYSTEM_CONSTANTS
