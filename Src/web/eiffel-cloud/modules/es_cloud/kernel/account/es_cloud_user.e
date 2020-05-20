note
	description: "Summary description for {ES_CLOUD_USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_USER

create
	make

convert
	make ({CMS_USER, CMS_PARTIAL_USER}),
	cms_user: {CMS_USER}

feature {NONE} -- Initialization

	make (a_user: CMS_USER)
		do
			cms_user := a_user
		end

feature -- Access

	cms_user: CMS_USER

	same_as (other: detachable CMS_USER): BOOLEAN
		do
			Result := cms_user.same_as (other)
		end

	id: INTEGER_64
			-- User id.
		do
			Result := cms_user.id
		end

	has_id: BOOLEAN
		do
			Result := cms_user.has_id
		end

end
