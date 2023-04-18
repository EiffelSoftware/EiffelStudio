note
	description: "Summary description for {CLI_IMAGE_RELOCATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMAGE_RELOCATION

inherit
	CLI_UTILITIES
		export
			{NONE} padding, pad_up
		end
create
	make

feature {NONE} -- Initialization

	make
		do
			create padding_field.make_filled ({NATURAL_8} 0, 1, 2)
			block_size_field := 0x0C
		end

feature -- Access

	block_rva: INTEGER_32
			-- RVA of section in which fixup needs to be applied.

	block_size_field: INTEGER_32
			-- Default value 0x0C

	fixup: INTEGER_16
			-- Fixup location from `BlockRVA'.

	padding_field: ARRAY [NATURAL_8]
			-- two bytes

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Element Change

	set_block_rva (a_block_rva: INTEGER_32)
			-- Set `block_rva` to `a_block_rva'.
		do
			block_rva := a_block_rva
		ensure
			block_rva_set: block_rva = a_block_rva
		end

	set_fixup (a_fixup: INTEGER_16)
			-- Set `fixup' to `a_fixup'.
		do
			fixup := a_fixup
		ensure
			fixup_set: fixup = a_fixup
		end

feature -- Settings

	set_data (data_location: INTEGER)
			-- Set current structure knowing that relocation
			-- location is at position `data_location' in memory.
		require
			valid_data_location: data_location >= Section_alignment
		local
			i: INTEGER
			l_block_rva: INTEGER
		do
			l_block_rva := pad_up (data_location, Block_size)
			if l_block_rva /= data_location then
					-- Block was not aligned on a `Block_size' boundary, so we remove `Block_size'
					-- from `block_rva' to find in which `Block_size' RVA is `data_location'.
				l_block_rva := l_block_rva - Block_size
			end
			i := data_location - l_block_rva
			set_block_rva (l_block_rva)
			set_fixup ({CLI_PE_FILE_CONSTANTS}.Image_reloc_highlow +
				i.to_integer_16)
		end

feature -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (item, 0, count)
			l_file.close
		end

feature -- Managed Pointer

	item: MANAGED_POINTER
			-- Write the items to the buffer in little-endian format.
		local
			l_pos: INTEGER
		do
			create Result.make (size_of)
			l_pos := 0

				-- block_rva
			Result.put_integer_32_le (block_rva, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- block_size_field
			Result.put_integer_32_le (block_size_field, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- fixup
			Result.put_integer_16_le (fixup, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- padding_field
			Result.put_array (padding_field, l_pos)
		end

feature -- Measurement

	size_of: INTEGER
			-- Size of `CLI_IMAGE_RELOCATION' structure.
		do
			Result := {PLATFORM}.integer_32_bytes + {PLATFORM}.integer_32_bytes + {PLATFORM}.integer_16_bytes + 2 * {PLATFORM}.natural_8_bytes
		ensure
			is_class: class
		end

	Block_size: INTEGER = 4096
			-- Size of block for a relocation location.

end -- class CLI_IMAGE_RELOCATION
