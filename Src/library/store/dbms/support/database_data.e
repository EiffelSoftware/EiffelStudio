indexing
	description: "Implementation of DB_DATA";
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

feature -- Status report

	count:  INTEGER
		-- Number of columns in result

	map_table: ARRAY [INTEGER]
		-- Correspondance table between column rank and
		-- attribute rank in mapped object

	item (index: INTEGER): ANY is
			-- Data at `index'-th column.
		require else
			index_in_range: index > 0 and index <= count
		do
			Result := value.item (index)
		ensure then
			returned_value: Result = value.item (index)
		end

	column_name (index: INTEGER): STRING is
			-- Name of the `index'-th column.
		require else
			index_in_range: index > 0 and index <= count
		do
			Result := select_name.item (index)
		ensure then
			returned_name: Result = select_name.item (index)
		end

feature -- Element change

	update_map_table (object: ANY) is
			-- Update map table according to field names of `object'
			-- and `Current' metadata.
		require else
			object_exists: object /= Void
		local
			g: INTEGER
			ind, index: INTEGER
		do
			g := field_count (object)
			if map_table = Void then
				create map_table.make (1, count)
			elseif map_table.count < count then
				map_table.resize (1, count)
			end
			from
				ind := 1
			until
				ind > count
			loop
				buffer.wipe_out
				buffer.append (column_name (ind))
				buffer.to_lower
				buffer.right_adjust
				from
					index := 1
				until
					index > g or else field_name (index, object).is_equal (buffer) 
				loop
					index := index + 1
				end
				if index <= g then
					map_table.put (index, ind)
				else
					db_spec.update_map_table_error (handle, map_table, ind)
					ind := count
				end
				ind := ind + 1
			end
		end

	fill_in (no_descriptor: INTEGER) is
			-- Fill attributes of Current with results obtained
			-- from server after execution of query statement.
		local
			i, ind: INTEGER
			d_year, d_month, d_day, d_hour, d_min, d_sec, d_ms: INTEGER
			date: DATE
			time: TIME
			get_metadata : BOOLEAN
		do
			if database_string = Void then
				create database_string.make (selection_string_size)
			end
			count := db_spec.get_count (no_descriptor)
			get_metadata := False  -- do not get metadata
			if value = Void then
				create value.make (1, count)
				create value_size.make (1, count)
				create value_max_size.make (1, count)
				create value_type.make (1, count)
				create select_name.make (1, count)
				get_metadata := True --PGC
				
					-- `metadata_to_update' is True at the beginning of every new selection.
			elseif metadata_to_update then
				value.resize (1, count)
				value_size.resize (1, count)
				value_max_size.resize (1, count)
				value_type.resize (1, count)
				select_name.resize (1, count)
				get_metadata := True --PGC
				metadata_to_update := False
			end
			from
				ind := 1
			until
				ind > count
			loop
				if get_metadata then --PGC
					value_size.put (db_spec.get_data_len (no_descriptor, ind), ind)
					value_max_size.put (db_spec.get_col_len (no_descriptor, ind), ind)
					value_type.put (db_spec.get_col_type (no_descriptor, ind), ind)
					f_string := select_name.item (ind)
					if f_string = Void then
						create f_string.make (1)
						select_name.put (f_string, ind)
					else
						f_string.wipe_out
					end
					database_string.get_select_name (no_descriptor, ind)
						-- Due to a Problem with SQL Server through ODBC
						-- we need to remove all the %U of the string.

					f_string.append (database_string)
				end --PGC

				f_any := value.item (ind)

				-- STRING type: Void value is coded by empty string.
				if value_type.item (ind) = String_type_database then
					database_string.get_value (no_descriptor, ind)
					if value_size.item (ind) = value_max_size.item (ind) then
						database_string.right_adjust
					end
					f_string ?= f_any
					if f_string = Void then
						create f_string.make (1)
						value.put (f_string, ind)
					else
						f_string.wipe_out
					end
					f_string.append (database_string)

				elseif not db_spec.is_null_data (no_descriptor, ind) then

					-- INTEGER type
					if value_type.item (ind) = Integer_type_database then		
						if f_any = Void then
							create f_integer
							value.put (f_integer, ind)
						else
							f_integer ?= f_any
							if f_integer = Void then
								create f_integer
								value.put (f_integer, ind)
							end
						end
						f_integer.set_item (db_spec.get_integer_data (no_descriptor, ind))

					-- DOUBLE type
					elseif value_type.item (ind) = Float_type_database then
						if f_any = Void then
							create f_double
							value.put (f_double, ind)
						else
							f_double ?= f_any
							if f_double = Void then
								create f_double
								value.put (f_double, ind)
							end
						end
						f_double.set_item (db_spec.get_float_data (no_descriptor, ind))

					-- DATE type
					elseif value_type.item (ind) = Date_type_database then
						if f_any = Void then
							create f_date.make_now
							value.put (f_date, ind)
						else
							f_date ?= f_any
							if f_date = Void then
								create f_date.make_now
								value.put (f_date, ind)
							end
						end
						if db_spec.get_date_data (no_descriptor, ind) = 1 then
							create time.make (db_spec.get_hour (no_descriptor, ind), db_spec.get_min (no_descriptor, ind), db_spec.get_sec (no_descriptor, ind))
							create date.make_month_day_year (db_spec.get_month (no_descriptor, ind), db_spec.get_day (no_descriptor, ind), db_spec.get_year (no_descriptor, ind))
							f_date.set_time (time)
							f_date.set_date (date)
						else
							value.put (Void, ind)
						end

          			-- REAL type
		           	elseif value_type.item (ind) = Real_type_database then
 		            	if f_any = Void then
							create f_real
							value.put (f_real, ind)
						else
							f_real ?= f_any
    		                if f_real = Void then
        	                    create f_real
            	               	value.put (f_real, ind)
                	   		end
           				end
						f_real.set_item (db_spec.get_real_data (no_descriptor, ind))

					-- BOOLEAN type
					else--if value_type.item (ind) = Boolean_type_database then
						if f_any = Void then
							create f_boolean
							value.put (f_boolean, ind)
						else
							f_boolean ?= f_any
							if f_boolean = Void then
								create f_boolean
								value.put (f_boolean, ind)
							end
						end
						f_boolean.set_item (db_spec.get_boolean_data(no_descriptor, ind))
					end
				else
					value.put (Void, ind)
				end
				ind := ind + 1
			end
		end

feature {NONE} -- Status report

	f_any: ANY
	f_integer: INTEGER_REF
	f_real: REAL_REF
	f_double: DOUBLE_REF
	f_boolean: BOOLEAN_REF
	f_date: DATE_TIME
	f_string, tmp_string: STRING
			-- Temporary variables

	database_string: DATABASE_STRING_EX [G]
		-- String returned from the database C interface 

	buffer: STRING is
			-- String buffer.
		once
			create Result.make (50)
		ensure
			result_not_void: Result /= Void
		end

	value: ARRAY [ANY]
		-- Array of values corresponding to a tuple

	value_size: ARRAY [INTEGER]
		-- Array of result value size for each column

	value_max_size: ARRAY [INTEGER]
		-- Array of column capacity

	value_type: ARRAY [INTEGER]
		-- Array of column result type coded according to Eiffel conventions

	select_name: ARRAY [STRING]
		-- Array of selected column names listed in select clause

end -- class DATABASE_DATA

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
