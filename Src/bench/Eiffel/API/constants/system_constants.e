class SYSTEM_CONSTANTS

feature {NONE}

	Continuation: CHARACTER is '\'

	Comp: STRING is "COMP"

	Copy_cmd: STRING is "cp"

	Default_Ace_file: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (0);
			Result.append_character (c);
			Result.append ("bench");
			Result.append_character (c);
			Result.append ("help");
			Result.append_character (c);
			Result.append ("defaults");
			Result.append_character (c);
			Result.append ("Ace.default");
		end;

	Default_precompiled_location: STRING is
		local
			c: CHARACTER
		once
			c := Directory_separator;
			!!Result.make (0);
			Result.append ("$EIFFEL3");
			Result.append_character (c);
			Result.append ("precompiled");
			Result.append_character (c);
			Result.append ("spec");
			Result.append_character (c);
			Result.append ("$PLATFORM");
			Result.append_character (c);
			Result.append ("base.batch");
		end;

	Descriptor_suffix: STRING is "D"

	Directory_separator: CHARACTER is
		once
			Result := c_dir_separator
		end

	Dot: CHARACTER is '.'

	Dot_c: STRING is ".c"

	Dot_e: STRING is ".e"

	Dot_h: STRING is ".h"

	Dot_o: STRING is ".o"

	Dot_workbench: STRING is ".workbench"

	Dot_x: STRING is ".x"

	Driver: STRING is "driver"

	Eattr: STRING is "Eattr"

	Ecall: STRING is "Ecall"

	Econform: STRING is "Econform"

	Edispatch: STRING is "Edisptch"

	Efrozen: STRING is "Efrozen"

	Ehisto: STRING is "Ehisto"

	Eiffelgen: STRING is "EIFFELGEN"

	Eiffel_suffix: CHARACTER is 'e'

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

	Executable_suffix: STRING is ""

	F_code: STRING is "F_code"

	Finish_freezing_script: STRING is "finish_freezing"

	Feature_table_suffix: STRING is "F"

	Makefile_SH: STRING is "Makefile.SH"

	Prelink_script: STRING is "prelink"

	Preobj: STRING is "preobj.o"

	Updt: STRING is ".UPDT"

	Version_number: STRING is "3.2.4"

	W_code: STRING is "W_code"

feature {NONE}

	Max_non_encrypted: INTEGER is 3
		-- Maximum number of non encrypted characters during
		-- code generation
		--| The class FEATURE_I will be generated in the file 'feature<n>.c'

feature {NONE} -- Externals

	c_dir_separator: CHARACTER is
		external
			"C"
		alias
			"eif_dir_separator"
		end;

end

