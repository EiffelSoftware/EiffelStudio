note
	description: "Summary description for {CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER

inherit
	CMS_NODE_TYPE_WEBFORM_MANAGER [CMS_BLOG]
		redefine
			content_type
		end

create
	make

feature -- Access

	content_type: CMS_BLOG_NODE_TYPE
			-- Associated content type.	

end
