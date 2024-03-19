note
	description: "[
		Class desribing the module table.
		The Module table shall contain one and only one row
	]"
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

	make_with_data (a_name_index: NATURAL_32; a_Mvid_index: NATURAL_32)
		do
			create name_index.make_with_index (a_name_index)
			create mvid_index.make_with_index (a_Mvid_index)
		end

feature -- Status

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
			--| The Module table shall contain one and only one row.

		do
			Result := Precursor (e)
				or else (
					e.name_index.is_equal (name_index) and then
					e.mvid_index.is_equal (mvid_index)
				)
		end

feature -- Access

	name_index: PE_STRING
			-- an index into the String heap.

	mvid_index: PE_GUID
			-- Mvid (an index into the Guid heap; simply a Guid used to distinguish between two
			-- versions of the same module)

		-- EncId (an index into the Guid heap; reserved, shall be zero)
		-- EncBaseId (an index into the Guid heap; reserved, shall be zero)

feature -- Operations

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tmodule
		end

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes_written: NATURAL_32
			l_null_guid_index: PE_GUID
		do
				-- Initialize the first two bytes of dest to zero:
				-- Generation (a 2-byte value, reserved, shall be zero)
			{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, 0, 0)
			l_bytes_written := 2

				-- Render the name_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + name_index.render (a_sizes, a_dest, l_bytes_written)

				-- Render the guid_index and add the number of bytes written to l_bytes_written
			l_bytes_written := l_bytes_written + mvid_index.render (a_sizes, a_dest, l_bytes_written)

				-- EncId (an index into the Guid heap; reserved, shall be zero)
				-- EncBaseId (an index into the Guid heap; reserved, shall be zero)
			create l_null_guid_index.make_with_index (0)
			l_bytes_written := l_bytes_written + l_null_guid_index.render (a_sizes, a_dest, l_bytes_written) -- EncId
			l_bytes_written := l_bytes_written + l_null_guid_index.render (a_sizes, a_dest, l_bytes_written) -- EncBaseId

				-- Return the total number of bytes written
			Result := l_bytes_written
		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
		local
			l_bytes: NATURAL_32
			l_null_guid_index: PE_GUID
		do
				-- Initialize the number of bytes read to 2.

			l_bytes := 2 -- Generation

				-- Read the name_index.
			l_bytes := l_bytes + name_index.rendering_size (a_sizes)

				-- Read the guid_index.
			l_bytes := l_bytes + mvid_index.rendering_size (a_sizes)

			create l_null_guid_index.make_with_index (0)
			l_bytes := l_bytes + l_null_guid_index.rendering_size (a_sizes) -- EncId
			l_bytes := l_bytes + l_null_guid_index.rendering_size (a_sizes) -- EncBaseId

				-- Return the total number of bytes read.
			Result := l_bytes
		end

end
