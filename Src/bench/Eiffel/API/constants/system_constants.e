indexing
	description: "System level constants.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_CONSTANTS

inherit
	SHARED_PLATFORM_CONSTANTS

	PRODUCT_NAMES

feature {NONE}

	Additional_args: STRING is "arguments.wb"

	Backup: STRING is "BACKUP"

	Backup_info: STRING is "compilation_info.txt"

	Studio_directory_list: STRING is "DIRECTORYLIST"

	Studio_recent_files: STRING is "STUDIO_RECENT_FILES"

	Casegen: STRING is "CASEGEN"

	Case_storage: STRING is "Storage"

	C_prefix: CHARACTER is 'C'
			-- Prefix for C generated directories and object files

	System_object_prefix: CHARACTER is 'E'

	Continuation: CHARACTER is '\'

	Comp: STRING is "COMP"

	Default_ace_file: STRING is "default.ace"

	Default_class_filename: STRING is "default.cls"

	Descriptor_file_suffix: CHARACTER is 'd'

	Documentation: STRING is "Documentation"

	Dot: CHARACTER is '.'

	Dot_c: STRING is ".c"

	Dot_cpp: STRING is ".cpp"

	Dot_h: STRING is ".h"

	Dot_workbench: STRING is "precomp.epr"

	Dot_x: STRING is ".x"

	Dot_xpp: STRING is ".xpp"

	Dot_profile_information: STRING is "pfi"

	Eac_browser_file: STRING is "eac_browser.exe"

	Epoly: STRING is "epoly"

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

	Eparents: STRING is "eparents"

	Epattern: STRING is "epattern"

	Eplug: STRING is "eplug"

	Eref: STRING is "eref"

	Esize: STRING is "esize"

	Eskelet: STRING is "eskelet"

	Evisib: STRING is "evisib"

	F_code: STRING is "F_code"

	Feature_table_file_suffix: CHARACTER is 'f'

	Makefile_sh: STRING is "Makefile.SH"

	updt_dle: STRING is "melted.dle";

	Precomp_eif: STRING is "precomp.eif"

	Prelink_script: STRING is "prelink"

	Profiler: STRING is "Profiler"

	Removed_log_file_name: STRING is "REMOVED";

	Static_log_file_name: STRING is "STATIC";

	Translation_log_file_name: STRING is "TRANSLAT";

	Updt: STRING is "melted.eif"

	Finished_file_for_make: STRING is "finished"

	Local_assemblies: STRING is "Assemblies"

	W_code: STRING is "W_code"

	project_extension: STRING is "epr"

	Debug_info_extension: STRING is "edb"
			-- Eiffel Debug Breakpoints file (extension)

	Debug_info_name: STRING is "options"
			-- Eiffel Debug Breakpoints file (core name)	

	Il_info_extension: STRING is "edi"
			-- Eiffel Debug Info file (extension)
			-- Used for IL code generation

	Il_info_name: STRING is "il_info"
			-- Eiffel Debug Info file (core name)
			-- Used for IL code generation

	info_flag_begin: STRING is "-- System name is "

	info_flag_end: STRING is "-- end of info"

feature {NONE, AUXILIARY_FILES} -- Versioning

	Precompilation_id_tag: STRING is "precompilation_id"
	Version_number_tag: STRING is "version_number"
	Ace_file_path_tag: STRING is "ace_file_path"
			-- Tags used in project file header.

	Major_version_number: INTEGER is 5
	Minor_version_number: INTEGER is 4
			-- Version number

	Version_number: STRING is
			-- Version number composed of
			-- `Major_version_number' . `Minor_version_number' . `Build_version_number'.
		once
			create Result.make (10)
			Result.append_integer (Major_version_number)
			Result.append_character ('.')
			Result.append_integer (Minor_version_number)
			Result.append_character ('.')
			Result.append_string ("0901")
			Result.append_character (' ')
			Result.append_string (version_type_name)
		end

	Version_tag: INTEGER is 0x00000026

	Version_type_name: STRING is "Enterprise Edition"
			-- Name of version, e.g. Free edition, Enterprise Edition,...
			-- Default: "Enterprise Edition"
		
end -- class SYSTEM_CONSTANTS
