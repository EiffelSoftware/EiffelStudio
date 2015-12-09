note
	description: "Summary description for {CMS_WISH_LIST_STORAGE_SQL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_LIST_STORAGE_SQL

inherit

	CMS_MOTION_LIST_STORAGE_SQL

create
	make

feature -- Table

	table_motion: STRING = "wish_list"
			-- <Precursor>

end
