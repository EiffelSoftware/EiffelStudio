note
	description: "Summary description for {WS_NOTIFICATION_SENDMAIL_MAILER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WS_NOTIFICATION_SENDMAIL_MAILER

inherit
	NOTIFICATION_EXTERNAL_MAILER
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		local
			l_path: PATH
		do
			Precursor
			create l_path.make_current
			make (l_path.name,Void)
		end

feature -- Command		


	process_mail_command (a_cmd: READABLE_STRING_8; a_dir: STRING; is_silent: BOOLEAN; a_error_buffer: detachable STRING)
			-- process mail command `a_cmd' launched in directory `a_dir'.
		require
			cmd_attached: a_cmd /= Void
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			retried: BOOLEAN
			err: BOOLEAN
		do
			if not retried then
				err := False
				create pf
				p := pf.process_launcher_with_command_line (a_cmd, a_dir )
				p.set_hidden (True)
				p.set_separate_console (False)
				p.redirect_input_to_stream
				p.launch
				if not p.launched then
					if a_error_buffer /= Void then
						a_error_buffer.append ("Error: can not execute %"" + a_cmd + "%"%N")
					end
					io.error.put_string ("Error: can not execute %"" + a_cmd + "%"%N")
				else
					p.wait_for_exit
					if p.exit_code /= 0 then
						if not is_silent then
							io.error.put_string ("Error: exit code for %"" + a_cmd + "%" = " + p.exit_code.out + "%N")
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
