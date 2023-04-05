note
	description:  "Representation of a CLI section header."
	date: "$Date$"
	revision: "$Revision$"
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
			l_pos: INTEGER_32
		do
			create Result.make(size_of)
			l_pos := 0

				-- name
			Result.put_array (name, l_pos)
			l_pos := l_pos + 8

				-- physical_address or virtual_size depending on is_physical_address_active.
			Result.put_integer_32_le(value, l_pos)

			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- virtual_address
			Result.put_integer_32_le(virtual_address, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_raw_data
			Result.put_integer_32_le(size_of_raw_data, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- pointer_to_raw_data
			Result.put_integer_32_le(pointer_to_raw_data, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- pointer_to_relocations
			Result.put_integer_32_le(pointer_to_relocations, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- pointer_to_linenumbers
			Result.put_integer_32_le(pointer_to_linenumbers, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- number_of_relocations
			Result.put_integer_16_le(number_of_relocations, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- number_of_linenumbers
			Result.put_integer_16_le(number_of_linenumbers, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- characteristics
			Result.put_integer_32_le(characteristics, l_pos)
		end

feature -- Size

	size_of: INTEGER_32
			-- Size of the structure.
		do
				-- name
			Result := 8
				-- misc	
			Result := Result + {PLATFORM}.integer_32_bytes
				-- virtual_address
			Result := Result + {PLATFORM}.integer_32_bytes
				-- size_of_raw_data
			Result := Result + {PLATFORM}.integer_32_bytes
				-- pointer_to_raw_data
			Result := Result + {PLATFORM}.integer_32_bytes
				-- pointer_to_relocations
			Result := Result + {PLATFORM}.integer_32_bytes
				-- pointer_to_linenumbers
			Result := Result + {PLATFORM}.integer_32_bytes
				-- number_of_relocations
			Result := Result + {PLATFORM}.integer_16_bytes
				-- number_of_linenumbers
			Result := Result + {PLATFORM}.integer_16_bytes
				-- characteristics
			Result := Result + {PLATFORM}.integer_32_bytes
		end


end
