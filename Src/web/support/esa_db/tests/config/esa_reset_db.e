note
	description: "[
		    Setting up database tests
			1. Put the database in a known state before running your test suite.
			2. Fresh start. Rebuild the database, including both creation of the schema as well as loading of initial test data, for every test run.
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=DatabaseTesting", "src=http://www.agiledata.org/essays/databaseTesting.html", "protocol=uri"

class
	ESA_RESET_DB

feature -- Process

	has_error: BOOLEAN

	execute_command (a_cmd: READABLE_STRING_8; a_args: detachable LIST [READABLE_STRING_GENERAL]; is_silent: BOOLEAN; a_error_buffer: detachable STRING)

			-- process command `a_cmd' launched in directory `a_dir'.
		require
			cmd_attached: a_cmd /= Void
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			retried: BOOLEAN
			err: BOOLEAN
			l_result: STRING
		do
			if not retried then
				err := False
				create l_result.make (10)
				create pf
				p := pf.process_launcher (a_cmd, a_args, Void)
				p.set_hidden (True)
				p.set_separate_console (False)
				p.redirect_input_to_stream
				p.redirect_output_to_agent (agent  (res: STRING; s: STRING)
					do
						res.append_string (s)
					end (l_result, ?))
				p.redirect_error_to_same_as_output
				p.launch
				if not p.launched then
					if a_error_buffer /= Void then
						a_error_buffer.append ("Error: can not execute %"" + a_cmd + "%"%N")
					end
					io.error.put_string ("Error: can not execute %"" + a_cmd + "%"%N")
					has_error := True
				else
					if p.launched and not p.has_exited then
						p.wait_for_exit_with_timeout (1_000_000)
						if not p.has_exited then
							p.terminate
							if not p.has_exited then
								p.wait_for_exit_with_timeout (1_000_000)
							end
						end
					end
				end
			else
				err := True
				has_error := True
			end
		rescue
			retried := True
			retry
		end

end
