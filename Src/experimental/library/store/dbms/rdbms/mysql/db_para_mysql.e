note
	description: "Parameter of MySQL dynamic call"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_PARA_MYSQL

inherit
	ARRAYED_LIST [DB_BIND_MYSQL]
		redefine
			make
		end

	GLOBAL_SETTINGS
		undefine
			is_equal,
			copy
		end

	MYSQL_EXTERNALS
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER_32)
			-- Initialization
		do
			Precursor (n)
		end

feature -- Access

	bound_parameter (pos: INTEGER): POINTER
			-- Get the parameter at `pos'.
		require
			pos_valid: pos <= count and pos >= 1
		do
			if attached internal_parameter_pointer as l_p then
				Result := l_p.item.plus ((pos - 1) * c_sizeof_mysql_bind)
			end
		end

	bound_parameter_pointer: POINTER
			-- Pointer to the bind struct
		local
			l_pointer: detachable MANAGED_POINTER
			l_n: INTEGER
			l_item: DB_BIND_MYSQL
		do
			if parameter_count > 0 then
				l_n := parameter_count.min (count)
				if attached internal_parameter_pointer as l_p then
					l_pointer := l_p
					l_pointer.resize (l_n * c_sizeof_mysql_bind)
				else
					create l_pointer.make (l_n * c_sizeof_mysql_bind)
					internal_parameter_pointer := l_pointer
				end

				from
					start
				until
					after or else l_n = 0
				loop
					l_item := item
					if attached l_item.buffer as l_buf then
						c_set_mysql_bind (l_pointer.item, index, l_buf.item, l_item.count, l_item.type, l_item.length_pointer.item, l_item.is_null_pointer.item)
					else
						c_set_mysql_bind (l_pointer.item, index, default_pointer, 0, l_item.type, l_item.length_pointer.item, l_item.is_null_pointer.item)
					end
					l_n := l_n - 1
					forth
				end
				Result := l_pointer.item
			end
		end

	parameter_count: INTEGER
			-- Used number of parameters.

feature -- Element Change

	extend_parameter (a_object: detachable ANY)
			-- Put parameter at current position
		do
			if attached a_object as l_obj then
				if attached object_to_pointer (l_obj) as l_p then
					extend (l_p)
				end
			else
				extend (create {DB_BIND_MYSQL}.make (mysql_type_null, Void, 0))
			end
		end

	replace_parameter (i: INTEGER; a_object: detachable ANY)
			-- Replace parameter at i-th position
		require
			i_valid: valid_index (i)
		do
			if attached a_object as l_obj then
					--|FIXME: It can be optimized by reusing previous object away.
				if attached object_to_pointer (l_obj) as l_p then
					put_i_th (l_p, i)
				end
			else
				put_i_th (create {DB_BIND_MYSQL}.make (mysql_type_null, Void, 0), i)
			end
		end

	set_parameter_count (a_count: INTEGER)
			-- Set used parameter number
		require
			a_count_valid: a_count >= 0 and then a_count <= count
		do
			parameter_count := a_count
		ensure
			parameter_count_set: parameter_count = a_count
		end

	prepare_result_buffers
			-- Prepare buffers for results
		do
			from
				start
			until
				after
			loop
				item.prepare_buffer_from_column_length
				forth
			end
		end

feature -- Action

	release
			-- Release the parameters
		do
			wipe_out
		end

feature {NONE} -- Implementation

	object_to_pointer (a_obj: ANY): DB_BIND_MYSQL
			-- Convert Eiffel object to pointer
		local
			type: INTEGER
			l_any: ANY
			l_managed_pointer: detachable MANAGED_POINTER
			l_value_count: INTEGER
			l_c_string: MYSQL_SQL_STRING
			u: UTF_CONVERTER
		do
			l_any := a_obj
			if attached {READABLE_STRING_8} l_any as l_val_string then
				type := MYSQL_TYPE_STRING
				create l_c_string.make (l_val_string)
				l_value_count := l_c_string.bytes_count
				l_managed_pointer := l_c_string.managed_data
			elseif attached {READABLE_STRING_32} l_any as l_string_32 then
				type := MYSQL_TYPE_STRING
				create l_c_string.make (u.utf_32_string_to_utf_8_string_8 (l_string_32))
				l_value_count := l_c_string.bytes_count
				l_managed_pointer := l_c_string.managed_data
			elseif attached {INTEGER_REF} l_any as l_val_int then
				type := MYSQL_TYPE_LONG
				create l_managed_pointer.make ({PLATFORM}.integer_32_bytes)
				l_managed_pointer.put_integer_32 (l_val_int.item, 0)
				l_value_count := {PLATFORM}.integer_32_bytes
			elseif attached {INTEGER_16_REF} l_any as l_val_int16 then
				type := MYSQL_TYPE_SHORT
				create l_managed_pointer.make ({PLATFORM}.integer_16_bytes)
				l_managed_pointer.put_integer_16 (l_val_int16.item, 0)
				l_value_count := {PLATFORM}.integer_16_bytes
			elseif attached {INTEGER_64_REF} l_any as l_val_int64 then
				type := MYSQL_TYPE_LONGLONG
				create l_managed_pointer.make ({PLATFORM}.integer_64_bytes)
				l_managed_pointer.put_integer_64 (l_val_int64.item, 0)
				l_value_count := {PLATFORM}.integer_64_bytes
			elseif attached {DATE_TIME} l_any as l_tmp_date then
					-- Fractional part of the second is unused.
					-- See: http://dev.mysql.com/doc/refman/5.0/en/c-api-prepared-statement-data-structures.html
				type := MYSQL_TYPE_TIME
				create l_managed_pointer.make (c_sizeof_mysql_time)
				c_set_mysql_time (l_managed_pointer.item, l_tmp_date.year, l_tmp_date.month, l_tmp_date.day, l_tmp_date.hour, l_tmp_date.minute, l_tmp_date.second)
				l_value_count := c_sizeof_mysql_time
			elseif attached {DOUBLE_REF} l_any as l_val_double then
				type := MYSQL_TYPE_DOUBLE
				create l_managed_pointer.make ({PLATFORM}.real_64_bytes)
				l_managed_pointer.put_real_64 (l_val_double.item, 0)
				l_value_count := {PLATFORM}.real_64_bytes
			elseif attached {REAL_REF} l_any as l_val_real then
				type := MYSQL_TYPE_FLOAT
				create l_managed_pointer.make ({PLATFORM}.real_32_bytes)
				l_managed_pointer.put_real_32 (l_val_real.item, 0)
				l_value_count := {PLATFORM}.real_32_bytes
			elseif attached {CHARACTER_REF} l_any as l_val_char then
				type := MYSQL_TYPE_STRING
				create l_managed_pointer.make ({PLATFORM}.character_8_bytes)
				l_managed_pointer.put_character (l_val_char.item, 0)
				l_value_count := {PLATFORM}.character_8_bytes
			elseif attached {BOOLEAN_REF} l_any as l_val_bool  then
				type := MYSQL_TYPE_TINY
				l_value_count := 1
				create l_managed_pointer.make (l_value_count)
				if l_val_bool.item then
					l_managed_pointer.put_integer_8 (1, 0)
				else
					l_managed_pointer.put_integer_8 (0, 0)
				end
			-- elseif is_decimal_used and then is_decimal_function.item ([l_any]) then
			-- Decimal is not supported.
			-- See: http://dev.mysql.com/doc/refman/5.0/en/c-api-prepared-statement-type-codes.html
			end

			create Result.make (type, l_managed_pointer, l_value_count)
		end

	internal_parameter_pointer: detachable MANAGED_POINTER;
			-- Parameter pointer

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
