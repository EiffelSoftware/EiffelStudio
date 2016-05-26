class CLIENT inherit SHARED

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			f: RAW_FILE
		do
				-- Prepare a file for input redirection.
			create f.make_create_read_write (input_file_name)
			f.put_string (client_message)
			f.close

			test_redirection (False, False, False, no_input_arguments, "1")
			test_redirection (False, False, True, no_input_arguments, "2")
			test_redirection (False, True, False, no_input_arguments, "3")
			test_redirection (False, True, True, no_input_arguments, "4")

			test_redirection (True, False, False, input_arguments, "5")
			test_redirection (True, False, True, input_arguments, "6")
			test_redirection (True, True, False, input_arguments, "7")
			test_redirection (True, True, True, input_arguments, "8")

			wipe_file (input_file_name)
		end

feature {NONE} -- Tests

	test_redirection (input, output, error: BOOLEAN; arguments: ARRAYED_LIST [READABLE_STRING_32]; name: STRING)
			-- Test redirection for input if `input', for output if `output', for error if `error'
			-- by running supplier with all possible variants of `arguments'
			-- for test named `name'.
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			supplier: READABLE_STRING_32
		do
			supplier := "supplier"
			if command_line.argument_count > 0 then
				supplier := command_line.argument (1)
			end
			create pf
			across
				arguments as c
			loop
				p := pf.process_launcher (supplier, create {ARRAYED_LIST [READABLE_STRING_32]}.make_from_array (<<c.item>>), Void)
				if input then
					p.redirect_input_to_file (input_file_name)
				end
				if output then
					p.redirect_output_to_agent (record_output)
				end
				if error then
					p.redirect_error_to_agent (record_error)
				end
				p.launch
				if p.launched then
					p.wait_for_exit
					if input then
						record_input
					end
					report (input, output, error, name + c.item)
				else
					io.put_string ("Test ")
					io.put_string (name + c.item)
					io.put_string (": Failed to launch %"")
					io.put_string (supplier)
					io.put_character ('"')
					io.put_new_line
				end
			end
		end

	record_output: PROCEDURE [STRING_8]
			-- An agent that records output produced by the supplier.
		do
			Result := agent (s: STRING_8) do
				if attached actual_output as a then
					a.append (s)
				else
					create actual_output.make_from_string (s)
				end
			end
		end

	record_error: PROCEDURE [STRING_8]
			-- An agent that records error produced by the supplier.
		do
			Result := agent (s: STRING_8) do
				if attached actual_error as a then
					a.append (s)
				else
					create actual_error.make_from_string (s)
				end
			end
		end

	record_input
			-- Record input read by the supplier.
		local
			f: RAW_FILE
		do
			create f.make_with_name (output_file_name)
			if f.path_exists then
				f.open_read
				f.read_stream (maximum_message_count)
				actual_input := f.last_string.twin
			end
		end

feature {NONE} -- Reporting

	report (i, o, e: BOOLEAN; name: STRING)
			-- Report results for a test of name `name'.
		do
			io.put_string ("Test ")
			io.put_string (name)
			if
				is_actual_value_valid (actual_input, client_message, i) and then
				is_actual_value_valid (actual_output, output_message, o) and then
				is_actual_value_valid (actual_error, error_message, e)
			then
				io.put_string (": OK")
			else
				io.put_string (": Failed")
			end
			report_actual_value (actual_input, client_message, i, "input")
			report_actual_value (actual_output, output_message, o, "output")
			report_actual_value (actual_error, error_message, e, "error")
			io.put_new_line
			clear
		end

	report_actual_value (actual_message: detachable STRING_8; expected_message: STRING_8; is_active: BOOLEAN; name: STRING)
			-- Report an issue with a data for stream `name' if it is enabled by `is_active' by comparing `actual_message' with `expected_message'.
		do
			if not is_actual_value_valid (actual_message, expected_message, is_active) then
				io.put_string ("%N%T")
				io.put_string (name)
				if attached actual_message then
					io.put_string (" - Expected: %"")
					io.put_string (expected_message)
					io.put_string ("%" Actual: %"")
					io.put_string (actual_message)
					io.put_character ('"')
				else
					io.put_string (" - no value")
				end
			end
		end

	is_actual_value_valid (actual_message: detachable STRING_8; expected_message: STRING_8; is_active: BOOLEAN): BOOLEAN
			-- Does `actual_value' match `expected_message' if testing is enabled according to `is_active'?
		do
			if is_active then
				Result := attached actual_message and then actual_message.same_string (expected_message)
			else
				Result := True
			end
		end

feature {NONE} -- Removal

	clear
			-- Reset data to initial state.
		do
			actual_input := Void
			actual_output := Void
			actual_error := Void
			wipe_file (output_file_name)
		end

	wipe_file (name: STRING_32)
			-- Delete a file `name' or its contents.
		local
			attempt: INTEGER
			f: RAW_FILE
		do
			create f.make_with_name (name)
			inspect attempt
			when 0 then
					-- Try to delete the file.
				if f.path_exists then
					f.delete
				end
			when 1 then
					-- Try to remove contents of the file.
				f.create_read_write
				f.close
					-- Try to delete the file again.
				if f.path_exists then
					f.delete
				end
			else
					-- No more ideas.
			end
		rescue
			attempt := attempt + 1
			retry
		end

feature {NONE} -- Input/output

	actual_input, actual_output, actual_error: detachable STRING_8
			-- Actual data read from redirected input, output and error streams.

	input_file_name: STRING_32 = "client.out"

	client_message: STRING_8 = "Client's message to standard output."

	maximum_message_count: INTEGER
			-- Maximum lemgth of messages exchanged between applications.
		do
			Result :=
				(client_message.count).max
				(output_message.count).max
				(error_message.count)
		end

feature {NONE} -- Environment

	command_line: ARGUMENTS_32
			-- Access to command-line arguments.
		once
			create Result
		end

end
