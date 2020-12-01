class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			p: BASE_PROCESS
			a: ARRAY [READABLE_STRING_32]
			buffer: SPECIAL [NATURAL_8]
			n: like {SPECIAL [NATURAL_8]}.count
		do
			create buffer.make_filled (0, 512)
			a := (create {ARGUMENTS_32}).argument_array
			if a.upper = 0 then
					-- There are no arguments, launch a process that will write to a standard output and error.

					-- Tests for standard output.

					-- Test #1: read 0 bytes.
				buffer.fill_with (0, 0, buffer.capacity - 1)
				io.put_string ("Test output #1: ")
				p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<output_option, "0">>), Void)
				p.redirect_output_to_stream
				launch (p)
				p.read_output_to_special (buffer)
				if p.has_output_stream_error then
					exit ("Error reading output stream.")
				elseif not p.has_output_stream_closed then
					exit ("Output stream is not closed.")
				elseif buffer.count /= 0 then
					exit ("Unexpected data count.")
				end
				report (p)

					-- Test #2: read less than buffer size.
				io.put_string ("Test output #2: ")
				n := 123
				p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<output_option, n.out>>), Void)
				p.redirect_output_to_stream
				launch (p)
				read (agent p.read_output_to_special, agent p.has_output_stream_closed, agent p.has_output_stream_error, n)
				report (p)

					-- Test #3: read more  than buffer size.
				io.put_string ("Test output #3: ")
				n := 1234
				p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<output_option, n.out>>), Void)
				p.redirect_output_to_stream
				launch (p)
				read (agent p.read_output_to_special, agent p.has_output_stream_closed, agent p.has_output_stream_error, n)
				report (p)

					-- Tests for standard error.

					-- Test #1: read 0 bytes.
				buffer.fill_with (0, 0, buffer.capacity - 1)
				io.put_string ("Test error #1: ")
				p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<error_option, "0">>), Void)
				p.redirect_error_to_stream
				launch (p)
				p.read_error_to_special (buffer)
				if p.has_error_stream_error then
					exit ("Error reading error stream.")
				elseif not p.has_error_stream_closed then
					exit ("Error stream is not closed.")
				elseif buffer.count /= 0 then
					exit ("Unexpected data count.")
				end
				report (p)

					-- Test #2: read less than buffer size.
				io.put_string ("Test error #2: ")
				n := 123
				p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<error_option, n.out>>), Void)
				p.redirect_error_to_stream
				launch (p)
				read (agent p.read_error_to_special, agent p.has_error_stream_closed, agent p.has_error_stream_error, n)
				report (p)

					-- Test #3: read more  than buffer size.
				io.put_string ("Test error #3: ")
				n := 1234
				p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<error_option, n.out>>), Void)
				p.redirect_error_to_stream
				launch (p)
				read (agent p.read_error_to_special, agent p.has_error_stream_closed, agent p.has_error_stream_error, n)
				report (p)

					-- Tests for standard error redirected to standard output.

				if not {PLATFORM}.is_dotnet then

						-- Test #1: read 0 bytes.
					buffer.fill_with (0, 0, buffer.capacity - 1)
					io.put_string ("Test error->output #1: ")
					p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<error_option, "0">>), Void)
					p.redirect_output_to_stream
					p.redirect_error_to_same_as_output
					launch (p)
					p.read_output_to_special (buffer)
					if p.has_output_stream_error then
						exit ("Error reading output stream.")
					elseif not p.has_output_stream_closed then
						exit ("Output stream is not closed.")
					elseif buffer.count /= 0 then
						exit ("Unexpected data count.")
					end
					report (p)

						-- Test #2: read less than buffer size.
					io.put_string ("Test error->output #2: ")
					n := 123
					p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<error_option, n.out>>), Void)
					p.redirect_output_to_stream
					p.redirect_error_to_same_as_output
					launch (p)
					read (agent p.read_output_to_special, agent p.has_output_stream_closed, agent p.has_output_stream_error, n)
					report (p)

						-- Test #3: read more  than buffer size.
					io.put_string ("Test error->output #3: ")
					n := 1234
					p := base_factory.process_launcher (command, arguments ({ARRAY [READABLE_STRING_32]} <<error_option, n.out>>), Void)
					p.redirect_output_to_stream
					p.redirect_error_to_same_as_output
					launch (p)
					read (agent p.read_output_to_special, agent p.has_output_stream_closed, agent p.has_output_stream_error, n)
					report (p)

				end

			elseif a.upper \\ 2 = 0 then
				across
					a as argument
				from
					argument.forth
				loop
					if argument.item.same_string (output_option) then
						argument.forth
						if argument.item.is_integer then
							write (agent io.put_string, argument.item.to_integer)
						else
							exit ({STRING_32} "Unexpected value after " + output_option + ".")
						end
					elseif argument.item.same_string (error_option) then
						argument.forth
						if argument.item.is_integer then
							write (agent (io.error).put_string, argument.item.to_integer)
						else
							exit ({STRING_32} "Unexpected value after " + error_option + ".")
						end
					end
				end
			else
				exit ("Invalid argument count.")
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
			-- The command to start.
			-- It is the name of the current program.
		once
			Result := (create {ARGUMENTS_32}).command_name
		end

	arguments (a: ARRAY [READABLE_STRING_32]): ARRAYED_LIST [READABLE_STRING_32]
			-- Make argument list from the given array.
		do
			create Result.make_from_array (a)
		end

	delay: INTEGER = 5_000
			-- Default to sleep in milliseconds.

feature {NONE} -- Command line

	output_option: STRING_32 = "--output"
	error_option: STRING_32 = "--error"

feature {NONE} -- Execution

	launch (p: BASE_PROCESS)
			-- Launch process `p`.
		do
			p.launch
			if not p.launched then
				exit ("Failed to launch")
			end
		ensure
			p.launched
		end

	value (i: INTEGER): NATURAL_8
			-- Value of `i`-th byte written to the stream.
		do
			Result := (i + 5).as_natural_8
			if Result.to_character_8 = '%R' or else Result.to_character_8 = '%N' then
					-- Avoid special handling of line breaks.
				Result := Result + 85
			end
		end

	write (write_stream: PROCEDURE [READABLE_STRING_8]; n: like {SPECIAL [NATURAL_8]}.count)
			-- Write `n` bytes to standard output.
		local
			buffer: STRING_8
			i: like {SPECIAL [NATURAL_8]}.count
			j: like {SPECIAL [NATURAL_8]}.count
		do
				-- Write data in chunks of size 1, 2, 6, 15, 37, etc.
			from
				j := 1
			until
				i = n
			loop
				j := j.min (n - i)
				create buffer.make_filled ('%U', j)
				across
					1 |..| j as k
				loop
					buffer [k.item] := value (i).to_character_8
					i := i + 1
				end
				write_stream (buffer)
				j := (j * 2 + j // 2).max (buffer.capacity)
			end
		end

	read (read_stream: PROCEDURE [SPECIAL [NATURAL_8]]; has_closed, has_error: PREDICATE; n: like {SPECIAL [NATURAL_8]}.count)
		local
			buffer: SPECIAL [NATURAL_8]
			i: like {SPECIAL [NATURAL_8]}.count
		do
			create buffer.make_filled (0, 512)
			from
			until
				has_closed.item
			loop
				buffer.fill_with (0, 0, buffer.capacity - 1)
				read_stream (buffer)
				if has_error.item then
					exit ("Error reading output stream.")
				elseif buffer.count = 0 and then n /= i then
					exit ("Unexpected data count: 0.")
				elseif buffer.count > n - i then
					exit ("Unexpected data count: " + buffer.count.out + ".")
				else
					across
						buffer as c
					loop
						if c.item /= value (i) then
							exit ("Unexpected data.")
						end
						i := i + 1
					end
				end
			end
			if i /= n then
				exit ("Not enough data.")
			end
		end

	report (p: BASE_PROCESS)
			-- Wait for termination of process `p`, check its exit code and
			-- report that the test number `n` has completed.
		require
			p.launched
		do
			p.wait_for_exit
			if p.exit_code /= 0 then
				exit ({STRING_32} "%"" + command + "%" has exitited with code " + p.exit_code.out + ".")
			end
			io.put_string ("OK")
			io.put_new_line
		end

end
