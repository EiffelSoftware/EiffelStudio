class SYSTEM_CONSTANTS

feature {NONE}

	Comp: STRING is "COMP"

	Default_precompiled_location: STRING is "$EIFFEL3/precompiled/spec/$PLATFORM/base"

	Descriptor_suffix: STRING is "D"

	Directory_separator: CHARACTER is '/';

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

	Edispatch: STRING is "Edispatch"

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

	F_code: STRING is "F_code"

	Feature_table_suffix: STRING is "F"

	Makefile_SH: STRING is "Makefile.SH"

	Preobj: STRING is "preobj.o"

	Updt: STRING is ".UPDT"

	Version_number: STRING is "3.2.3b"

	W_code: STRING is "W_code"

feature {NONE}

	Max_non_encrypted: INTEGER is 7
		-- Maximum number of non encrypted characters during
		-- code generation
		--| The class FEATURE_I will be generated in the file 'feature<n>.c'

end

