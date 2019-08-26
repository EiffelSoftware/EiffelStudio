note
	description: "Implementation of DB_DATA"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_DATA [G -> DATABASE create default_create end]

inherit
	HANDLE_SPEC [G]

	DB_STATUS_USE

	DB_DATA_SQL

	EXT_INTERNAL

	DB_CONSTANT
		export
			{NONE} all
		end

	GLOBAL_SETTINGS
		export
			{NONE} all
		end

	REFACTORING_HELPER

feature -- Status report

	count:  INTEGER
		-- Number of columns in result

	map_table: detachable ARRAY [INTEGER]
		-- Correspondance table between column rank and
		-- attribute rank in mapped object

	item (index: INTEGER): detachable ANY
			-- Data at `index'-th column.
		do
			if attached value as l_value then
				Result := l_value.item (index)
			end
		ensure then
			returned_value: attached value as l_value and then Result = l_value.item (index)
		end

	column_name (index: INTEGER): detachable STRING
			-- Name of the `index'-th column.
		local
			l_select_name: like select_name
		do
			l_select_name := select_name
			if l_select_name /= Void and then l_select_name.valid_index (index) then
				Result := l_select_name.item (index)
			end
		ensure then
			returned_name: attached select_name as le_select_name and then Result = le_select_name.item (index)
		end

feature -- Element change

	reset_data
			-- Reset count, keeping cached data for performance.
		do
			count := 0
		end

	update_map_table (object: ANY)
			-- Update map table according to field names of `object'
			-- and `Current' metadata.
		local
			g: INTEGER
			ind, index: INTEGER
			l_map_table: like map_table
			l_buffer: like buffer
			l_obj_dyn_type: INTEGER
			l_field_list: SPECIAL [STRING_8]
		do
			g := field_count (object)
			l_map_table := map_table
			if l_map_table = Void then
				create l_map_table.make_filled (0, 1, count)
				map_table := l_map_table
			elseif l_map_table.count < count then
				l_map_table.conservative_resize_with_default (0, 1, count)
			end
			from
				from
						-- Prepopulate object field list for faster lookup.
					l_obj_dyn_type := dynamic_type (object)
					create l_field_list.make_empty (g + 1)
						-- Add empty string at zero index.
					l_field_list.extend ("")
					ind := 1
				until
					ind > g
				loop
					l_field_list.extend (field_name_of_type (ind, l_obj_dyn_type))
					ind := ind + 1
				end

				l_buffer := buffer
				ind := 1
			until
				ind > count
			loop
				l_buffer.wipe_out
				l_buffer.append_string (column_name (ind))
				l_buffer.right_adjust
				l_buffer.to_lower
				from
					index := 1
				until
					index > g or else l_field_list [index].is_equal (l_buffer)
				loop
					index := index + 1
				end
				if index <= g then
						-- Free field list entry memory.
					l_field_list [index].wipe_out
					l_field_list [index].adapt_size
					l_map_table.put (index, ind)
				else
					db_spec.update_map_table_error (handle, l_map_table, ind)
				end
				ind := ind + 1
			end
		end

	fill_in (no_descriptor: INTEGER)
			-- Fill attributes of Current with results obtained
			-- from server after execution of query statement.
		local
			ind: INTEGER
			date: DATE
			time: TIME
			get_metadata: BOOLEAN
			l_any: detachable ANY
			l_integer_32: INTEGER_32_REF
			l_integer_16: INTEGER_16_REF
			l_integer_64: INTEGER_64_REF
			l_real_64: REAL_64_REF
			l_real_32: REAL_32_REF
			l_date: DATE_TIME
			l_boolean: BOOLEAN_REF
			l_string_8: STRING_8
			l_string_32: STRING_32
			l_value_size: like value_size
			l_value_max_size: like value_max_size
			l_database_string: like database_string
			l_database_string_32: like database_string_32
			l_value_type: like value_type
			l_value: like value
			l_select_name: like select_name
			l_db_spec: like db_spec
		do
			l_database_string := database_string
			if l_database_string = Void then
				create l_database_string.make (selection_string_size)
				database_string := l_database_string
			end
			l_database_string_32 := database_string_32
			if l_database_string_32 = Void then
				create l_database_string_32.make (selection_string_size)
				database_string_32 := l_database_string_32
			end

			l_db_spec := db_spec

			count := l_db_spec.get_count (no_descriptor)
			get_metadata := False  -- do not get metadata
			l_value := value
			l_value_size := value_size
			l_value_max_size := value_max_size
			l_value_type := value_type
			l_select_name := select_name
			if l_value /= Void and l_value_size /= Void and l_value_max_size /= Void and l_value_type /= Void and l_select_name /= Void then
					-- `metadata_to_update' is True at the beginning of every new selection.
				if metadata_to_update then
					l_value.conservative_resize_with_default (Void, 1, count)
					l_value_size.conservative_resize_with_default (0, 1, count)
					l_value_max_size.conservative_resize_with_default (0, 1, count)
					l_value_type.conservative_resize_with_default (0, 1, count)
					l_select_name.conservative_resize_with_default (Void, 1, count)
					get_metadata := True --PGC
					metadata_to_update := False
				end
			else
				create l_value.make_filled (Void, 1, count)
				create l_value_size.make_filled (0, 1, count)
				create l_value_max_size.make_filled (0, 1, count)
				create l_value_type.make_filled (0, 1, count)
				create l_select_name.make_filled (Void, 1, count)
				get_metadata := True --PGC
				value := l_value
				value_size := l_value_size
				value_max_size := l_value_max_size
				value_type := l_value_type
				select_name := l_select_name
			end

			from
				ind := 1
			until
				ind > count
			loop
				if get_metadata then --PGC
					l_value_size.put (l_db_spec.get_data_len (no_descriptor, ind), ind)
					l_value_max_size.put (l_db_spec.get_col_len (no_descriptor, ind), ind)
					l_value_type.put (l_db_spec.get_col_type (no_descriptor, ind), ind)

					if attached l_select_name.item (ind) as l_string_8_result then
						l_string_8 := l_string_8_result
						l_string_8.wipe_out
					else
						create l_string_8.make (1)
						l_select_name.put (l_string_8, ind)
					end
					l_database_string.get_select_name (no_descriptor, ind)
						-- Due to a Problem with SQL Server through ODBC
						-- we need to remove all the %U of the string.

					l_string_8.append (l_database_string)
				end --PGC


				l_any := l_value.item (ind)

				if not l_db_spec.is_null_data (no_descriptor, ind) then

					inspect l_value_type.item (ind)
						-- STRING TYPE
					when {DB_TYPES}.string_type then
						l_database_string.get_value (no_descriptor, ind)
						if attached {STRING_8} l_any as l_string_8_result then
							l_string_8 := l_string_8_result
							l_string_8.wipe_out
						else
							create l_string_8.make_empty
						end
						l_string_8.append (l_database_string)
						l_value.put (l_string_8, ind)

						-- STRING_32 TYPE
					when {DB_TYPES}.string_32_type then
						l_database_string_32.get_value (no_descriptor, ind)
						if attached {STRING_32} l_any as l_string_32_result then
							l_string_32 := l_string_32_result
							l_string_32.wipe_out
						else
							create l_string_32.make_empty
						end
						l_string_32.append (l_database_string_32)
						if use_extended_types then
							l_value.put (l_string_32, ind)
						else
							if l_string_32.is_valid_as_string_8 then
								l_value.put (l_string_32.to_string_8, ind)
							else
								l_value.put ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_string_32), ind)
								fixme ("Report data loss, or utf-8 encoding.")
							end
						end

						-- INTEGER type
					when {DB_TYPES}.integer_32_type then
						if attached {INTEGER_32_REF} l_any as l_integer_result then
							l_integer_32 := l_integer_result
						else
							create l_integer_32
						end
						l_value.put (l_integer_32, ind)
						l_integer_32.set_item (l_db_spec.get_integer_data (no_descriptor, ind))

						-- INTEGER_16 type
					when {DB_TYPES}.integer_16_type then
						if attached {INTEGER_16_REF} l_any as l_integer_16_result then
							l_integer_16 := l_integer_16_result
						else
							create l_integer_16
						end
						l_integer_16.set_item (l_db_spec.get_integer_16_data (no_descriptor, ind))

						if use_extended_types then
							l_value.put (l_integer_16, ind)
						else
								-- Case where we only support INTEGER on the Eiffel side.
							create l_integer_32
							l_integer_32.set_item (l_integer_16.item)
							l_value.put (l_integer_32, ind)
						end

						-- INTEGER_64 type
					when {DB_TYPES}.integer_64_type then
						if attached {INTEGER_64_REF} l_any as l_integer_64_result then
							l_integer_64 := l_integer_64_result
						else
							create l_integer_64
						end
						l_integer_64.set_item (l_db_spec.get_integer_64_data (no_descriptor, ind))

						if use_extended_types then
							l_value.put (l_integer_64, ind)
						else
								-- Case where we only support INTEGER on the Eiffel side.
							create l_integer_32
							l_integer_32.set_item (l_integer_64.item.as_integer_32)
							if (l_integer_64.item > {INTEGER_32}.max_value or l_integer_64.item < {INTEGER_32}.min_value) then
								fixme ("Report data loss.")
							end
							l_value.put (l_integer_32, ind)
						end

						-- DATE type
					when {DB_TYPES}.date_type then
						if l_db_spec.get_date_data (no_descriptor, ind) = 1 then
							create time.make (l_db_spec.get_hour (no_descriptor, ind), l_db_spec.get_min (no_descriptor, ind), l_db_spec.get_sec (no_descriptor, ind))
							create date.make_month_day_year (l_db_spec.get_month (no_descriptor, ind), l_db_spec.get_day (no_descriptor, ind), l_db_spec.get_year (no_descriptor, ind))
							if attached {DATE_TIME} l_any as l_date_result then
								l_date := l_date_result
							else
								create l_date.make_now
							end
							l_date.set_time (time)
							l_date.set_date (date)
							l_value.put (l_date, ind)
						else
							l_value.put (Void, ind)
						end

        				-- REAL type
		           	when {DB_TYPES}.real_32_type then
						if attached {REAL_32_REF} l_any as l_real_32_result then
							l_real_32 := l_real_32_result
						else
							create l_real_32
						end
						l_real_32.set_item (l_db_spec.get_real_data (no_descriptor, ind))
						l_value.put (l_real_32, ind)

						-- REAL_64 type
					when {DB_TYPES}.real_64_type then
						if attached {REAL_64_REF} l_any as l_real_64_result then
							l_real_64 := l_real_64_result
						else
							create l_real_64
						end
						l_real_64.set_item (l_db_spec.get_float_data (no_descriptor, ind))
						l_value.put (l_real_64, ind)

						-- DECIMAL type
					when {DB_TYPES}.decimal_type then
						if not is_decimal_used then
							if attached {REAL_64_REF} l_any as l_real_64_result then
								l_real_64 := l_real_64_result
							else
								create l_real_64
							end
							l_real_64.set_item (l_db_spec.get_float_data (no_descriptor, ind))
							l_value.put (l_real_64, ind)
						else
							if attached l_db_spec.get_decimal (no_descriptor, ind) as l_decimal then
								l_value.put (decimal_creation_function.item (l_decimal), ind)
							else
								l_value.put (Void, ind)
							end
						end

  						-- BOOLEAN type
					when {DB_TYPES}.boolean_type then
						if attached {BOOLEAN_REF} l_any as l_boolean_result then
							l_boolean := l_boolean_result
						else
							create l_boolean
						end
						l_boolean.set_item (l_db_spec.get_boolean_data(no_descriptor, ind))
						l_value.put (l_boolean, ind)

					else
						check known_type: False end
						l_value.put (Void, ind)
					end
				else
					l_value.put (Void, ind)
				end
				ind := ind + 1
			end
		ensure then
			set_together: value /= Void implies value_size /= Void and value_max_size /= Void and value_type /= Void and select_name /= Void
		end

feature {NONE} -- Status report

	database_string: detachable DATABASE_STRING_EX [G]
		-- String returned from the database C interface

	database_string_32: detachable DATABASE_STRING_32_EX [G]
		-- String returned from the database C interface WIDE version.

	buffer: STRING
			-- String buffer.
		once
			create Result.make (50)
		ensure
			result_not_void: Result /= Void
		end

	value: detachable ARRAY [detachable ANY] note option: stable attribute end
		-- Array of values corresponding to a tuple

	value_size: detachable ARRAY [INTEGER] note option: stable attribute end
		-- Array of result value size for each column

	value_max_size: detachable ARRAY [INTEGER] note option: stable attribute end
		-- Array of column capacity

	value_type: detachable ARRAY [INTEGER] note option: stable attribute end
		-- Array of column result type coded according to Eiffel conventions

	select_name: detachable ARRAY [detachable STRING] note option: stable attribute end
		-- Array of selected column names listed in select clause

invariant
	all_voids: value = Void implies value_size = Void and value_max_size = Void and value_type = Void and select_name = Void
	all_non_voids: value /= Void implies value_size /= Void and value_max_size /= Void and value_type /= Void and select_name /= Void

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DATABASE_DATA


