indexing
	description: 
		"Dump loop"
	date: "$Date$"
	revision: "$Revision $"

class EWB_DUMP_LOOP

inherit

	EWB_CMD
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		end

	SHARED_WORKBENCH

creation

	do_nothing

feature

	execute is
			-- Dump class information.
		local
			done: BOOLEAN
			input: FILE
			cmd: STRING
			arg: STRING
			i: INTEGER
			f_dump: EWB_DUMP_FEATURES
		do
			from
				input := io.input
				print ("ready%N")
			until
				done
			loop
				io.output.flush
				io.input.flush
				input.read_line
				cmd := input.last_string
				i := cmd.substring_index (" ", 1)
				if i > 0 then
					arg := cmd.substring (
						i + 1,
						cmd.count
					)
					cmd := cmd.substring (1, i - 1)
				else
					arg := ""
				end
				if cmd.is_equal ("features") and not arg.is_empty then
					create f_dump.make_verbose (arg)
					f_dump.execute
					print ("%N")
				end
				if
					cmd.is_empty or
					cmd.is_equal ("done") or
					cmd.is_equal ("quit") or
					cmd.is_equal ("exit") or
					cmd.is_equal ("bye")
				then
					done := True
				end
			end

		end

end -- class EWB_DUMP_CLASSES
