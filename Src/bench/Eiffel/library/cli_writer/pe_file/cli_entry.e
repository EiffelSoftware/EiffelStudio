indexing
	description: "Small structure that holds entry point of current CLI image"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_ENTRY
	
inherit
	WEL_STRUCTURE
		rename
			structure_size as size
		redefine
			make
		end
		
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Allocated `item'.
		do
			Precursor {WEL_STRUCTURE}
			c_set_jump_inst_high (item, 0xFF)
			c_set_jump_inst_low (item, 0x25)
		end
		
feature -- Measurement

	size: INTEGER is
			-- Size of current.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of `CLI_ENTRY' structure.
		external
			"C macro use %"pe_writer.h%""
		alias
			"sizeof(CLI_ENTRY)"
		end

	start_position: INTEGER is 2
			-- Actual position where `jump' info and `rva'
			-- are located.
			
	jump_size: INTEGER is 4
			-- Size taken by padding + `jump' instruction.

feature -- Settings

	set_iat_rva (rva: INTEGER) is
			-- Set `iat_rva' to `rva'.
		do
			c_set_iat_rva (item, rva + 0x400000)
		end
		
feature {NONE} -- Initialization

	c_set_jump_inst_high (an_item: POINTER; i: INTEGER_8) is
			-- Set `JumpInstH' to `i'.
		external
			"C struct CLI_ENTRY access JumpInstH type BYTE use %"pe_writer.h%""
		end
			
	c_set_jump_inst_low (an_item: POINTER; i: INTEGER_8) is
			-- Set `JumpInstL' to `i'.
		external
			"C struct CLI_ENTRY access JumpInstL type BYTE use %"pe_writer.h%""
		end
	
	c_set_iat_rva (an_item: POINTER; i: INTEGER) is
			-- Set `IAT_RVA' to `i'.
		external
			"C struct CLI_ENTRY access IAT_RVA type DWORD use %"pe_writer.h%""
		end

end -- class CLI_ENTRY
