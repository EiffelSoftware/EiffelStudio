indexing
	description: "Representation of a section header for a method."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_SECTION_HEADER

inherit
	MD_METHOD_HEADER

create
	make
	
feature -- Initialization

	make, remake (a_try_offset, a_try_length, a_handler_offset,
			a_handler_length, a_type_token: INTEGER)
		is
			-- Create fat method section header.
		do
			if a_try_length < 256 and a_handler_length < 256 then
				is_fat := False
				internal_data := ((feature {MD_METHOD_CONSTANTS}.Section_ehtable)
					.to_integer_32 |<< 24) | Size
			else
				is_fat := True
				internal_data := ((feature {MD_METHOD_CONSTANTS}.Section_ehtable |
					feature {MD_METHOD_CONSTANTS}.Section_fat_format)
					.to_integer_32 |<< 24) | Size
			end
			try_offset := a_try_offset
			try_length := a_try_length
			handler_offset := a_handler_offset
			handler_length := a_handler_length
			type_token := a_type_token
		ensure
			try_offset_set: try_offset = a_try_offset
			try_length_set: try_length = a_try_length
			handler_offset_set: handler_offset = a_handler_offset
			handler_length_set: handler_length = a_handler_length
			type_token_set: type_token = a_type_token
		end

feature -- Access

	flags: INTEGER
			-- Flags for current section.
			
	try_offset: INTEGER
			-- Offset in bytes of try block from start of the header.
			
	try_length: INTEGER
			-- Length in bytes of try bock.

	handler_offset: INTEGER
			-- Offset in bytes of location of handler.
			
	handler_length: INTEGER
			-- Length of handler code in bytes.
			
	type_token: INTEGER
			-- Meta data token for type-based exception handler.
			
feature -- Access

	size: INTEGER is
			-- Size of structure once emitted.
		do
			if is_fat then
				Result := 28
			else
				Result := 16
			end
		end
		
feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
			-- Write to stream `m' at position `pos'.
		local
			l_byte: INTEGER_8
		do
			l_byte := ((internal_data & 0xFF000000) |>> 24).to_integer_8
			m.put_integer_8 (l_byte, pos)

				-- FIXME: Manu 3/29/2002: Should it be big endian?
			l_byte := size.to_integer_8
			m.put_integer_8 (l_byte, pos + 1)
				-- +3 as size is coded on 3 bytes, but as we only use only
				-- one exception, we store the first 8 bits and skip the last
				-- 16 as they are `0'.
			
			if is_fat then
				m.put_integer_32 (flags, pos + 4)
				m.put_integer_32 (try_offset, pos + 8)
				m.put_integer_32 (try_length, pos + 12)
				m.put_integer_32 (handler_offset, pos + 16)
				m.put_integer_32 (handler_length, pos + 20)
				m.put_integer_32 (type_token, pos + 24)
			else
				m.put_integer_16 (flags.to_integer_16, pos + 4)
				m.put_integer_16 (try_offset.to_integer_16, pos + 6)
				m.put_integer_8 (try_length.to_integer_8, pos + 8)
				m.put_integer_16 (handler_offset.to_integer_16, pos + 9)
				m.put_integer_8 (handler_length.to_integer_8, pos + 11)
				m.put_integer_32 (type_token, pos + 12)
			end
		end

feature {NONE} -- Internal data

	internal_data: INTEGER
			-- Stores kind and size of clause.
	
	is_fat: BOOLEAN
			-- Is current header a fat one?
		
end -- class MD_METHOD_SECTION_HEADER
