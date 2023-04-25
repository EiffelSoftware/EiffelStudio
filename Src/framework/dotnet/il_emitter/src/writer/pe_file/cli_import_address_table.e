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
        	st: STRUCT_MANAGED_POINTER
        do
			create st.make (size_of)
			st.put_integer_32 (import_by_name_rva) -- import_by_name_rva
			st.put_natural_8_array (padding) -- padding
			Result := st
        end

feature -- Size

    size_of: INTEGER
            -- Compute the size of the struct.
		local
			st: STRUCT_SIZE
		do
			create st.make
       		st.put_integer_32 --import_by_name_rva
       		st.put_natural_8_array (4) -- padding 4 bytes (FIXME: why?)
       		Result := st
        end


end -- class CLI_IMPORT_ADDRESS_TABLE
