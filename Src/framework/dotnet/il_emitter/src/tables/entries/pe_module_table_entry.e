note
	description: "Class desribing the module table."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Module", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=265&zoom=100,116,350", "protocol=uri"

class
	PE_MODULE_TABLE_ENTRY

inherit
	PE_TABLE_ENTRY_BASE
		redefine
			same_as
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_name_index: NATURAL_64; a_guid_index: NATURAL_64)
		do
			create name_index.make_with_index (a_name_index)
			create guid_index.make_with_index (a_guid_index)
		end

feature -- Status

	token_searching_supported: BOOLEAN = True

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := Precursor (e)
				or else (
					e.name_index.is_equal (name_index) and then
					e.guid_index.is_equal (guid_index)
				)
		end

feature -- Access

	name_index: PE_STRING
			-- an index into the String heap.

	guid_index: PE_GUID
			-- Mvid (an index into the Guid heap; simply a Guid used to distinguish between two
			-- versions of the same module)

		--  EncId (an index into the Guid heap; reserved, shall be zero)
		--  EncBaseId (an index into the Guid heap; reserved, shall be zero)

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tmodule.to_integer_32
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

				--  EncId (an index into the Guid heap; reserved, shall be zero)
				--  EncBaseId (an index into the Guid heap; reserved, shall be zero)
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
