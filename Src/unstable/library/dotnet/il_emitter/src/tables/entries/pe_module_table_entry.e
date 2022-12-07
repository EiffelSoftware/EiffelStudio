note
	description: "Class desribing the module table."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MODULE_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_name_index: NATURAL_64; a_guid_index: NATURAL_64)
		do
			create name_index.make_with_index (a_name_index)
			create guid_index.make_with_index (a_guid_index)
		end

feature -- Access

	name_index: PE_STRING

	guid_index: PE_GUID

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tmodule.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes_written: NATURAL_64
		do
				-- Initialize the first two bytes of dest to zero
			{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest.to_special, 0, 0)

				-- Set the initial number of bytes written to 2
			l_bytes_written := 2

				-- Render the name_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + name_index.render (a_sizes, a_dest, l_bytes_written.to_integer_32)

				-- Render the guid_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + guid_index.render (a_sizes, a_dest, l_bytes_written.to_integer_32)

			if a_sizes [{PE_TABLE_CONSTANTS}.t_guid + 1] > 65535 then
					-- If the size of the GUID table is greater than 65535, write two
					-- zero-valued NATURAL_32 to the destination
					--| DWord in C++
				{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, 0, l_bytes_written.to_integer_32)
				l_bytes_written := l_bytes_written + 4
				{BYTE_ARRAY_HELPER}.put_array_natural_32 (a_dest, 0, l_bytes_written.to_integer_32)
				l_bytes_written := l_bytes_written + 4
			else
					-- If the size of the GUID table is greater than 65535, write two
					-- zero-valued NATURAL_16 to the destination
					--| Word in C++
				{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, 0, l_bytes_written.to_integer_32)
				l_bytes_written := l_bytes_written + 2
				{BYTE_ARRAY_HELPER}.put_array_natural_16 (a_dest, 0, l_bytes_written.to_integer_32)
				l_bytes_written := l_bytes_written + 2
			end

				-- Return the total number of bytes written
			Result := l_bytes_written
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Initilize the number of bytes read to 2.
			l_bytes := 2

				-- Read the name_index.
			l_bytes := l_bytes + name_index.get (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Read the guid_index.
			l_bytes := l_bytes + guid_index.get (a_sizes, a_dest, l_bytes.to_integer_32)

			if a_sizes [{PE_TABLE_CONSTANTS}.t_guid + 1] > 65535 then
					-- If the size of the GUID index is greater than 65535,
					-- add 8 bytes to the number of bytes read
				l_bytes := l_bytes + 8
			else
					-- in other case, add 4 bytes to the number of bytes read.
				l_bytes := l_bytes + 4
			end
				-- Return the total number of bytes read.
			Result := l_bytes
		end

end
