note
	description: "Summary description for {ES_CLOUD_USER_LICENSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_USER_LICENSE

create
	make

convert
	license: {ES_CLOUD_LICENSE}

feature {NONE} -- Creation

	make (u: ES_CLOUD_USER; a_license: ES_CLOUD_LICENSE)
		do
			user := u
			license := a_license
		end

feature -- Access

	license: ES_CLOUD_LICENSE

	user: ES_CLOUD_USER

	user_id: INTEGER_64
		do
			Result := user.id
		end

end
