note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_MISC

feature

	last_error: INTEGER

	output_of_command (a_cmd: STRING; a_dir: detachable STRING): detachable STRING
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			retried: BOOLEAN
		do
			if not retried then
				last_error := 0
				create Result.make (10)
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_dir)
				p.set_hidden (True)
				p.set_separate_console (False)
				p.redirect_output_to_agent (agent (res: STRING; s: STRING)
						do
							res.append_string (s)
						end (Result, ?)
					)
				p.launch
				p.wait_for_exit
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

	launch_no_wait_command (a_cmd, a_dir: STRING; is_hidden: BOOLEAN)
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			retried: BOOLEAN
		do
			if not retried then
				last_error := 0
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_dir)
				p.set_hidden (True)
				p.set_separate_console (False)
				p.launch
			else
				last_error := 1
			end
		rescue
			retried := True
			retry
		end

end
