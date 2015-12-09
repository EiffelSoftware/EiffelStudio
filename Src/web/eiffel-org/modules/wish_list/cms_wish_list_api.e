note
	description: "[
		API to manage CMS Wish List.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_LIST_API

inherit

	CMS_MOTION_API

create {CMS_WISH_LIST_MODULE}

	make_with_storage


feature -- Resource Access

	name, collection: STRING = "wish_list"
			-- <Precursor>

	resource_path: STRING = "resources"
			-- <Precursor>

	item: STRING = "wish"

end
