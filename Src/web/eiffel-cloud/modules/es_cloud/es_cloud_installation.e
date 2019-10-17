note
	description: "Summary description for {ES_CLOUD_INSTALLATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATION

create
	make
	
feature {NONE} -- Creation

	make (a_installation_id: READABLE_STRING_GENERAL; a_user: CMS_USER)
		do
			user := a_user
			create installation_id.make_from_string_general (a_installation_id)
			create info.make_empty
			status := status_active
		end

feature -- Access

	installation_id: IMMUTABLE_STRING_32

	user: CMS_USER

	info: IMMUTABLE_STRING_32

	status: INTEGER

	creation_date: detachable DATE_TIME
			-- Installation registration date.

feature -- status report

	is_active: BOOLEAN
		do
			Result := status = status_active
		end

feature -- Constants/status

	status_active: INTEGER = 1
	status_inactive: INTEGER = 0

feature -- Element change

	set_info (inf: detachable READABLE_STRING_GENERAL)
		do
			if inf = Void then
				create info.make_empty
			else
				create info.make_from_string_general (inf)
			end
		end

	set_status (s: INTEGER)
		do
			status := s
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end

end
