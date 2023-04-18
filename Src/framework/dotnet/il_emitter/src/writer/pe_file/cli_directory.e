note
	description: "Representation of an IMAGE_DATA_DIRECTORY for CLI."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=image_data_directory", "src=https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_data_directory", "protocol=uri"

class
	CLI_DIRECTORY

create
	make

feature {NONE}

	make
		do
			set_rva_and_size (0, 0)
		end

feature -- Access

	rva: INTEGER_32
			-- RVA of the directory.
			--| Relative virtual address for current directory.

	data_size: INTEGER_32
			-- Size of the directory in bytes.

feature -- Setter

	set_rva (a_virtual_address: INTEGER_32)
			-- Set `rva` to `a_virtual_address'.
		do
			rva := a_virtual_address
		ensure
			rva_set: rva = a_virtual_address
		end

	set_data_size (a_size: INTEGER_32)
			-- Set `data_size` with `a_size'.
		do
			data_size := a_size
		ensure
			data_size_set: data_size = a_size
		end

	set_rva_and_size (a_rva, a_size: INTEGER)
			-- Set `rva' and `data_size' to `a_rva' and `a_size'.
		do
			set_rva (a_rva)
			set_data_size (a_size)
		ensure
			rva_set: rva = a_rva
			data_size_set: data_size = a_size
		end

feature -- Managed Pointer

	item: MANAGED_POINTER
			-- write the items to the buffer in  little-endian format.
		local
			l_pos: INTEGER
		do
			create Result.make (size_of)
			l_pos := 0

				-- rva
			Result.put_integer_32_le (rva, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- data_size
			Result.put_integer_32_le (data_size, l_pos)
		end

feature -- Size

	size_of: INTEGER_32
			-- Size of the structure.
		do
				-- rva
			Result := {PLATFORM}.integer_32_bytes
				-- data_size
			Result := Result + {PLATFORM}.integer_32_bytes
		ensure
			is_class: class
		end

end -- class CLI_DIRECTORY
