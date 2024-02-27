note
	description: "[
			Contact message storage based on SQL statements.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_STORAGE_FS

inherit
	CONTACT_STORAGE_I

	CMS_STORAGE_FS_I

	REFACTORING_HELPER

create
	make

feature -- Change

	save_contact_message (m: CONTACT_MESSAGE)
		local
			s: STRING
			now: DATE_TIME
		do
			error_handler.reset
			create now.make_now_utc

			create s.make_empty
			s.append ("date=")
			s.append (m.date.out)
			s.append_character ('%N')
			s.append ("name=")
			s.append (api.utf_8_encoded (m.username))
			s.append_character ('%N')

			if attached m.email as l_email then
				s.append ("email=")
				s.append (l_email)
				s.append_character ('%N')
			end
			s.append ("message=%N")
			s.append (api.utf_8_encoded (m.message))
			s.append_character ('%N')

			save_to_file (s, date_to_yyyymmdd_hhmmss_string (now))
		end

end
