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

feature -- PE section header constants

	image_section_code: INTEGER is 0x00000020
			-- Section contains executable code.
			
	image_section_initialized_data: INTEGER is 0x00000040
			-- Section contains initialized data.

	image_section_uninitialized_data: INTEGER is 0x00000080
			-- Section contains uninitialized data.
	
	image_section_mem_discardable: INTEGER is 0x02000000
			-- Section can be discarded once loaded.

	image_section_mem_execute: INTEGER is 0x20000000
			-- Section to be executed as code.
			
	image_section_mem_read: INTEGER is 0x40000000
			-- Section can be read.

	image_section_mem_write: INTEGER is 0x80000000
			-- Section can be write.


feature -- PE relocation constants

	image_reloc_highlow: INTEGER_16 is 0x3000

end -- class CLI_PE_FILE_CONSTANTS
