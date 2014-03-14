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


	problem_reports (a_username: STRING; a_open_only: BOOLEAN; a_category, a_status: INTEGER): ESA_DATABASE_ITERATION_CURSOR [ESA_REPORT]
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
			last_row_count := db_handler.count
			create Result.make (db_handler, agent new_report)
		end


	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: INTEGER): ESA_DATABASE_ITERATION_CURSOR [ESA_REPORT]
			-- All Problem reports for guest users
			-- Only not confidential reports
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (2)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_page_number, "PageNumber")
			l_parameters.put (a_category, {ESA_DATA_PARAMETERS_NAMES}.categoryid_param)
			l_parameters.put (a_status, {ESA_DATA_PARAMETERS_NAMES}.statusid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportsGuest", l_parameters))
			db_handler.execute_reader
			last_row_count := db_handler.count
			create Result.make (db_handler, agent new_report)
		end


	problem_report (a_number: INTEGER): detachable ESA_REPORT
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

	interactions_guest (a_report_number: INTEGER; a_report: ESA_REPORT): LIST[ESA_REPORT_INTERACTION]
			-- Interactions related to problem report with ID `a_report_id'
			-- for a guest user
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create {ARRAYED_LIST[ESA_REPORT_INTERACTION]} Result.make (0)
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


	attachments_headers (a_interaction: ESA_REPORT_INTERACTION): LIST[ESA_REPORT_ATTACHMENT]
			-- -- Attachments for interaction `a_interaction_id'
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create {ARRAYED_LIST[ESA_REPORT_ATTACHMENT]} Result.make (0)
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


	categories (a_username: STRING): ESA_DATABASE_ITERATION_CURSOR[ESA_REPORT_CATEGORY]
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


	all_categories: ESA_DATABASE_ITERATION_CURSOR[ESA_REPORT_CATEGORY]
			-- All report categories
			-- Columns: CategoryID, CategorySynopsis, CategoryGroupSynopsis
		local
			l_parameters: STRING_TABLE [ANY]
		do
			create l_parameters.make (0)
			db_handler.set_query (create {ESA_DATABASE_QUERY}.data_reader (Select_categories, l_parameters))
			db_handler.execute_query
			create Result.make (db_handler, agent new_report_category )
		end

	classes: ESA_DATABASE_ITERATION_CURSOR[ESA_REPORT_CLASS]
			-- Possible problem report classes
			-- Columns: ClassID, ClassSynopsis, ClassDescription
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportClasses", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_class )
		end

	severities: ESA_DATABASE_ITERATION_CURSOR[ESA_REPORT_SEVERITY]
			-- Possible problem report severities
			-- Columns: SeverityID, SeveritySynopsis, SeverityDescription
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportSeverities", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_severity )
		end


	priorities: ESA_DATABASE_ITERATION_CURSOR[ESA_REPORT_PRIORITY]
			-- Possible problem report priorities
			-- Columns: PriorityID, PrioritySynopsis, PriorityDescription
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportPriorities", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_priority )
		end


	status: ESA_DATABASE_ITERATION_CURSOR [ESA_REPORT_STATUS]
			-- Possible problem report status
			-- Columns: StatusID, StatusSynopsis, StatusDescription
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			create l_parameters.make (0)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportStatus", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler, agent new_report_status )
		end

	last_problem_report_number: INTEGER
			-- Number of last submitted pr if `commit_problem_report' was called successfully
			-- 0 otherwise

	temporary_problem_report (a_id: INTEGER): detachable TUPLE[synopsis : detachable STRING;
															   release: detachable STRING;
															   confidential: detachable STRING;
															   environment: detachable STRING;
															   description: detachable STRING;
															   toreproduce: detachable STRING;
															   priority_synopsis: detachable STRING;
															   category_synopsis: detachable STRING;
															   severity_synopsis: detachable STRING;
															   class_synopsis: detachable STRING;
															   user_name: detachable STRING;
															   responsible: detachable STRING
															   ]
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
			--			Responsible
		local
				l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_id, {ESA_DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportTemporary2", l_parameters))
			db_handler.execute_reader
			if not db_handler.after then
				db_handler.start
				create Result.default_create
				across 1 |..| 12 as i loop
					Result[i.item] := db_handler.read_string (i.item)
				end
			end
			disconnect
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

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		local
				l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (2)
			l_parameters.put (a_category, {ESA_DATA_PARAMETERS_NAMES}.categoryid_param)
			l_parameters.put (a_status, {ESA_DATA_PARAMETERS_NAMES}.statusid_param)
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

	commit_problem_report (a_report_id: INTEGER)
			-- Commit temporary problem report `a_report_id'.
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
			l_int: INTEGER
		do
			set_last_problem_report_number (l_int)
			connect
			create l_parameters.make (1)
			l_parameters.put (a_report_id, {ESA_DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("CommitProblemReport", l_parameters))
			db_handler.execute_reader

			if not db_handler.after then
				db_handler.start
				if attached db_handler.read_integer_32 (1) as l_item then
					l_int := l_item
				end
			end
			disconnect
			if l_int > 0 then
				set_last_problem_report_number (l_int)
			end
		end

	remove_temporary_problem_report (a_report_id: INTEGER)
			-- Remove temporary problem report `a_report_id'.
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
			l_int: INTEGER
		do
			connect
			create l_parameters.make (1)
			l_parameters.put (a_report_id, {ESA_DATA_PARAMETERS_NAMES}.Reportid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("RemoveTemporaryProblemReport", l_parameters))
			db_handler.execute_reader
			disconnect
		end


	initialize_problem_report (a_report_id: INTEGER; a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential, a_synopsis,
			a_release, a_environment, a_description, a_to_reproduce: STRING)
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
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (11)
			l_parameters.put (a_report_id, {ESA_DATA_PARAMETERS_NAMES}.Reportid_param)
			l_parameters.put (a_priority_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_severity_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Severityid_param)
			l_parameters.put (a_category_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_class_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Classid_param)
			l_parameters.put (a_confidential.to_boolean, {ESA_DATA_PARAMETERS_NAMES}.Confidential_param)
			l_parameters.put (string_parameter (a_synopsis, 100), {ESA_DATA_PARAMETERS_NAMES}.Synopsis_param)
			l_parameters.put (string_parameter (a_release, 50), {ESA_DATA_PARAMETERS_NAMES}.Release_param)
			l_parameters.put (string_parameter (a_environment, 200), {ESA_DATA_PARAMETERS_NAMES}.Environment_param)
			l_parameters.put (a_description, {ESA_DATA_PARAMETERS_NAMES}.Description_param)
			l_parameters.put (a_to_reproduce, {ESA_DATA_PARAMETERS_NAMES}.Toreproduce_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("InitializeProblemReport", l_parameters))
			db_handler.execute_reader
			disconnect
		end



	update_problem_report (a_pr: INTEGER; a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential, a_synopsis,
			a_release, a_environment, a_description, a_to_reproduce: STRING)
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
			l_parameters: HASH_TABLE[ANY,STRING_32]
		do
			connect
			create l_parameters.make (11)
			l_parameters.put (a_pr, {ESA_DATA_PARAMETERS_NAMES}.Number_param)
			l_parameters.put (a_priority_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Priorityid_param)
			l_parameters.put (a_severity_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Severityid_param)
			l_parameters.put (a_category_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_class_id.to_integer, {ESA_DATA_PARAMETERS_NAMES}.Classid_param)
			l_parameters.put (a_confidential.to_boolean, {ESA_DATA_PARAMETERS_NAMES}.Confidential_param)
			l_parameters.put (string_parameter (a_synopsis, 100), {ESA_DATA_PARAMETERS_NAMES}.Synopsis_param)
			l_parameters.put (string_parameter (a_release, 50), {ESA_DATA_PARAMETERS_NAMES}.Release_param)
			l_parameters.put (string_parameter (a_environment, 200), {ESA_DATA_PARAMETERS_NAMES}.Environment_param)
			l_parameters.put (a_description, {ESA_DATA_PARAMETERS_NAMES}.Description_param)
			l_parameters.put (a_to_reproduce, {ESA_DATA_PARAMETERS_NAMES}.Toreproduce_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("UpdateProblemReport2", l_parameters))
			db_handler.execute_reader
			disconnect
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

	set_last_problem_report_number (a_number: INTEGER)
			-- Set `last_problem_report_number' with `a_number'.
		do
			last_problem_report_number := a_number
		ensure
			set: last_problem_report_number = a_number
		end

	new_report (a_tuple: DB_TUPLE): ESA_REPORT
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
					Result.set_report_category (create {ESA_REPORT_CATEGORY}.make (-1,l_item_3, True))
				end
				if attached {DATE_TIME} l_tuple.item (4) as  l_item_4 then
					Result.set_submission_date (l_item_4)
				end

				if attached {INTEGER_32_REF} l_tuple.item (5) as  l_item_5 then
					Result.set_status (create {ESA_REPORT_STATUS}.make (l_item_5.item,""))
				end
			end
		end

	new_report_detail (a_tuple: DB_TUPLE): ESA_REPORT
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
				Result.set_status (create {ESA_REPORT_STATUS}.make (-1,l_item_8))
			end

				--Priority Synopsis
			if attached {STRING} a_tuple.item (9) as  l_item_9 then
				Result.set_priority (create {ESA_REPORT_PRIORITY}.make (-1,l_item_9))
			end

				--Category Synopsis
			if attached {STRING} a_tuple.item (10) as  l_item_10 then
				Result.set_report_category (create {ESA_REPORT_CATEGORY}.make (-1,l_item_10, True))
			end

			 	--Severity Synopsis
			if attached {STRING} a_tuple.item (11) as  l_item_11 then
				Result.set_severity (create {ESA_REPORT_SEVERITY}.make (-1,l_item_11))
			end

			 	--Class Synopsis
			if attached {STRING} a_tuple.item (12) as  l_item_12 then
				Result.set_report_class (create {ESA_REPORT_CLASS}.make (-1,l_item_12))
			end

			 	--User Name
			if attached {STRING} a_tuple.item (13) as  l_item_13 then
				Result.set_contact (create {ESA_USER}.make (l_item_13))
			end


		end


	new_report_interaction (a_tuple: DB_TUPLE; a_report: ESA_REPORT): ESA_REPORT_INTERACTION
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
				Result.set_contact (create {ESA_USER}.make (l_item_3))
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


	new_interaction_attachment (a_tuple: DB_TUPLE; a_report: ESA_REPORT_INTERACTION): ESA_REPORT_ATTACHMENT
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

	new_report_category (a_tuple: DB_TUPLE): ESA_REPORT_CATEGORY
			-- Create a new report Category if any or a
			-- default empty category.
		do
			create Result.make (0, "", True)
			Result.set_id (db_handler.read_integer_32 (1))
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end


	new_report_class (a_tuple: DB_TUPLE): ESA_REPORT_CLASS
		do
			create Result.make (-1, "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_report_severity (a_tuple: DB_TUPLE): ESA_REPORT_SEVERITY
		do
			create Result.make (-1, "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

	new_report_priority (a_tuple: DB_TUPLE): ESA_REPORT_PRIORITY
		do
			create Result.make (-1, "")
			if attached db_handler.read_integer_32 (1) as l_id then
				Result.set_id (l_id)
			end
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end


	new_report_status (a_data_value: DB_TUPLE): ESA_REPORT_STATUS
			-- New `Report Status'
		do
			create Result.make (-1, "")
			Result.set_id (db_handler.read_integer_32 (1))
			if attached db_handler.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
		end

feature -- Status Report

	last_row_count: INTEGER
		-- Number of rows retrieved by the last query.

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

feature -- Queries

	Select_categories: STRING = "select CategoryID, CategorySynopsis from ProblemReportCategories;"

end
