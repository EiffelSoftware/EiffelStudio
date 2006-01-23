indexing
	description: "Serialize/Deserialize data from memory."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SED_MEMORY_READER_WRITER

inherit
	SED_BINARY_READER_WRITER
		export
			{ANY} buffer
		end

create
	make,
	make_with_buffer

feature {NONE} -- Initialization

	make is
			-- Initialize current to read or write from `a_medium'.
		do
			make_with_buffer (create {MANAGED_POINTER}.make (default_buffer_size))
		ensure
			buffer_set: buffer /= Void
			buffer_size_set: buffer_size = default_buffer_size
		end

	make_with_buffer (a_buffer: like buffer) is
			-- Initialize current to read or write from `a_medium' using a buffer of size `a_buffer_size'.
			-- `buffer_size' will be overriden during read operation by the value of `buffer_size' used
			-- when writing.
		require
			a_buffer_not_void: a_buffer /= Void
		do
			buffer := a_buffer
			buffer_size := a_buffer.count
		ensure
			buffer_set: buffer = a_buffer
			buffer_size_set: buffer_size = a_buffer.count
		end

feature {NONE} -- Buffer update

	check_buffer (n: INTEGER) is
			-- If there is enough space in `buffer' to read `n' bytes, do nothing.
			-- Otherwise, read/write to `medium' to free some space.
		do
			if n + buffer_position > buffer_size then
				buffer.resize (buffer.count + buffer.count // 2)
				buffer_size := buffer.count
			end
		end

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
