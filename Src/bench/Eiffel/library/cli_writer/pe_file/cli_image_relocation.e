indexing
	description: "Representation of a relocation structure for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMAGE_RELOCATION
	
inherit
	WEL_STRUCTURE
		rename
			structure_size as count
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
			block_rva := pad_up (data_location, Block_size)
			if block_rva /= data_location then
					-- Block was not aligned on a `Block_size' boundary, so we remove `Block_size'
					-- from `block_rva' to find in which `Block_size' RVA is `data_location'.
				block_rva := block_rva - Block_size	
			end
			i := data_location - block_rva
			c_set_block_rva (item, block_rva)
			c_set_fixup (item, feature {CLI_PE_FILE_CONSTANTS}.Image_reloc_highlow +
				i.to_integer_16)
		end

feature -- Measurement

	count: INTEGER is
			-- Size of current structure.
		do
			Result := structure_size
		end

	structure_size: INTEGER is
			-- Size of CLI_IMAGE_RELOCATION structure.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMAGE_RELOCATION)"
		end

	Block_size: INTEGER is 4096
			-- Size of block for a relocation location.

feature {NONE} -- Implementation

	c_set_block_rva (an_item: POINTER; i: INTEGER) is
			-- Set `BlockRVA' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access BlockRVA type DWORD use %"cli_writer.h%""
		end

	c_set_block_size (an_item: POINTER; i: INTEGER) is
			-- Set `BlockSize' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access BlockSize type DWORD use %"cli_writer.h%""
		end

	c_set_fixup (an_item: POINTER; i: INTEGER_16) is
			-- Set `Fixup' to `i'.
		external
			"C struct CLI_IMAGE_RELOCATION access Fixup type WORD use %"cli_writer.h%""
		end

end -- class CLI_IMAGE_RELOCATION
