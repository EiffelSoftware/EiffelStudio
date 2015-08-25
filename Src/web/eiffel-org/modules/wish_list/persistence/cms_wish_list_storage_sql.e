note
	description: "CMS_WISH_LIST_STORAGE_SQL"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_LIST_STORAGE_SQL

inherit
	CMS_WISH_LIST_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

create
	make

feature -- Acess: WishList

	row_count_wish_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING
		do
			create l_parameters.make (2)
			l_parameters.put (a_category, "category")
			if attached a_filter then
				l_parameters.put (a_filter, "filter")
			end
			create l_query.make_from_string (sql_select_row_count_wish_list)

				-- Filter search.
			if
				attached a_filter and then
				not a_filter.is_empty
			then
				if a_content = 1 then
						-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", filter_by_content)
				else
						-- Search only by Synopsis
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", " AND (( ProblemReports.Synopsis like '%%' + :filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", "")
			end

			l_query.replace_substring_all ("$StatusSet", "(" + a_status + ")")
			write_information_log (generator + ".row_count_wish_list")
			sql_query (l_query, l_parameters)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
		end


	wish_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_WISH_LIST]
				-- <Precursor>
			local
				l_parameters: STRING_TABLE [ANY]
				l_query: STRING
			do
				create l_parameters.make (4)
				l_parameters.put (a_rows_per_page, "RowsPerPage")
				l_parameters.put (a_page_number - 1, "Offset")
				l_parameters.put (a_category, "category")
				if attached a_filter then
					l_parameters.put (a_filter, "filter")
				end
				create l_query.make_from_string (sql_select_wish_list_template)
				if a_order = 1 then
					l_query.replace_substring_all ("$ORD", "ASC")
				else
					l_query.replace_substring_all ("$ORD", "DESC")
				end
				l_query.replace_substring_all ("$Column", a_column)

					-- Filter search.
				if
					attached a_filter and then
					not a_filter.is_empty
				then
					if a_content = 1 then
							-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
						l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", filter_by_content)
					else
							-- Search only by Synopsis
						l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", " AND (( wish_list.synopsis like '%%' + :filter + '%%'))")
					end
				else
						-- No filter
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", "")
				end

				--| Need to be updated to build the set based on user selection.
				l_query.replace_substring_all ("$StatusSet", "(" + a_status + ")")
				write_information_log (generator + ".row_count_wish_list")

				create {ARRAYED_LIST [CMS_WISH_LIST]} Result.make (0)
				from
					sql_query (l_query, l_parameters)
					sql_start
				until
					sql_after
				loop
					if attached fetch_wish as l_wish then
						Result.force (l_wish)
					end
					sql_forth
				end
			end

	wish_by_id (a_wid: INTEGER_64): detachable CMS_WISH_LIST
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".wish_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_wid, "wid")
			sql_query (sql_select_wish_by_id, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_wish
			end
		end

	wish_interactions (a_wid: INTEGER): detachable LIST [CMS_WISH_LIST_INTERACTION]
			-- <Precursor>
		local
				l_parameters: STRING_TABLE [ANY]
		do
			create {ARRAYED_LIST [CMS_WISH_LIST_INTERACTION]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".wish_interactions")

			create l_parameters.make (1)
			l_parameters.put (a_wid, "wid")

			from
				sql_query (sql_select_wish_interactions, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_interaction as l_interaction then
					Result.force (l_interaction)
				end
				sql_forth
			end
		end


	wish_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): detachable LIST [CMS_WISH_FILE]
			-- <Precursor>
		local
				l_parameters: STRING_TABLE [ANY]
		do
			create {ARRAYED_LIST [CMS_WISH_FILE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".wish_attachments")

			create l_parameters.make (1)
			l_parameters.put (a_wid, "wid")
			l_parameters.put (a_interaction_id, "iid")

			from
				sql_query (sql_select_wish_attachments, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_attachment as l_attachment then
					Result.force (l_attachment)
				end
				sql_forth
			end
		end


	wish_author (a_wish: CMS_WISH_LIST): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".wish_author")
			create l_parameters.make (2)
			l_parameters.put (a_wish.id, "wid")
			sql_query (Select_user_author, l_parameters)
			if sql_rows_count >= 1 then
				Result := fetch_author
			end
		end


	vote_wish (u: CMS_USER; a_wish: CMS_WISH_LIST): INTEGER
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".vote_wish")
			create l_parameters.make (2)
			l_parameters.put (a_wish.id, "wid")
			l_parameters.put (u.id, "author")
			sql_query (Select_wish_author_vote, l_parameters)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
		end

	has_vote_wish (u: CMS_USER; a_wid: INTEGER_64): BOOLEAN
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".vote_wish")
			create l_parameters.make (2)
			l_parameters.put (a_wid, "wid")
			l_parameters.put (u.id, "author")
			sql_query (Select_exist_wish_author_vote, l_parameters)
			if sql_rows_count = 1 then
				Result := True
			end
		end

feature -- Change wish vote

	add_wish_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add like to wish `a_wid'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".add_wish_like")
			create l_parameters.make (3)
			l_parameters.put (1, "vote")
			l_parameters.put (a_wid, "wid")
			l_parameters.put (a_user.id, "author")

			sql_begin_transaction
			if has_vote_wish (a_user, a_wid) then
					-- Update
				sql_change (sql_update_wish_vote, l_parameters)
			else
					-- New
				sql_change (sql_insert_wish_vote, l_parameters)
			end
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
				if attached {CMS_WISH_LIST} wish_by_id (a_wid) as l_wish then
					 l_wish.set_votes (l_wish.votes + 1)
					 save_wish (l_wish)
				end
			end
		end

	add_wish_not_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add not like to wish `a_wid'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			  -- Todo refactor
			error_handler.reset
			write_information_log (generator + ".add_wish_not_like")
			create l_parameters.make (3)
			l_parameters.put (-1, "vote")
			l_parameters.put (a_wid, "wid")
			l_parameters.put (a_user.id, "author")

			sql_begin_transaction
			if has_vote_wish (a_user, a_wid) then
					-- Update
				sql_change (sql_update_wish_vote, l_parameters)
			else
					-- New
				sql_change (sql_insert_wish_vote, l_parameters)
			end
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
				if attached {CMS_WISH_LIST} wish_by_id (a_wid) as l_wish then
					 l_wish.set_votes (l_wish.votes - 1)
					 save_wish (l_wish)
				end
			end
		end

feature -- Change: WishList

	save_wish (a_wish: CMS_WISH_LIST)
			-- <Precursor>
		do
			store_wish (a_wish)
		end

	save_wish_interaction (a_wish: CMS_WISH_LIST_INTERACTION)
			-- <Precursor>
		do
			store_wish_interaction (a_wish)
		end

	upload_wish_attachment  (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_size:INTEGER_64; a_content: READABLE_STRING_32; a_file_name: READABLE_STRING_32)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE[ANY]
		do
			error_handler.reset

			write_information_log (generator + ".upload_wish_attachment")
			create l_parameters.make (5)
			l_parameters.put (a_interaction_id, "iid")
			l_parameters.put (a_id, "wid")
			l_parameters.put (a_size, "length")
			l_parameters.put (a_content, "content")
			l_parameters.put (a_file_name, "fileName")
			sql_begin_transaction
			sql_change (sql_upload_wish_attachment, l_parameters)
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

	remove_wish_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		local
			l_parameters: STRING_TABLE[ANY]
		do
			error_handler.reset

			write_information_log (generator + ".remove_wish_attachments")
			create l_parameters.make (5)
			l_parameters.put (a_id, "wid")
			l_parameters.put (a_interaction_id, "iid")
			sql_begin_transaction
			sql_change (sql_delete_wish_attachments, l_parameters)
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


	remove_wish_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- Remove attachment with name `a_name' associated with wish `a_id'.
		local
			l_parameters: STRING_TABLE[ANY]
		do
			error_handler.reset

			write_information_log (generator + ".remove_wish_attachment_by_name")
			create l_parameters.make (2)
			l_parameters.put (a_id, "wid")
			l_parameters.put (a_name, "name")
			l_parameters.put (a_interaction_id, "iid")
			sql_begin_transaction
			sql_change (sql_delete_wish_attachment_by_name, l_parameters)
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


feature -- Access: Categories

	categories_count: INTEGER
			-- <Precursor>
		do
			error_handler.reset
			write_information_log (generator + ".categories_count")

			sql_query (select_categories_count, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_32 (1)
			end
			error_handler.reset
		end


	recent_categories (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_WISH_LIST_CATEGORY]
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_WISH_LIST_CATEGORY]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".recent_categories")

			from
				create l_parameters.make (2)
				l_parameters.put (a_count, "rows")
				l_parameters.put (a_lower, "offset")
				sql_query (sql_select_recent_categories, l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_category as l_category then
					Result.force (l_category)
				end
				sql_forth
			end
		end

	categories: LIST [CMS_WISH_LIST_CATEGORY]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_WISH_LIST_CATEGORY]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".categories")

			from
				sql_query (sql_select_categories, Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_category as l_category then
					Result.force (l_category)
				end
				sql_forth
			end
		end

	category_by_id (a_id: INTEGER_64): detachable CMS_WISH_LIST_CATEGORY
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".category_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_id, "cid")
			sql_query (sql_select_category_by_id, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_category
			end
		end

	category_by_name (a_name: READABLE_STRING_32): detachable CMS_WISH_LIST_CATEGORY
			-- Category for the given name`a_name', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".category_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name, "name")
			sql_query (sql_select_category_by_name, l_parameters)
			if sql_rows_count = 1 then
				Result := fetch_category
			end
		end

feature -- Change: Category

	save_category (a_category: CMS_WISH_LIST_CATEGORY)
			-- Save category `a_category'.
		do
			store_category (a_category)
		end


feature -- Access: Status

	status: LIST [CMS_WISH_LIST_STATUS]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_WISH_LIST_STATUS]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".status")

			from
				sql_query (sql_select_status, Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_status as l_status then
					Result.force (l_status)
				end
				sql_forth
			end
		end


feature {NONE} -- Implemenation

	fetch_category: detachable CMS_WISH_LIST_CATEGORY
		do
			if attached sql_read_integer_32 (1) as l_id then
				create Result.make_empty
				Result.set_id (l_id)

					-- Synopsis
				if attached sql_read_string_32 (2) as l_synopsis then
					Result.set_synopsis (l_synopsis)
				end
					-- Description
				if attached sql_read_string_32 (3) as l_description then
					Result.set_description (l_description)
				end

				if attached sql_read_integer_32 (4) as l_boolean then
					Result.set_is_active (l_boolean.to_boolean)
				end
			end
		end


	fetch_status: detachable CMS_WISH_LIST_STATUS
		do
			 -- Synopsis, PAG2.CategorySynopsis as CategorySynopsis, SubmissionDate, PAG2.StatusID as statusID, PAG2.StatusSynopsis, PAG2.Username, PAG2.votes
			if attached sql_read_integer_32 (1) as l_id then
				create Result.make_empty
				Result.set_id (l_id)

				if attached sql_read_string_32 (2) as l_synopsis then
					Result.set_synopsis (l_synopsis)
				end
			end
		end

	fetch_wish: detachable CMS_WISH_LIST
		do
			if attached sql_read_integer_32 (1) as l_id then
				create Result.make_empty
				Result.set_id (l_id)

					-- Synopsis
				if attached sql_read_string_32 (2) as l_synopsis then
					Result.set_synopsis (l_synopsis)
				end

					-- Category Synopsis
				if
					attached sql_read_string_32 (3) as l_category_synopsis and then
					attached sql_read_integer_32 (7) as l_category_id
				then
					Result.set_wish_list_category (create {CMS_WISH_LIST_CATEGORY}.make (l_category_id, l_category_synopsis, True))

				end

					-- Submission date
				if attached sql_read_date_time (4) as l_date then
					Result.set_submission_date (l_date)
				end

					-- Status
				if attached sql_read_integer_32 (5) as l_status_id then
					Result.set_status (create {CMS_WISH_LIST_STATUS}.make (l_status_id, ""))
					if attached sql_read_string (6) as l_synopsis and then attached Result.status as l_status then
						l_status.set_synopsis (l_synopsis)
					end
				end
					-- Username/Contact
				if
					attached sql_read_integer_64 (8) as l_user_id and then
					attached sql_read_string_32 (9) as l_user
				then
					Result.set_contact (create {CMS_USER}.make (l_user))
					if attached Result.contact as l_contact then
						l_contact.set_id (l_user_id)
					end
				end

					-- Votes
				if attached sql_read_integer_32 (10) as l_votes then
					Result.set_votes (l_votes)
				end

					-- Description
				if attached sql_read_string_32 (11) as l_description then
					Result.set_description(l_description)
				end
			end
		end

	fetch_interaction: detachable CMS_WISH_LIST_INTERACTION
		do
				--	wi.iid, wi.wid, wi.author, wi.content
			if attached sql_read_integer_32 (1) as l_id then
				create Result.make_empty
				Result.set_id (l_id)

					-- Wish id
				if attached sql_read_integer_64 (2) as l_wish_id then
					Result.set_wish_id (l_wish_id)
				end

					-- author id, and name
				if
					attached sql_read_integer_32 (3) as l_author and then
					attached sql_read_string_32 (4) as l_author_name
				then
					Result.set_contact (create {CMS_USER}.make (l_author_name))
				end

					-- content
				if attached sql_read_string_32 (5) as l_content then
					Result.set_content (l_content)
				end

					-- changed
				if attached sql_read_date_time(6) as l_date then
					Result.set_date (l_date)
				end

			end
		end


	store_wish (a_wish: CMS_WISH_LIST)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			now: DATE_TIME
		do
			create now.make_now_utc
			error_handler.reset

			write_information_log (generator + ".store_wish")
			create l_parameters.make (5)
			if
				attached a_wish.category as l_category and then
				attached a_wish.contact as l_contact and then
				attached a_wish.description as l_description and then
				attached a_wish.status as l_status
			then
				l_parameters.put (l_contact.id, "author")
				l_parameters.put (l_category.id, "category")
				l_parameters.put (l_status.id, "status")
				l_parameters.put (a_wish.synopsis, "synopsis")
				l_parameters.put (l_description, "description")
				l_parameters.put (now, "changed")
				l_parameters.put (a_wish.votes, "votes")
			else
				error_handler.add_custom_error (1, "Missign required data", "Check if category, contact, description or status are defined!")
			end

			sql_begin_transaction
			if a_wish.has_id then
				l_parameters.put (a_wish.id, "id")
				sql_change (sql_update_wish, l_parameters)
			else
					-- New
				l_parameters.put (now, "created")
				sql_change (sql_insert_wish, l_parameters)
				if not error_handler.has_error then
					a_wish.set_id (last_inserted_wish_id)
				end
			end

			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


	store_wish_interaction (a_wish_interaction: CMS_WISH_LIST_INTERACTION)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			now: DATE_TIME
		do
			create now.make_now_utc
			error_handler.reset

			write_information_log (generator + ".store_wish_interaction")
			create l_parameters.make (5)
			if
				attached a_wish_interaction.content as l_content and then
				attached a_wish_interaction.contact as l_contact
			then
				l_parameters.put (a_wish_interaction.wish_id, "wid")
				l_parameters.put (l_contact.id, "author")
				l_parameters.put (l_content, "description")
				l_parameters.put (now, "changed")
			else
				error_handler.add_custom_error (1, "Missign required data", "Check if description or contact are defined!")
			end

			sql_begin_transaction
			if a_wish_interaction.has_id then
				l_parameters.put (a_wish_interaction.id, "id")
				sql_change (sql_update_wish_interaction, l_parameters)
			else
					-- New
				sql_change (sql_insert_wish_interaction, l_parameters)
				if not error_handler.has_error then
					a_wish_interaction.set_id (last_inserted_wish_interaction_id)
				end
			end

			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


	store_category (a_category: CMS_WISH_LIST_CATEGORY)
		local
			l_parameters: STRING_TABLE [detachable ANY]
			now: DATE_TIME
		do
			create now.make_now_utc
			error_handler.reset

			write_information_log (generator + ".store_category")
			create l_parameters.make (3)
			l_parameters.put (a_category.synopsis,"synopsis")
			l_parameters.put (a_category.is_active.to_integer, "is_active")
			if
				attached a_category.description as l_description
			then
				l_parameters.put (l_description, "description")
			else
				l_parameters.put ("", "description")
			end

			sql_begin_transaction
			if a_category.has_id then
				l_parameters.put (a_category.id, "cid")
				sql_change (sql_update_wish_category, l_parameters)
			else
					-- New
				sql_change (sql_insert_wish_category, l_parameters)
				if not error_handler.has_error then
					a_category.set_id (last_inserted_wish_category_id)
				end
			end

			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

	fetch_attachment: detachable CMS_WISH_FILE
		do
			if
				attached sql_read_integer_64 (1) as l_id and then
				attached sql_read_integer_64 (2) as l_length and then
				attached sql_read_string_32 (3) as l_content and then
				attached sql_read_string_32 (4) as l_file_name
			then
				create Result.make (l_file_name, l_length, l_content)
				Result.set_id (l_id)
			end
		end

	last_inserted_wish_id: INTEGER_64
			-- Last insert wish id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_wish_id")
			sql_query (Sql_last_insert_wish_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end


	last_inserted_wish_interaction_id: INTEGER_64
			-- Last insert wish_interaction id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_wish_interaction_id")
			sql_query (Sql_last_insert_wish_interaction_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end


	last_inserted_wish_category_id: INTEGER_64
			-- Last insert wish_category id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_wish_category_id")
			sql_query (Sql_last_insert_wish_category_id, Void)
			if sql_rows_count = 1 then
				Result := sql_read_integer_64 (1)
			end
		end


	fetch_author: detachable CMS_USER
		do
			if attached sql_read_string_32 (2) as l_name and then not l_name.is_whitespace then
				create Result.make (l_name)
				if attached sql_read_integer_32 (1) as l_id then
					Result.set_id (l_id)
				end
				if attached sql_read_string (3) as l_password then
						-- FIXME: should we return the password here ???
					Result.set_hashed_password (l_password)
				end
				if attached sql_read_string (5) as l_email then
					Result.set_email (l_email)
				end
			else
				check expected_valid_user: False end
			end
		end


feature {NONE} -- Queries


	sql_select_status: STRING = "SELECT sid, synopsis FROM wish_list_status;"
			-- SQL Query to retrieve all status.


	sql_select_row_count_wish_list: STRING = "[
					SELECT COUNT(*)
					FROM wish_list
					WHERE ((wish_list.category = :category) OR (NOT EXISTS (SELECT cid FROM wish_list_categories WHERE cid = :category)))
					AND ((wish_list.status in $StatusSet))
					$SearchBySynopsisAndOrDescription
				]"


	filter_by_content: STRING =	"[
							AND (( wish_list.synopsis LIKE '%%' + :filter + '%' ) OR ( wish_list.description like '%%' + :filter + '%%' )
							OR ( wish_list.description LIKE '%%' + :filter + '%%' )
							OR ( wish_list.wid IN
								  ( SELECT  wish_list_interactions.iid
									FROM wish_list_interactions
									 	INNER JOIN wish_list ON wish_list_interactions.iid = wish_list.wid
									WHERE wish_list_interactions.content LIKE '%%' + :filter + '%%'
								   )
								)
							)
						]"


	sql_select_wish_list_template: STRING = "[
				SELECT wid, wish_list.synopsis, wish_list_categories.synopsis as CategorySynopsis, changed, wish_list.status statusID,
					   wish_list_status.synopsis, wish_list.category, users.uid author, users.name Username, wish_list.votes, wish_list.description
				FROM wish_list
				    INNER JOIN wish_list_categories ON wish_list_categories.cid = wish_list.category
				    INNER JOIN wish_list_status ON wish_list_status.sid = wish_list.status
				    INNER JOIN users ON users.uid = wish_list.author
				    WHERE ((wish_list.category = :category) OR (NOT EXISTS (SELECT cid FROM wish_list_categories WHERE cid = :category)))
						AND ((wish_list.status in $StatusSet ))	$SearchBySynopsisAndOrDescription
					ORDER BY wish_list.$Column $ORD
					LIMIT :Offset, :RowsPerPage;
    		]"


	sql_select_wish_by_id: STRING = "[
				SELECT wid, wish_list.synopsis, wish_list_categories.synopsis as CategorySynopsis, changed, wish_list.status statusID,
					   wish_list_status.synopsis, wish_list.category, users.uid author, users.name Username, wish_list.votes, wish_list.description
				FROM wish_list
				    INNER JOIN wish_list_categories ON wish_list_categories.cid = wish_list.category
				    INNER JOIN wish_list_status ON wish_list_status.sid = wish_list.status
				    INNER JOIN users ON users.uid = wish_list.author
				    WHERE wish_list.wid = :wid;
				  ]"


	sql_select_wish_interactions: STRING = "[
			SELECT wi.iid, wi.wid, wi.author, users.name, wi.content, wi.changed 
			FROM wish_list_interactions wi
			INNER JOIN users ON users.uid = wi.author
			WHERE wi.wid = :wid
		]"

	sql_last_insert_wish_id: STRING = "SELECT MAX(wid) FROM wish_list;"

	sql_last_insert_wish_interaction_id: STRING = "SELECT MAX(iid) FROM wish_list_interactions;"

	sql_insert_wish: STRING = "INSERT INTO wish_list (author, category, status, synopsis, description, changed, votes, created ) VALUES (:author, :category, :status, :synopsis, :description, :changed, :votes, :created);"
			-- SQL Insert to add a new wish

	sql_update_wish: STRING = "UPDATE wish_list SET author=:author, category=:category, status =:status, synopsis=:synopsis, description=:description, changed=:changed, votes=:votes WHERE wid=:id;"
			-- SQL update wish.

	sql_insert_wish_interaction: STRING = "INSERT INTO wish_list_interactions (wid, author, content, changed ) VALUES (:wid, :author, :description, :changed);"
			-- SQL Insert to add a new wish interaction.

	sql_update_wish_interaction: STRING = "UPDATE wish_list_interactions SET wid=:wid, author=:author, content=:description, changed=:changed WHERE iid=:id;"
			-- SQL update wish interaction.		

	sql_upload_wish_attachment: STRING = "INSERT INTO wish_list_attachments (iid, wid, length, content, fileName) VALUES (:iid, :wid, :length, :content, :fileName);"

	sql_select_wish_attachments: STRING = "SELECT wid, length, content, fileName  FROM wish_list_attachments WHERE wid =:wid and iid=:iid;"

	sql_delete_wish_attachments: STRING = "DELETE FROM wish_list_attachments  WHERE wid =:wid and iid=:iid;"

	sql_delete_wish_attachment_by_name: STRING = "DELETE FROM wish_list_attachments  WHERE wid =:wid and fileName =:name and iid =:iid;"

	Select_user_author: STRING = "SELECT uid, name, password, salt, email, users.status, users.created, signed FROM wish_list INNER JOIN users ON wish_list.author=users.uid AND wish_list.wid = :wid;"

	Select_wish_author_vote: STRING = "SELECT vote FROM wish_list_votes  WHERE wish=:wid AND author=:author;"

	Select_exist_wish_author_vote: STRING = "SELECT * FROM wish_list_votes  WHERE wish=:wid AND author=:author;"

	SQL_update_wish_vote: STRING = "UPDATE wish_list_votes SET vote=:vote WHERE wish=:wid AND author=:author;"

	SQL_insert_wish_vote: STRING = "INSERT INTO wish_list_votes (wish, author, vote) VALUES (:wid, :author, :vote);"

feature -- SQL query: Categories

	select_categories_count: STRING = "SELECT COUNT(*) FROM wish_list_categories;"

	Sql_select_recent_categories: STRING = "SELECT cid, synopsis, description, is_active FROM wish_list_categories ORDER BY cid DESC LIMIT :rows OFFSET :offset ;"
			-- Retrieve recent users

	sql_select_categories: STRING = "SELECT cid, synopsis, description, is_active FROM wish_list_categories WHERE is_active != 0 ;"
			-- SQL Query to retrieve all active categories.
			--| note: is_active =! 0

	sql_select_category_by_id: STRING = "SELECT cid, synopsis, description, is_active FROM wish_list_categories WHERE cid =:cid;"

	sql_select_category_by_name: STRING = "SELECT cid, synopsis, description, is_active FROM wish_list_categories WHERE synopsis =:name;"

	sql_update_wish_category: STRING = "UPDATE wish_list_categories SET synopsis=:synopsis, is_active=:is_active, description=:description WHERE cid=:cid;"

	sql_insert_wish_category: STRING = "INSERT INTO wish_list_categories (synopsis, is_active, description ) VALUES (:synopsis, :is_active, :description);"

	sql_last_insert_wish_category_id: STRING = "SELECT MAX(cid) FROM wish_list_categories;"


end
