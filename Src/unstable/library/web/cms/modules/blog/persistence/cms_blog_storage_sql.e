note
	description: "Access to the sql database for the blog module"
	author: "Dario Bösch <daboesch@student.ethz.ch>"
	date: "$Date: 2015-05-21 14:46:00 +0100$"
	revision: "$Revision$"

class
	CMS_BLOG_STORAGE_SQL

inherit
	CMS_NODE_STORAGE_SQL

	CMS_BLOG_STORAGE_I

create
	make

feature -- Access

	blogs_count: INTEGER_64
			-- <Precursor>
		do
			error_handler.reset
			write_information_log (generator + ".blogs_count")
			sql_query (sql_select_blog_count, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
		end

	blogs_count_from_user (a_user: CMS_USER) : INTEGER_64
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			error_handler.reset
			write_information_log (generator + ".blogs_count_from_user")
			create l_parameters.make (2)
			l_parameters.put (a_user.id, "user")
			sql_query (sql_select_blog_count_from_user, l_parameters)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
		end

	blogs: LIST [CMS_NODE]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".blogs")

			from
				sql_query (sql_select_blogs_order_created_desc, Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

	blogs_limited (a_limit: NATURAL_32; a_offset: NATURAL_32): LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".blogs_limited")

			from
				create l_parameters.make (2)
				l_parameters.put (a_limit, "limit")
				l_parameters.put (a_offset, "offset")
				sql_query (sql_blogs_limited, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

	blogs_from_user_limited (a_user: CMS_USER; a_limit: NATURAL_32; a_offset: NATURAL_32): LIST [CMS_NODE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_NODE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".blogs_from_user_limited")

			from
				create l_parameters.make (2)
				l_parameters.put (a_limit, "limit")
				l_parameters.put (a_offset, "offset")
				l_parameters.put (a_user.id, "user")
				sql_query (sql_blogs_from_user_limited, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_node as l_node then
					Result.force (l_node)
				end
				sql_forth
			end
			sql_finalize
		end

feature {NONE} -- Queries

	sql_select_blog_count: STRING = "SELECT count(*) FROM nodes WHERE status != -1 AND type = %"blog%";"
			-- Nodes count (Published and not Published)
			--| note: {CMS_NODE_API}.trashed = -1

	sql_select_blog_count_from_user: STRING = "SELECT count(*) FROM nodes WHERE status != -1 AND type = %"blog%" AND author = :user ;"
			-- Nodes count (Published and not Published)
			--| note: {CMS_NODE_API}.trashed = -1

	sql_select_blogs_order_created_desc: STRING = "SELECT * FROM nodes WHERE status != -1 AND type = %"blog%" ORDER BY created DESC;"
			-- SQL Query to retrieve all nodes that are from the type "blog" ordered by descending creation date.

	sql_blogs_limited: STRING = "SELECT * FROM nodes WHERE status != -1 AND type = %"blog%" ORDER BY created DESC LIMIT :limit OFFSET :offset ;"
			--- SQL Query to retrieve all node of type "blog" limited by limit and starting at offset

	sql_blogs_from_user_limited: STRING = "SELECT * FROM nodes WHERE status != -1 AND type = %"blog%" AND author = :user ORDER BY created DESC LIMIT :limit OFFSET :offset ;"
			--- SQL Query to retrieve all node of type "blog" from author with id limited by limit + offset


end
