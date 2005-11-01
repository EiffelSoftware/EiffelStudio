indexing
	description: "Serialize/Deserialize data from a medium."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_MEDIUM_READER_WRITER_1

inherit
	SED_BINARY_READER_WRITER
		redefine
			read_header,
			write_header,
			write_footer,
			is_ready_for_reading,
			is_ready_for_writing,
			medium
		end

create
	make,
	make_with_buffer

feature {NONE} -- Initialization

	make (a_medium: IO_MEDIUM) is
			-- Initialize current to read or write from `a_medium'.
		require
			a_medium_not_void: a_medium /= Void
		do
			make_with_buffer (a_medium, default_buffer_size)
		ensure
			medium_set: medium = a_medium
			buffer_size_set: buffer_size = default_buffer_size
		end

	make_with_buffer (a_medium: IO_MEDIUM; a_buffer_size: INTEGER) is
			-- Initialize current to read or write from `a_medium' using a buffer of size `a_buffer_size'.
			-- `buffer_size' will be overriden during read operation by the value of `buffer_size' used 
			-- when writing.
		require
			a_medium_not_void: a_medium /= Void
			a_buffer_size_non_negative: a_buffer_size >= 0
		do
			medium := a_medium
			buffer_size := a_buffer_size
			create buffer.make (a_buffer_size)
		ensure
			medium_set: medium = a_medium
			buffer_size_set: buffer_size = a_buffer_size
		end

feature -- Header/Footer

	read_header is
			-- Retrieve configuration of how data was stored.
		do
				-- Read header
			medium.read_to_managed_pointer (buffer, 0, header_size)
			is_little_endian_storable := buffer.read_boolean (0)
			is_pointer_value_stored := buffer.read_boolean (natural_8_bytes)
			buffer_size := buffer.read_integer_32_le (2 * natural_8_bytes)
			stored_pointer_bytes := buffer.read_integer_32_le (2 * natural_8_bytes + integer_32_bytes)

				-- Initialize buffer for next read operation
			medium.read_to_managed_pointer (buffer, 0, buffer_size)
			buffer_position := 0
		ensure then
			buffer_position_reset: buffer_position = 0
		end

	write_header is
			-- Store configuration on how data will be stored.
		do
			is_little_endian_storable := is_little_endian
			buffer.put_boolean (is_little_endian_storable, 0)
			buffer.put_boolean (is_pointer_value_stored, natural_8_bytes)
			buffer.put_integer_32_le (buffer_size, 2 * natural_8_bytes)
			buffer.put_integer_32_le (pointer_bytes, 2 * natural_8_bytes + integer_32_bytes)

			medium.put_managed_pointer (buffer, 0, header_size)
			buffer_position := 0
		ensure then
			buffer_position_reset: buffer_position = 0
		end

	write_footer is
			-- Store last buffered data.
		do
			medium.put_managed_pointer (buffer, 0, buffer_position)
		end

feature -- Status report

	is_ready_for_reading: BOOLEAN is
			-- Is Current ready for future read operations?
		do
			Result := is_for_reading and then
				medium.exists and then medium.is_open_read and then medium.support_storable
		end

	is_ready_for_writing: BOOLEAN is
			-- Is Current ready for future write operations?
		do
			Result := not is_for_reading and then
				medium.exists and then medium.is_open_write and then medium.support_storable
		end

feature {NONE} -- Implementation: Access

	medium: IO_MEDIUM
			-- Medium used for read/write operations

feature {NONE} -- Implementation: Status report

	header_size: INTEGER is
			-- Size for header storing properties of data stored in `medium'
		do
			Result := 
				natural_8_bytes 		-- `is_little_endian_storable'
				+ natural_8_bytes		-- `is_pointer_value_stored'
				+ integer_32_bytes	-- `buffer_size'
				+ integer_32_bytes	-- `stored_pointer_bytes'
		end

feature {NONE} -- Buffer update

	check_buffer (n: INTEGER) is
			-- If there is enough space in `buffer' to read `n' bytes, do nothing.
			-- Otherwise, read/write to `medium' to free some space.
		do
			if n + buffer_position > buffer_size then
				if is_for_reading then
					medium.read_to_managed_pointer (buffer, 0, buffer_size)
				else
					medium.put_managed_pointer (buffer, 0, buffer_size)
				end
				buffer_position := 0
			end
		end

invariant
	medium_not_void: medium /= Void

end
