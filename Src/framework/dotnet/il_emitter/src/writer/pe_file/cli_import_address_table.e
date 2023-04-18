note
	description: "Representation of both an Import Lookup table and an Import Address Table (IAT) in a PE File for CLI"
	date: "$Date$"
	revision: "$Revision$"

class
    CLI_IMPORT_ADDRESS_TABLE

create
	make

feature {NONE} -- Initialization

	make
		do
			create padding.make_filled ({NATURAL_8}0, 1, 4)
		end

feature -- Access

    import_by_name_rva: INTEGER_32
    	-- RVA to ImportByName table.

    padding: ARRAY [NATURAL_8]
    	-- Padding to make structure 8 bytes.

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Element Change

	set_import_by_name_rva (a_val: INTEGER_32)
			-- Set `import_by_name_rva' with `a_val'
		do
			import_by_name_rva := a_val
		ensure
			import_by_name_rva_set: import_by_name_rva = a_val
		end

feature  -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (item, 0, count)
			l_file.close
		end


feature -- Item

    item: MANAGED_POINTER
            -- Write the items to the buffer in little-endian format.

        local
        	l_pos: INTEGER
        do
			create Result.make(size_of)
			l_pos := 0

				-- import_by_name_rva
			Result.put_integer_32_le(import_by_name_rva, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- padding
			Result.put_array (padding, l_pos)
        end

feature -- Size

    size_of: INTEGER
            -- Compute the size of the struct.
       do
       			--import_by_name_rva
            Result := {PLATFORM}.integer_32_bytes
            	-- padding 4 bytes
            Result := Result + 4 * {PLATFORM}.natural_8_bytes

        end


end -- class CLI_IMPORT_ADDRESS_TABLE
