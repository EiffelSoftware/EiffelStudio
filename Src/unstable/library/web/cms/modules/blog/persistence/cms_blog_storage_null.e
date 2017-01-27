note
	description: "Summary description for {CMS_BLOG_STORAGE_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOG_STORAGE_NULL

inherit
	CMS_NODE_STORAGE_NULL

	CMS_BLOG_STORAGE_I

create
	make

feature -- Access

	blogs_count: INTEGER_64
			-- Count of nodes.
		do
		end

	blogs_count_from_user (a_user: CMS_USER) : INTEGER_64
			-- <Precursor>
		do
		end

	blogs: LIST [CMS_NODE]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	blogs_limited (limit: NATURAL_32; offset: NATURAL_32) : LIST [CMS_NODE]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	blogs_from_user_limited (a_user: CMS_USER; limit: NATURAL_32; offset: NATURAL_32): LIST [CMS_NODE]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end

	blogs_from_user_with_title (a_user: CMS_USER; a_title: READABLE_STRING_GENERAL): LIST [CMS_NODE]
			-- List of blogs from `a_user' with title `a_title` and ordered by creation date.
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)
		end
end
