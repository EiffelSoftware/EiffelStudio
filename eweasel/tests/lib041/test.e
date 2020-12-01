class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			p: BASE_PROCESS
			a: ARRAY [READABLE_STRING_32]
		do
			a := (create {ARGUMENTS_32}).argument_array
			if a.upper = 0 then
					-- There are no arguments, launch a process that will sleep
					-- for a specified period of time.
					-- Test #1: the new process still runs when timeout expires.
				p := base_factory.process_launcher (command, arguments, Void)
				launch (p, delay // 3)
				if p.has_exited then
					exit ("The process has exited too early.")
				end
				p.wait_for_exit
				report (p, 1)
					-- Test #2: the new process exists before timeout expires.
				p := base_factory.process_launcher (command, arguments, Void)
				launch (p, delay * 2)
				if not p.has_exited then
					p.terminate
					exit ("The process has not exited within allotted time.")
				end
				report (p, 2)
			elseif a.upper = 1 and then a [1].is_natural then
					-- There is one integer argument.
					-- Use it as a time to sleep in milliseconds.
				;(create {EXECUTION_ENVIRONMENT}).sleep (a [1].to_natural * {INTEGER_64} 1_000_000)
				;(create {EXCEPTIONS}).die (0)
			else
				exit ("Invalid argument, positive integer is expected.%N")
			end
		end

feature {NONE} -- Access

	base_factory: BASE_PROCESS_FACTORY
		once
			create Result
		end

	exit (message: READABLE_STRING_32)
		do
			io.error.put_string_32 (message)
			io.error.put_new_line
			;(create {EXCEPTIONS}).die (-1)
		end

	command: STRING_32
		once
			Result := (create {ARGUMENTS_32}).command_name
		end

	arguments: ARRAYED_LIST [STRING_32]
		once
			create Result.make (1)
			Result.extend (delay.out.as_string_32)
		end

	delay: INTEGER = 5_000
			-- Default to sleep in milliseconds.


feature {NONE} -- Execution

	launch (p: BASE_PROCESS; t: INTEGER)
			-- Launch process `p` and wait for exit with a specified timeout `t` in milliseconds.
		do
			p.launch
			if not p.launched then
				exit ("Failed to launch")
			end
			p.wait_for_exit_with_timeout (t)
		ensure
			p.launched
		end

	report (p: BASE_PROCESS; n: NATURAL)
			-- Check exit code of process `p` and report that the test number `n` has completed.
		require
			p.has_exited
		do
			if p.exit_code /= 0 then
				exit ({STRING_32} "%"" + command + "%" has exitited with code " + p.exit_code.out + ".")
			end
			io.put_string ("Test #" + n.out + ": OK")
			io.put_new_line
		end

end
