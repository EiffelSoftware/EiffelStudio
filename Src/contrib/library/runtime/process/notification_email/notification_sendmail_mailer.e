note
	description : "[
			NOTIFICATION_MAILER using sendmail as mailtool
			]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_SENDMAIL_MAILER

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
			make ("/usr/sbin/sendmail", <<"-t">>)
			if not is_available then
				make ("/usr/bin/sendmail", <<"-t">>)
			end
			set_stdin_mode (True, "%N.%N%N")
		end


note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
