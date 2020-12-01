class TEST

create
	make

feature

	make
		local
			p: BASE_PROCESS
			pp: PROCESS
			start, stop: DATE_TIME
			i: INTEGER
			a: ARRAY [READABLE_STRING_32]
			n: like max_count
			e: EXECUTION_ENVIRONMENT
		do
			create e
			a := (create {ARGUMENTS_32}).argument_array
			if a.upper = 0 then
				n := max_count
			elseif a.upper = 1 and then a [1].is_integer then
				n := a [1].to_integer
			end
			if n = 0 then
				(create {EXCEPTIONS}).die (0)
			elseif n < 0 then
				exit ("Invalid argument, positive integer is expected.%N")
			end
			io.put_string ("Iterations: ")
			io.put_integer (n)
			io.put_new_line
			create start.make_now_utc
			create stop.make_now_utc
			start.make_now_utc
			from
				i := n
			until
				i <= 0
			loop
				e.system (command + " " + arguments.first)
				if e.return_code /= 0 then
					exit ({STRING_32} "%"" + command + "%" failed")
				end
				i := i - 1
			end
			stop.make_now_utc
			io.put_string ("System: ")
			print (stop.relative_duration (start).fine_seconds_count.rounded)
			io.put_new_line
			start.make_now_utc
			from
				i := n
			until
				i <= 0
			loop
				p := base_factory.process_launcher (command, arguments, Void)
				p.launch
				if p.launched then
					p.wait_for_exit
				else
					exit ("Failed to launch")
				end
				if p.exit_code /= 0 then
					exit ({STRING_32} "%"" + command + "%" failed")
				end
				i := i - 1
			end
			stop.make_now_utc
			io.put_string ("Base wait: ")
			print (stop.relative_duration (start).fine_seconds_count.rounded)
			io.put_new_line
			start.make_now_utc
			from
				i := n
			until
				i <= 0
			loop
				p := factory.process_launcher (command, arguments, Void)
				p.launch
				if p.launched then
					p.wait_for_exit
				else
					exit ("Failed to launch")
				end
				if p.exit_code /= 0 then
					exit ({STRING_32} "%"" + command + "%" failed")
				end
				i := i - 1
			end
			stop.make_now_utc
			io.put_string ("Wait: ")
			print (stop.relative_duration (start).fine_seconds_count.rounded)
			io.put_new_line
			start.make_now_utc
			from
				i := n
			until
				i <= 0
			loop
				pp := factory.process_launcher (command, arguments, Void)
				pp.set_timer (create {PROCESS_THREAD_TIMER}.make (0))
				pp.launch
				if pp.launched then
					pp.wait_for_exit
				else
					exit ("Failed to launch")
				end
				if pp.exit_code /= 0 then
					exit ({STRING_32} "%"" + command + "%" failed")
				end
				i := i - 1
			end
			stop.make_now_utc
			io.put_string ("Timer busy wait: ")
			print (stop.relative_duration (start).fine_seconds_count.rounded)
			io.put_new_line
		end

	max_count: INTEGER = 100

	base_factory: BASE_PROCESS_FACTORY
		once
			create Result
		end

	factory: PROCESS_FACTORY
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
			Result.extend ({STRING_32} "0")
		end

end
