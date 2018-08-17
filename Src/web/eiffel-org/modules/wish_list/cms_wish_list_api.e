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

	name, collection: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			create Result.make_from_string ("wish_list")
		end

	resource_path: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			create Result.make_from_string ("resources")
		end

	item: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			create Result.make_from_string ("wish")
		end

end
