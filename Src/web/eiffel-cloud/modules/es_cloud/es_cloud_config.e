note
	description: "Summary description for {ES_CLOUD_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_CONFIG

create
	make

feature {NONE} -- Initialization

	make
		do
			session_expiration_delay := 60 -- minutes
		end


feature -- Access

	session_expiration_delay: INTEGER assign set_session_expiration_delay
			-- Delay in minutes before marking a session as expired.

feature -- Element change

	set_session_expiration_delay (d: INTEGER)
		do
			session_expiration_delay := d
		end


end
