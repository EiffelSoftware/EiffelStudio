note
	description:  "[
		Representation of a CLI section header.
		see ECMA spec, section II.25.3 Section headers
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=II.25.3 Section headers", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#%%5B%%7B%%22num%%22%%3A3050%%2C%%22gen%%22%%3A0%%7D%%2C%%7B%%22name%%22%%3A%%22XYZ%%22%%7D%%2C87%%2C638%%2C0%%5D", "protocol=uri"
	EIS: "name=IMAGE_SECTION_HEADER", "src=https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_section_header", "protocol=uri"

class
	CLI_SECTION_HEADER

create
	make

feature {NONE} -- Initialization

	make(a_name: STRING)
		require
			a_name_not_void: a_name /= Void
			a_name_valid: not a_name.is_empty and then a_name.count <= 8
		do
			set_pointer_to_linenumbers (0)
			set_number_of_linenumbers (0)
			set_name (a_name)
		end

feature -- Access

    name: ARRAY [NATURAL_8]
            -- Name of the section
            -- POINTER

    physical_address: INTEGER
		require is_physical_address
		do
			Result := value
		end

	virtual_size: INTEGER
		require is_virtual_size
		do
			Result := value
		end

	is_physical_address: BOOLEAN

	is_virtual_size: BOOLEAN
		do
			Result := not is_physical_address
		end

    virtual_address: INTEGER_32
            -- RVA of the section

    size_of_raw_data: INTEGER_32
            -- The size of the section in the PE file

    pointer_to_raw_data: INTEGER_32
            -- The offset of the section's data in the PE file

    pointer_to_relocations: INTEGER_32
            -- The file pointer to the beginning of the relocation entries for the section.

    pointer_to_linenumbers: INTEGER_32
            -- The file pointer to the beginning of the line-number entries for the section.

    number_of_relocations: INTEGER_16
            -- The number of relocation entries for the section.

    number_of_linenumbers: INTEGER_16
            -- The number of line-number entries for the section.

    characteristics: INTEGER_32
            -- The flags that describe the characteristics of the section.

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
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


feature -- Element Change

	set_name (a_name: STRING)
            -- Set the `name` attribute with `a_name`, padding with null characters if necessary.
        local
            l_name: ARRAY[NATURAL_8]
            l_name_length: INTEGER_32
            l_index: INTEGER_32
        do
            create l_name.make_filled ({NATURAL_8} 0, 1, 8)
            l_name_length := a_name.count
	        from
                l_index := 1
            until
                l_index > l_name_length
            loop
                l_name[l_index] := a_name.item_code (l_index).to_natural_8
                l_index := l_index + 1
            end

            name := l_name
        end

	set_physical_address (v: like physical_address)
		do
			is_physical_address := True
			value := v
		ensure
			is_physical_address
		end

	set_virtual_size (v: like virtual_size)
		do
			is_physical_address := False
			value := v
		ensure
			is_virtual_size
		end

	set_virtual_address (a_virtual_address: INTEGER_32)
            -- Set `virtual_address` with `a_virtual_address'.
        do
            virtual_address := a_virtual_address
        end

    set_raw_data_size (a_size_of_raw_data: INTEGER_32)
            -- Set `size_of_raw_data` with `a_size_of_raw_data'.
        do
            size_of_raw_data := a_size_of_raw_data
        end

    set_pointer_to_raw_data (a_pointer_to_raw_data: INTEGER_32)
            -- Set `pointer_to_raw_data` with `a_pointer_to_raw_data'.
        do
            pointer_to_raw_data := a_pointer_to_raw_data
        end

    set_pointer_to_relocations (a_pointer_to_relocations: INTEGER_32)
            -- Set `pointer_to_relocations` with `a_pointer_to_relocations'.
        do
            pointer_to_relocations := a_pointer_to_relocations
        end

    set_pointer_to_linenumbers (a_pointer_to_linenumbers: INTEGER_32)
            -- Set `pointer_to_linenumbers` with `a_pointer_to_linenumbers'.
        do
            pointer_to_linenumbers := a_pointer_to_linenumbers
        end

    set_number_of_relocations (a_number_of_relocations: INTEGER_16)
            -- Set `number_of_relocations` with `a_number_of_relocations'.
        do
            number_of_relocations := a_number_of_relocations
        end

    set_number_of_linenumbers (a_number_of_linenumbers: INTEGER_16)
            -- Set `number_of_linenumbers` with `a_number_of_linenumbers'.
        do
            number_of_linenumbers := a_number_of_linenumbers
        end

    set_characteristics (a_characteristics: INTEGER_32)
    		-- Set `characteristics` with `a_characteristics'.
    	do
    		characteristics := a_characteristics
    	end


feature {NONE} -- Internal

	value: INTEGER
			-- value stored in the union

feature -- Managed Pointer

	item: MANAGED_POINTER
			-- write the items to the buffer in little-endian format.
		local
			st: STRUCT_MANAGED_POINTER
		do
			create st.make(size_of)
				-- name
			st.put_natural_8_array (name)
				-- physical_address or virtual_size depending on is_physical_address_active.
			st.put_integer_32 (value)
				-- virtual_address
			st.put_integer_32 (virtual_address)
				-- size_of_raw_data
			st.put_integer_32 (size_of_raw_data)
				-- pointer_to_raw_data
			st.put_integer_32 (pointer_to_raw_data)
				-- pointer_to_relocations
			st.put_integer_32 (pointer_to_relocations)
				-- pointer_to_linenumbers
			st.put_integer_32 (pointer_to_linenumbers)
				-- number_of_relocations
			st.put_integer_16 (number_of_relocations)
				-- number_of_linenumbers
			st.put_integer_16 (number_of_linenumbers)
				-- characteristics
			st.put_integer_32 (characteristics)

			Result := st
		end

feature -- Size

	structure_size: STRUCT_SIZE
			-- Size of the structure.
		do
			create Result.make
				-- name
			Result.put_natural_8_array (name.count)
				-- physical_address or virtual_size depending on is_physical_address_active.
			Result.put_integer_32
				-- virtual_address
			Result.put_integer_32
				-- size_of_raw_data
			Result.put_integer_32
				-- pointer_to_raw_data
			Result.put_integer_32
				-- pointer_to_relocations
			Result.put_integer_32
				-- pointer_to_linenumbers
			Result.put_integer_32
				-- number_of_relocations
			Result.put_integer_16
				-- number_of_linenumbers
			Result.put_integer_16
				-- characteristics
			Result.put_integer_32
		end

	size_of: INTEGER_32
			-- Size of the structure.
		do
			Result := structure_size
		end


end
