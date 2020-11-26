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

feature -- Element change

	update_user (api: CMS_API)
		do
			if attached {CMS_PARTIAL_USER} cms_user as l_partial and then attached api.user_api.user_by_id (l_partial.id) as l_user then
				cms_user := l_user
			end
		end

end
