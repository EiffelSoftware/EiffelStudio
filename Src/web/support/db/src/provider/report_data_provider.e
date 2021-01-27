note
	description: "Provides access to database tables via stored procedures calls"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_DATA_PROVIDER

inherit

	PARAMETER_NAME_HELPER

	SHARED_ERROR

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_connection: DATABASE_CONNECTION)
			-- Create a data provider with connection `a_connection'.
		do
			create {DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
			post_execution
		end

	db_handler: DATABASE_HANDLER
			-- Db handler.

feature -- Access

	problem_reports (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_username: READABLE_STRING_GENERAL;  a_category: INTEGER; a_status, a_column: READABLE_STRING_32; a_order: INTEGER; a_filter: READABLE_STRING_32; a_content: INTEGER): DATABASE_ITERATION_CURSOR [REPORT]
			-- Problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
			l_encoder: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".problem_reports_2")
			end
			create l_parameters.make (6)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_rows_per_page * a_page_number, "Offset")
			l_parameters.put (l_encoder.encoded_string (string_parameter (a_username, 50)), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.categoryid_param)
			if not a_filter.is_empty then
				l_parameters.put (l_encoder.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string_general (Select_problem_reports_by_user_template)
			if a_order = 1 then
				l_query.replace_substring_all ({STRING_32} "$ORD1", {STRING_32} "ASC")
				l_query.replace_substring_all ({STRING_32} "$ORD2", {STRING_32} "DESC")
			else
				l_query.replace_substring_all ({STRING_32} "$ORD1", {STRING_32} "DESC")
				l_query.replace_substring_all ({STRING_32} "$ORD2", {STRING_32} "ASC")
			end
			l_query.replace_substring_all ({STRING_32} "$Column", l_encoder.encoded_string (string_parameter (a_column, 30)))

			-- Filter search.
			if
				attached a_filter and then
				not a_filter.is_empty
			then
				if a_content = 1 then
						-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", filter_by_content)
				else
						-- Search only by Synopsis
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} " AND (( ProblemReports.Synopsis like '%%' + :Filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} "")
			end

				--| Need to be updated to build the set based on user selection.
			l_query.replace_substring_all ({STRING_32} "$StatusSet", {STRING_32} "(" + l_encoder.encoded_string (a_status) + {STRING_32} ")")

			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report)
			post_execution
		end

	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: READABLE_STRING_8; a_column: READABLE_STRING_8; a_order: INTEGER; a_username: READABLE_STRING_32; a_filter:READABLE_STRING_32; a_content:INTEGER): DATABASE_ITERATION_CURSOR [REPORT]
			-- All Problem reports for guest users
			-- Only not confidential reports
			-- Filtered category `a_category' and status `a_status'
			-- Order by column `a_column' in a DESC or ASC.
			-- by the default the order by is done on Number.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
			l_encode: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".problem_reports_guest_2")
			end
			to_implement ("Improve the way to generate the prepare statement.")
			create l_parameters.make (4)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_page_number * a_rows_per_page, "Offset")
			l_parameters.put (string_parameter (a_username, 100),{DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			if attached a_filter then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string (Select_problem_reports_template)
			if a_order = 1 then
				l_query.replace_substring_all ("$ORD1", "ASC")
				l_query.replace_substring_all ("$ORD2", "DESC")
			else
				l_query.replace_substring_all ("$ORD1", "DESC")
				l_query.replace_substring_all ("$ORD2", "ASC")
			end
			l_query.replace_substring_all ("$Column", l_encode.encoded_string (string_parameter (a_column.to_string_32, 30)).to_string_8)

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
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", " AND (( ProblemReports.Synopsis like '%%' + :Filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", "")
			end

			--| Need to be updated to build the set based on user selection.
			l_query.replace_substring_all ("$StatusSet", "(" + l_encode.encoded_string (a_status).to_string_8 + ")")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report)
			post_execution
		end

	problem_reports_closed_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_column: READABLE_STRING_8; a_order: INTEGER; a_username: READABLE_STRING_32; a_filter:READABLE_STRING_32): DATABASE_ITERATION_CURSOR [REPORT]
			-- All Problem reports closed or won't fix for guest users for the previous weeks ( the last 7 days)
			-- Only not confidential reports
			-- Filtered category `a_category' and status `a_status'
			-- Order by column `a_column' in a DESC or ASC.
			-- by the default the order by is done on Number.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
			l_encode: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".problem_reports_closed_guest")
			end
			create l_parameters.make (4)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_page_number * a_rows_per_page, "Offset")
			l_parameters.put (string_parameter (a_username, 100),{DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (0, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			if attached a_filter then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string (Select_problem_reports_closed_template)
			if a_order = 1 then
				l_query.replace_substring_all ("$ORD1", "ASC")
				l_query.replace_substring_all ("$ORD2", "DESC")
			else
				l_query.replace_substring_all ("$ORD1", "DESC")
				l_query.replace_substring_all ("$ORD2", "ASC")
			end
			l_query.replace_substring_all ("$Column", l_encode.encoded_string (string_parameter (a_column.to_string_32, 30)).to_string_8)

			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report)
			post_execution
		end


	problem_reports_responsibles (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_severity: INTEGER; a_priority: INTEGER; a_responsible: INTEGER; a_column: READABLE_STRING_32; a_order: INTEGER; a_status: READABLE_STRING_32; a_username: READABLE_STRING_32; a_filter: detachable READABLE_STRING_32; a_content: INTEGER_32): DATABASE_ITERATION_CURSOR [REPORT]
			-- All Problem reports for responsible users
			-- All reports are visible for responsible users
			-- Filtered category `a_category' and status `a_status'
			-- Order by column `a_column' in a DESC or ASC.
			-- by the default the order by is done on Number.
			-- Reports are searched by Username or FirstName or LastName.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
			l_encode: DATABASE_SQL_SERVER_ENCODER
			l_query_filter: STRING
		do
			debug
				log.write_information (generator + ".problem_reports_responsibles")
			end
			create l_parameters.make (7)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_rows_per_page * a_page_number, "Offset")
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_severity, {DATA_PARAMETERS_NAMES}.Severityid_param)
			l_parameters.put (a_priority, {DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_responsible, {DATA_PARAMETERS_NAMES}.Responsibleid_param)
			if attached a_filter then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string (Select_problem_reports_responsibles_template)
			if not a_username.is_empty then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_username, 50)), {DATA_PARAMETERS_NAMES}.Username_param)
				l_query.replace_substring_all ("$Submitter", "(Username = :Username or FirstName = :Username or LastName = :Username) AND")
			else
				l_query.replace_substring_all ("$Submitter", "")
			end

				-- Filter search.
			create  l_query_filter.make_empty
			if a_category > 0 then
				l_query_filter.append (" AND ((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))")
			end
			if a_severity > 0 then
				l_query_filter.append (" AND ((ProblemReports.SeverityID = :SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = :SeverityID)))")
			end
			if a_priority > 0 then
				l_query_filter.append (" AND ((ProblemReports.PriorityID = :PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = :PriorityID)))")
			end

			if a_responsible > 0 then
				l_query_filter.append (" AND ((ProblemReportResponsibles.ResponsibleID =  :ResponsibleID) OR (NOT EXISTS (SELECT ResponsibleID FROM ProblemReportResponsibles r WHERE r.ResponsibleID = :ResponsibleID)))")
			end

			l_query.replace_substring_all ("$queryFilter", l_query_filter)


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
					l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", " AND (( ProblemReports.Synopsis like '%%' + :Filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ("$SearchBySynopsisAndOrDescription", "")
			end

			l_query.replace_substring_all ("$Column", l_encode.encoded_string (string_parameter (a_column, 30)).to_string_8)
			if a_order = 1 then
				l_query.replace_substring_all ("$ORD1", "ASC")
				l_query.replace_substring_all ("$ORD2", "DESC")
			else
				l_query.replace_substring_all ("$ORD1", "DESC")
				l_query.replace_substring_all ("$ORD2", "ASC")
			end
				--| Need to be updated to build the set based on user selection.
			l_query.replace_substring_all ("$StatusSet", "(" + l_encode.encoded_string (a_status).to_string_8 + ")")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report_responsible)
			post_execution
		end

	problem_reports_responsibles_closed (a_page_number: INTEGER; a_rows_per_page: INTEGER): DATABASE_ITERATION_CURSOR [REPORT]
			-- All Problem reports for responsible users closed or won't-fix.
			-- All reports are visible for responsible users
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
		do
			debug
				log.write_information (generator + ".problem_reports_responsibles")
			end
			create l_parameters.make (2)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_rows_per_page * a_page_number, "Offset")
			create l_query.make_from_string (Select_problem_reports_responsibles_closed_template)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report_responsible)
			post_execution
		end

	problem_report (a_number: INTEGER): detachable REPORT
			-- Problem report with number `a_number'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".problem_report")
			end

			create l_parameters.make (1)
			l_parameters.put (a_number, {DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReport2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result := new_report_detail (l_item)
					Result.set_number (a_number)
				end
			end

			post_execution
		end


	problem_report_category_subscribers (a_category: READABLE_STRING_32): DATABASE_ITERATION_CURSOR [STRING]
			-- Problem report subscribers emails for category `a_category'
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".problem_report_category_subscribers")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_category, 50), {DATA_PARAMETERS_NAMES}.Category_synopsis_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportCategorySubscribers", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_category_email_subscribers)
			post_execution
		end

	interaction (a_username: READABLE_STRING_GENERAL; a_interaction_id: INTEGER; a_report: REPORT): detachable REPORT_INTERACTION
			-- Problem report interaction given `a_username', `a_interaction_id' and report, if any.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".interaction")
			end

			create l_parameters.make (2)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteraction2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result := new_report_interaction_2 (l_item, a_report)
					Result.set_id (a_interaction_id)
				end
			end

			post_execution
		end

	interactions (a_username: READABLE_STRING_32; a_report_number: INTEGER; a_report: REPORT): LIST [REPORT_INTERACTION]
			-- Interactions related to problem report with ID `a_report_id'.
			-- for a user `a_username'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_list: LIST [INTEGER]
		do
			debug
				log.write_information (generator + ".interactions")
			end
			create {ARRAYED_LIST [REPORT_INTERACTION]} Result.make (0)
			create {ARRAYED_LIST [INTEGER]} l_list.make (0)

			create l_parameters.make (2)
			l_parameters.put (a_report_number, {DATA_PARAMETERS_NAMES}.Number_param)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteractions2", l_parameters))
			db_handler.execute_reader

				-- Build list
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached db_handler.read_integer_32 (1) as l_item then
					l_list.force (l_item)
				end
				db_handler.forth
			end
			across
				l_list as c
			loop
				if attached interaction (a_username, c.item, a_report) as l_interaction then
					Result.force (l_interaction)
				end
			end

			post_execution
		end

	interactions_guest (a_report_number: INTEGER; a_report: REPORT): LIST [REPORT_INTERACTION]
			-- Interactions related to problem report with ID `a_report_id'.
			-- for a guest user
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".interactions_guest")
			end
			create {ARRAYED_LIST [REPORT_INTERACTION]} Result.make (0)

			create l_parameters.make (1)
			l_parameters.put (a_report_number, {DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetReportProblemInteractionsGuest", l_parameters))
			db_handler.execute_reader

				-- Build list
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result.force (new_report_interaction (l_item, a_report))
				end
				db_handler.forth
			end

			post_execution
		end

	attachments_headers (a_interaction: REPORT_INTERACTION): LIST [REPORT_ATTACHMENT]
			-- -- Attachments for interaction `a_interaction_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".attachment_headers")
			end
			create {ARRAYED_LIST [REPORT_ATTACHMENT]} Result.make (0)

			create l_parameters.make (1)
			l_parameters.put (a_interaction.id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteractionAttachmentsHeaders", l_parameters))
			db_handler.execute_reader
				-- Build list
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result.force (new_interaction_attachment (l_item, a_interaction))
				end
				db_handler.forth
			end

			post_execution
		end

	attachments_headers_guest (a_interaction: REPORT_INTERACTION): LIST [REPORT_ATTACHMENT]
			-- -- Attachments for interaction `a_interaction_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".attachment_headers_guest")
			end
			create {ARRAYED_LIST [REPORT_ATTACHMENT]} Result.make (0)

			create l_parameters.make (1)
			l_parameters.put (a_interaction.id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteractionAttachmentsHeadersGuest", l_parameters))
			db_handler.execute_reader
				-- Build list
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result.force (new_interaction_attachment (l_item, a_interaction))
				end
				db_handler.forth
			end

			post_execution
		end

	attachments_content (a_attachment_id: INTEGER): STRING_8
			-- Attachment content of attachment with ID `a_attachment_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".attachment_content")
			end
			create Result.make_empty

			create l_parameters.make (1)
			l_parameters.put (a_attachment_id, {DATA_PARAMETERS_NAMES}.attachmentid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteractionAttachmentContent", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {STRING_8} l_item.item (1) as l_item_1 then
					Result := l_item_1
				end
			end

			post_execution
		end

	registration_token_from_username (a_username: READABLE_STRING_32): STRING
			-- Associated token for a username `a_username', or
			-- Empty String if the Account not activated.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".registration_token_from_username")
			end
			create Result.make_empty

			create l_parameters.make (1)
			l_parameters.put (a_username, {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationTokenFromUsername", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {STRING} l_item.item (1) as l_item_1 then
					Result := l_item_1
				end
			end

			post_execution
		end

	user_password_salt (a_username: READABLE_STRING_32): detachable STRING
			-- Associated password salt for a username `a_username'.
		local
			l_parameters:STRING_TABLE [ANY]
			l_encoder: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".user_password_salt")
			end
			create l_parameters.make (1)
			l_parameters.put (l_encoder.encoded_string (string_parameter (a_username, 50)), {DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_user_password_salt, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string (1)
			end
			post_execution
		end

	add_user (a_first_name, a_last_name: READABLE_STRING_32; a_email: READABLE_STRING_8; a_username, a_password, a_answer, a_token: READABLE_STRING_32; a_question_id: INTEGER)
			-- Add user with username `a_username', first name `a_first_name' and last name `a_last_name'.
		require
			attached_username: a_username /= Void
			attached_first_name: a_first_name /= Void
			attached_last_name: a_last_name /= Void
		local
			l_answer_salt, l_password_salt, l_answer_hash, l_password_hash: STRING
			l_security: SECURITY_PROVIDER
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".add_user")
			end
			create l_security
			l_answer_salt := l_security.salt
			l_answer_hash := l_security.password_hash (a_answer.to_string_8, l_answer_salt)
			l_password_salt := l_security.salt
			l_password_hash := l_security.password_hash (a_password.to_string_8, l_password_salt)

			create l_parameters.make (10)
			l_parameters.put (string_parameter (a_first_name, 50), {DATA_PARAMETERS_NAMES}.Firstname_param)
			l_parameters.put (string_parameter (a_last_name, 50), {DATA_PARAMETERS_NAMES}.Lastname_param)
			l_parameters.put (string_parameter (a_email, 100), {DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (string_parameter (a_username, 100), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (l_password_hash, 40), {DATA_PARAMETERS_NAMES}.Passwordhash_param)
			l_parameters.put (string_parameter (l_password_salt, 24), {DATA_PARAMETERS_NAMES}.Passwordsalt_param)
			l_parameters.put (string_parameter (l_answer_hash, 40), {DATA_PARAMETERS_NAMES}.Answerhash_param)
			l_parameters.put (string_parameter (l_answer_salt, 24), {DATA_PARAMETERS_NAMES}.Answersalt_param)
			l_parameters.put (string_parameter (a_token, 7), {DATA_PARAMETERS_NAMES}.Registrationtoken_param)
			l_parameters.put (a_question_id, {DATA_PARAMETERS_NAMES}.Questionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("AddUser2", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	categories (a_username: STRING): DATABASE_ITERATION_CURSOR [REPORT_CATEGORY]
			-- Possible problem report categories
			-- Columns: CategoryID, CategorySynopsis, CategoryGroupSynopsis.
		require
			non_void_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".categories")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportCategories", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_category)
			post_execution
		end

	all_categories: DATABASE_ITERATION_CURSOR [REPORT_CATEGORY]
			-- All report categories
			-- Columns: CategoryID, CategorySynopsis, CategoryGroupSynopsis.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			debug
				log.write_information (generator + ".all_categories")
			end
			create l_parameters.make (0)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_categories, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report_category)
			post_execution
		end

	classes: DATABASE_ITERATION_CURSOR [REPORT_CLASS]
			-- Possible problem report classes
			-- Columns: ClassID, ClassSynopsis, ClassDescription.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".classes")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportClasses", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_class)
			post_execution
		end

	severities: DATABASE_ITERATION_CURSOR [REPORT_SEVERITY]
			-- Possible problem report severities
			-- Columns: SeverityID, SeveritySynopsis, SeverityDescription.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".severities")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportSeverities", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_severity)
			post_execution
		end

	priorities: DATABASE_ITERATION_CURSOR [REPORT_PRIORITY]
			-- Possible problem report priorities
			-- Columns: PriorityID, PrioritySynopsis, PriorityDescription.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".priorities")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportPriorities", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_priority)
			post_execution
		end

	status: DATABASE_ITERATION_CURSOR [REPORT_STATUS]
			-- Possible problem report status
			-- Columns: StatusID, StatusSynopsis, StatusDescription.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".status")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportStatus", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_status)
			post_execution
		end

	countries: DATABASE_ITERATION_CURSOR [REPORT_SEVERITY]
			-- Possible problem report severities
			-- Columns: SeverityID, SeveritySynopsis, SeverityDescription.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".countries")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportSeverities", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_severity)
			post_execution
		end

	last_problem_report_number: INTEGER
			-- Number of last submitted pr if `commit_problem_report' was called successfully
			-- 0 otherwise.

	last_interaction_id: INTEGER
			-- Number of last submitted interaction_id if `commit_interaction' was called successfully.

	temporary_problem_report (a_id: INTEGER): detachable TUPLE [synopsis: detachable STRING_32; release: detachable STRING; confidential: detachable STRING; environment: detachable STRING; description: detachable STRING_32; toreproduce: detachable STRING_32; priority_synopsis: detachable STRING_32; category_synopsis: detachable STRING; severity_synopsis: detachable STRING; class_synopsis: detachable STRING; user_name: detachable STRING; responsible: detachable STRING]
			-- Temporary problem report
			--			Synopsis,
			--			Release,
			--			Confidential,
			--			Environment,
			--			[Description],
			--			ToReproduce,
			--			PrioritySynopsis,
			--			CategorySynopsis,
			--			SeveritySynopsis,
			--			ClassSynopsis,
			--			Username,
			--			Responsible.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".temporary_problem_report")
			end

			create l_parameters.make (1)
			l_parameters.put (a_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportTemporary2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				create Result.default_create
				across
					1 |..| 12 as i
				loop
					Result [i.item] := db_handler.read_string_32 (i.item)
				end
			end

			post_execution
		end

	problem_reports_for_edition (a_username, a_first_name, a_last_name, a_responsible, a_responsible_first_name, a_responsible_last_name: STRING; a_category_id, a_status_id, a_priority_id, a_severity_id: INTEGER): DATABASE_ITERATION_CURSOR [REPORT]
			-- Problem reports for edition.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".problem_reports_for_edition")
			end
			create l_parameters.make (4)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (string_parameter (a_first_name, 50), {DATA_PARAMETERS_NAMES}.Firstname_param)
			l_parameters.put (string_parameter (a_last_name, 50), {DATA_PARAMETERS_NAMES}.Lastname_param)
			l_parameters.put (string_parameter (a_responsible, 50), {DATA_PARAMETERS_NAMES}.Responsible_param)
			l_parameters.put (string_parameter (a_responsible_first_name, 50), {DATA_PARAMETERS_NAMES}.Responsible_firstname_param)
			l_parameters.put (string_parameter (a_responsible_last_name, 50), {DATA_PARAMETERS_NAMES}.Responsible_lastname_param)
			l_parameters.put (a_category_id, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_status_id, {DATA_PARAMETERS_NAMES}.Statusid_param)
			l_parameters.put (a_priority_id, {DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_severity_id, {DATA_PARAMETERS_NAMES}.Severityid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportsForEdition2", l_parameters))
			db_handler.execute_reader
			last_row_count := db_handler.count
			create Result.make (db_handler, agent new_report)
			post_execution
		end

	responsibles: DATABASE_ITERATION_CURSOR [USER]
			-- Problem report responsibles
			-- Columns ContactID, Username, Name.

		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".responsibles")
			end
			create l_parameters.make (0)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportResponsibles", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_reponsible)
			post_execution
		end

	temporary_interaction_2 (a_id: INTEGER): detachable TUPLE [content: detachable READABLE_STRING_32; username: detachable READABLE_STRING_32; status: detachable READABLE_STRING_32; private: detachable READABLE_STRING_32; category: detachable READABLE_STRING_32]
			-- Temporary problem report interaction
			--			Content,
			--			Username,
			--			Status,
			--			Private,
			--          Category.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".temporary_interaction_2")
			end

			create l_parameters.make (1)
			l_parameters.put (a_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportTemporaryInteraction2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				create Result.default_create
				across
					1 |..| 5 as i
				loop
					Result [i.item] := db_handler.read_string_32 (i.item)
				end
			end

			post_execution
		end

	temporary_interaction_3 (a_id: INTEGER): detachable TUPLE [status: INTEGER; category: INTEGER]
			-- Temporary problem report interaction
			--			Content,
			--			Username,
			--			Status,
			--			Private,
			--          Category.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".temporary_interaction_3")
			end

			create l_parameters.make (1)
			l_parameters.put (a_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportTemporaryInteraction3", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				create Result.default_create
				across
					1 |..| 2 as i
				loop
					if attached db_handler.read_integer_32 (i.item) as l_item then
						Result [i.item] := l_item
					end
				end
			end

			post_execution
		end

	temporary_problem_report_attachments (a_id: INTEGER): LIST [TUPLE [id: INTEGER_32; length: INTEGER_32; filename: READABLE_STRING_32]]
			-- File attachments associated with a report_id `a_id', if any.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".temporary_problem_report_attachments")
			end

			create {ARRAYED_LIST [TUPLE [id: INTEGER_32; length: INTEGER_32; filename: READABLE_STRING_32]]} Result.make (0)
			create l_parameters.make (1)
			l_parameters.put (a_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportTemporaryReportAttachments", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				from
					db_handler.start
				until
					db_handler.after
				loop
					if attached db_handler.read_integer_32 (1) as l_id and then attached db_handler.read_integer_32 (2) as l_length and then attached db_handler.read_string (3) as l_name then
						Result.force ([l_id, l_length, l_name.as_string_32])
					end
					db_handler.forth
				end
			end

			post_execution
		end

	temporary_interation_attachments (a_interaction_id: INTEGER): LIST [TUPLE [id: INTEGER_32; length: INTEGER_32; filename: READABLE_STRING_32]]
			-- Attachments for temporary interaction `a_interaction_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".temporary_interation_attachments")
			end

			create {ARRAYED_LIST [TUPLE [id: INTEGER_32; length: INTEGER_32; filename: READABLE_STRING_32]]} Result.make (0)
			create l_parameters.make (1)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportTemporaryInteractionAttachmentsHeaders", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				from
					db_handler.start
				until
					db_handler.after
				loop
					if attached db_handler.read_integer_32 (1) as l_id and then attached db_handler.read_integer_32 (3) as l_length and then attached db_handler.read_string (2) as l_name then
						Result.force ([l_id, l_length, l_name.as_string_32])
					end
					db_handler.forth
				end
			end

			post_execution
		end

	subscribed_categories (a_username: READABLE_STRING_GENERAL): DATABASE_ITERATION_CURSOR [ TUPLE [categoryId:INTEGER; synopsis:STRING; subscribed:INTEGER] ]
			-- Table associating each category with boolean value specifying whether responsible `a_username'
			-- is subscribed for receiving email notifications when reports or interactions are created in
			-- category
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".responsibles")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportSubscribedCategories2", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_problem_report_subsribed_categeory)
			post_execution
		end

	interaction_content (a_id: INTEGER): detachable STRING_32
		local
			l_parameters:STRING_TABLE [ANY]
		do
			debug
				log.write_information (generator + ".interaction_by_id")
			end
			create l_parameters.make (1)
			l_parameters.put (a_id, "id")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_interaction_content, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_string_32 (1)
			end
			post_execution
		end

feature -- Basic Operations

	new_problem_report_id (a_username: READABLE_STRING_32): INTEGER
			-- Initialize new problem report row and returns ReportID.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".new_problem_report_id")
			end

			create l_parameters.make (1)
			l_parameters.put (a_username, {DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("AddTemporaryProblemReport", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end

			post_execution
		end

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER; a_username: READABLE_STRING_32): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users and
			-- users with role user.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".row_count_problem_report_guest")
			end

			create l_parameters.make (2)
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_status, {DATA_PARAMETERS_NAMES}.Statusid_param)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportsRowCountGuest", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end

			post_execution
		end

	row_count_problem_reports (a_category: INTEGER; a_status: STRING; a_username: READABLE_STRING_32; a_filter: READABLE_STRING_32; a_content:INTEGER ): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users and
			-- users with role user.
		local
			l_parameters: STRING_TABLE [ANY]
			l_encode: DATABASE_SQL_SERVER_ENCODER
			l_query: STRING_32
		do
			debug
				log.write_information (generator + ".row_count_problem_report_guest")
			end

			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			if attached a_filter then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string (Select_row_count_problem_reports)

				-- Filter search.
			if
				attached a_filter and then
				not a_filter.is_empty
			then
				if a_content = 1 then
						-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", filter_by_content)
				else
						-- Search only by Synopsis
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} " AND (( ProblemReports.Synopsis like '%%' + :Filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} "")
			end

			--| Need to be updated to build the set based on user selection.
			l_query.replace_substring_all ({STRING_32} "$StatusSet", {STRING_32} "(" + l_encode.encoded_string (a_status) + {STRING_32} ")")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_count then
					Result := l_count
				end
			end

			post_execution
		end

	row_count_problem_reports_closed (a_username: READABLE_STRING_32; a_filter: READABLE_STRING_32;): INTEGER
			-- Row count closed or won't fix reports for guest users, for the last week.
			-- users with role user.
		local
			l_parameters: STRING_TABLE [ANY]
			l_encode: DATABASE_SQL_SERVER_ENCODER
			l_query: STRING_32
		do
			debug
				log.write_information (generator + ".row_count_problem_reports_closed")
			end

			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (0, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			if attached a_filter then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string (Select_row_count_problem_reports_closed_guest)

			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_count then
					Result := l_count
				end
			end

			post_execution
		end

	row_count_problem_report_responsible (a_category: INTEGER; a_severity: INTEGER; a_priority: INTEGER; a_responsible: INTEGER; a_status: READABLE_STRING_32; a_username: READABLE_STRING_32; a_filter: detachable READABLE_STRING_32; a_content: INTEGER_32): INTEGER
			-- Number of problems reports for responsible users.
			-- Could be filtered by category, serverity, priority, responsible, and username.
			-- Updated to search for Username, LastName or FirstName.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
			l_encode: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".row_count_problem_report_responsible")
			end

			create l_parameters.make (6)
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_severity, {DATA_PARAMETERS_NAMES}.Severityid_param)
			l_parameters.put (a_priority, {DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_responsible, {DATA_PARAMETERS_NAMES}.Responsibleid_param)
			l_parameters.put (l_encode.encoded_string (string_parameter (a_username, 50)), {DATA_PARAMETERS_NAMES}.Username_param)
			if attached a_filter then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end
			create l_query.make_from_string (select_row_count_problem_reports_responsibles)
			if not a_username.is_empty then
				l_query.replace_substring_all ({STRING_32} "$Submitter", {STRING_32} "(Username = :Username or FirstName = :Username or LastName = :Username) AND")
			else
				l_query.replace_substring_all ({STRING_32} "$Submitter", {STRING_32} "")
			end
				-- Filter search.
			if
				attached a_filter and then
				not a_filter.is_empty
			then
				if a_content = 1 then
						-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", filter_by_content)
				else
						-- Search only by Synopsis
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} " AND (( ProblemReports.Synopsis like '%%' + :Filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} "")
			end
				--| Need to be updated to build the set based on user selection.
			l_query.replace_substring_all ({STRING_32} "$StatusSet", {STRING_32} "(" + l_encode.encoded_string (a_status) + {STRING_32} ")")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_count then
					Result := l_count
				end
			end

			post_execution
		end

	row_count_problem_report_responsible_closed: INTEGER
			-- Number of problems reports closed or won't fix visible for responsible users for the last week.
		local
			l_parameters: STRING_TABLE [ANY]
			l_query: STRING_32
		do
			debug
				log.write_information (generator + ".row_count_problem_report_responsible_closed")
			end

			create l_parameters.make (0)
			create l_query.make_from_string (select_row_count_problem_reports_responsibles_closed)

			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_count then
					Result := l_count
				end
			end

			post_execution
		end

	row_count_problem_report_user (a_username: READABLE_STRING_32; a_category:INTEGER; a_status: READABLE_STRING_GENERAL; a_filter: READABLE_STRING_32; a_content: INTEGER_32): INTEGER
			-- Number of problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise, filetred by category and status.
		local
			l_parameters: STRING_TABLE [ANY]
			l_encode: DATABASE_SQL_SERVER_ENCODER
			l_query: STRING_32
		do
			debug
				log.write_information (generator + ".row_count_problem_report_user")
			end

			create l_parameters.make (4)
			l_parameters.put (l_encode.encoded_string (string_parameter (a_username, 50)), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_category, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			if not a_filter.is_empty then
				l_parameters.put (l_encode.encoded_string (string_parameter (a_filter, 100)), {DATA_PARAMETERS_NAMES}.Filter_param)
			end

			create l_query.make_from_string (Select_row_count_problem_report_by_user)

					-- Filter search.
			if
				attached a_filter and then
				not a_filter.is_empty
			then
				if a_content = 1 then
						-- Search by Synopsis, ToReproduce, Descriptions, Interactions.
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", filter_by_content)
				else
						-- Search only by Synopsis
					l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} " AND (( ProblemReports.Synopsis like '%%' + :Filter + '%%'))")
				end
			else
					-- No filter
				l_query.replace_substring_all ({STRING_32} "$SearchBySynopsisAndOrDescription", {STRING_32} "")
			end
				--| Need to be updated to build the set based on user selection.
			l_query.replace_substring_all ({STRING_32} "$StatusSet", {STRING_32} "(" + l_encode.encoded_string (a_status) + {STRING_32} ")")
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (l_query, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_count then
					Result := l_count
				end
			end

			post_execution
		end

	commit_problem_report (a_report_id: INTEGER)
			-- Commit temporary problem report `a_report_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_int: INTEGER
		do
			debug
				log.write_information (generator + ".commit_problem_report")
			end
			set_last_problem_report_number (l_int)

			create l_parameters.make (1)
			l_parameters.put (a_report_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("CommitProblemReport", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_int := l_item
				end
			end

			if l_int > 0 then
				set_last_problem_report_number (l_int)
			end
			post_execution
		end

	remove_temporary_problem_report (a_report_id: INTEGER)
			-- Remove temporary problem report `a_report_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_temporary_problem_report")
			end

			create l_parameters.make (1)
			l_parameters.put (a_report_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("RemoveTemporaryProblemReport", l_parameters))
			db_handler.execute_reader

			post_execution
		end

	initialize_problem_report (a_report_id: INTEGER; a_priority_id, a_severity_id, a_category_id, a_class_id: READABLE_STRING_8; a_confidential, a_synopsis, a_release, a_environment, a_description, a_to_reproduce: READABLE_STRING_32)
			-- Initialize temporary problem report row.
		require
			attached_priority: a_priority_id /= Void
			valid_priority_id: a_priority_id.is_integer
			attached_severity: a_severity_id /= Void
			valid_severity_id: a_severity_id.is_integer
			attached_category: a_category_id /= Void
			valid_category_id: a_category_id.is_integer
			attached_class: a_class_id /= Void
			valid_class_id: a_class_id.is_integer
			attached_confidential: a_confidential /= Void
			valid_confidential: a_confidential.is_boolean
			attached_synopsis: a_synopsis /= Void
			attached_release: a_release /= Void
			attached_environment: a_environment /= Void
			attached_description: a_description /= Void
			attached_to_reproduce: a_to_reproduce /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".initialize_problem_report")
			end

			create l_parameters.make (11)
			l_parameters.put (a_report_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			l_parameters.put (a_priority_id.to_integer, {DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_severity_id.to_integer, {DATA_PARAMETERS_NAMES}.Severityid_param)
			l_parameters.put (a_category_id.to_integer, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_class_id.to_integer, {DATA_PARAMETERS_NAMES}.Classid_param)
			l_parameters.put (a_confidential.to_boolean, {DATA_PARAMETERS_NAMES}.Confidential_param)
			l_parameters.put (string_parameter (a_synopsis, 100), {DATA_PARAMETERS_NAMES}.Synopsis_param)
			l_parameters.put (string_parameter (a_release, 50), {DATA_PARAMETERS_NAMES}.Release_param)
			l_parameters.put (string_parameter (a_environment, 200), {DATA_PARAMETERS_NAMES}.Environment_param)
			l_parameters.put (a_description , {DATA_PARAMETERS_NAMES}.Description_param)
			l_parameters.put (a_to_reproduce, {DATA_PARAMETERS_NAMES}.Toreproduce_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("InitializeProblemReport", l_parameters))
			db_handler.execute_reader

			post_execution
		end

	update_problem_report (a_pr: INTEGER; a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential: READABLE_STRING_8; a_synopsis, a_release, a_environment, a_description, a_to_reproduce: READABLE_STRING_32)
			-- Handle update report problem
		require
			valid_pr: a_pr > 0
			attached_priority: a_priority_id /= Void
			valid_priority_id: a_priority_id.is_integer
			attached_severity: a_severity_id /= Void
			valid_severity_id: a_severity_id.is_integer
			attached_category: a_category_id /= Void
			valid_category_id: a_category_id.is_integer
			attached_class: a_class_id /= Void
			valid_class_id: a_class_id.is_integer
			attached_confidential: a_confidential /= Void
			valid_confidential: a_confidential.is_boolean
			attached_synopsis: a_synopsis /= Void
			attached_release: a_release /= Void
			attached_environment: a_environment /= Void
			attached_description: a_description /= Void
			attached_to_reproduce: a_to_reproduce /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".update_problem_report")
			end

			create l_parameters.make (11)
			l_parameters.put (a_pr, {DATA_PARAMETERS_NAMES}.Number_param)
			l_parameters.put (a_priority_id.to_integer, {DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_severity_id.to_integer, {DATA_PARAMETERS_NAMES}.Severityid_param)
			l_parameters.put (a_category_id.to_integer, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_class_id.to_integer, {DATA_PARAMETERS_NAMES}.Classid_param)
			l_parameters.put (a_confidential.to_boolean, {DATA_PARAMETERS_NAMES}.Confidential_param)
			l_parameters.put (string_parameter (a_synopsis, 100), {DATA_PARAMETERS_NAMES}.Synopsis_param)
			l_parameters.put (string_parameter (a_release, 50), {DATA_PARAMETERS_NAMES}.Release_param)
			l_parameters.put (string_parameter (a_environment, 200), {DATA_PARAMETERS_NAMES}.Environment_param)
			l_parameters.put (a_description, {DATA_PARAMETERS_NAMES}.Description_param)
			l_parameters.put (a_to_reproduce, {DATA_PARAMETERS_NAMES}.Toreproduce_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("UpdateTemporaryProblemReport", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	set_problem_report_responsible (a_number, a_contact_id: INTEGER)
			-- Assign responsible with id `a_contact_id' to problem report number `a_report_number'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".set_problem_report_responsible")
			end

			create l_parameters.make (2)
			l_parameters.put (a_number, {DATA_PARAMETERS_NAMES}.Number_param)
			l_parameters.put (a_contact_id, {DATA_PARAMETERS_NAMES}.Contactid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("SetProblemReportResponsible", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	new_interaction_id (a_username: READABLE_STRING_GENERAL; a_pr_number: INTEGER): INTEGER
			-- Id of added interaction by user `a_username' to interactions of pr with number `a_pr_number'.
		require
			attached_username: a_username /= Void
			valid_pr_number: a_pr_number > 0
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".new_interaction_id")
			end

			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_pr_number, {DATA_PARAMETERS_NAMES}.Number_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("AddTemporaryProblemReportInteraction", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					Result := l_item
				end
			end

			post_execution
		end

	initialize_interaction (a_interaction_id: INTEGER; a_category_id: INTEGER; a_content: STRING_32; a_new_status: INTEGER; a_private: BOOLEAN)
			-- Initialize temporary interaction `a_interaction_id' with content `a_content'.
		require
			attached_content: a_content /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".initialize_interaction_2")
			end

			create l_parameters.make (5)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			l_parameters.put (a_content, {DATA_PARAMETERS_NAMES}.Content_param)
			l_parameters.put (a_new_status, {DATA_PARAMETERS_NAMES}.Statusid_param)
			l_parameters.put (a_private, {DATA_PARAMETERS_NAMES}.Private_param)
			l_parameters.put (a_category_id, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("InitializeInteraction3", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	commit_interaction (a_interaction_id: INTEGER)
			-- Commit temporary interaction report `a_report_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_int: INTEGER
		do
			debug
				log.write_information (generator + ".commit_interaction")
			end
			set_last_interaction_id (l_int)

			create l_parameters.make (1)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("CommitInteraction2", l_parameters))
			db_handler.execute_reader

				-- At the moment the following code is not needed
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_int := l_item
				end
			end

			if l_int > 0 then
				set_last_interaction_id (l_int)
			end
			post_execution
				--			delete_problem_report_temporary_interactions (a_interaction_id)
		end

	upload_temporary_report_attachment (a_report_id: INTEGER; a_length: INTEGER; a_name: READABLE_STRING_32; a_content: READABLE_STRING_8)
			-- Upload attachment in temporary table for temporary report `a_report_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".upload_temporary_report_attachment")
			end

			create l_parameters.make (4)
			l_parameters.put (a_report_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			l_parameters.put (a_length, {DATA_PARAMETERS_NAMES}.Length_param)
			l_parameters.put (a_content, {DATA_PARAMETERS_NAMES}.Content_param)
			l_parameters.put (string_parameter (a_name, 260), {DATA_PARAMETERS_NAMES}.Filename_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("AddTemporaryProblemReportAttachment", l_parameters))
			db_handler.execute_reader

			post_execution
		end

	upload_temporary_interaction_attachment (a_interaction_id: INTEGER; a_length: INTEGER; a_name: READABLE_STRING_32; a_content: READABLE_STRING_8)
			-- Upload attachment in temporary table for temporary interaction `a_interaction_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".upload_temporary_interaction_attachment")
			end

			create l_parameters.make (4)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			l_parameters.put (a_length, {DATA_PARAMETERS_NAMES}.Length_param)
			l_parameters.put (a_content, {DATA_PARAMETERS_NAMES}.Content_param)
			l_parameters.put (string_parameter (a_name, 260), {DATA_PARAMETERS_NAMES}.Filename_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("AddTemporaryProblemReportInteractionAttachment", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	remove_temporary_report_attachment (a_report_id: INTEGER; a_filename: READABLE_STRING_GENERAL)
			-- Remove a temporary attachment `a_filename' for the report `a_report_id'.
		require
			attached_filename: a_filename /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_temporary_report_attachment")
			end

			create l_parameters.make (2)
			l_parameters.put (a_report_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			l_parameters.put (string_parameter (a_filename, 260), {DATA_PARAMETERS_NAMES}.Filename_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveProblemReportAttachment", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	remove_temporary_interaction_attachment (a_interaction_id: INTEGER; a_filename: READABLE_STRING_GENERAL)
			-- Remove all temporary attachment with file name `a_file_name' uploaded by user with username `a_username'.
		require
			attached_filename: a_filename /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_temporary_interaction_attachment")
			end

			create l_parameters.make (2)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			l_parameters.put (string_parameter (a_filename, 260), {DATA_PARAMETERS_NAMES}.Filename_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveProblemReportInteractionAttachment", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	remove_all_temporary_report_attachments (a_report_id: INTEGER)
			-- Remove all temporary attachments used by temporary report `a_report_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_all_temporary_report_attachments")
			end

			create l_parameters.make (1)
			l_parameters.put (a_report_id, {DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveProblemReportTemporaryReportAttachments", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	remove_all_temporary_interaction_attachments (a_interaction_id: INTEGER)
			-- Remove all temporary attachments used by temporary interaction `a_interaction_id'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".remove_all_temporary_interaction_attachments")
			end

			create l_parameters.make (1)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveProblemReportTemporaryInteractionAttachments", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	set_problem_report_status (a_number, a_status_id: INTEGER)
			-- Set status of problem report with number `a_number' to status with status ID `a_status_id'.
		require
			valid_number: a_number > 0
			valid_status_id: a_status_id > 0
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".set_problem_report_status")
			end

			create l_parameters.make (2)
			l_parameters.put (a_number, {DATA_PARAMETERS_NAMES}.Number_param)
			l_parameters.put (a_status_id, {DATA_PARAMETERS_NAMES}.Statusid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("UpdateProblemReportStatus", l_parameters))
			db_handler.execute_writer

			post_execution
		end

	set_problem_report_category (a_number, a_category_id: INTEGER)
			-- Set category of problem report with number `a_number' to category with category ID `a_category_id'.
		require
			valid_number: a_number > 0
			valid_category_id: a_category_id > 0
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".set_problem_report_category")
			end

			create l_parameters.make (2)
			l_parameters.put (a_number, {DATA_PARAMETERS_NAMES}.Number_param)
			l_parameters.put (a_category_id, {DATA_PARAMETERS_NAMES}.Categoryid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("UpdateProblemReportCategory", l_parameters))
			db_handler.execute_writer

			post_execution
		end


	add_download_interaction (a_username: READABLE_STRING_32; a_product, a_platform: READABLE_STRING_8; a_file_name: READABLE_STRING_GENERAL)
			-- Adds a download interaction to the database.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_subject: STRING_8
			l_notes: STRING_32
		do
			debug
				log.write_information (generator + ".add_download_interaction")
			end

			create l_subject.make (a_product.count + a_platform.count + 40)
			l_subject.append ("Downloaded ")
			l_subject.append (a_product)
			l_subject.append (" (")
			l_subject.append (a_platform)
			l_subject.append_character (')')

			create l_notes.make (a_file_name.count + 40)
			l_notes.append_string_general ("File downloaded: ")
			l_notes.append_string_general (a_file_name)

			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (l_subject, {DATA_PARAMETERS_NAMES}.Subject_param)
			l_parameters.put (l_notes, {DATA_PARAMETERS_NAMES}.Notes_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("AddDownloadInteraction", l_parameters))
			db_handler.execute_writer
			post_execution
		end


	add_download_interaction_contact (a_email, a_product, a_platform: READABLE_STRING_8; a_file_name: READABLE_STRING_GENERAL)
			-- Adds a download interaction to the database.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_subject: STRING_8
			l_notes: STRING_32
		do
			debug
				log.write_information (generator + ".add_download_interaction_contact")
			end

			create l_subject.make (a_product.count + a_platform.count + 40)
			l_subject.append ("Downloaded ")
			l_subject.append (a_product)
			l_subject.append (" (")
			l_subject.append (a_platform)
			l_subject.append_character (')')

			create l_notes.make (a_file_name.count + 40)
			l_notes.append_string_general ("File downloaded: ")
			l_notes.append_string_general (a_file_name)

			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (l_subject, {DATA_PARAMETERS_NAMES}.Subject_param)
			l_parameters.put (l_notes, {DATA_PARAMETERS_NAMES}.Notes_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("AddDownloadInteractionContact", l_parameters))
			db_handler.execute_writer
			post_execution
		end


	initialize_download (a_email: READABLE_STRING_8; a_token: READABLE_STRING_32; a_platform: READABLE_STRING_8; a_company: READABLE_STRING_32; a_first_name: READABLE_STRING_32; a_last_name: READABLE_STRING_32)
			-- Initialize download for a given user with email `a_email' and token `a_token' and platform `a_platform'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".initialize_download")
			end
			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (a_token, {DATA_PARAMETERS_NAMES}.Token_param)
			l_parameters.put (a_platform, {DATA_PARAMETERS_NAMES}.Platform_param)
			l_parameters.put (a_company, {DATA_PARAMETERS_NAMES}.Company_param)
			l_parameters.put (a_first_name, {DATA_PARAMETERS_NAMES}.firstname_param)
			l_parameters.put (a_last_name, {DATA_PARAMETERS_NAMES}.lastname_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("InitializeDownload", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	retrieve_download_details (a_token: READABLE_STRING_32): detachable TUPLE [email: READABLE_STRING_8; platform: READABLE_STRING_8; username: READABLE_STRING_32; org_name: READABLE_STRING_32; phone: READABLE_STRING_8; org_email: READABLE_STRING_8; date: DATE_TIME; company: READABLE_STRING_32; first_name: READABLE_STRING_32; last_name: READABLE_STRING_32]
			-- Retrieve download details as tuple with email and platform for a given token `a_token', if any.
		local
			l_parameters: STRING_TABLE [ANY]
			l_encode: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".retrieve_download_details")
			end
			create l_parameters.make (1)
			l_parameters.put (l_encode.encoded_string (string_parameter(a_token,50)), {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_download_details, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				create Result.default_create
				if attached  db_handler.read_string (1) as l_email then
					Result.email := l_email
				end
				if attached  db_handler.read_string (2) as l_platform then
					Result.platform := l_platform
				end
				if attached  db_handler.read_string_32 (3) as l_username then
					Result.username := l_username
				end
				if attached  db_handler.read_string_32 (4) as l_org_name then
					Result.org_name := l_org_name
				end
				if attached  db_handler.read_string (5) as l_phone then
					Result.phone := l_phone
				end
				if attached  db_handler.read_string (6) as l_org_email then
					Result.org_email := l_org_email
				end
				if attached  db_handler.read_date_time (7) as l_date then
					Result.date := l_date
				end
				if attached  db_handler.read_string_32 (8) as l_username then
					Result.username := l_username
				end
				if attached  db_handler.read_string_32 (9) as l_company then
					Result.company := l_company
				end
				if attached  db_handler.read_string_32 (10) as l_first_name then
					Result.first_name := l_first_name
				end
				if attached  db_handler.read_string_32 (11) as l_last_name then
					Result.last_name := l_last_name
				end
			end
			post_execution
		end

	retrieve_temporary_download_details (a_token: READABLE_STRING_32): detachable TUPLE [email: READABLE_STRING_8; platform: READABLE_STRING_8; username: READABLE_STRING_32; date: DATE_TIME; company: READABLE_STRING_32; first_name: READABLE_STRING_32; last_name: READABLE_STRING_32]
			-- Retrieve download details as tuple with email and platform for a given token `a_token', if any.
		local
			l_parameters: STRING_TABLE [ANY]
			l_encode: DATABASE_SQL_SERVER_ENCODER
		do
			debug
				log.write_information (generator + ".retrieve_download_details")
			end
			create l_parameters.make (1)
			l_parameters.put (l_encode.encoded_string (string_parameter(a_token,50)), {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (Select_temporary_download_details, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				create Result.default_create
				if attached  db_handler.read_string (1) as l_email then
					Result.email := l_email
				end
				if attached  db_handler.read_string (2) as l_platform then
					Result.platform := l_platform
				end
				if attached  db_handler.read_string_32 (3) as l_username then
					Result.username := l_username
				end
				if attached  db_handler.read_date_time (4) as l_date then
					Result.date := l_date
				end
				if attached  db_handler.read_string_32 (5) as l_company then
					Result.company := l_company
				end
				if attached  db_handler.read_string_32 (6) as l_first_name then
					Result.first_name := l_first_name
				end
				if attached  db_handler.read_string_32 (7) as l_last_name then
					Result.last_name := l_last_name
				end
			end
			post_execution
		end


	add_contacts_temporary (a_first_name, a_last_name: READABLE_STRING_32; a_email: READABLE_STRING_8; a_newsletter: INTEGER)
			-- Add a contact temporary with first_name `a_first_name', last_name to `a_last_name' and email to `a_email'.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".add_contacts_temporary")
			end
			create l_parameters.make (3)
			l_parameters.put (string_parameter (a_first_name, 50), {DATA_PARAMETERS_NAMES}.Firstname_param)
			l_parameters.put (string_parameter (a_last_name, 50), {DATA_PARAMETERS_NAMES}.Lastname_param)
			l_parameters.put (string_parameter (a_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)
			l_parameters.put (a_newsletter, {DATA_PARAMETERS_NAMES}.Newsletter_param)

			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("AddContactsTemporary", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	add_temporary_contacts_to_contacts (a_email: READABLE_STRING_8)
			-- Add a temporary contact with email  `a_email' to contacts.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".add_temporary_contacts_to_contacts")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("CommitContact", l_parameters))
			db_handler.execute_writer
			post_execution
		end

	register_newsletter (a_email: READABLE_STRING_8)
			-- Register a contact with email `a_email' to the newsletter.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".register_newsletter")
			end
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_email, 150), {DATA_PARAMETERS_NAMES}.Email_param)

			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RegisterNewsletter", l_parameters))
			db_handler.execute_writer
			post_execution
		end

feature -- Status Report

	is_report_visible_guest (a_number: INTEGER): BOOLEAN
			-- Can user `guest' see report number `a_number'?
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_res: INTEGER
		do
			debug
				log.write_information (generator + ".is_report_visible_guest")
			end

			create l_parameters.make (1)
			l_parameters.put (a_number, {DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportVisibleGuest", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					l_res := l_item_1.item
				end
			end
			Result := l_res > 0

			post_execution
		end

	is_report_visible (a_username: READABLE_STRING_32; a_number: INTEGER): BOOLEAN
			-- Can user `a_username' see report number `a_number'?
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_res: INTEGER
		do
			debug
				log.write_information (generator + ".is_report_visible")
			end

			create l_parameters.make (2)
			l_parameters.put (a_username, {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_number, {DATA_PARAMETERS_NAMES}.Number_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportVisible", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					l_res := l_item_1.item
				end
			end
			Result := l_res > 0

			post_execution
		end

	interaction_visible (a_username: READABLE_STRING_32; a_interaction_id: INTEGER): BOOLEAN
			-- Can user with username `a_username' see interaction `a_interaction_id'?
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_res: INTEGER
		do
			debug
				log.write_information (generator + ".interaction_visible")
			end

			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportInteractionVisible", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_res := l_item
				end
			end
			Result := l_res > 0

			post_execution
		end

	interaction_visible_guest (a_interaction_id: INTEGER): BOOLEAN
			-- Can user `Guest' see interaction `a_interaction_id'?
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_res: INTEGER
		do
			debug
				log.write_information (generator + ".interaction_visible_guest")
			end

			create l_parameters.make (1)
			l_parameters.put (a_interaction_id, {DATA_PARAMETERS_NAMES}.Interactionid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportInteractionVisibleGuest", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_res := l_item
				end
			end
			Result := l_res > 0

			post_execution
		end

	attachment_visible (a_username: READABLE_STRING_32; a_attachment_id: INTEGER): BOOLEAN
			-- Can user with username `a_username' see attachment `a_attachment_id'?
		require
			attached_username: a_username /= Void
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_res: INTEGER
		do
			debug
				log.write_information (generator + ".attachment_visible")
			end

			create l_parameters.make (2)
			l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_attachment_id, {DATA_PARAMETERS_NAMES}.Attachmentid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportInteractionAttachmentVisible", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_res := l_item
				end
			end
			Result := l_res > 0

			post_execution
		end

	attachment_visible_guest (a_attachment_id: INTEGER): BOOLEAN
			-- Can user `Guest' see attachment `a_attachment_id'?
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
			l_res: INTEGER
		do
			debug
				log.write_information (generator + ".attachment_visible_guest")
			end

			create l_parameters.make (1)
			l_parameters.put (a_attachment_id, {DATA_PARAMETERS_NAMES}.Attachmentid_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportInteractionAttachmentVisibleGuest", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_res := l_item
				end
			end
			Result := l_res > 0

			post_execution
		end

	register_subscriber (a_username: READABLE_STRING_32; a_catID: INTEGER; a_subscribe: BOOLEAN)
			-- Subscribe responsible `a_username' to category with category ID `a_catID' if `a_subscribe'
			-- Unsubscribe otherwise.
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".register_subscriber")
			end
			if a_subscribe then

				create l_parameters.make (2)
				l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
				l_parameters.put (a_catid, {DATA_PARAMETERS_NAMES}.Categoryid_param)
				db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("AddProblemReportCategorySubscriber", l_parameters))
				db_handler.execute_writer

				post_execution
			else

				create l_parameters.make (2)
				l_parameters.put (string_parameter (a_username, 50), {DATA_PARAMETERS_NAMES}.Username_param)
				l_parameters.put (a_catid, {DATA_PARAMETERS_NAMES}.Categoryid_param)
				db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_writer ("RemoveProblemReportCategorySubscriber", l_parameters))
				db_handler.execute_writer

				post_execution
			end
		end

	download_expiration_token_age (a_token: READABLE_STRING_GENERAL): INTEGER
		local
			l_parameters: HASH_TABLE [ANY, STRING_32]
		do
			debug
				log.write_information (generator + ".download_expiration_token_age")
			end
			create l_parameters.make (1)
			l_parameters.put (a_token, {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_store (create {DATABASE_STORE_PROCEDURE}.data_reader ("GetDownloadExpirationTokenAge", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end


	download_expiration_token_age_2 (a_token: STRING ): INTEGER
		local
			l_parameters: STRING_TABLE [STRING_32]
			l_encoder: DATABASE_SQL_SERVER_ENCODER
		do
			create l_encoder
			Result := -1
			debug
				log.write_information (generator + ".download_expiration_token_age_2")
			end
			create l_parameters.make (1)
			l_parameters.put (l_encoder.encoded_string (string_parameter(a_token,50)), {DATA_PARAMETERS_NAMES}.Token_param)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (select_download_expiration, l_parameters))
			db_handler.execute_query
			if not db_handler.after then
				db_handler.start
				Result := db_handler.read_integer_32 (1)
			end
			post_execution
		end


feature {NONE} -- Implementation

	set_last_problem_report_number (a_number: INTEGER)
			-- Set `last_problem_report_number' with `a_number'.
		do
			last_problem_report_number := a_number
		ensure
			set: last_problem_report_number = a_number
		end

	set_last_interaction_id (a_number: INTEGER)
			-- Set `last_interaction_id' with `a_number'.
		do
			last_interaction_id := a_number
		ensure
			set: last_interaction_id = a_number
		end

	new_report (a_tuple: DB_TUPLE): REPORT
			-- Create a new report from Database.
		do
			create Result.make (0, "Null", False)
			if attached a_tuple as l_tuple then
					-- Report Number
				if attached db_handler.read_integer_32 (1) as l_item_1 then
					Result.set_number (l_item_1.item)
				end
					-- Synopsis
				if attached db_handler.read_string_32 (2) as l_item_2 then
					Result.set_synopsis (l_item_2)
				end
					-- Category Synopsis
				if attached db_handler.read_string_32 (3) as l_item_3 then
					Result.set_report_category (create {REPORT_CATEGORY}.make (0, l_item_3, True))
				end
					-- Submission Date
				if attached db_handler.read_date_time (4) as l_item_4 then
					Result.set_submission_date (l_item_4)
				end
					-- StatusId
				if attached db_handler.read_integer_32 (5) as l_item_5 then
					Result.set_status (create {REPORT_STATUS}.make (l_item_5.item, ""))
						-- Status Synopsis
					if attached db_handler.read_string_32 (6) as l_item_6 and then attached Result.status as l_status then
						l_status.set_synopsis (l_item_6)
					end
				end
					-- Contact
				if attached db_handler.read_string_32 (7) as l_item then
					Result.set_contact (create {USER}.make (l_item))
				end
			end
		end

	new_report_detail (a_tuple: DB_TUPLE): REPORT
			-- Create a new report detail from Database.
		do
			create Result.make (0, "Null", False)

				--SubmissionDate
			if attached db_handler.read_date_time (1) as l_item_1 then
				Result.set_submission_date (l_item_1)
			end
				--Synopsis
			if attached db_handler.read_string_32 (2) as l_item_2 then
				Result.set_synopsis (l_item_2)
			end

				--Release
			if attached db_handler.read_string (3) as l_item_3 then
				Result.set_release (l_item_3)
			end

				--Confidential
			if attached db_handler.read_boolean (4) as l_item_4 then
				Result.set_confidential (l_item_4)
			end

				--Environment
			if attached db_handler.read_string (5) as l_item_5 then
				Result.set_environment (l_item_5)
			end

				--Description
			if attached db_handler.read_string_32 (6) as l_item_6 then
				-- Result.set_description (utf.utf_8_string_8_to_string_32 (l_item_6))
				Result.set_description (l_item_6)
			end

				--To Reproduce
			if attached db_handler.read_string_32 (7) as l_item_7 then
				Result.set_to_reproduce (l_item_7)
			end

				--Status Synopsis
			if attached db_handler.read_string (8) as l_item_8 then
				Result.set_status (create {REPORT_STATUS}.make (0, l_item_8))
			end

				--Priority Synopsis
			if attached db_handler.read_string (9) as l_item_9 then
				Result.set_priority (create {REPORT_PRIORITY}.make (0, l_item_9))
			end

				--Category Synopsis
			if attached db_handler.read_string (10) as l_item_10 then
				Result.set_report_category (create {REPORT_CATEGORY}.make (0, l_item_10, True))
			end

				--Severity Synopsis
			if attached db_handler.read_string (11) as l_item_11 then
				Result.set_severity (create {REPORT_SEVERITY}.make (0, l_item_11))
			end

				--Class Synopsis
			if attached db_handler.read_string (12) as l_item_12 then
				Result.set_report_class (create {REPORT_CLASS}.make (0, l_item_12))
			end

				--User Name
			if attached db_handler.read_string (13) as l_item_13 then
				Result.set_contact (create {USER}.make (l_item_13))
			end

				-- Responsible
			if attached db_handler.read_string (14) as l_item_14 then
				Result.set_assigned (create {USER}.make (l_item_14))
				if attached Result.assigned as l_assigned and then attached db_handler.read_integer_32 (15) as l_item15 then
					l_assigned.set_id (l_item15)
				end
			end
		end

	new_report_responsible (a_tuple: DB_TUPLE): REPORT
			-- Create a new report from database.
		do
			create Result.make (0, "Null", False)
				--Number
			if attached db_handler.read_integer_32 (1) as l_number then
				Result.set_number (l_number)
			end
				--Synopsis
			if attached db_handler.read_string_32 (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
				--Submission Date
			if attached db_handler.read_date_time (3) as l_date then
				Result.set_submission_date (l_date)
			end
				--Release
			if attached db_handler.read_string (4) as l_release then
				Result.set_release (l_release)
			end
				--Priority ID
			if attached db_handler.read_integer_32 (5) as l_priority then
				Result.set_priority (create {REPORT_PRIORITY}.make (l_priority, ""))
					-- PrioritySynopsis
				if attached db_handler.read_string (6) as l_priority_synopsis and then attached Result.priority as ll_priority then
					ll_priority.set_synopsis (l_priority_synopsis)
				end
			end
				--Category Synopsis
			if attached db_handler.read_string (7) as l_category_synopsis then
				Result.set_report_category (create {REPORT_CATEGORY}.make (0, l_category_synopsis, True))
			end
				--Severity ID
			if attached db_handler.read_integer_32 (8) as l_severity then
				Result.set_severity (create {REPORT_SEVERITY}.make (l_severity, ""))
					-- SeveritySynopsis
				if attached db_handler.read_string (9) as l_serverity_synopsis and then attached Result.severity as ll_severity then
					ll_severity.set_synopsis (l_serverity_synopsis)
				end
			end
				--Status ID
			if attached db_handler.read_integer_32 (10) as l_status then
				Result.set_status (create {REPORT_STATUS}.make (l_status, ""))
					-- StatusSynopsis
				if attached db_handler.read_string (11) as l_status_synopsis and then attached Result.status as ll_status then
					ll_status.set_synopsis (l_status_synopsis)
				end
			end
				--User Name
			if attached db_handler.read_string (12) as l_name then
				Result.set_contact (create {USER}.make (l_name))
			end
				-- Responsible ID
			if attached db_handler.read_integer_32 (13) as l_responsible then
				Result.set_assigned (create {USER}.make (""))
				if attached Result.assigned as l_assigned then
					l_assigned.set_id (l_responsible)
				end
			end
		end

	new_report_interaction (a_tuple: DB_TUPLE; a_report: REPORT): REPORT_INTERACTION
			-- InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis, Private, InteractionID.
		do
				-- Todo merge with version 2
				-- InteractionID
			if attached {INTEGER_32_REF} a_tuple.item (8) as l_item_8 then
				create Result.make (l_item_8.item, a_report, False)
			else
				create Result.make (0, a_report, False)
			end

				--Interaction Date
			if attached {DATE_TIME} a_tuple.item (1) as l_item_1 then
				Result.set_date (l_item_1)
			end

				--Content
			if attached db_handler.read_string_32 (2) as l_item_2 then
				Result.set_content (l_item_2)
			end

				--Username
			if attached db_handler.read_string_32 (3) as l_item_3 then
				Result.set_contact (create {USER}.make (l_item_3))
			end
				--Status
			if attached db_handler.read_string (6) as l_item_6 then
				Result.set_status (l_item_6)
			end

				--Private
			if attached {BOOLEAN} a_tuple.item (7) as l_item_7 then
				Result.set_private (l_item_7)
			end
		end

	new_report_interaction_2 (a_tuple: DB_TUPLE; a_report: REPORT): REPORT_INTERACTION
			-- InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis, Private, InteractionID.
		do
			create Result.make (0, a_report, False)

				--Interaction Date
			if attached db_handler.read_date_time (1) as l_item_1 then
				Result.set_date (l_item_1)
			end

				--Content
			if attached db_handler.read_string_32 (2) as l_item_2 then
				Result.set_content (l_item_2)
			end

				--Username
			if attached db_handler.read_string (3) as l_item_3 then
				Result.set_contact (create {USER}.make (l_item_3))
			end

				--Status
			if attached db_handler.read_string (6) as l_item_6 then
				Result.set_status (l_item_6)
			end

				--Private
			if attached db_handler.read_boolean (7) as l_item_7 then
				Result.set_private (l_item_7)
			end
		end

	new_interaction_attachment (a_tuple: DB_TUPLE; a_report: REPORT_INTERACTION): REPORT_ATTACHMENT
			-- Create a new Report attachemnt from Database.
		do

				-- AttachmentID
			if attached {INTEGER_32_REF} a_tuple.item (1) as l_item_1 then
				create Result.make (l_item_1, a_report, "")
			else
				create Result.make (0, a_report, "")
			end

				--Interaction Date
			if attached {STRING} a_tuple.item (2) as l_item_2 then
				Result.set_name (l_item_2)
			end

				--Bytes Count
			if attached {INTEGER_32_REF} a_tuple.item (3) as l_item_3 then
				Result.set_bytes_count (l_item_3.item)
			end
		end

	new_report_category (a_tuple: DB_TUPLE): REPORT_CATEGORY
			-- Create a new report Category if any or a
			-- default empty category.
		do
			create Result.make (0, "", True)
			Result.set_id (db_handler.read_integer_32 (1))
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_report_class (a_tuple: DB_TUPLE): REPORT_CLASS
			-- Create a new report Class from database.
		do
			create Result.make (0, "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_report_severity (a_tuple: DB_TUPLE): REPORT_SEVERITY
			-- Create a new report severity from Database.
		do
			create Result.make (0, "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_report_priority (a_tuple: DB_TUPLE): REPORT_PRIORITY
			-- Create a new report priority from Database.
		do
			create Result.make (0, "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_report_status (a_data_value: DB_TUPLE): REPORT_STATUS
			-- New `Report Status'.
		do
			create Result.make (0, "")
			Result.set_id (db_handler.read_integer_32 (1))
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_reponsible (a_data_value: DB_TUPLE): USER
			-- New `responsible User'.
		do
			create Result.make ("")
			if attached db_handler.read_string (3) as l_name then
				create Result.make (l_name)
			end
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
		end

	new_category_email_subscribers (a_data_value: DB_TUPLE): STRING
			-- New subscriber email.
		do
			create Result.make_empty
			if attached db_handler.read_string (3) as l_email then
				Result.append (l_email)
			end
		end

	new_problem_report_subsribed_categeory	(a_data_value: DB_TUPLE): TUPLE[categoryId:INTEGER; synopsis:STRING; subscribed:INTEGER]
			-- New tuple row (CategoryID, CategorySynopsis, Subscribed).
		do
			create Result
			if attached db_handler.read_integer_32 (1) as l_categoryid then
				Result[1] := l_categoryid
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result[2] := l_synopsis
			end
			if attached db_handler.read_integer_32 (3) as l_subcribed then
				Result[3] := l_subcribed
			end
		end



feature -- Status Report

	last_row_count: INTEGER
			-- Number of rows retrieved by the last query.

feature -- Connection


	connect
			-- Connect to the database.
		do
			if not db_handler.is_connected then
				db_handler.connect
			end
		end


	disconnect
			-- Disconnect from the database.
		do
			if db_handler.is_connected then
				db_handler.disconnect
			end
		end

feature -- {NONE} Implementation

	delete_problem_report_temporary_interactions (a_interaction: INTEGER)
			-- Delete a report temporary interaction by id `a_interaction_id'.
		local
			l_parameters: STRING_TABLE [ANY]
		do
			debug
				log.write_information (generator + ".delete_problem_report_temporary_interactions")
			end

			create l_parameters.make (1)
			l_parameters.put (a_interaction, {DATA_PARAMETERS_NAMES}.interactionid_param)
			db_handler.set_query (create {DATABASE_QUERY}.data_reader (delete_ProblemReportTemporaryInteractions, l_parameters))
			db_handler.execute_query

			post_execution
		end

feature -- Queries

	Select_categories: STRING = "select CategoryID, CategorySynopsis from ProblemReportCategories;"
			-- Sql query to retrive categories.

	Select_problem_reports_template: STRING = "[
				SELECT Number, Synopsis, PAG2.CategorySynopsis as CategorySynopsis, SubmissionDate, PAG2.StatusID as statusID, PAG2.StatusSynopsis, PAG2.Username
			 FROM (
			    SELECT TOP :RowsPerPage
				   Number, Synopsis, PAG.CategorySynopsis as CategorySynopsis, SubmissionDate, PAG.StatusID as statusID, PAG.StatusSynopsis, PAG.CategoryID, PAG.Username
			    FROM (
				SELECT TOP :Offset
				Number, Synopsis, ProblemReportCategories.CategorySynopsis as CategorySynopsis, SubmissionDate, ProblemReports.StatusID statusID, 
				ProblemReportStatus.StatusSynopsis, ProblemReports.CategoryID, Memberships.Username
				FROM ProblemReports
			    INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
			    INNER JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReports.StatusID  
			    LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID  
			    WHERE (Confidential = 0 or (Confidential = 1 and ProblemReports.ContactID = (SELECT ContactID FROM Memberships WHERE Username = :Username ) ) ) AND ((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
					AND ((ProblemReports.StatusID in $StatusSet ))
					$SearchBySynopsisAndOrDescription
				ORDER BY $Column $ORD1
				) AS PAG
				ORDER BY $Column $ORD2
			) AS PAG2
			ORDER BY $Column $ORD1
		]"


	Select_problem_reports_closed_template: STRING = "[
				SELECT Number, Synopsis, PAG2.CategorySynopsis as CategorySynopsis, SubmissionDate, PAG2.StatusID as statusID, PAG2.StatusSynopsis, PAG2.Username
			 FROM (
			    SELECT TOP :RowsPerPage
				   Number, Synopsis, PAG.CategorySynopsis as CategorySynopsis, SubmissionDate, PAG.StatusID as statusID, PAG.StatusSynopsis, PAG.CategoryID, PAG.Username
			    FROM (
				SELECT TOP :Offset
				Number, Synopsis, ProblemReportCategories.CategorySynopsis as CategorySynopsis, SubmissionDate, ProblemReports.StatusID statusID,
				ProblemReportStatus.StatusSynopsis, ProblemReports.CategoryID, Memberships.Username
				FROM ProblemReports
			    INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
			    INNER JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReports.StatusID
			    LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
			    WHERE (Confidential = 0 or (Confidential = 1 and ProblemReports.ContactID = (SELECT ContactID FROM Memberships WHERE Username = :Username ) ) ) AND ((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
					AND ((ProblemReports.StatusID in (3,5) ))
					AND ProblemReports.LastActivityDate >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate()))
			        AND ProblemReports.LastActivityDate <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate()))
				ORDER BY $Column $ORD1
				) AS PAG
				ORDER BY $Column $ORD2
			) AS PAG2
			ORDER BY $Column $ORD1
		]"


	Select_row_count_problem_reports: STRING = "[
					SELECT COUNT(*)
					FROM dbo.ProblemReports
					where (Confidential = 0 or (Confidential = 1 and ContactID = (SELECT ContactID FROM Memberships WHERE Username = :Username ) ))
					and ((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
					AND ((ProblemReports.StatusID in $StatusSet))
					$SearchBySynopsisAndOrDescription
				]"

	Select_row_count_problem_reports_closed_guest: STRING = "[
					SELECT COUNT(*)
					FROM dbo.ProblemReports
					where (Confidential = 0 or (Confidential = 1 and ContactID = (SELECT ContactID FROM Memberships WHERE Username = :Username ) ))
					and ((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
					AND ((ProblemReports.StatusID in (3,5)))
					AND ProblemReports.LastActivityDate >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate()))
					AND ProblemReports.LastActivityDate <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate()))
				]"



	Select_problem_reports_responsibles_template: STRING = "[
			 SELECT   PAG2.Number, PAG2.Synopsis, SubmissionDate,
					 PAG2.Release, PAG2.PriorityID PriorityID, PAG2.PrioritySynopsis, 
					 PAG2.CategorySynopsis, PAG2.SeverityID SeverityID, PAG2.SeveritySynopsis,
					 PAG2.StatusID StatusID, PAG2.StatusSynopsis, 
					 PAG2.Username as 'DisplayName',
					 PAG2.ResponsibleID, PAG2.Username
				FROM (SELECT TOP :RowsPerPage  
				     PAG.Number, PAG.Synopsis, SubmissionDate,
					 PAG.Release, PAG.PriorityID PriorityID, PAG.PrioritySynopsis, 
					 PAG.CategorySynopsis, PAG.SeverityID SeverityID, PAG.SeveritySynopsis,
					 PAG.StatusID StatusID, PAG.StatusSynopsis, 
					 PAG.Username as 'DisplayName',
					 PAG.ResponsibleID, PAG.Username,
					 PAG.CategoryID,
					 PAG.ReportID,
					 PAG.ContactID	
					FROM (SELECT TOP :Offset
					     ProblemReports.Number, ProblemReports.Synopsis, SubmissionDate = ProblemReports.LastActivityDate,
						 ProblemReports.Release, ProblemReports.PriorityID PriorityID, ProblemReportPriorities.PrioritySynopsis, 
						 ProblemReportCategories.CategorySynopsis, ProblemReports.SeverityID SeverityID, ProblemReportSeverities.SeveritySynopsis,
						 ProblemReports.StatusID StatusID, ProblemReportStatus.StatusSynopsis, 
						 Memberships.Username as 'DisplayName',
						 ProblemReportResponsibles.ResponsibleID, Memberships.Username,
						 ProblemReports.CategoryID,
						 ProblemReports.ReportID,
						 Memberships.ContactID
						FROM ProblemReports
						INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
						INNER JOIN ProblemReportPriorities ON ProblemReports.PriorityID = ProblemReportPriorities.PriorityID
						INNER JOIN ProblemReportSeverities ON ProblemReports.SeverityID = ProblemReportSeverities.SeverityID
						INNER JOIN ProblemReportStatus ON ProblemReports.StatusID = ProblemReportStatus.StatusID
						LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
						LEFT JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID
						LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportResponsibleID =
																(select max (ReportResponsibleID) as ReportResponsibleID
										    from ProblemReportResponsibles prr, ProblemReports pr
										    where prr.ReportID = pr.ReportID and pr.ReportID = ProblemReports.ReportID)
						LEFT JOIN LastActivityDates ON LastActivityDates.ReportID = ProblemReports.ReportID
						WHERE $Submitter 
						ProblemReports.StatusID in $StatusSet
						$queryFilter
						$SearchBySynopsisAndOrDescription
						ORDER BY $Column $ORD1
					) AS PAG
					ORDER BY $Column $ORD2
				 )  as PAG2
			   ORDER by $Column $ORD1
		]"

	Select_problem_reports_responsibles_closed_template: STRING = "[
			 SELECT   PAG2.Number, PAG2.Synopsis, SubmissionDate,
					 PAG2.Release, PAG2.PriorityID PriorityID, PAG2.PrioritySynopsis,
					 PAG2.CategorySynopsis, PAG2.SeverityID SeverityID, PAG2.SeveritySynopsis,
					 PAG2.StatusID StatusID, PAG2.StatusSynopsis,
					 PAG2.Username as 'DisplayName',
					 PAG2.ResponsibleID, PAG2.Username
				FROM (SELECT TOP :RowsPerPage
				     PAG.Number, PAG.Synopsis, SubmissionDate,
					 PAG.Release, PAG.PriorityID PriorityID, PAG.PrioritySynopsis,
					 PAG.CategorySynopsis, PAG.SeverityID SeverityID, PAG.SeveritySynopsis,
					 PAG.StatusID StatusID, PAG.StatusSynopsis,
					 PAG.Username as 'DisplayName',
					 PAG.ResponsibleID, PAG.Username,
					 PAG.CategoryID,
					 PAG.ReportID,
					 PAG.ContactID
					FROM (SELECT TOP :Offset
					     ProblemReports.Number, ProblemReports.Synopsis, SubmissionDate = ProblemReports.LastActivityDate,
						 ProblemReports.Release, ProblemReports.PriorityID PriorityID, ProblemReportPriorities.PrioritySynopsis,
						 ProblemReportCategories.CategorySynopsis, ProblemReports.SeverityID SeverityID, ProblemReportSeverities.SeveritySynopsis,
						 ProblemReports.StatusID StatusID, ProblemReportStatus.StatusSynopsis,
						 Memberships.Username as 'DisplayName',
						 ProblemReportResponsibles.ResponsibleID, Memberships.Username,
						 ProblemReports.CategoryID,
						 ProblemReports.ReportID,
						 Memberships.ContactID
						FROM ProblemReports
						INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
						INNER JOIN ProblemReportPriorities ON ProblemReports.PriorityID = ProblemReportPriorities.PriorityID
						INNER JOIN ProblemReportSeverities ON ProblemReports.SeverityID = ProblemReportSeverities.SeverityID
						INNER JOIN ProblemReportStatus ON ProblemReports.StatusID = ProblemReportStatus.StatusID
						LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
						LEFT JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID
						LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportResponsibleID =
																(select max (ReportResponsibleID) as ReportResponsibleID
										    from ProblemReportResponsibles prr, ProblemReports pr
										    where prr.ReportID = pr.ReportID and pr.ReportID = ProblemReports.ReportID)
						LEFT JOIN LastActivityDates ON LastActivityDates.ReportID = ProblemReports.ReportID
						WHERE
						ProblemReports.StatusID in (3,5)
						AND ProblemReports.LastActivityDate >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate()))
						AND ProblemReports.LastActivityDate <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate()))
					) AS PAG
				 )  as PAG2
		]"

	Select_row_count_problem_reports_responsibles: STRING = "[
			SELECT COUNT(DISTINCT(number))
			FROM ProblemReports
			INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
			LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
			LEFT JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID
			LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID
			LEFT JOIN LastActivityDates ON LastActivityDates.ReportID = ProblemReports.ReportID
			WHERE  
			$Submitter
			((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
			AND StatusID in $StatusSet
			AND ((ProblemReports.PriorityID = :PriorityID) OR (NOT EXISTS (SELECT PriorityID FROM ProblemReportPriorities WHERE PriorityID = :PriorityID)))
			AND ((ProblemReports.SeverityID = :SeverityID) OR (NOT EXISTS (SELECT SeverityID FROM ProblemReportSeverities WHERE SeverityID = :SeverityID)))
			AND ((ProblemReportResponsibles.ResponsibleID =  :ResponsibleID) OR (NOT EXISTS (SELECT ResponsibleID FROM ProblemReportResponsibles r WHERE r.ResponsibleID = :ResponsibleID)))
			$SearchBySynopsisAndOrDescription
		]"

	Select_row_count_problem_reports_responsibles_closed: STRING = "[
			SELECT COUNT(DISTINCT(number))
			FROM ProblemReports
			INNER JOIN ProblemReportCategories ON ProblemReports.CategoryID = ProblemReportCategories.CategoryID
			LEFT JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID
			LEFT JOIN Contacts ON Contacts.ContactID = ProblemReports.ContactID
			LEFT JOIN ProblemReportResponsibles ON ProblemReportResponsibles.ReportID = ProblemReports.ReportID
			LEFT JOIN LastActivityDates ON LastActivityDates.ReportID = ProblemReports.ReportID
			WHERE
			StatusID in (3,5)
			AND ProblemReports.LastActivityDate >= dateadd(day, 1-datepart(dw, getdate()), CONVERT(date,getdate()))
			AND ProblemReports.LastActivityDate <  dateadd(day, 8-datepart(dw, getdate()), CONVERT(date,getdate()))

		]"

	Select_problem_reports_by_user_template: STRING = "[
				SELECT Number, Synopsis, PAG2.CategorySynopsis, SubmissionDate, PAG2.StatusID, PAG2.StatusSynopsis, PAG2.Username
				 FROM(SELECT TOP :RowsPerPage
					Number, Synopsis, PAG.CategorySynopsis, SubmissionDate, PAG.StatusID, PAG.StatusSynopsis, PAG.Username
				FROM (
					SELECT TOP :Offset
					Number, Synopsis, ProblemReportCategories.CategorySynopsis, SubmissionDate, ProblemReports.StatusID as statusID, ProblemReportStatus.StatusSynopsis,
					ProblemReports.CategoryID, ProblemReports.ContactID, Memberships.Username
					FROM ProblemReports
					INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
					INNER JOIN ProblemReportStatus ON ProblemReportStatus.StatusID = ProblemReports.StatusID   
					INNER JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID and Username = :Username
					WHERE 
						((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
						AND ((ProblemReports.StatusID in $StatusSet))
						$SearchBySynopsisAndOrDescription
						ORDER BY $Column $ORD1
					) as PAG
					ORDER BY $Column $ORD2	
				) as PAG2
			  ORDER BY $Column $ORD1
		]"

	Select_row_count_problem_report_by_user: STRING = "[
			SELECT COUNT (*)
			FROM ProblemReports
			INNER JOIN ProblemReportCategories ON ProblemReportCategories.CategoryID = ProblemReports.CategoryID
			INNER JOIN Memberships ON ProblemReports.ContactID = Memberships.ContactID and Username = :Username
			WHERE 
				((ProblemReports.CategoryID = :CategoryID) OR (NOT EXISTS (SELECT CategoryID FROM ProblemReportCategories WHERE CategoryID = :CategoryID)))
				AND ((ProblemReports.StatusID in $StatusSet))
				$SearchBySynopsisAndOrDescription

		]"

	delete_ProblemReportTemporaryInteractions: STRING = "[
			DELETE FROM ProblemReportTemporaryInteractions WHERE InteractionID = :InteractionID
		]"


	filter_by_content: STRING =	"[
							AND (( ProblemReports.Synopsis like '%%' + :Filter + '%' ) or ( ProblemReports.Description like '%%' + :Filter + '%%' )
							or ( ProblemReports.Description like '%%' + :Filter + '%%' )
							or ( ProblemReports.ReportID IN
								  ( Select  ProblemReportInteractions.ReportID
									from ProblemReportInteractions
									 	INNER JOIN ProblemReports ON ProblemReportInteractions.ReportID = ProblemReports.ReportID
									where ProblemReportInteractions.Content like '%%' + :Filter + '%%'
								   )
								)
							)
						]"


	Select_download_details: STRING = "[
				Select d.Email, d.Platform, c.FirstName +' '+ c.LastName as UserName, c.organizationName, c.phone, c.organizationEmail, d.CreatedDate, m.Username MembershipUserName, d.Company, d.FirstName, d.LastName
				from DownloadExpiration d
				INNER JOIN Contacts as c ON c.Email = d.Email
				LEFT JOIN Memberships as m on c.ContactID = m.ContactID
				where Token = :Token;
	]"


	Select_temporary_download_details: STRING = "[
				Select d.Email, d.Platform, c.FirstName +' '+ c.LastName as UserName, d.CreatedDate, d.Company, d.FirstName, d.LastName
				from DownloadExpiration d
				INNER JOIN ContactsTemporary as c ON c.Email = d.Email
				where Token = :Token;
	]"

	select_download_expiration: STRING = "[
		select DATEDIFF(day,CreatedDate,getdate()) from DownloadExpiration where Token = :Token
		]"


	Select_user_password_salt:  STRING = "[
		SELECT PasswordSalt FROM Memberships WHERE Username = :Username
		]"

	Select_interaction_content:  STRING = "[
		SELECT Content FROM ProblemReportInteractions WHERE InteractionID = :id
		]"

feature {NONE} -- Implementation

	post_execution
			-- Post database execution.
		do
			if db_handler.successful then
				set_successful
			else
				if attached db_handler.last_error then
					set_last_error_from_handler (db_handler.last_error)
				end
			end
		end

end
