note
	description: "[
		API to manage CMS Task List.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TASK_LIST_API

inherit

	CMS_MOTION_API

create {CMS_TASK_LIST_MODULE}

	make_with_storage


feature -- Resource Access

	name, collection: STRING = "task_list"
			-- <Precursor>

	resource_path: STRING = "resources"
			-- <Precursor>

	item: STRING = "task"

end
