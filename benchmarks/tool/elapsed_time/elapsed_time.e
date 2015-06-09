class ELAPSED_TIME

inherit
	ARGUMENT_SINGLE_PARSER
		rename
			make as make_argument
		end

create
	make

feature

	make
		do
			make_argument (True, True)
			execute (agent benchmark)
		end

feature {NONE} -- Benchmarking

	benchmark
			-- Benchmark specified example.
		local
			test_name: detachable STRING_32
			directory: READABLE_STRING_GENERAL
			process: PROCESS
			start_time: DATE_TIME
			stop_time: DATE_TIME
			duration: INTEGER_64
			count: INTEGER
			n: INTEGER
			minimum: INTEGER_64
			maximum: INTEGER_64
			total: INTEGER_64
			time: ARRAYED_LIST [INTEGER_64]
			sorter: SORTER [INTEGER_64]
			skip_first_count: INTEGER
			skip_maximum_count: INTEGER
			processor_count: INTEGER
			adjusted_command: detachable STRING_32
			mean: INTEGER_64
			total_square_differences, total_differences: INTEGER_64
			deviation: INTEGER_64
			deviation_value: detachable ANY
		do
			if attached option_of_name (name_switch) as s then
					-- Use specified name.
				test_name := s.value
			end
			if attached option_of_name (directory_switch) as d then
					-- Use specified working directory.
				directory := d.value
			else
					-- Use current working directory.
				directory := "."
			end
			if attached option_of_name (count_switch) as c then
					-- Use specified repeat count.
				count := c.value.to_integer
			else
					-- Run one time.
				count := 1
			end
			n := count
			if attached option_of_name (skip_first_switch) as c then
					-- Use specified count to skip the first runs.
				skip_first_count := c.value.to_integer
				n := n + skip_first_count
			else
					-- Do not skip first runs.
				skip_first_count := 0
			end
			if attached option_of_name (skip_maximum_switch) as c then
					-- Use specified count to skip runs with maximum time.
				skip_maximum_count := c.value.to_integer
				n := n + skip_maximum_count
			else
					-- Do not skip runs with maximum time.
				skip_maximum_count := 0
			end
			if attached option_of_name (processor_count_switch) as p and then p.value.to_integer > 0 then
					-- Limit processor usage to the given number of processors.
				if {PLATFORM}.is_windows then
					adjusted_command := {STRING_32} "cmd /c start /w /affinity "
				elseif {PLATFORM}.is_unix then
					adjusted_command := {STRING_32} "/usr/bin/taskset "
				end
				if attached adjusted_command then
					processor_count := p.value.to_integer
					adjusted_command.append_string_general (((1 |<< processor_count) - 1).to_hex_string)
					adjusted_command.append_character (' ')
				end
			else
					-- Do not limit processor usage.
			end
			check
				from_initialization: attached values [1] as command
			then
				if attached adjusted_command then
					adjusted_command.append_string (command)
				else
					adjusted_command := command
				end
				from
					create time.make (n.as_integer_32)
				until
					n = 0
				loop
					process := (create {PROCESS_FACTORY}).process_launcher_with_command_line (adjusted_command, directory)
					process.redirect_output_to_agent (agent (s: STRING_8) do end)
					process.set_on_fail_launch_handler (
						agent (c: STRING_32)
							do
								io.error.put_string ("Failed to start command %"")
								localized_print_error (c)
								io.error.put_string ("%".")
								io.error.put_new_line
							end
						(adjusted_command)
					)
					create start_time.make_now_utc
					process.launch
					if process.launched then
						process.wait_for_exit
						create stop_time.make_now_utc
					else
							-- Reset all measurements.
						count := 0
						skip_first_count := 0
						skip_maximum_count := 0
						time.wipe_out
						stop_time := start_time
							-- Exit from the loop.
						n := 1
					end
					if n <= count + skip_maximum_count then
							-- This is not one of the first runs that should be skipped.
						duration := (stop_time.relative_duration (start_time).fine_seconds_count * 1_000).truncated_to_integer_64
						time.extend (duration)
					end
					n := n - 1
				end
					-- Sort results.
				create {QUICK_SORTER [INTEGER_64]} sorter.make (create {COMPARABLE_COMPARATOR [INTEGER_64]})
				sorter.sort (time)
					-- Remove measurements with maximum time.
				from
					time.finish
				until
					time.count = count
				loop
					time.remove
					time.back
				end
				across
					time as t
				from
					minimum := minimum.max_value
					total := 0
				loop
					duration := t.item
					if minimum > duration then
						minimum := duration
					end
					if maximum < duration then
						maximum := duration
					end
					total := total + duration
				end
				if count > 0 then
					mean := total // count
					if count > 1 then
							-- Compensated variance algorithm is taken from "http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance".
						from
							time.start
								-- Skip `skip_maximum_count' measurements with maxiumum values.
							n := count
						until
							n = 0
						loop
							duration := time.item
							total_square_differences := total_square_differences + (duration - mean) * (duration - mean)
							total_differences := total_differences + (duration - mean)
							time.forth
							n := n - 1
						end
						deviation := m.sqrt((total_square_differences - total_differences * total_differences // count) // (count - 1)).truncated_to_integer_64
						deviation_value := deviation
					end
						-- Report execution times.
					report (<<
						[{STRING_32} "Name", test_name],
						[{STRING_32} "Processors", processor_count],
						[{STRING_32} "Count", count],
						[{STRING_32} "Minimum (ms)", minimum],
						[{STRING_32} "Maximum (ms)", maximum],
						[{STRING_32} "Average (ms)", mean],
						[{STRING_32} "Standard deviation (ms)", deviation_value],
						[{STRING_32} "Command", command],
						[{STRING_32} "Directory", directory],
						[{STRING_32} "Skip first count", skip_first_count],
						[{STRING_32} "Skip maximum count", skip_maximum_count]
					>>)
				end
			end
		end

feature {NONE} -- Output

	report (data: ARRAY [TUPLE [name: STRING_32; value: detachable ANY]])
			-- Report results of the test runs.
		local
			s: STRING
		do
			if not attached option_of_name (format_switch) as f or else f.value.same_string (format_text_value.out) then
					-- Text output.
				across
					data as c
				loop
					if has_option (header_switch) then
						localized_print (c.item.name)
						io.put_string (": ")
					end
					if attached c.item.value as v then
						io.put_string (v.out)
					end
					io.put_new_line
				end
			else
					-- CSV output.
				if has_option (header_switch) then
						-- Output header line.
					across
						data as c
					loop
						if not c.is_first then
								-- Output a separator.
							io.put_character (',')
						end
						localized_print (c.item.name)
					end
					io.put_new_line
				end
					-- Output values line.
				across
					data as d
				loop
					if not d.is_first then
							-- Output a separator.
						io.put_character (',')
					end
					if attached d.item.value as v then
						s := v.out
						if s.has ('"') then
								-- Enclose value in quotes and duplicate each occurrence of a quote.
							across
								s as c
							loop
								io.put_character (c.item)
								if c.item = '"' then
										-- Duplicate a quote.
									io.put_character ('"')
								end
							end
						elseif s.has (',') or s.has ('%R') or s.has ('%N') then
								-- Enclose value in quotes.
							io.put_character ('"')
							io.put_string (s)
							io.put_character ('"')
						else
								-- Output value as is.
							io.put_string (s)
						end
					end
				end
				io.put_new_line
			end
		end

feature {NONE} -- Usage

	name: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result :=  "Eiffel Benchmark utility"
		end

	version: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result :=  "1.1"
		end

	copyright: READABLE_STRING_GENERAL
			-- <Precursor>
		do
			Result :=  "Copyright (c) 2014-2015, Eiffel Software. All Rights Reserved."
		end

feature {NONE} -- Switches

	non_switched_argument_name: STRING = "command"
			-- <Precursor>

	non_switched_argument_description: STRING = "Command to be executed."
			-- <Precursor>

	non_switched_argument_type: STRING = "Command line"
			-- <Precursor>

	directory_switch: STRING = "w"
			-- A switch to specify working directory.

	count_switch: STRING = "c"
			-- A switch to specify repeat count.

	format_switch: STRING = "f"
			-- A switch to specify output format.

	format_text_value: CHARACTER_8 = 't'
			-- Value of the switch `format_switch' for text.

	format_csv_value: CHARACTER_8 = 'c'
			-- Value of the switch `format_switch' for CSV.

	header_switch: STRING = "h"
			-- A switch to specify that a header should be output.

	name_switch: STRING = "n"
			-- A switch to specify a name.

	skip_maximum_switch: STRING = "skip_maximum"
			-- A switch to skip runs with maximum time.

	skip_first_switch: STRING = "skip_first"
			-- A switch to skip the first run.

	processor_count_switch: STRING = "p"
			-- A switch to specify maximum number of logical processors that can be used.

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		local
			format: HASH_TABLE [IMMUTABLE_STRING_32, CHARACTER_32]
		once
			create format.make (2)
			format [format_text_value] := "Text"
			format [format_csv_value] := "CSV - comma-separated values"
			create Result.make_from_array (<<
				create {ARGUMENT_VALUE_SWITCH}.make (name_switch, "Name of the test run", True, False, "name", "String to identify the test", False),
				create {ARGUMENT_NATURAL_SWITCH}.make_with_range (count_switch, "Repeat count", True, False, "count", "Number of runs to be included in the results", False, 0, {INTEGER}.max_value.as_natural_64),
				create {ARGUMENT_NATURAL_SWITCH}.make_with_range (skip_first_switch, "Skip the first runs", True, False, "count", "Number of runs to drop from results", False, 0, 5),
				create {ARGUMENT_NATURAL_SWITCH}.make_with_range (skip_maximum_switch, "Skip runs with maximum time", True, False, "count", "Number of runs to drop from results", False, 0, 5),
				create {ARGUMENT_NATURAL_SWITCH}.make_with_range (processor_count_switch, "Restrict the number of processors that can be used", True, False, "count", "Number of logical processors", False, 0, 64),
				create {ARGUMENT_FLAG_SWITCH}.make (format_switch, "Output format", True, False, "kind", "Kind of a format to be used", False, format, True),
				create {ARGUMENT_DIRECTORY_SWITCH}.make (directory_switch, "Working directory", True, False, "dir", "Directory path (current directory by default)", False),
				create {ARGUMENT_SWITCH}.make (header_switch, "Generate headers", True, False)
			>>)
		end

feature {NONE} -- Statistics

	m: DOUBLE_MATH
			-- Arithmetics.
		once
			create Result
		end

end
