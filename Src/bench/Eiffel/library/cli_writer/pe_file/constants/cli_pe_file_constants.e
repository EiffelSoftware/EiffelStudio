indexing
	description: "PE File characteristics constants"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PE_FILE_CONSTANTS
	
feature -- PE header constants

	image_file_dll: INTEGER_16 is 0x2000
			-- File is DLL.

	image_file_32bit_machine: INTEGER_16 is 0x0100
			-- 32 bit word machine.

	image_file_executable_image: INTEGER_16 is 0x0002
			-- File is executable (i.e. no unresolved external references).

	image_file_line_nums_stripped: INTEGER_16 is 0x0004
			-- Line numbers stripped from file.

	image_file_local_syms_stripped: INTEGER_16 is 0x0008
			-- Local symboles stripped from file.

feature -- PE optional header constants

	image_subsystem_windows_gui: INTEGER_16 is 2
			-- Graphical application.

	image_subsystem_windows_console: INTEGER_16 is 3
			-- Console application.

feature -- PE relocation constants

	image_reloc_highlow: INTEGER_16 is 0x3000

end -- class CLI_PE_FILE_CONSTANTS
