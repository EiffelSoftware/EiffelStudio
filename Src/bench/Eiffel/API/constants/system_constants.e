class SYSTEM_CONSTANTS

feature {NONE}

	Continuation: CHARACTER is '\'

	Comp: STRING is "COMP"

	Copy_cmd: STRING is
		once
			Result := Platform_constants.Copy_cmd
		end;

	Default_Ace_file: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (0);
			Result.extend (c);
			Result.append ("bench");
			Result.extend (c);
			Result.append ("help");
			Result.extend (c);
			Result.append ("defaults");
			Result.extend (c);
			Result.append (Platform_constants.Default_ace_name);
		end;

	Default_precompiled_location: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (0);
			Result.append ("$EIFFEL3");
			Result.extend (c);
			Result.append (Platform_constants.precompiled_directory);
			Result.extend (c);
			Result.append ("spec");
			Result.extend (c);
			Result.append ("$PLATFORM");
			Result.extend (c);
			Result.append ("base");
		end;

	Descriptor_suffix: STRING is "D"

	Directory_separator: CHARACTER is
		once
			Result := c_dir_separator
		end

	Dot: CHARACTER is '.'

	Dot_c: STRING is ".c"

	Dot_e: STRING is
		once
			Result := Platform_constants.Dot_e
		end;

	Dot_h: STRING is ".h"

	Dot_o: STRING is
		once
			Result := Platform_constants.Dot_o
		end;

	Dot_workbench: STRING is
		once
			Result := Platform_constants.Dot_workbench
		end;

	Dot_x: STRING is ".x"

	Driver: STRING is
		once
			Result := Platform_constants.Driver
		end;

	Eattr: STRING is "Eattr"

	Ecall: STRING is "Ecall"

	Econform: STRING is "Econform"

	Edispatch: STRING is "Edisptch"

	Efrozen: STRING is "Efrozen"

	Ehisto: STRING is "Ehisto"

	Eiffelgen: STRING is
		once
			Result := Platform_constants.Eiffelgen
		end;

	Eiffel_suffix: CHARACTER is
		once
			Result := Platform_constants.Eiffel_suffix
		end;

	Einit: STRING is "Einit"

	Emain: STRING is "Emain"

	Eoption: STRING is "Eoption"

	Epattern: STRING is "Epattern"

	Eplug: STRING is "Eplug"

	Eref: STRING is "Eref"

	Erout: STRING is "Erout"

	Esize: STRING is "Esize"

	Eskelet: STRING is "Eskelet"

	Evisib: STRING is "Evisib"

	Executable_suffix: STRING is
		once
			Result := Platform_constants.Executable_suffix
		end;

	F_code: STRING is "F_code"

	Finish_freezing_script: STRING is "finish_freezing"

	Feature_table_suffix: STRING is "F"

	Makefile_SH: STRING is "Makefile.SH"

	Prelink_script: STRING is "prelink"

	Preobj: STRING is
		once
			Result := Platform_constants.Preobj
		end;

	Updt: STRING is
		once
			Result := Platform_constants.Updt
		end;

	Version_number: STRING is "3.2.4"

	W_code: STRING is "W_code"

feature {NONE}

	Max_non_encrypted: INTEGER is 3
		-- Maximum number of non encrypted characters during
		-- code generation
		--| The class FEATURE_I will be generated in the file 'feature<n>.c'

feature {NONE}

	Platform_constants: PLATFORM_CONSTANTS is
		once
			!!Result
		end;

feature {NONE} -- Externals

	c_dir_separator: CHARACTER is
		external
			"C"
		alias
			"eif_dir_separator"
		end;

end

