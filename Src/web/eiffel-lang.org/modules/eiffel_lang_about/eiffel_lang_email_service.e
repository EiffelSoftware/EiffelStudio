note
	description: "Summary description for {EIFFEL_LANG_EMAIL_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_EMAIL_SERVICE

inherit
	EMAIL_SERVICE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization	

	make (a_params: EIFFEL_LANG_EMAIL_SERVICE_PARAMETERS)
			-- <Precursor>
		do
			parameters := a_params
			initialize
			if not admin_email.has ('<') then
				admin_email := "Eiffel Lang Notification Contact <" + admin_email +">"
			end
		end

feature -- Access		

	contact_email: IMMUTABLE_STRING_8
			-- Contact email.
		once
			Result := "Eiffel-Lang Community <contact@eiffel-lang.org>"
		end

feature -- Basic Operations

	send_contact_email (a_to, a_content: READABLE_STRING_8)
			-- Send successful contact message `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
		do
			send_message (contact_email, a_to, "Thank you for contact us", a_content)
		end

end
