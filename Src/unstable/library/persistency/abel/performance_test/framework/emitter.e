note
	description: "Utility to measure time and write the output to a file."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER

inherit
	MEMORY

create
	make

feature {NONE} -- Initialization

	make (a_controller: ABSTRACT_CONTROLLER)
			-- Initialization for `Current'.
		do
			controller := a_controller
			create test_execution.make_now_utc
			create results.make (50)

			create partial_result.make_from_string ("../results/part.txt")
		end

	partial_result: FILE_NAME
			-- A file to write the partial results.

feature -- Access

	controller: ABSTRACT_CONTROLLER

	test_execution: DATE_TIME


feature -- Access: Test execution

	is_running: BOOLEAN
			-- Is there a test running right now?

	description: detachable STRING
			-- The description of the currently running test.

	start_time: detachable DATE_TIME
			-- The start time of the currently running test.

	results: HASH_TABLE [REAL_64, STRING]

feature -- Element change

	start (a_description: STRING)
			-- Start the test with description `a_description'.
		require
			not_running: not is_running
			not_empty: not a_description.is_empty
		do
			check not_yet_present: not results.has (a_description) end

			is_running := True
			description := a_description


			write ("Executing test: " + a_description + "%N")

			full_collect

			create start_time.make_now_utc
		ensure
			running: is_running
		end


	stop
			-- Stop the previously started test.
		require
			running: is_running
		local
			stop_time: DATE_TIME
			diff: REAL_64
		do
			create stop_time.make_now_utc
			check attached start_time as l_start_time and attached description as l_description then

				diff := stop_time.definite_duration (l_start_time).fine_seconds_count

				write ("%TRequired time: " + diff.out + "%N")

				results.extend (diff, l_description)

			end
			is_running := False
			description := Void
			start_time := Void
		ensure
			not is_running
		end

	write_results
			-- Write all results to a CSV table.
		local
			csv: PLAIN_TEXT_FILE
			temp_file: PLAIN_TEXT_FILE

			header: LIST [STRING]
			column_max: HASH_TABLE [INTEGER, STRING]
			next_line: detachable LIST [STRING]

			prev_res: HASH_TABLE [STRING, STRING]
			content: LINKED_LIST [HASH_TABLE [STRING, STRING]]

			new_result: HASH_TABLE [STRING, STRING]

			last_write: STRING
		do
			create csv.make_open_read_append (controller.result_file)
			create column_max.make (50)

				-- Read the contents of the existing CSV file, if any.
			if attached read_csv (csv) as old_header then

				check first_key_is_date: old_header.first ~ "Date" end
				across
					old_header as cursor
				loop
					column_max.extend (cursor.item.count + 2, cursor.item)
				end

				from
					next_line := read_csv (csv)
					create content.make
				until
					next_line = Void
				loop
					from
						check same_count: next_line.count = old_header.count end
						next_line.start
						old_header.start
						create prev_res.make (next_line.count)
						content.extend (prev_res)
					until
						next_line.after
					loop
						prev_res.extend (next_line.item, old_header.item)

						column_max.force (next_line.item.count.max (column_max[old_header.item]), old_header.item)

						next_line.forth
						old_header.forth
					end
					next_line := read_csv (csv)
				end

				header := old_header
			else
				create {ARRAYED_LIST [STRING]} header.make (results.count + 1)
				header.extend ("Date")
				column_max.extend (4, "Date")
				create content.make
			end

				-- Delete the current file (we're going to rewrite it).
			csv.close
			csv.wipe_out
			csv.open_append

				-- Adjust the header if necessary.
			header.compare_objects
			across
				results.current_keys as key
			loop
				if not column_max.has (key.item) then
					header.extend (key.item)
					column_max.extend (key.item.count, key.item)
				end
			end

				-- Write the new header.
			across
				header as cursor
			loop
				csv.put_character ('"')
				csv.put_string (cursor.item)
				csv.put_character ('"')

				if cursor.is_last then
					csv.put_character ('%N')
				else
					csv.put_character (',')
					write_space (csv, column_max [cursor.item] - cursor.item.count)
--					csv.put_character (' ')
				end
			end

				-- Transform the result from the current test into a CSV line.
			across
				results as res_cursor
			from
				create new_result.make (results.count)
				content.extend (new_result)

				new_result.extend (
					test_execution.year.out + "-" +
					trim_integer (test_execution.month) + "-" +
					trim_integer (test_execution.day) + "T" +
					trim_integer (test_execution.hour) + ":" +
					trim_integer (test_execution.minute) + ":" +
					trim_integer (test_execution.second)
					, "Date")
			loop
				new_result.extend (trim_double (res_cursor.item), res_cursor.key)
			end

				-- Write the content of the CSV file.
			across
				content as prev_cursor
			loop
				across
					header as cursor
				loop
					if attached prev_cursor.item [cursor.item] as old_result then
						last_write := old_result
					else
						last_write := "n/a"
					end
					csv.put_string (last_write)

					if cursor.is_last then
						csv.put_character ('%N')
					else
						csv.put_character (',')

						write_space (csv, column_max [cursor.item] - last_write.count + 2)
--						csv.put_character (' ')
					end
				end
			end

			csv.close

				-- Delete the file for partial results.

			create temp_file.make_with_name (partial_result)
			if temp_file.exists then
				temp_file.delete
			end

		end


feature {NONE} -- Implementation

	write (a_string: STRING)
			-- Write `a_string' to a temporary file and to the standard output.
		local
			file: PLAIN_TEXT_FILE
		do
			print (a_string)
			create file.make_open_append (partial_result)
			file.put_string (a_string)
			file.close
		end

	read_csv (csv: PLAIN_TEXT_FILE): detachable LIST [STRING]
			-- Read a line in a CSV
		do
			if csv.readable then
				csv.read_line
				if not csv.last_string.is_empty then
					Result := csv.last_string.split (',')
					Result.do_all (agent {STRING}.prune_all ('"'))
					Result.do_all (agent {STRING}.left_adjust)
					Result.do_all (agent {STRING}.right_adjust)
				end
			end
		end

	write_space (csv: PLAIN_TEXT_FILE; count: INTEGER)
			-- Append `count' spaces to `csv'.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				csv.put_character (' ')
				i := i + 1
			end
		end

	trim_double (a_real: REAL_64): STRING
			-- Convert `a_real' to a string with exactly two digits after the comma.
		local
			point_index: INTEGER
		do
			Result := a_real.out
			point_index := Result.index_of ('.',  1)

			if point_index = 0 then
				Result.append (".00")
			elseif point_index = Result.count -1 then -- Only one digit
				Result.append ("0")
			else -- Many digits
				Result.keep_head (point_index + 2)

			end
		end

	trim_integer (int: INTEGER): STRING
			-- Add leading zeros if necessary.
		do
			Result := int.out
			if Result.count = 1 then
				Result.prepend ("0")
			end
		end

invariant
	attached_when_running: is_running = (attached description and attached start_time)
end
