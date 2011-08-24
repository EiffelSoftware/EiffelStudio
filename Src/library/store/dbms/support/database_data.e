note
	description: "Implementation of DB_DATA"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_DATA [G -> DATABASE create default_create end]

inherit

	DB_STATUS_USE

	DB_DATA_SQL

	EXT_INTERNAL

	DB_CONSTANT
		export
			{NONE} all
		end

	TYPES [G]

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
		require else
			index_in_range: valid_index (index)
		local
			l_value: like value
		do
			l_value := value
			check l_value /= Void end -- FIXME: implied by precursor's precondition `value_not_void', but `require else'...
			Result := l_value.item (index)
		ensure then
			returned_value: attached value as le_value and then Result = le_value.item (index)
		end

	valid_index (index: INTEGER): BOOLEAN
			-- Is `index' valid for `value'?
		do
			Result := index >0 and index <= count
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
					l_field_list [index].resize (0)
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
			l_integer: like f_integer
			l_integer_16: like f_integer_16
			l_integer_64: like f_integer_64
			l_double: like f_double
			l_real: like f_real
			l_date: like f_date
			l_boolean: like f_boolean
			l_string: like f_string
			l_string_32: like f_string_32
			l_value_size: like value_size
			l_value_max_size: like value_max_size
			l_database_string: like database_string
			l_database_string_32: like database_string_32
			l_value_type: like value_type
			l_value: like value
			l_select_name: like select_name
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
			count := db_spec.get_count (no_descriptor)
			get_metadata := False  -- do not get metadata
			l_value := value
			if l_value = Void then
				create l_value.make_filled (Void, 1, count)
				value := l_value
				create value_size.make_filled (0, 1, count)
				create value_max_size.make_filled (0, 1, count)
				create value_type.make_filled (0, 1, count)
				create select_name.make_filled (Void, 1, count)
				get_metadata := True --PGC

					-- `metadata_to_update' is True at the beginning of every new selection.
			elseif metadata_to_update then
				l_value.conservative_resize_with_default (Void, 1, count)
				l_value_size := value_size
				check l_value_size /= Void end -- implied by `fill_in' postcondition `set_together'
				l_value_size.conservative_resize_with_default (0, 1, count)

				l_value_max_size := value_max_size
				check l_value_max_size /= Void end -- implied by `fill_in' postcondition `set_together'
				l_value_max_size.conservative_resize_with_default (0, 1, count)

				l_value_type := value_type
				check l_value_type /= Void end -- implied by `fill_in' postcondition `set_together'
				l_value_type.conservative_resize_with_default (0, 1, count)

				l_select_name := select_name
				check l_select_name /= Void end -- implied by `fill_in' postcondition `set_together'
				l_select_name.conservative_resize_with_default (Void, 1, count)
				get_metadata := True --PGC
				metadata_to_update := False
			end
			l_value_size := value_size
			check l_value_size /= Void end -- implied by `fill_in' postcondition `set_together'
			l_value_max_size := value_max_size
			check l_value_max_size /= Void end -- implied by `fill_in' postcondition `set_together'
			l_value_type := value_type
			check l_value_type /= Void end -- implied by `fill_in' postcondition `set_together'
			l_select_name := select_name
			check l_select_name /= Void end -- implied by `fill_in' postcondition `set_together'

			from
				ind := 1
			until
				ind > count
			loop
				if get_metadata then --PGC
					l_value_size.put (db_spec.get_data_len (no_descriptor, ind), ind)
					l_value_max_size.put (db_spec.get_col_len (no_descriptor, ind), ind)
					l_value_type.put (db_spec.get_col_type (no_descriptor, ind), ind)

					f_string := l_select_name.item (ind)
					l_string := f_string
					if l_string = Void then
						create l_string.make (1)
						f_string := l_string
						l_select_name.put (l_string, ind)
					else
						l_string.wipe_out
					end
					l_database_string.get_select_name (no_descriptor, ind)
						-- Due to a Problem with SQL Server through ODBC
						-- we need to remove all the %U of the string.

					l_string.append (l_database_string)
				end --PGC

				f_any := l_value.item (ind)

				if not db_spec.is_null_data (no_descriptor, ind) then

					-- STRING TYPE
					if l_value_type.item (ind) = String_type_database then
						l_database_string.get_value (no_descriptor, ind)
						if l_value_size.item (ind) = l_value_max_size.item (ind) then
							l_database_string.right_adjust
						end
						if attached {like f_string} f_any as l_string_2 then
							l_string_2.wipe_out
							f_string := l_string_2
						else
							create f_string.make_empty
						end
						l_string := f_string
						check l_string /= Void end -- implied by previous if clause
						l_string.append (l_database_string)
						l_value.put (l_string, ind)

					-- STRING_32 TYPE
					elseif l_value_type.item (ind) = Wide_string_type_database then
						l_database_string_32.get_value (no_descriptor, ind)
						if l_value_size.item (ind) = l_value_max_size.item (ind) then
							l_database_string_32.force_right_adjust
						end
						if attached {like f_string_32} f_any as l_string_3 then
							l_string_3.wipe_out
							f_string_32 := l_string_3
						else
							create f_string_32.make_empty
						end
						l_string_32 := f_string_32
						check l_string_32 /= Void end -- implied by previous if clause
						l_string_32.append (l_database_string_32)
						if use_extended_types then
							l_value.put (l_string_32, ind)
						else
							if l_string_32.is_valid_as_string_8 then
								l_value.put (l_string_32.as_string_8, ind)
							else
								l_value.put (l_string_32.as_string_8, ind)
								fixme ("Report data loss.")
							end
						end

					-- INTEGER type
					elseif l_value_type.item (ind) = Integer_type_database then
						if f_any = Void then
							create f_integer
							l_value.put (f_integer, ind)
						else
							if attached {like f_integer} f_any as l_integer_2 then
								f_integer := l_integer_2
							else
								create f_integer
								l_value.put (f_integer, ind)
							end
						end
						l_integer := f_integer
						check l_integer /= Void end -- implied by previous if clause
						l_integer.set_item (db_spec.get_integer_data (no_descriptor, ind))

					-- INTEGER_16 type
					elseif l_value_type.item (ind) = Integer_16_type_database then
						if f_any = Void then
							create f_integer_16
							l_value.put (f_integer_16, ind)
						else
							if attached {like f_integer_16} f_any as l_integer_3 then
								f_integer_16 := l_integer_3
							else
								create f_integer_16
								l_value.put (f_integer_16, ind)
							end
						end
						l_integer_16 := f_integer_16
						check l_integer_16 /= Void end -- implied by previous if clause
						l_integer_16.set_item (db_spec.get_integer_16_data (no_descriptor, ind))

						if not use_extended_types then
							l_value.put (l_integer_16.item.as_integer_32.to_reference, ind)
						end

					-- INTEGER_64 type
					elseif l_value_type.item (ind) = Integer_64_type_database then
						if f_any = Void then
							create f_integer_64
							l_value.put (f_integer_64, ind)
						else
							if attached {like f_integer_64} f_any as l_integer_4 then
								f_integer_64 := l_integer_4
							else
								create f_integer_64
								l_value.put (f_integer_64, ind)
							end
						end
						l_integer_64 := f_integer_64
						check l_integer_64 /= Void end -- implied by previous if clause
						l_integer_64.set_item (db_spec.get_integer_64_data (no_descriptor, ind))

						if not use_extended_types then
							l_value.put (l_integer_64.item.as_integer_32.to_reference, ind)
							if (l_integer_64.item > {INTEGER_32}.max_value or l_integer_64.item < {INTEGER_32}.min_value) then
								fixme ("Report data loss.")
							end
						end

					-- DOUBLE type
					elseif l_value_type.item (ind) = Float_type_database then
						if f_any = Void then
							create f_double
							l_value.put (f_double, ind)
						else
							if attached {like f_double} f_any as l_double_2 then
								f_double := l_double_2
							else
								create f_double
								l_value.put (f_double, ind)
							end
						end
						l_double := f_double
						check l_double /= Void end -- implied by previous if clause
						l_double.set_item (db_spec.get_float_data (no_descriptor, ind))

					-- DATE type
					elseif l_value_type.item (ind) = Date_type_database then
						if f_any = Void then
							create f_date.make_now
							l_value.put (f_date, ind)
						else
							if attached {like f_date} f_any as l_date_2 then
								f_date := l_date_2
							else
								create f_date.make_now
								l_value.put (f_date, ind)
							end
						end
						if db_spec.get_date_data (no_descriptor, ind) = 1 then
							create time.make (db_spec.get_hour (no_descriptor, ind), db_spec.get_min (no_descriptor, ind), db_spec.get_sec (no_descriptor, ind))
							create date.make_month_day_year (db_spec.get_month (no_descriptor, ind), db_spec.get_day (no_descriptor, ind), db_spec.get_year (no_descriptor, ind))
							l_date := f_date
							check l_date /= Void end -- implied by previous if clause
							l_date.set_time (time)
							l_date.set_date (date)
						else
							l_value.put (Void, ind)
						end

          			-- REAL type
		           	elseif l_value_type.item (ind) = Real_type_database then
 		            	if f_any = Void then
							create f_real
							l_value.put (f_real, ind)
						else
                	   		if attached {like f_real} f_any as l_real_2 then
                	   			f_real := l_real_2
                	   		else
         	                    create f_real
            	               	l_value.put (f_real, ind)
                	   		end
           				end
           				l_real := f_real
           				check l_real /= Void end -- implied by previous if clause
						l_real.set_item (db_spec.get_real_data (no_descriptor, ind))

					-- BOOLEAN type
					else--if value_type.item (ind) = Boolean_type_database then
						if f_any = Void then
							create f_boolean
							l_value.put (f_boolean, ind)
						else
							if attached {like f_boolean} f_any as l_boolean_2 then
								f_boolean := l_boolean_2
							else
								create f_boolean
								l_value.put (f_boolean, ind)
							end
						end
						l_boolean := f_boolean
						check l_boolean /= Void end -- implied by previsoue if clause
						l_boolean.set_item (db_spec.get_boolean_data(no_descriptor, ind))
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

	f_any: detachable ANY
	f_integer: detachable INTEGER_REF
	f_integer_16: detachable INTEGER_16_REF
	f_integer_64: detachable INTEGER_64_REF
	f_real: detachable REAL_REF
	f_double: detachable DOUBLE_REF
	f_boolean: detachable BOOLEAN_REF
	f_date: detachable DATE_TIME
	f_string: detachable STRING
	f_string_32: detachable STRING_32
			-- Temporary variables

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

	value: detachable ARRAY [detachable ANY]
		-- Array of values corresponding to a tuple

	value_size: detachable ARRAY [INTEGER]
		-- Array of result value size for each column

	value_max_size: detachable ARRAY [INTEGER]
		-- Array of column capacity

	value_type: detachable ARRAY [INTEGER]
		-- Array of column result type coded according to Eiffel conventions

	select_name: detachable ARRAY [detachable STRING];
		-- Array of selected column names listed in select clause

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATABASE_DATA


