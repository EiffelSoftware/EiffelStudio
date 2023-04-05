note
	description: "Representation of PE import table for CLI"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMPORT_TABLE

create
	make

feature {NONE} -- Initialization

	make (is_dll: BOOLEAN)
			-- Allocate `item'.
		local
			str: POINTER
			l_name: ARRAY [NATURAL_8]
		do
			set_time_date_stamp (0)
			set_forwarder_chain (0)

			create padding_1.make_filled ({NATURAL_8} 0, 1, 20)
			create padding_3.make_filled ({NATURAL_8} 0, 1, 6)

				-- 	-- Set `entry_point_name'.
			if is_dll then
				 set_entry_point_name (dll_entry_point_name)
			else
				set_entry_point_name (exe_entry_point_name)
			end

				-- Set `library_name'.
			set_library_name (library_name_dll)

		end

feature -- Access

	import_lookup_table: INTEGER_32
			-- RVA to ImportLookupTable

	time_date_stamp: INTEGER_32
			-- Default 0

	forwarder_chain: INTEGER_32
			-- Default 0

	name_rva: INTEGER_32
			--  RVA to null terminated ASCII string "mscoree.dll"

	iat_rva: INTEGER_32
			-- RVA to IAT

	padding_1: ARRAY [NATURAL_8]
			-- Filled with 0
			-- count = 20

	import_by_name_rva: INTEGER_32
			-- RVA to null terminated ASCII string "_CorDllMain" or "_CorExeMain"

	padding_3: ARRAY [NATURAL_8]
			-- count = 6

	entry_point_name: ARRAY [NATURAL_8]
			-- count = 12

	library_name: ARRAY [NATURAL_8]
			-- count = 12


feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Settings

	set_rvas (section_rva, current_location: INTEGER)
			-- Knowing that current lies in a section at `section_rva'
			-- and that its current RVA is `current_location', updates
			-- attributes of current to match those.
		do
			set_import_lookup_table (current_location + 40)
			set_name_rva (current_location + 62)
			set_iat_rva (section_rva)
			set_import_by_name_rva (current_location + size_to_import_by_name)
		end


feature -- Element Change

	set_import_lookup_table (a_value: INTEGER_32)
			-- Set the RVA to ImportLookupTable.
		do
			import_lookup_table := a_value
		end

	set_time_date_stamp (a_value: INTEGER_32)
			-- Set the time and date that the import was added.
		do
			time_date_stamp := a_value
		end

	set_forwarder_chain (a_value: INTEGER_32)
			-- Set the index of the first forwarder reference.
		do
			forwarder_chain := a_value
		end

	set_name_rva (a_value: INTEGER_32)
			-- Set the RVA to the null-terminated ASCII string that contains the name of the DLL.
		do
			name_rva := a_value
		end

	set_iat_rva (a_value: INTEGER_32)
			-- Set the RVA to the import address table (IAT).
		do
			iat_rva := a_value
		end

	set_import_by_name_rva (a_value: INTEGER_32)
			-- Set the RVA to the null-terminated ASCII string that contains the import symbol name.
		do
			import_by_name_rva := a_value
		end

	set_entry_point_name (a_value: STRING)
			-- Set the EntryPointName attribute to `a_value`.
		require
			valid_entry_point_name: a_value.count <= 12
		do
			entry_point_name := string_to_array_8 (a_value, 12)
		end

	set_library_name (a_value: STRING)
			-- Set the LibraryName attribute to `a_value`.
		require
			valid_library_name: a_value.count <= 12
		do
			library_name := string_to_array_8 (a_value, 12)
		end

feature {NONE} -- Implementation

	string_to_array_8 (a_name: STRING; n: INTEGER): ARRAY [NATURAL_8]
			-- Set the `name` attribute with `a_name`, padding with null characters if necessary.
		local
			l_name: ARRAY [NATURAL_8]
			l_name_length: INTEGER_32
			l_index: INTEGER_32
		do
			create l_name.make_filled ({NATURAL_8} 0, 1, n)
			l_name_length := a_name.count
			from
				l_index := 1
			until
				l_index > l_name_length
			loop
				l_name [l_index] := a_name.item_code (l_index).to_natural_8
				l_index := l_index + 1
			end

			Result := l_name
		end

feature -- Constants

	size_to_import_by_name: INTEGER = 48
			-- Location of import by name table from top of structure.

	dll_entry_point_name: STRING = "_CorDllMain"
	exe_entry_point_name: STRING = "_CorExeMain"
			-- Entry point names for `dll' or `exe'.

	library_name_dll: STRING = "mscoree.dll"
			-- Name of library containing above entry points.


feature -- Managed Pointer

	item: MANAGED_POINTER
		-- Write the item attributes to the buffer in little-endian format.
		local
			l_pos: INTEGER
		do
			create Result.make(size_of)
			l_pos := 0

				-- import_lookup_table
			Result.put_integer_32_le(import_lookup_table, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- time_date_stamp
			Result.put_integer_32_le(time_date_stamp, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- forwarder_chain
			Result.put_integer_32_le(forwarder_chain, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- name_rva	
			Result.put_integer_32_le(name_rva, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- iat_rva	
			Result.put_integer_32_le(iat_rva, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- padding_1
			Result.put_array (padding_1, l_pos)
			l_pos := l_pos + 20 * {PLATFORM}.natural_8_bytes

				-- import_by_name_rva	
			Result.put_integer_32_le(import_by_name_rva, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- padding_3
			Result.put_array (padding_3, l_pos)
			l_pos := l_pos + 6 * {PLATFORM}.natural_8_bytes

				-- entry_point_name
			Result.put_array (entry_point_name, l_pos)
			l_pos := l_pos + 12 * {PLATFORM}.natural_8_bytes

				-- library_name
			Result.put_array (library_name, l_pos)
			l_pos := l_pos + 12 * {PLATFORM}.natural_8_bytes

		end


 	size_of: INTEGER
 			-- Size of the structure
 		do
 				-- import_lookup_table
			Result := {PLATFORM}.integer_32_bytes

				-- time_date_stamp
			Result := Result + {PLATFORM}.integer_32_bytes

				-- forwarder_chain
			Result := Result + {PLATFORM}.integer_32_bytes

				-- name_rva	
			Result := Result + {PLATFORM}.integer_32_bytes

				-- iat_rva	
			Result := Result + {PLATFORM}.integer_32_bytes

				-- padding_1
			Result := Result + 20 * {PLATFORM}.natural_8_bytes

				-- import_by_name_rva	
			Result := Result + {PLATFORM}.integer_32_bytes

				-- padding_3
			Result := Result + 6 * {PLATFORM}.natural_8_bytes

				-- entry_point_name
			Result := Result + 12 * {PLATFORM}.natural_8_bytes

				-- library_name
			Result := Result + 12 * {PLATFORM}.natural_8_bytes

 		end

end
