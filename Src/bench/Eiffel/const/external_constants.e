-- Constants for special external routines handling

class
	EXTERNAL_CONSTANTS

feature -- String constants

	macro_string: STRING is "macro"

	struct_string: STRING is "struct"

	dll32_string: STRING is "dll32"

	dllwin32_string: STRING is "dllwin32"

feature -- Integer constants

	macro_type: INTEGER is 1

	dll32_type: INTEGER is 3

	dllwin32_type: INTEGER is 4

end -- EXTERNAL_CONSTANTS

