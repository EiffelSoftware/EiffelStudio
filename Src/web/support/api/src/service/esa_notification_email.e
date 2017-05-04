note
	description: "Summary description for {ESA_NOTIFICATION_EMAIL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_NOTIFICATION_EMAIL

inherit
	NOTIFICATION_EMAIL

create
	make

feature -- Status report

	is_sent: BOOLEAN
			-- Current Email is sent.

feature -- Element change

	set_is_sent (b: BOOLEAN)
		do
			is_sent := b
		end

	mail_signature: detachable STRING
		-- Email signature

feature -- Settings

	set_signature (s: STRING)
			-- Set mail_signature to 's'.
		do
			mail_signature:= s
		end
end
