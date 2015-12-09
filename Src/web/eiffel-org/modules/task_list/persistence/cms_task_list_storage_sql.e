note
	description: "Summary description for {CMS_TASK_LIST_STORAGE_SQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TASK_LIST_STORAGE_SQL

inherit

	CMS_MOTION_LIST_STORAGE_SQL

create
	make

feature -- Table

	table_motion: STRING = "task_list"
			-- <Precursor>

end
