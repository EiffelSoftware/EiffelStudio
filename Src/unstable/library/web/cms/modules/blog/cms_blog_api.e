note
	description: "API to handle nodes of type blog. Extends the node API."
	author: "Dario Bösch <daboesch@student.ethz.ch"
	date: "$Date: 2015-05-21 14:46:00 +0100$"
	revision: "$Revision$"

class
	CMS_BLOG_API

inherit
	CMS_MODULE_API
		rename
			make as make_with_cms_api
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_node_api: CMS_NODE_API)
			-- (from CMS_MODULE_API)
			-- (export status {NONE})
		do
			node_api := a_node_api
			make_with_cms_api (a_api)
		end

	initialize
			-- <Precursor>
		do
			Precursor

				-- Create the node storage for type blog
			if attached storage.as_sql_storage as l_storage_sql then
				create {CMS_BLOG_STORAGE_SQL} blog_storage.make (l_storage_sql)
			else
				create {CMS_BLOG_STORAGE_NULL} blog_storage.make
			end
--			initialize_node_types
		end

feature {CMS_API_ACCESS, CMS_MODULE, CMS_API} -- Restricted access		

	node_api: CMS_NODE_API

feature {CMS_MODULE} -- Access nodes storage.

	blog_storage: CMS_BLOG_STORAGE_I

feature -- Configuration of blog handlers

	entries_per_page : NATURAL_32 = 2
			-- The numbers of posts that are shown on one page. If there are more post a pagination is generated
			--| For test reasons this is 2, so we don't have to create a lot of blog entries.
			--| TODO: Set to bigger constant.

feature -- Access node

	blogs_count: INTEGER_64
			-- Number of nodes of type blog.
		do
			Result := blog_storage.blogs_count
		end

	blogs_count_from_user (a_user: CMS_USER): INTEGER_64
			-- Number of nodes of type blog from user with `a_user_id'.
		require
			has_id: a_user.has_id
		do
			Result := blog_storage.blogs_count_from_user (a_user)
		end

	blogs_order_created_desc: LIST [CMS_BLOG]
			-- List of nodes ordered by creation date (descending)
		do
			Result := nodes_to_blogs (blog_storage.blogs)
		end

	blogs_order_created_desc_limited (a_limit: NATURAL_32; a_offset: NATURAL_32): LIST [CMS_BLOG]
			-- List of nodes ordered by creation date and limited by limit and offset
		do
				-- load all posts and add the authors to each post
			Result := nodes_to_blogs (blog_storage.blogs_limited (a_limit, a_offset))
		end

	blogs_from_user_order_created_desc_limited (a_user: CMS_USER; a_limit: NATURAL_32; a_offset: NATURAL_32) : LIST [CMS_BLOG]
			-- List of nodes ordered by creation date and limited by limit and offset
		require
			has_id: a_user.has_id
		do
				-- load all posts and add the authors to each post
			Result := nodes_to_blogs (blog_storage.blogs_from_user_limited (a_user, a_limit, a_offset))
		end

feature -- Conversion

	full_blog_node (a_blog: CMS_BLOG): CMS_BLOG
			-- If `a_blog' is partial, return the full blog node from `a_blog',
			-- otherwise return directly `a_blog'.
		require
			a_blog_set: a_blog /= Void
		do
			if attached {CMS_BLOG} node_api.full_node (a_blog) as l_full_blog then
				Result := l_full_blog
			else
				Result := a_blog
			end
		end

feature {NONE} -- Helpers

	nodes_to_blogs (a_nodes: LIST [CMS_NODE]): ARRAYED_LIST [CMS_BLOG]
			-- Convert list of nodes into a list of blog when possible.
		do
			create {ARRAYED_LIST [CMS_BLOG]} Result.make (a_nodes.count)

			if attached node_api as l_node_api then
				across
					a_nodes as ic
				loop
					if attached {CMS_BLOG} l_node_api.full_node (ic.item) as l_blog then
						Result.force (l_blog)
					end
				end
			end
		end

end
