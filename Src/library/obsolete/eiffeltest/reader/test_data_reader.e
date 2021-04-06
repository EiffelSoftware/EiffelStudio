note
	description: "Reader for injecting test input data from a file into a test case."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DATA_READER [G -> TEST_SIMPLE_CASE create make end]

create

	make, make_with_result_column

feature {NONE} -- Initialization

	make (f: PLAIN_TEXT_FILE; c: INTEGER)
			-- Create reader with input file `f' and `c' columns.
		require
			file_readable: f /= Void and then f.exists and then f.is_readable
			column_number_positive: c > 0
		do
			file := f
			create table.make_filled (Void, 1, c)
		ensure
			file_set: file = f
			columns_set: columns = c
			table_created: table /= Void
			no_result_column: not has_result_column
		end

	make_with_result_column (f: PLAIN_TEXT_FILE; c: INTEGER)
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
			last_column_set: table [table.count] /= Void
			result_column: has_result_column
		end

feature -- Access

	last_string: STRING
			-- Last string read from file
		do
			Result := file.last_string
		end

	data_values: ARRAY [STRING]
			-- Test data values parsed out of `last_string'

	suite: TEST_SUITE
			-- Generated test suite

feature -- Measurement

	columns: INTEGER
			-- Number of columns in table
		do
			Result := table.count
		end

feature -- Status report

	end_of_file: BOOLEAN
			-- Is file at end?
		do
			Result := file.end_of_file
		end

	is_open: BOOLEAN
			-- Is file open?
		do
			Result := file.is_open_read
		end

	is_line_valid: BOOLEAN
			-- Does `last_string' hold a valid test data record?
		do
			if has_last_string then
				Result := (last_string.occurrences ('%T') = columns - 1) and
					(last_string.item (1) /= '%T') and
					(last_string.item (last_string.count) /= '%T')
			end
		end

	has_last_string: BOOLEAN
			-- Is `last_string' accessible?
		do
			Result := last_string /= Void
		end

	has_data_values: BOOLEAN
			-- Is `data_values' accesible?
		do
			Result := data_values /= Void
		end

	is_suite_generated: BOOLEAN
			-- Has test suite been generated?
		do
			Result := suite /= Void
		end

	is_complete: BOOLEAN
			-- Is test input table set up completely?
		do
			Result := (table.occurrences (Void) = 0)
		end

	all_values_valid: BOOLEAN
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
				if data_values [i] /= Void then
					Result := ((data_values [i]).occurrences ('%T') = 0) and
						(table [i]).input_accepted (data_values [i])
				else
					Result := (table [i]).input_accepted (data_values [i])
				end
				i := i + 1
			end
		end

	has_result_column: BOOLEAN
			-- Does table have a result column?

	valid_column_index (i: INTEGER): BOOLEAN
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

	is_log_set: BOOLEAN
			-- Is a log facility set up?
		do
			Result := log /= Void and then log.is_format_set
		end

	is_comment: BOOLEAN
			-- Is record in `last_line' commented out?
		require
			last_string_available: has_last_string
		do
			Result := (last_string.item (1) = Comment_character)
		end

feature -- Status setting

	set_log (l: LOG_FACILITY)
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

	set_column (c: TEST_DATA_COLUMN; pos: INTEGER)
			-- Set column handler `c' at column `pos'.
		require
			handler_exists: c /= Void
			valid_position: valid_column_index (pos)
		do
			table.put (c, pos)
		ensure
			handler_set: table [pos] = c
		end

feature -- Basic operations

	build_suite
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

				if (invalid or not all_values_valid)
					and not last_string.is_empty
					and is_log_set then
					log.put_string ("Record " + count.out + " not valid!")
					log.put_new_line
				end
				count := count + 1
			end
			file.close
		ensure
			suite_not_empty: is_suite_generated implies not suite.is_empty
		end

feature {NONE} -- Constants

	Comment_character: CHARACTER = '#'
			-- Character for commenting out data records
	Void_entity: STRING = "[]"
			-- String that is used for denoting a void string object

feature {NONE} -- Implementation

	table: ARRAY [detachable TEST_DATA_COLUMN]
			-- Table storing test data column handlers

	file: FILE
			-- Input file

	log: LOG_FACILITY
			-- Log for error output

	parse_line
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
			create data_values.make_filled ("", 1, columns)
			s := last_string.twin
			if is_comment then s.keep_tail (s.count - 1) end
			from i := 1 until i > columns loop
				pos := s.index_of ('%T', 1)
				if pos > 0 then
					val := s.substring (1, pos - 1)
					s.keep_tail (s.count - pos)
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

	inject_record (c: INTEGER)
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
				(table [i]).inject (tc, (data_values [i]))
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

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
