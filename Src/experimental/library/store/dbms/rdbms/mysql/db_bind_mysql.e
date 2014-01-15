note
	description: "One piece of MySQL parameter bind info"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_BIND_MYSQL

inherit
	MYSQL_EXTERNALS

create
	make

feature {NONE} -- Initialization

	make (a_type: like type; a_buffer: like buffer; a_count: like count)
			-- Initialization
		do
			count := a_count
			type := a_type
			buffer := a_buffer
			create length_pointer.make ({PLATFORM}.integer_32_bytes)
			length_pointer.put_integer_32 (count, 0)
			create is_null_pointer.make (1)
			if a_buffer = Void then
				is_null_pointer.put_natural_8 (1, 0)
			else
				is_null_pointer.put_natural_8 (0, 0)
			end
		end

feature -- Element Change

	set_count (a_count: like count)
			-- Set `count' with `a_count'.
		do
			count := a_count
		ensure
			count_set: count = a_count
		end

	set_type (a_type: like type)
			-- Set `type' with `a_type'.
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_buffer (a_buffer: like buffer)
			-- Set `buffer' with `a_buffer'.
		do
			buffer := a_buffer
		ensure
			buffer_set: buffer = a_buffer
		end

	set_eiffel_type (a_eiffel_type: like eiffel_type)
			-- Set `eiffel_type' with `a_eiffel_type'.
		do
			eiffel_type := a_eiffel_type
		ensure
			eiffel_type_set: eiffel_type = a_eiffel_type
		end

	set_meta_info (a_meta_info: like meta_info)
			-- Set `meta_info' with `a_meta_info'.
		do
			meta_info := a_meta_info
		ensure
			meta_info_set: meta_info = a_meta_info
		end

	prepare_buffer_from_column_length
			-- Create buffers according `length'.
		local
			l_len: INTEGER
		do
			if count = 0 then
				l_len := column_length
				if attached buffer as l_buf then
					l_buf.resize (l_len)
				else
					create buffer.make (l_len)
				end
				set_count (l_len)
			end
		end

feature -- Access

	count: INTEGER
			-- Count of the used bytes in `buffer'

	type: INTEGER
			-- Type of the bind

	eiffel_type: INTEGER
			-- Type in Eiffel (in C)

	buffer: detachable MANAGED_POINTER;
			-- Buffer of the bind

	meta_info: POINTER
			-- Meta info. (MYSQL_FIELD)

	length_pointer: MANAGED_POINTER
			-- Length

	is_null_pointer: MANAGED_POINTER
			-- Is null

	length: INTEGER
			-- Length of the data
		do
			Result := length_pointer.read_integer_32 (0)
		end

	column_length: INTEGER
			-- Column length
		do
			if meta_info /= default_pointer then
				Result := c_mysql_column_length (meta_info)
			end
		end

	column_name: detachable STRING
			-- Column name
		local
			l_m: C_STRING
		do
			if meta_info /= default_pointer then
				create l_m.make_shared_from_pointer_and_count (c_mysql_column_name (meta_info), c_mysql_column_name_length (meta_info))
				Result := l_m.string
			end
		end

	is_null: BOOLEAN
			-- Is the `data' null?
		do
			Result := is_null_pointer.read_natural_8 (0) = 1
		end

	read_string: detachable STRING
			-- Read from the buffer.
		local
			l_c: C_STRING
		do
			if attached buffer as l_buf then
				create l_c.make_shared_from_pointer_and_count (l_buf.item, length.min (l_buf.count))
				Result := l_c.substring (1, l_c.count)
			end
		end

	read_integer: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= {PLATFORM}.integer_32_bytes then
				Result := l_buf.read_integer_32 (0)
			end
		end

	read_integer_16: INTEGER_16
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= {PLATFORM}.integer_16_bytes then
				Result := l_buf.read_integer_16 (0)
			end
		end

	read_integer_64: INTEGER_64
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= {PLATFORM}.integer_64_bytes then
				Result := l_buf.read_integer_64 (0)
			end
		end

	read_real: REAL
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= {PLATFORM}.real_32_bytes then
				Result := l_buf.read_real_32 (0)
			end
		end

	read_float: REAL_64
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= {PLATFORM}.real_64_bytes then
				Result := l_buf.read_real_64 (0)
			end
		end

	read_year: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= c_sizeof_mysql_time then
				Result := c_mysql_time_year (l_buf.item)
			end
		end

	read_month: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= c_sizeof_mysql_time then
				Result := c_mysql_time_month (l_buf.item)
			end
		end

	read_day: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= c_sizeof_mysql_time then
				Result := c_mysql_time_day (l_buf.item)
			end
		end

	read_hour: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= c_sizeof_mysql_time then
				Result := c_mysql_time_hour (l_buf.item)
			end
		end

	read_minute: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= c_sizeof_mysql_time then
				Result := c_mysql_time_minute (l_buf.item)
			end
		end

	read_second: INTEGER
			-- Read from the buffer.
		do
			if attached buffer as l_buf and then count >= c_sizeof_mysql_time then
				Result := c_mysql_time_second (l_buf.item)
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
