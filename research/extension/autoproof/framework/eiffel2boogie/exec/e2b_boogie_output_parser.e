note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BOOGIE_OUTPUT_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize output parser.
		do
		end

feature -- Access

	last_result: E2B_BOOGIE_RESULT
			-- Last Boogie result.

feature -- Basic operations

	parse (a_boogie_output: STRING)
			-- Parse Boogie output and create result.
		local
			l_line: STRING
		do
				-- Reset state
			create last_result.make
			input_lines := Void
			current_procedure_result := Void
			current_procedure_error := Void

				-- Parse output
			across a_boogie_output.split ('%N') as l loop
				l_line := l.item
				l_line.right_adjust
				if not (l_line.is_empty or l_line.starts_with ("//")) then
					parse_line (l_line)
				end
			end

			postprocess_times
		end

feature {NONE} -- Implementation

	input_lines: LIST [STRING]
			-- Input to Boogie verifier as list of lines.

	current_procedure_result: E2B_BOOGIE_PROCEDURE_RESULT
			-- Info of currently processed procedure result.

	current_procedure_error: E2B_BOOGIE_PROCEDURE_ERROR
			-- Info of currenlty processed procedure error.

	parse_line (a_line: STRING)
			-- Parse individual line.
		local
			l_line: INTEGER
		do
			if version_regexp.matches (a_line) then
				-- version: version_regexp.captured_substring (1)
				last_result.set_boogie_version (version_regexp.captured_substring (1))

			elseif parsing_regexp.matches (a_line) then
				-- boogie file name: parsing_regexp.captured_substring (1)
				fill_boogie_input_lines (create {PATH}.make_from_string (parsing_regexp.captured_substring (1)))
				last_result.set_input_text (input_lines)

			elseif finished_regexp.matches (a_line) then
				-- nr verified: finished_regexp.captured_substring (1).to_integer
				-- nr failed: finished_regexp.captured_substring (2).to_integer
				-- inconclusive text (optional): finished_regexp.captured_substring (3)
				-- nr inconclusive (optional): finished_regexp.captured_substring (4).to_integer
				check current_procedure_error = Void end
				check current_procedure_result = Void or else current_procedure_result.is_error end

			elseif verifying_regexp.matches (a_line) then
				-- name of procedure: verifying_regexp.captured_substring (1)
				check current_procedure_error = Void end
				check current_procedure_result = Void or else current_procedure_result.is_error end
				create current_procedure_result.make (verifying_regexp.captured_substring (1), last_result)

			elseif verified_regexp.matches (a_line) then
				-- time in seconds: verified_regexp.captured_substring (1).to_real
				-- result (inconclusive/error/verified): verified_regexp.captured_substring (2)
				check current_procedure_error = Void end
				check current_procedure_result /= Void end
				if verified_regexp.captured_substring (2) ~ "verified" then
					current_procedure_result.set_successful
				elseif verified_regexp.captured_substring (2) ~ "inconclusive" then
					current_procedure_result.set_inconclusive
				else
					check verified_regexp.captured_substring (2).starts_with ("error") end
					current_procedure_result.set_error
				end
				if attached verified_regexp.captured_substring (1) as t then
					if t.has (',') then
						t.replace_substring_all (",", ".")
					end
					if t.is_real_32 then
						current_procedure_result.set_time (t.to_real_32)
					end
				end
				last_result.procedure_results.extend (current_procedure_result)
				if not current_procedure_result.is_error then
					current_procedure_result := Void
				end

			elseif boogie_error_regexp.matches (a_line) then
				-- file: boogie_error_regexp.captured_substring (1)
				-- line: boogie_error_regexp.captured_substring (2).to_integer
				-- column: boogie_error_regexp.captured_substring (3).to_integer
				-- error message: boogie_error_regexp.captured_substring (4)
				check current_procedure_error = Void end
				check current_procedure_result /= Void end
				l_line := boogie_error_regexp.captured_substring (2).to_integer
				create current_procedure_error.make (boogie_error_regexp.captured_substring (4))
				current_procedure_error.set_line (l_line, input_lines.i_th (l_line))
				current_procedure_result.errors.extend (current_procedure_error)
				if not current_procedure_error.has_related_location then
					current_procedure_error := Void
				end

			elseif error_regexp.matches (a_line) then
				-- file: error_regexp.captured_substring (1)
				-- line: error_regexp.captured_substring (2).to_integer
				-- column: error_regexp.captured_substring (3).to_integer
				-- error code: error_regexp.captured_substring (4)
				-- error message: error_regexp.captured_substring (5)				
				check current_procedure_error = Void end
				check current_procedure_result /= Void end
				l_line := error_regexp.captured_substring (2).to_integer
				create current_procedure_error.make (error_regexp.captured_substring (5))
				current_procedure_error.set_line (l_line, input_lines.i_th (l_line))
				current_procedure_result.errors.extend (current_procedure_error)
				if not current_procedure_error.has_related_location then
					current_procedure_error := Void
				end

			elseif related_regexp.matches (a_line) then
				-- file: related_regexp.captured_substring (1)
				-- line: related_regexp.captured_substring (2).to_integer
				-- column: related_regexp.captured_substring (3).to_integer
				-- message: related_regexp.captured_substring (4)
				check current_procedure_error /= Void end
				check current_procedure_result /= Void end
				l_line := related_regexp.captured_substring (2).to_integer
				current_procedure_error.set_related_line (l_line, input_lines.i_th (l_line))
				current_procedure_error := Void
			end
		end

	fill_boogie_input_lines (a_filename: PATH)
			-- Fill `input_lines' with file `a_filename'.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (a_filename)
			create {ARRAYED_LIST [STRING]} input_lines.make (10_000)
			from
				l_file.open_read
			until
				l_file.end_of_file
			loop
				l_file.read_line
				input_lines.extend (l_file.last_string.twin)
			end
			l_file.close
		end

	postprocess_times
			-- Change verification times from cumulative to differences.
		local
			l_sorted_procs: ARRAYED_LIST [E2B_BOOGIE_PROCEDURE_RESULT]
			j: INTEGER
		do
				-- Sort procedures results in descending order by verification times:
			create l_sorted_procs.make (last_result.procedure_results.count)
			across last_result.procedure_results as i loop
				from
					j := 1
				until
					j > l_sorted_procs.count or else l_sorted_procs [j].time < i.item.time
				loop
					j := j + 1
				end
				l_sorted_procs.go_i_th (j)
				l_sorted_procs.put_left (i.item)
			end
				-- For each result in the list but last, subtract the time of the next procedure
			from
				j := 1
			until
				j >= l_sorted_procs.count
			loop
				l_sorted_procs [j].set_time (l_sorted_procs [j].time - l_sorted_procs [j + 1].time)
				j := j + 1
			end
		end

feature {NONE} -- Regular expressions

	version_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for version information line.
		once
			create Result.make
			Result.compile ("^Boogie program verifier version ([^,]*).*$")
		end

	parsing_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for parsing line
		once
			create Result.make
			Result.compile ("^Parsing (.*)$")
		end

	finished_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for finished line.
		once
			create Result.make
			Result.compile ("^Boogie program verifier finished with ([0-9]*) verified, ([0-9]*) errors?(, ([0-9]*) inconclusives?)?$")
		end

	verifying_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for verifying section.
		once
			create Result.make
			Result.compile ("^Verifying\s+([\w.$#\^]+)\s+.*$")
		end

	verified_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for verified information line.
		once
			create Result.make
			Result.compile ("^\s*\[([0-9.,]*) s, [0-9]+ proof obligations?\]\s*(\w+)\s*$")
		end

	boogie_error_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for error line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): [Ee]rror: (.*)$")
		end

	error_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for error line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): Error (.*): (.*)$")
		end

	related_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for related information line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): Related location: (.*)$")
		end

end
