indexing
	description: "Serialize/Deserialize data from a medium."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_MEDIUM_READER_WRITER

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
				-- Read data from medium
			read_buffer_from_medium

				-- Read header telling how data is stored.
			is_little_endian_storable := read_boolean
			is_pointer_value_stored := read_boolean

				-- Note: it is ok here to call `read_integer_32' because
				-- `is_little_endian_storable' is set two lines above.
			stored_pointer_bytes := read_integer_32
		end

	write_header is
			-- Store configuration on how data will be stored.
		do
				-- Before doing any writing we need to setup the attributes
				-- that control how the data will be stored. So far just one
			buffer_position := integer_32_bytes
			is_little_endian_storable := is_little_endian

				-- Write the header describing how the data is stored.
			write_boolean (is_little_endian_storable)
			write_boolean (is_pointer_value_stored)
			write_integer_32 (pointer_bytes)
		end

	write_footer is
			-- Store last buffered data.
		do
			flush_buffer_to_medium
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

feature {NONE} -- Buffer update

	check_buffer (n: INTEGER) is
			-- If there is enough space in `buffer' to read `n' bytes, do nothing.
			-- Otherwise, read/write to `medium' to free some space.
		do
			if n + buffer_position > buffer_size then
				if is_for_reading then
					read_buffer_from_medium
				else
					flush_buffer_to_medium
				end
			end
		end

	read_buffer_from_medium is
			-- Read next chunk of data.
		require
			is_ready: is_ready_for_reading
		do
				-- Read the amount of data we are suppose to read
			medium.read_to_managed_pointer (buffer, 0, integer_32_bytes)
			buffer_size := buffer.read_integer_32_be (0)
				-- Resize `buffer' if necessary.
			if buffer.count < buffer_size then
				buffer.resize (buffer_size)
			end
				-- Read the data.
			medium.read_to_managed_pointer (buffer, integer_32_bytes, buffer_size - integer_32_bytes)

				-- Put the position at the right place.
			buffer_position := integer_32_bytes
		end

	flush_buffer_to_medium is
			-- Write next chunk of data to `medium'.
		require
			is_ready: is_ready_for_writing
		do
				-- Write the amount of bytes we are actually writting
			buffer.put_integer_32_be (buffer_position, 0)
				-- Write the data.
			medium.put_managed_pointer (buffer, 0, buffer_position)

				-- Put the position at the right place.
			buffer_position := integer_32_bytes
		end

invariant
	medium_not_void: medium /= Void

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
