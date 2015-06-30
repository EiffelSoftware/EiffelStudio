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
	default_create,
	make_with_location

feature {NONE} -- Initialization

	make_with_location (a_path: READABLE_STRING_GENERAL)
		do
			make (a_path, <<"-t">>)
			set_stdin_mode (True, "%N.%N%N")
		end

	default_create
		do
			Precursor
			make_with_location ("/usr/sbin/sendmail")
			if not is_available then
				make_with_location ("/usr/bin/sendmail")
			end
		end


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
