note
	description: "Interface for accessing blog contents from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_BLOG_STORAGE_I

inherit
	CMS_NODE_STORAGE_I

feature -- Access

	blogs_count: INTEGER_64
			-- Count of blog nodes
		deferred
		end

	blogs_count_from_user (a_user: CMS_USER) : INTEGER_64
			-- Number of nodes of type blog from `a_user'.
		require
			has_id: a_user.has_id
		deferred
		end

	blogs: LIST [CMS_NODE]
			-- List of nodes ordered by creation date (descending).
		deferred
		end

	blogs_limited (limit: NATURAL_32; offset: NATURAL_32): LIST [CMS_NODE]
			-- List of posts ordered by creation date from offset to offset + limit.
		deferred
		end

	blogs_from_user_limited (a_user: CMS_USER; limit: NATURAL_32; offset: NATURAL_32): LIST [CMS_NODE]
			-- List of posts from `a_user' ordered by creation date from offset to offset + limit.
		require
			has_id: a_user.has_id
		deferred
		end

end
