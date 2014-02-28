note
	description: "Provides access to database tables via stored procedures calls"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_DATA_PROVIDER

inherit

	ESA_PARAMETER_NAME_HELPER

create
	make

feature -- Initialization

	make (a_connection: ESA_DATABASE_CONNECTION)
			-- Create a data provider with connection `a_connection'
		do
			create {ESA_DATABASE_HANDLER_IMPL} db_handler.make (a_connection)
		end

	db_handler: ESA_DATABASE_HANDLER
		-- Db handler

feature -- Access


	problem_reports (a_username: STRING; a_open_only: BOOLEAN; a_category, a_status: INTEGER): ESA_DATABASE_ITERATION_CURSOR [REPORT]
			-- Problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise.
		require
			non_void_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (4)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_open_only, {ESA_DATA_PARAMETERS_NAMES}.Openonly_param)
			l_parameters.put (a_category, {ESA_DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_status, {ESA_DATA_PARAMETERS_NAMES}.Statusid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReports2", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report)
		end


	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER): ESA_DATABASE_ITERATION_CURSOR [REPORT]
			-- All Problem reports for guest users
			-- Only not confidential reports
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (2)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_page_number, "PageNumber")
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportsGuest", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report)
		end


	problem_report (a_number: INTEGER): detachable REPORT
			-- Problem report with number `a_number'.
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_number, {ESA_DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReport2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item  then
					Result := new_report_detail (l_item)
					Result.set_number (a_number)
				end
			end
			disconnect
		end

	interactions_guest (a_report_number: INTEGER; a_report: REPORT): LIST[REPORT_INTERACTION]
			-- Interactions related to problem report with ID `a_report_id'
			-- for a guest user
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create {ARRAYED_LIST[REPORT_INTERACTION]} Result.make (0)
			connect
			create l_parameters.make (1)
			l_parameters.put (a_report_number, {ESA_DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetReportProblemInteractionsGuest", l_parameters))
			db_handler.execute_reader

				-- Build list
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result.force (new_report_interaction (l_item,a_report))
				end
				db_handler.forth
			end
			disconnect
		end


	attachments_headers (a_interaction: REPORT_INTERACTION): LIST[REPORT_ATTACHMENT]
			-- -- Attachments for interaction `a_interaction_id'
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create {ARRAYED_LIST[REPORT_ATTACHMENT]} Result.make (0)
			connect
			create l_parameters.make (1)
			l_parameters.put (a_interaction.id, {ESA_DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteractionAttachmentsHeaders", l_parameters))
			db_handler.execute_reader

				-- Build list
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result.force (new_interaction_attachment (l_item,a_interaction))
				end
				db_handler.forth
			end
			disconnect
		end


	attachments_content (a_attachment_id: INTEGER): STRING
			-- Attachment content of attachment with ID `a_attachment_id'
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create Result.make_empty
			connect
			create l_parameters.make (1)
			l_parameters.put (a_attachment_id, {ESA_DATA_PARAMETERS_NAMES}.attachmentid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportInteractionAttachmentContent", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {STRING} l_item.item (1) as l_item_1 then
					Result := l_item_1
				end
			end
			disconnect
		end


	registration_token_from_username (a_username: READABLE_STRING_32): STRING
			-- Associated token for a username `a_username', or
			-- Empty String if the Account not activated.
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create Result.make_empty
			connect
			create l_parameters.make (1)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetRegistrationTokenFromUsername", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {STRING} l_item.item (1) as l_item_1 then
					Result := l_item_1
				end
			end
			disconnect
		end


	user_password_salt (a_username: READABLE_STRING_32): detachable STRING
			-- Associated password salt for a username `a_username'
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetUserPasswordSalt", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {STRING} l_item.item (1) as l_item_1 then
					Result := l_item_1
				end
			end
			disconnect
		end

	add_user (a_first_name, a_last_name, a_email, a_username, a_password, a_answer, a_token: STRING; a_question_id: INTEGER): BOOLEAN
			-- Add user with username `a_username', first name `a_first_name' and last name `a_last_name'.
			--
		require
			attached_username: a_username /= Void
			attached_first_name: a_first_name /= Void
			attached_last_name: a_last_name /= Void
		local
			l_answer_salt, l_password_salt, l_answer_hash, l_password_hash: STRING
			l_security: ESA_SECURITY_PROVIDER
			l_exists: BOOLEAN
			l_int: INTEGER
			l_parameters: HASH_TABLE[ANY,STRING_32]
			exist: BOOLEAN
		do
			create l_security
			l_answer_salt := l_security.salt
			l_answer_hash := l_security.password_hash (a_answer, l_answer_salt)
			l_password_salt := l_security.salt
			l_password_hash := l_security.password_hash (a_password, l_password_salt)

			connect
			create l_parameters.make (10)
			l_parameters.put (a_first_name, {ESA_DATA_PARAMETERS_NAMES}.firstname_param)
			l_parameters.put (a_last_name, {ESA_DATA_PARAMETERS_NAMES}.lastname_param)
			l_parameters.put (a_email, {ESA_DATA_PARAMETERS_NAMES}.email_param)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.username_param)
			l_parameters.put (string_parameter (l_password_hash, 40), {ESA_DATA_PARAMETERS_NAMES}.passwordhash_param)
			l_parameters.put (string_parameter (l_password_salt, 24), {ESA_DATA_PARAMETERS_NAMES}.passwordsalt_param)
			l_parameters.put (string_parameter (l_answer_hash, 40), {ESA_DATA_PARAMETERS_NAMES}.answerhash_param)
			l_parameters.put (string_parameter (l_answer_salt, 24), {ESA_DATA_PARAMETERS_NAMES}.answersalt_param)
			l_parameters.put (a_token, {ESA_DATA_PARAMETERS_NAMES}.registrationtoken_param)
			l_parameters.put (a_question_id, {ESA_DATA_PARAMETERS_NAMES}.questionid_param)


			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("AddUser2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item  then
						if attached {INTEGER_REF} l_item.item(1) as l_item_1 then
							l_int := l_item_1.item
						end
						if attached {BOOLEAN_REF} l_item.item(2) as l_item_2 then
							exist := l_item_2.item
						end
				end
			end
			Result := not exist
			disconnect
		end


	categories (a_username: STRING): ESA_DATABASE_ITERATION_CURSOR[REPORT_CATEGORY]
			-- Possible problem report categories
			-- Columns: CategoryID, CategorySynopsis, CategoryGroupSynopsis
		require
			non_void_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (1)
			l_parameters.put (string_parameter (a_username, 50), {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportCategories", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_category)
		end

feature -- Basic Operations

	new_problem_report_id (a_username: STRING): INTEGER
			-- Initialize new problem report row and returns ReportID.
		require
			attached_username: a_username /= Void
		local
				l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("AddTemporaryProblemReport", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end
			disconnect
		end

	row_count (a_table: STRING): INTEGER
		-- Return number of rows for `a_table'.
		require
			attached_table: a_table /= Void
		local
				l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_table, "TableName")
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("TableRowCount", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end
			disconnect
		end

	row_count_problem_report_guest: INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		local
				l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportsRowCountGuest", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					Result := l_item_1.item
				end
			end
			disconnect
		end

	status: ESA_DATA_VALUE
			-- Possible problem report status
			-- Columns: StatusID, StatusSynopsis, StatusDescription
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportStatus", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler)
		end

feature -- Status Report

	report_visible_guest ( a_number: INTEGER): BOOLEAN
			-- Can user `guest' see report number `a_number'?
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
			l_res: INTEGER
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_number, {ESA_DATA_PARAMETERS_NAMES}.number_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("IsProblemReportVisibleGuest", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached {DB_TUPLE} db_handler.item as l_item and then attached {INTEGER_32_REF} l_item.item (1) as l_item_1 then
					l_res := l_item_1.item
				end
			end
			Result := l_res > 0
			disconnect
		end


feature {NONE} -- Implementation

	new_report (a_tuple: DB_TUPLE): REPORT
		do
			create Result.make (-1, "Null", False)
			if attached a_tuple as l_tuple then
				if attached {INTEGER_32_REF} l_tuple.item (1) as l_item_1 then
						Result.set_number (l_item_1.item)
				end
				if attached {STRING} l_tuple.item (2) as  l_item_2 then
					Result.set_synopsis (l_item_2)
				end
				if attached {STRING} l_tuple.item (3) as  l_item_3 then
					Result.set_report_category (create {REPORT_CATEGORY}.make (-1,l_item_3, True))
				end
				if attached {DATE_TIME} l_tuple.item (4) as  l_item_4 then
					Result.set_submission_date (l_item_4)
				end

				if attached {INTEGER_32_REF} l_tuple.item (5) as  l_item_5 then
					Result.set_status (create {REPORT_STATUS}.make (l_item_5.item,""))
				end
			end
		end

	new_report_detail (a_tuple: DB_TUPLE): REPORT
		do

			create Result.make (-1, "Null", False)
				--SubmissionDate
			if attached {DATE_TIME} a_tuple.item (1) as  l_item_1 then
						Result.set_submission_date (l_item_1)
					end
				--Synopsis	
			if attached {STRING} a_tuple.item (2) as  l_item_2 then
				Result.set_synopsis (l_item_2)
			end

				--Release	
			if attached {STRING} a_tuple.item (3) as  l_item_3 then
				Result.set_release (l_item_3)
			end

				--Confidential	
			if attached {BOOLEAN} a_tuple.item (4) as  l_item_4 then
--				Result.set_confidential (l_item_4)
			end

				--Environment
			if attached {STRING} a_tuple.item (5) as  l_item_5 then
				Result.set_environment (l_item_5)
			end

				--Description
			if attached {STRING} a_tuple.item (6) as  l_item_6 then
				Result.set_description (l_item_6)
			end

				--To Reproduce
			if attached {STRING} a_tuple.item (7) as  l_item_7 then
				Result.set_to_reproduce (l_item_7)
			end

				--Status Synopsis
			if attached {STRING} a_tuple.item (8) as  l_item_8 then
				Result.set_status (create {REPORT_STATUS}.make (-1,l_item_8))
			end

				--Priority Synopsis
			if attached {STRING} a_tuple.item (9) as  l_item_9 then
				Result.set_priority (create {REPORT_PRIORITY}.make (-1,l_item_9))
			end

				--Category Synopsis
			if attached {STRING} a_tuple.item (10) as  l_item_10 then
				Result.set_report_category (create {REPORT_CATEGORY}.make (-1,l_item_10, True))
			end

			 	--Severity Synopsis
			if attached {STRING} a_tuple.item (11) as  l_item_11 then
				Result.set_severity (create {REPORT_SEVERITY}.make (-1,l_item_11))
			end

			 	--Class Synopsis
			if attached {STRING} a_tuple.item (12) as  l_item_12 then
				Result.set_report_class (create {REPORT_CLASS}.make (-1,l_item_12))
			end

			 	--User Name
			if attached {STRING} a_tuple.item (13) as  l_item_13 then
				Result.set_contact (create {USER}.make (l_item_13))
			end


		end


	new_report_interaction (a_tuple: DB_TUPLE; a_report: REPORT): REPORT_INTERACTION
			-- InteractionDate, Content, Username, FirstName, LastName, StatusSynopsis, Private, InteractionID
		do

				-- InteractionID
			if attached {INTEGER_32_REF} a_tuple.item (8) as  l_item_8 then
				create Result.make (l_item_8.item, a_report, False)
			else
				create Result.make (-1, a_report, False)
			end

				--Interaction Date
			if attached {DATE_TIME} a_tuple.item (1) as  l_item_1 then
				Result.set_date (l_item_1)
			end

				--Content	
			if attached {STRING} a_tuple.item (2) as  l_item_2 then
				Result.set_content (l_item_2)
			end

				--Username	
			if attached {STRING} a_tuple.item (3) as  l_item_3 then
				Result.set_contact (create {USER}.make (l_item_3))
			end

				--Status
			if attached {STRING} a_tuple.item (6) as  l_item_6 then
				Result.set_status (l_item_6)
			end

				--Private
			if attached {BOOLEAN} a_tuple.item (7) as  l_item_7 then
				Result.set_private (l_item_7)
			end
		end


	new_interaction_attachment (a_tuple: DB_TUPLE; a_report: REPORT_INTERACTION): REPORT_ATTACHMENT
		local
			-- AttachmentID, [FileName], BytesCount
		do

				-- AttachmentID
			if attached {INTEGER_32_REF} a_tuple.item (1) as  l_item_1 then
				create Result.make (l_item_1,a_report,"")
			else
				create Result.make (-1, a_report, "")
			end

				--Interaction Date
			if attached {STRING} a_tuple.item (2) as  l_item_2 then
				Result.set_name (l_item_2)
			end

				--Bytes Count	
			if attached {INTEGER_32_REF} a_tuple.item (3) as  l_item_3 then
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


feature -- Connection

	connect
		do
			if not db_handler.is_connected then
				db_handler.connect
			end
		end

	disconnect
		do
			if db_handler.is_connected then
				db_handler.disconnect
			end
		end

end
