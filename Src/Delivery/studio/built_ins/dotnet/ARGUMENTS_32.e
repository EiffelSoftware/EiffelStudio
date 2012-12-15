class ARGUMENTS_32

feature

	i_th_argument_string (i: INTEGER): IMMUTABLE_STRING_32
			-- Underlying string holding the argument at position `i'.
		do
			check
				attached {ENVIRONMENT}.get_command_line_args as l_cmd_line and then
				attached l_cmd_line.item (i) as l_str
			then
				create Result.make_from_cil (l_str)
			end
		end

	i_th_argument_pointer (i: INTEGER): POINTER
			-- Underlying pointer holding the argument at position `i'.
		do
			-- Not applicable on .NET
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
