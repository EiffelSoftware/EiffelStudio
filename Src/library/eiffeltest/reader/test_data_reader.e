indexing
	description:
		"Reader for injecting test input data from a file into a test case"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	TEST_DATA_READER [G -> TEST_CASE create make end]

create

	make, make_with_result_column

feature {NONE} -- Initialization

	make (f: PLAIN_TEXT_FILE; c: INTEGER) is
			-- Create reader with input file `f' and `c' columns.
		require
			file_readable: f /= Void and then f.exists and then f.is_readable
			column_number_positive: c > 0
		do
			file := f
			create table.make (1, c)
		ensure
			file_set: file = f
			columns_set: columns = c
			table_created: table /= Void
			no_result_column: not has_result_column
		end

	make_with_result_column (f: PLAIN_TEXT_FILE; c: INTEGER) is
			-- Create reader with input file `f, `c' columns, and a result
			-- column.
		require
			file_readable: f /= Void and then f.exists and then f.is_readable
			column_number_positive: c > 0
		local
			r: RESULT_COLUMN
		do
			make (f, c + 1)
			create r
			table.put (r, table.count)
			has_result_column := True
		ensure
			file_set: file = f
			columns_set: columns = c + 1
			table_created: table /= Void
			last_column_set: table @ table.count /= Void
			result_column: has_result_column
		end

feature -- Access

	last_string: STRING is
			-- Last string read from file
		do
			Result := file.last_string
		end
		
	data_values: ARRAY [STRING]
			-- Test data values parsed out of `last_string'
			
	suite: TEST_SUITE
			-- Generated test suite
			
feature -- Measurement

	columns: INTEGER is
			-- Number of columns in table
		do
			Result := table.count
		end

feature -- Status report

	end_of_file: BOOLEAN is
			-- Is file at end?
		do
			Result := file.end_of_file
		end

	is_open: BOOLEAN is
			-- Is file open?
		do
			Result := file.is_open_read
		end

	is_line_valid: BOOLEAN is
			-- Does `last_string' hold a valid test data record?
		do
			if has_last_string then
				Result := (last_string.occurrences ('%T') = columns - 1) and 
					(last_string.item (1) /= '%T') and
					(last_string.item (last_string.count) /= '%T')
			end
		end

	has_last_string: BOOLEAN is
			-- Is `last_string' accessible?
		do
			Result := last_string /= Void
		end

	has_data_values: BOOLEAN is
			-- Is `data_values' accesible?
		do
			Result := data_values /= Void
		end
			
	is_suite_generated: BOOLEAN is
			-- Has test suite been generated?
		do
			Result := suite /= Void
		end

	is_complete: BOOLEAN is
			-- Is test input table set up completely?
		do
			Result := (table.occurrences (Void) = 0)
		end
		
	all_values_valid: BOOLEAN is
			-- Are all entries in `data_values' valid?
		require
			data_values_available: has_data_values
		local
			i: INTEGER
		do
			from 
				i := 1 
				Result := True
			until 
				not Result or i > data_values.count 
			loop
				if data_values @ i /= Void then
					Result := ((data_values @ i).occurrences ('%T') = 0) and
						(table @ i).input_accepted (data_values @ i)
				else 
					Result := (table @ i).input_accepted (data_values @ i)
				end
				i := i + 1
			end
		end

	has_result_column: BOOLEAN
			-- Does table have a result column?

	valid_column_index (i: INTEGER): BOOLEAN is
			-- Is column index `i' valid?
		local
			maxcol: INTEGER
		do
			if has_result_column then
				maxcol := columns - 1
			else
				maxcol := columns
			end
			Result := 1 <= i and i <= maxcol
		end
		
	is_log_set: BOOLEAN is
			-- Is a log facility set up?
		do
			Result := log /= Void and then log.is_format_set
		end

	is_comment: BOOLEAN is
			-- Is record in `last_line' commented out?
		require
			last_string_available: has_last_string
		do
			Result := (last_string.item (1) = Comment_character)
		end
		
feature -- Status setting

	set_log (l: LOG_FACILITY) is
			-- Set log facility to `l'.
		require
			log_exists: l /= Void
			log_format_set: l.is_format_set
		do
			log := l
		ensure
			log_set: log = l
		end

feature -- Element change

	set_column (c: TEST_DATA_COLUMN; pos: INTEGER) is
			-- Set column handler `c' at column `pos'.
		require
			handler_exists: c /= Void
			valid_position: valid_column_index (pos)
		do
			table.put (c, pos)
		ensure
			handler_set: table @ pos = c
		end

feature -- Basic operations

	build_suite is
			-- Build test suite.
		require
			complete: is_complete
		local
			count: INTEGER
			invalid: BOOLEAN
		do
			suite := Void
			file.open_read
			from count := 1 until end_of_file loop
				file.read_line
				invalid := not is_line_valid
				if not invalid then 
					parse_line 
					if all_values_valid then inject_record (count) end
				end
				
				if (invalid or not all_values_valid) and not last_string.empty 
					and is_log_set then
					log.put_string ("Record " + count.out + " not valid!")
					log.put_new_line
				end
				count := count + 1
			end
			file.close
		ensure
			suite_not_empty: is_suite_generated implies not suite.empty
		end
				 
feature {NONE} -- Constants

	Comment_character: CHARACTER is '#'
			-- Character for commenting out data records
	Void_entity: STRING is "[]"
			-- String that is used for denoting a void string object
 
feature {NONE} -- Implementation

	table: ARRAY [TEST_DATA_COLUMN]
			-- Table storing test data column handlers

	file: FILE
			-- Input file

	log: LOG_FACILITY
			-- Log for error output
			
	parse_line is
			-- Parse data values in `last_string'
		require
			line_available: has_last_string
			line_valid: is_line_valid
		local
			s: STRING
			val: STRING
			i: INTEGER
			pos: INTEGER
		do
			create data_values.make (1, columns)
			s := clone (last_string)
			if is_comment then s.tail (s.count - 1) end
			from i := 1 until i > columns loop
				pos := s.index_of ('%T', 1)
				if pos > 0 then
					val := s.substring (1, pos - 1)
					s.tail (s.count - pos)
				else
					val := s
				end
				if equal (val, Void_entity) then val := Void end
				data_values.put (val, i)
				i := i + 1
			end
		ensure
			data_values_exist: data_values /= Void
			columns_ok: data_values.count = columns
			
		end

	inject_record (c: INTEGER) is
			-- Inject current record into new test case instance and add it to
			-- `suite'.
		require
			count_positive: c > 0
			has_data_values: has_data_values
			valid_data: all_values_valid
		local
			tc: G
			i: INTEGER
		do
			if suite = Void then create suite.make end
			create tc.make
			from i := 1 until i > columns loop
				(table @ i).inject (tc, (data_values @ i))
				i := i + 1
			end
			if is_comment then
				tc.disable_test
				if is_log_set then
					log.put_string ("Record " + c.out + " is disabled!")
					log.put_new_line
				end
			end
			suite.extend (tc)
		ensure
			suite_exists: suite /= Void
		end
			
invariant

	table_exists: table /= Void
	file_exists: file /= Void
	valid_line_constraint: is_line_valid implies has_last_string
	data_values_consistent: has_data_values implies data_values.count = columns

end -- class TEST_DATA_READER

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
