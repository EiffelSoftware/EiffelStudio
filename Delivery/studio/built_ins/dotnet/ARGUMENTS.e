class ARGUMENTS

feature

	argument (i: INTEGER): STRING
		do
			check
				attached {ENVIRONMENT}.get_command_line_args as l_cmd_line and then
				attached l_cmd_line.item (i) as l_str
			then
				create {STRING} Result.make_from_cil (l_str)
			end
		end

	argument_count: INTEGER
			-- Number of arguments given to command that started
			-- system execution (command name does not count)
		once
			check attached {ENVIRONMENT}.get_command_line_args as l_cmd_line then
				Result := l_cmd_line.count - 1
			end
		end

end
