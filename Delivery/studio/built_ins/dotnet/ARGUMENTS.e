class ARGUMENTS

feature

	argument (i: INTEGER): STRING
		local
			cmd_line: detachable NATIVE_ARRAY [detachable SYSTEM_STRING]
			l_str: detachable SYSTEM_STRING
		do
			cmd_line := {ENVIRONMENT}.get_command_line_args
			check cmd_line_attached: cmd_line /= Void end
			l_str := cmd_line.item (i)
			check l_str_attached: l_str /= Void end
			Result := create {STRING}.make_from_cil (l_str)
		end

	argument_count: INTEGER
			-- Number of arguments given to command that started
			-- system execution (command name does not count)
		local
			cmd_line: detachable NATIVE_ARRAY [detachable SYSTEM_STRING]
		once
			cmd_line := {ENVIRONMENT}.get_command_line_args
			check cmd_line_attached: cmd_line /= Void end
			Result := cmd_line.count - 1
		end

end
