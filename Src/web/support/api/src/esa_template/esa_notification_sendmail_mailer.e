note
	description: "Summary description for {WS_NOTIFICATION_SENDMAIL_MAILER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_NOTIFICATION_SENDMAIL_MAILER

inherit
	NOTIFICATION_EXTERNAL_MAILER
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			make ((create {PATH}.make_current).name,Void)
		end

feature -- Command		


	process_mail_command (a_cmd: READABLE_STRING_8; a_dir: STRING; is_silent: BOOLEAN; a_error_buffer: detachable STRING) : detachable STRING
			-- process mail command `a_cmd' launched in directory `a_dir'.
		require
			cmd_attached: a_cmd /= Void
		local
			p: BASE_PROCESS
			retried: BOOLEAN
			err: BOOLEAN
		do
			if not retried then
				err := False
				create Result.make (10)
				p := (create {BASE_PROCESS_FACTORY}).process_launcher_with_command_line (a_cmd, a_dir )
				p.set_hidden (True)
				p.set_separate_console (False)
				p.redirect_input_to_stream
				p.redirect_output_to_agent (agent  (res: STRING; s: STRING)
					do
						res.append_string (s)
					end (Result, ?))
				p.redirect_error_to_same_as_output
				p.launch
				if not p.launched then
					if a_error_buffer /= Void then
						a_error_buffer.append ("Error: can not execute %"" + a_cmd + "%"%N")
					end
					debug
						io.error.put_string ("Error: can not execute %"" + a_cmd + "%"%N")
					end
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
			end
		rescue
			retried := True
			retry
		end

end
