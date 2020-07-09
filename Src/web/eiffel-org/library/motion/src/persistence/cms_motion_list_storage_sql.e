note
	description: "Summary description for {CMS_MOTION_LIST_STORAGE_SQL}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MOTION_LIST_STORAGE_SQL

inherit

	CMS_MOTION_LIST_STORAGE_I

	CMS_MOTION_STORAGE_CONSTANTS_SQL

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

	REFACTORING_HELPER

feature -- Acess: Motion

	row_count_motion_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING
			l_filter_by_content: STRING
		do
			error_handler.reset
			create l_parameters.make (2)
			l_parameters.put (a_category, "category")


			create l_query.make_from_string (sql_select_row_count_motion_list)
			l_query.replace_substring_all ("<motion>", table_motion)

				-- Filter search.
			if
				attached a_filter and then
				not a_filter.is_empty
			then
				if attached a_filter then
					l_parameters.put (a_filter, "filter")
				end
				if a_content = 1 then
						-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
					create l_filter_by_content.make_from_string (filter_by_content)
					l_filter_by_content.replace_substring_all ("<motion>", table_motion)
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", l_filter_by_content)
				else
						-- Search only by Synopsis
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", " AND ((  " + table_motion + ".synopsis like '%%' + :filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", "")
			end

			l_query.replace_substring_all ("$StatusSet", "(" + a_status + ")")
			write_information_log (generator + ".row_count_motion_list")
			sql_query (l_query, l_parameters)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1).as_integer_32
			end
			sql_finalize
		end


	motion_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_MOTION_LIST]
				-- <Precursor>
			local
				l_parameters: STRING_TABLE [ANY]
				l_query: STRING
				l_filter_by_content: STRING
			do
				error_handler.reset
				create l_parameters.make (3)
				l_parameters.put (a_rows_per_page, "RowsPerPage")
				l_parameters.put (a_page_number - 1, "Offset")
				l_parameters.put (a_category, "category")

				create l_query.make_from_string (sql_select_motion_list_template)
				l_query.replace_substring_all ("<motion>", table_motion)

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

					if attached a_filter then
						l_parameters.put (a_filter, "filter")
					end
					if a_content = 1 then
							-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
						create l_filter_by_content.make_from_string (filter_by_content)
						l_filter_by_content.replace_substring_all ("<motion>", table_motion)
						l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", l_filter_by_content)
					else
							-- Search only by Synopsis
						l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", " AND (( " + table_motion + ".synopsis like '%%' + :filter + '%%'))")
					end
				else
						-- No filter
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", "")
				end

				--| Need to be updated to build the set based on user selection.
				l_query.replace_substring_all ("$StatusSet", "(" + a_status + ")")
				write_information_log (generator + ".row_count_motion_list")

				create {ARRAYED_LIST [CMS_MOTION_LIST]} Result.make (0)
				from
					sql_query (l_query, l_parameters)
					sql_start
				until
					sql_after
				loop
					if attached fetch_motion as l_wish then
						Result.force (l_wish)
					end
					sql_forth
				end
				sql_finalize
			end

	motion_by_id (a_wid: INTEGER_64): detachable CMS_MOTION_LIST
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".motion_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_wid, "wid")

			sql_query (query_generator (sql_select_motion_by_id), l_parameters)
			if not has_error and not sql_after then
				Result := fetch_motion
			end
			sql_finalize
		end

	motion_interactions (a_wid: INTEGER): detachable LIST [CMS_MOTION_LIST_INTERACTION]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_INTERACTION]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".motion_interactions")

			create l_parameters.make (1)
			l_parameters.put (a_wid, "wid")

			from
				sql_query (query_generator (sql_select_motion_interactions), l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_interaction as l_interaction then
					Result.force (l_interaction)
				end
				sql_forth
			end
			sql_finalize
		end


	motion_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): detachable LIST [CMS_MOTION_FILE]
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			create {ARRAYED_LIST [CMS_MOTION_FILE]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".motion_attachments")

			create l_parameters.make (1)
			l_parameters.put (a_wid, "wid")
			l_parameters.put (a_interaction_id, "iid")

			from
				sql_query (query_generator (sql_select_motion_attachments), l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_attachment as l_attachment then
					Result.force (l_attachment)
				end
				sql_forth
			end
			sql_finalize
		end


	motion_author (a_wish: CMS_MOTION_LIST): detachable CMS_USER
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".motion_author")
			create l_parameters.make (2)
			l_parameters.put (a_wish.id, "wid")
			sql_query (query_generator (Select_user_author), l_parameters)
			if not has_error and not sql_after then
				Result := fetch_author
			end
			sql_finalize
		end


	vote_motion (u: CMS_USER; a_wish: CMS_MOTION_LIST): INTEGER
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".vote_motion")
			create l_parameters.make (2)
			l_parameters.put (a_wish.id, "wid")
			l_parameters.put (u.id, "author")
			sql_query (query_generator (select_motion_author_vote), l_parameters)
			if not has_error and not sql_after then
				Result := sql_read_integer_32 (1)
			end
			sql_finalize
		end

	has_vote_motion (u: CMS_USER; a_wid: INTEGER_64): BOOLEAN
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".has_vote_motion")
			create l_parameters.make (2)
			l_parameters.put (a_wid, "wid")
			l_parameters.put (u.id, "author")
			sql_query (query_generator (select_exist_motion_author_vote), l_parameters)
			if not has_error and not sql_after then
				Result := True
			end
			sql_finalize
		end

feature -- Change Motion vote

	add_motion_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".add_motion_like")
			create l_parameters.make (3)
			l_parameters.put (1, "vote")
			l_parameters.put (a_wid, "wid")
			l_parameters.put (a_user.id, "author")

			sql_begin_transaction
			if has_vote_motion (a_user, a_wid) then
					-- Update
				sql_modify (query_generator (sql_update_motion_vote), l_parameters)
			else
					-- New
				sql_insert (query_generator (sql_insert_motion_vote), l_parameters)
			end
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
				if attached {CMS_MOTION_LIST} motion_by_id (a_wid) as l_wish then
					 l_wish.set_votes (l_wish.votes + 1)
					 save_motion (l_wish)
				end
			end
		end

	add_motion_not_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add not like to wish `a_wid'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			  -- Todo refactor
			error_handler.reset
			write_information_log (generator + ".add_motion_not_like")
			create l_parameters.make (3)
			l_parameters.put (-1, "vote")
			l_parameters.put (a_wid, "wid")
			l_parameters.put (a_user.id, "author")

			sql_begin_transaction
			if has_vote_motion (a_user, a_wid) then
					-- Update
				sql_modify (query_generator (sql_update_motion_vote), l_parameters)
			else
					-- New
				sql_insert (query_generator (sql_insert_motion_vote), l_parameters)
			end
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
				if attached {CMS_MOTION_LIST} motion_by_id (a_wid) as l_wish then
					 l_wish.set_votes (l_wish.votes - 1)
					 save_motion (l_wish)
				end
			end
		end

feature -- Change: Motion

	save_motion (a_wish: CMS_MOTION_LIST)
			-- <Precursor>
		do
			store_motion (a_wish)
		end

	save_motion_interaction (a_wish: CMS_MOTION_LIST_INTERACTION)
			-- <Precursor>
		do
			store_motion_interaction (a_wish)
		end

	upload_motion_attachment  (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_size: INTEGER_64; a_content: READABLE_STRING_8; a_file_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset

			write_information_log (generator + ".upload_motion_attachment")
			create l_parameters.make (5)
			l_parameters.put (a_interaction_id, "iid")
			l_parameters.put (a_id, "wid")
			l_parameters.put (a_size, "length")
			l_parameters.put (a_content, "content")
			l_parameters.put (a_file_name, "fileName")
			sql_begin_transaction
			sql_modify (query_generator (sql_upload_motion_attachment), l_parameters)
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

	remove_motion_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".remove_motion_attachments")
			create l_parameters.make (5)
			l_parameters.put (a_id, "wid")
			l_parameters.put (a_interaction_id, "iid")
			sql_begin_transaction
			sql_modify (query_generator (sql_delete_motion_attachments), l_parameters)
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


	remove_motion_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- Remove attachment with name `a_name' associated with wish `a_id'.
		local
			l_parameters: STRING_TABLE[ANY]
		do
			error_handler.reset
			write_information_log (generator + ".remove_motion_attachment_by_name")
			create l_parameters.make (2)
			l_parameters.put (a_id, "wid")
			l_parameters.put (a_name, "name")
			l_parameters.put (a_interaction_id, "iid")
			sql_begin_transaction
			sql_modify (query_generator (sql_delete_motion_attachment_by_name), l_parameters)
			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


feature -- Access: Categories

	categories_count: INTEGER_64
			-- <Precursor>
		do
			error_handler.reset
			write_information_log (generator + ".categories_count")

			sql_query (query_generator (select_categories_count), Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
			error_handler.reset
		end

	recent_categories (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_MOTION_LIST_CATEGORY]
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_CATEGORY]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".recent_categories")

			from
				create l_parameters.make (2)
				l_parameters.put (a_count, "rows")
				l_parameters.put (a_lower, "offset")
				sql_query (query_generator (sql_select_recent_categories), l_parameters)
				sql_start
			until
				sql_after
			loop
				if attached fetch_category as l_category then
					Result.force (l_category)
				end
				sql_forth
			end
			sql_finalize
		end

	categories: LIST [CMS_MOTION_LIST_CATEGORY]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_CATEGORY]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".categories")

			from
				sql_query (query_generator (sql_select_categories), Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_category as l_category then
					Result.force (l_category)
				end
				sql_forth
			end
			sql_finalize
		end

	category_by_id (a_id: INTEGER_64): detachable CMS_MOTION_LIST_CATEGORY
			-- <Precursor>.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".category_by_id")
			create l_parameters.make (1)
			l_parameters.put (a_id, "cid")
			sql_query (query_generator (sql_select_category_by_id), l_parameters)
			if not has_error and not sql_after then
				Result := fetch_category
			end
			sql_finalize
		end

	category_by_name (a_name: READABLE_STRING_32): detachable CMS_MOTION_LIST_CATEGORY
			-- Category for the given name`a_name', if any.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			error_handler.reset
			write_information_log (generator + ".category_by_name")
			create l_parameters.make (1)
			l_parameters.put (a_name, "name")
			sql_query (query_generator (sql_select_category_by_name), l_parameters)
			if not has_error and not sql_after then
				Result := fetch_category
			end
			sql_finalize
		end

feature -- Change: Category

	save_category (a_category: CMS_MOTION_LIST_CATEGORY)
			-- Save category `a_category'.
		do
			store_category (a_category)
		end


feature -- Access: Status

	status: LIST [CMS_MOTION_LIST_STATUS]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_STATUS]} Result.make (0)

			error_handler.reset
			write_information_log (generator + ".status")

			from
				sql_query (query_generator (sql_select_status), Void)
				sql_start
			until
				sql_after
			loop
				if attached fetch_status as l_status then
					Result.force (l_status)
				end
				sql_forth
			end
			sql_finalize
		end


feature {NONE} -- Implemenation

	fetch_category: detachable CMS_MOTION_LIST_CATEGORY
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


	fetch_status: detachable CMS_MOTION_LIST_STATUS
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

	fetch_motion: detachable CMS_MOTION_LIST
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
					Result.set_wish_list_category (create {CMS_MOTION_LIST_CATEGORY}.make (l_category_id, l_category_synopsis, True))

				end

					-- Submission date
				if attached sql_read_date_time (4) as l_date then
					Result.set_submission_date (l_date)
				end

					-- Status
				if attached sql_read_integer_32 (5) as l_status_id then
					Result.set_status (create {CMS_MOTION_LIST_STATUS}.make (l_status_id, ""))
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

	fetch_interaction: detachable CMS_MOTION_LIST_INTERACTION
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


	store_motion (a_wish: CMS_MOTION_LIST)
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
				sql_modify ( query_generator (sql_update_motion), l_parameters)
			else
					-- New
				l_parameters.put (now, "created")
				sql_insert (query_generator (sql_insert_motion), l_parameters)
				if not error_handler.has_error then
					a_wish.set_id (last_inserted_motion_id)
				end
			end

			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


	store_motion_interaction (a_wish_interaction: CMS_MOTION_LIST_INTERACTION)
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
				sql_modify (query_generator (sql_update_motion_interaction), l_parameters)
			else
					-- New
				sql_insert (query_generator (sql_insert_motion_interaction), l_parameters)
				if not error_handler.has_error then
					a_wish_interaction.set_id (last_inserted_motion_interaction_id)
				end
			end

			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end


	store_category (a_category: CMS_MOTION_LIST_CATEGORY)
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
				sql_modify (query_generator (sql_update_motion_category), l_parameters)
			else
					-- New
				sql_insert (query_generator (sql_insert_motion_category), l_parameters)
				if not error_handler.has_error then
					a_category.set_id (last_inserted_motion_category_id)
				end
			end

			if error_handler.has_error then
				sql_rollback_transaction
			else
				sql_commit_transaction
			end
		end

	fetch_attachment: detachable CMS_MOTION_FILE
		do
			if
				attached sql_read_integer_64 (1) as l_id and then
				attached sql_read_integer_64 (2) as l_length and then
				attached sql_read_string_8 (3) as l_content and then
				attached sql_read_string_32 (4) as l_file_name
			then
				create Result.make (l_file_name, l_length, l_content)
				Result.set_id (l_id)
			end
		end

	last_inserted_motion_id: INTEGER_64
			-- Last insert wish id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_motion_id")
			sql_query (query_generator (sql_last_insert_motion_id), Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
		end

	last_inserted_motion_interaction_id: INTEGER_64
			-- Last insert wish_interaction id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_motion_interaction_id")
			sql_query (query_generator (sql_last_insert_motion_interaction_id), Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
		end


	last_inserted_motion_category_id: INTEGER_64
			-- Last insert wish_category id.
		do
			error_handler.reset
			write_information_log (generator + ".last_inserted_motion_category_id")
			sql_query (query_generator (sql_last_insert_motion_category_id), Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize
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

feature {NONE} -- Implementation

	query_generator (a_template: STRING): STRING
			-- Return a query from template `a_template'.
		do
			create Result.make_from_string (a_template)
			Result.replace_substring_all ("<motion>", table_motion)
		end

feature {NONE} -- Queries


	sql_select_status: STRING = "SELECT sid, synopsis FROM <motion>_status;"
			-- SQL Query to retrieve all status.


	sql_select_row_count_motion_list: STRING = "[
					SELECT COUNT(*)
					FROM <motion>
					WHERE ((<motion>.category = :category) OR (NOT EXISTS (SELECT cid FROM <motion>_categories WHERE cid = :category)))
					AND ((<motion>.status in $StatusSet))
					$SearchBySynopsisAndOrDescription
					;
				]"


	filter_by_content: STRING =	"[
							AND (( <motion>.synopsis LIKE '%%' + :filter + '%' ) OR ( <motion>.description like '%%' + :filter + '%%' )
							OR ( <motion>.description LIKE '%%' + :filter + '%%' )
							OR ( <motion>.wid IN
								  ( SELECT  <motion>_interactions.iid
									FROM <motion>_interactions
									 	INNER JOIN <motion> ON <motion>_interactions.iid = <motion>.wid
									WHERE <motion>_interactions.content LIKE '%%' + :filter + '%%'
								   )
								)
							)
						]"


	sql_select_motion_list_template: STRING = "[
				SELECT wid, <motion>.synopsis, <motion>_categories.synopsis as CategorySynopsis, changed, <motion>.status statusID,
					   <motion>_status.synopsis, <motion>.category, users.uid author, users.name Username, <motion>.votes, <motion>.description
				FROM <motion>
				    INNER JOIN <motion>_categories ON <motion>_categories.cid = <motion>.category
				    INNER JOIN <motion>_status ON <motion>_status.sid = <motion>.status
				    INNER JOIN users ON users.uid = <motion>.author
				    WHERE ((<motion>.category = :category) OR (NOT EXISTS (SELECT cid FROM <motion>_categories WHERE cid = :category)))
						AND ((<motion>.status in $StatusSet ))	$SearchBySynopsisAndOrDescription
					ORDER BY <motion>.$Column $ORD
					LIMIT :Offset, :RowsPerPage;
    		]"


	sql_select_motion_by_id: STRING = "[
				SELECT wid, <motion>.synopsis, <motion>_categories.synopsis as CategorySynopsis, changed, <motion>.status statusID,
					   <motion>_status.synopsis, <motion>.category, users.uid author, users.name Username, <motion>.votes, <motion>.description
				FROM <motion>
				    INNER JOIN <motion>_categories ON <motion>_categories.cid = <motion>.category
				    INNER JOIN <motion>_status ON <motion>_status.sid = <motion>.status
				    INNER JOIN users ON users.uid = <motion>.author
				    WHERE <motion>.wid = :wid;
				  ]"


	sql_select_motion_interactions: STRING = "[
			SELECT wi.iid, wi.wid, wi.author, users.name, wi.content, wi.changed 
			FROM <motion>_interactions wi
			INNER JOIN users ON users.uid = wi.author
			WHERE wi.wid = :wid
		]"

	sql_last_insert_motion_id: STRING = "SELECT MAX(wid) FROM <motion>;"

	sql_last_insert_motion_interaction_id: STRING = "SELECT MAX(iid) FROM <motion>_interactions;"

	sql_insert_motion: STRING = "INSERT INTO <motion> (author, category, status, synopsis, description, changed, votes, created ) VALUES (:author, :category, :status, :synopsis, :description, :changed, :votes, :created);"
			-- SQL Insert to add a new wish

	sql_update_motion: STRING = "UPDATE <motion> SET author=:author, category=:category, status =:status, synopsis=:synopsis, description=:description, changed=:changed, votes=:votes WHERE wid=:id;"
			-- SQL update wish.

	sql_insert_motion_interaction: STRING = "INSERT INTO <motion>_interactions (wid, author, content, changed ) VALUES (:wid, :author, :description, :changed);"
			-- SQL Insert to add a new wish interaction.

	sql_update_motion_interaction: STRING = "UPDATE <motion>_interactions SET wid=:wid, author=:author, content=:description, changed=:changed WHERE iid=:id;"
			-- SQL update wish interaction.		

	sql_upload_motion_attachment: STRING = "INSERT INTO <motion>_attachments (iid, wid, length, content, fileName) VALUES (:iid, :wid, :length, :content, :fileName);"

	sql_select_motion_attachments: STRING = "SELECT wid, length, content, fileName  FROM <motion>_attachments WHERE wid =:wid and iid=:iid;"

	sql_delete_motion_attachments: STRING = "DELETE FROM <motion>_attachments  WHERE wid =:wid and iid=:iid;"

	sql_delete_motion_attachment_by_name: STRING = "DELETE FROM <motion>_attachments  WHERE wid =:wid and fileName =:name and iid =:iid;"

	Select_user_author: STRING = "SELECT uid, name, password, salt, email, users.status, users.created, signed FROM <motion> INNER JOIN users ON <motion>.author=users.uid AND <motion>.wid = :wid;"

	select_motion_author_vote: STRING = "SELECT vote FROM <motion>_votes  WHERE wish=:wid AND author=:author;"

	select_exist_motion_author_vote: STRING = "SELECT * FROM <motion>_votes  WHERE wish=:wid AND author=:author;"

	sql_update_motion_vote: STRING = "UPDATE <motion>_votes SET vote=:vote WHERE wish=:wid AND author=:author;"

	sql_insert_motion_vote: STRING = "INSERT INTO <motion>_votes (wish, author, vote) VALUES (:wid, :author, :vote);"

feature -- SQL query: Categories

	select_categories_count: STRING = "SELECT COUNT(*) FROM <motion>_categories;"

	Sql_select_recent_categories: STRING = "SELECT cid, synopsis, description, is_active FROM <motion>_categories ORDER BY cid DESC LIMIT :rows OFFSET :offset ;"
			-- Retrieve recent users

	sql_select_categories: STRING = "SELECT cid, synopsis, description, is_active FROM <motion>_categories WHERE is_active != 0 ;"
			-- SQL Query to retrieve all active categories.
			--| note: is_active =! 0

	sql_select_category_by_id: STRING = "SELECT cid, synopsis, description, is_active FROM <motion>_categories WHERE cid =:cid;"

	sql_select_category_by_name: STRING = "SELECT cid, synopsis, description, is_active FROM <motion>_categories WHERE synopsis =:name;"

	sql_update_motion_category: STRING = "UPDATE <motion>_categories SET synopsis=:synopsis, is_active=:is_active, description=:description WHERE cid=:cid;"

	sql_insert_motion_category: STRING = "INSERT INTO <motion>_categories (synopsis, is_active, description ) VALUES (:synopsis, :is_active, :description);"

	sql_last_insert_motion_category_id: STRING = "SELECT MAX(cid) FROM <motion>_categories;"


end
