note
	description: "Summary description for {ES_CLOUD_EMAIL_LICENSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_EMAIL_LICENSE

create
	make

convert
	license: {ES_CLOUD_LICENSE}

feature {NONE} -- Creation

	make (e: READABLE_STRING_8; a_license: ES_CLOUD_LICENSE)
		do
			email := e
			license := a_license
		end

feature -- Access

	license: ES_CLOUD_LICENSE

	email: IMMUTABLE_STRING_8

end
