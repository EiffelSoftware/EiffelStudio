indexing
	description: "Representation of a relocation structure for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMAGE_RELOCATION
	
inherit
	WEL_STRUCTURE
		rename
			structure_size as size
		redefine
			make
		end

	CLI_UTILITIES
		export
			{NONE} padding, pad_up
		end
		
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Allocate `item'.
		do
			Precursor {WEL_STRUCTURE}
			c_set_block_size (item, 0x0C)
		end

feature -- Settings

	set_data (data_location: INTEGER) is
			-- Set current structure knowing that relocation 
			-- location is at position `data_location' in memory.
		require
			valid_data_location: data_location >= Section_alignment
		local
			i: INTEGER
			block_rva: INTEGER
		do
			block_rva := pad_up (data_location, Section_alignment) - Section_alignment
			i := data_location - block_rva
			c_set_block_rva (item, block_rva)
			c_set_fixup (item, feature {CLI_PE_FILE_CONSTANTS}.Image_reloc_highlow | i.to_integer_16)
		end

feature -- Measurement

	size: INTEGER is
			-- Size of current structure.
		do
			Result := structure_size
		end

	structure_size: INTEGER is
			-- Size of CLI_IMAGE_RELOCATION structure.
		external
			"C macro use %"pe_writer.h%""
		alias
			"sizeof(CLI_IMAGE_RELOCATION)"
		end

feature {NONE} -- Implementation

	c_set_block_rva (an_item: POINTER; i: INTEGER) is
			-- Set `BlockRVA' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access BlockRVA type DWORD use %"pe_writer.h%""
		end

	c_set_block_size (an_item: POINTER; i: INTEGER) is
			-- Set `BlockSize' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access BlockSize type DWORD use %"pe_writer.h%""
		end

	c_set_fixup (an_item: POINTER; i: INTEGER_16) is
			-- Set `Fixup' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access Fixup type WORD use %"pe_writer.h%""
		end

end -- class CLI_IMAGE_RELOCATION
