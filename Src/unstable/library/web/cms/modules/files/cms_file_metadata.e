note
	description: "Metadata associated to a CMS_FILE."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILE_METADATA

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			create date.make_now_utc
		end

	make (f: CMS_FILE)
		do
			make_empty
		end

feature -- Access

	user: detachable CMS_USER

	date: detachable DATE_TIME

	size: INTEGER

	file_type: detachable READABLE_STRING_8

feature -- Element change

	set_user (u: detachable CMS_USER)
		do
			user := u
		end

	set_date (dt: detachable DATE_TIME)
		do
			date := dt
		end

	set_size (a_size: INTEGER)
		do
			size := a_size
		end

	set_file_type (a_type: detachable READABLE_STRING_8)
		do
			file_type := a_type
		end

end
