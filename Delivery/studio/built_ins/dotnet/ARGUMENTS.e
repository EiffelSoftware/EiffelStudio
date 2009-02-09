class ARGUMENTS

feature

	argument (i: INTEGER): STRING is
		local
			cmd_line: ?NATIVE_ARRAY [SYSTEM_STRING]
		do
			cmd_line := {ENVIRONMENT}.get_command_line_args
			check cmd_line_attached: cmd_line /= Void end
			Result := create {STRING}.make_from_cil (cmd_line.item (i))
		end

	argument_count: INTEGER is
			-- Number of arguments given to command that started
			-- system execution (command name does not count)
		local
			cmd_line: ?NATIVE_ARRAY [SYSTEM_STRING]
		once
			cmd_line := {ENVIRONMENT}.get_command_line_args
			check cmd_line_attached: cmd_line /= Void end
			Result := cmd_line.count - 1
		end

end
