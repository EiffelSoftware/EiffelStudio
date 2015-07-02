note
	description: "Summary description for {CMS_OAUTH_20_EMAIL_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_EMAIL_SERVICE

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

	parameters: CMS_OAUTH_20_EMAIL_SERVICE_PARAMETERS
			-- Associated parameters.		

feature -- Access		

	contact_email: IMMUTABLE_STRING_8
			-- contact email.

feature -- Basic Operations

	send_contact_welcome_email (a_to, a_content: READABLE_STRING_8)
			-- Send successful contact message `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_welcome)
			l_message.replace_substring_all ("$link", a_content)
			send_message (contact_email, a_to, parameters.contact_subject_register, l_message)
		end

end
