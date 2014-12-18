note
	description: "Summary description for {EIFFEL_LANG_EMAIL_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_EMAIL_SERVICE

inherit
	EMAIL_SERVICE
		redefine
			initialize,
			parameters
		end

create
	make

feature {NONE} -- Initialization	

	initialize
		do
			Precursor
			contact_email := parameters.contact_email
		end

	parameters: EIFFEL_LANG_EMAIL_SERVICE_PARAMETERS
			-- Associated parameters.		

feature -- Access		

	contact_email: IMMUTABLE_STRING_8
			-- Contact email.

feature -- Basic Operations

	send_contact_email (a_to, a_content: READABLE_STRING_8)
			-- Send successful contact message `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
		do
			send_message (contact_email, a_to, parameters.contact_subject_text, a_content)
		end

end
