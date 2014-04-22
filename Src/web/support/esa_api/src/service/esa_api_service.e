note
	description: "API Service facade to the underlying business logic"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_API_SERVICE

inherit

	ESA_API_ERROR

create
	make,
	make_with_database

feature {NONE} -- Initialization

	make
			-- Create the API service
		local
			l_connection: ESA_DATABASE_CONNECTION
		do
			create {ESA_DATABASE_CONNECTION_ODBC} l_connection.make_common
			create data_provider.make (l_connection)
			create login_provider.make (l_connection)
			is_successful := True
		end

	make_with_database (a_connection: ESA_DATABASE_CONNECTION)
			-- Create the API service
		require
			is_connected: a_connection.is_connected
		do
			create data_provider.make (a_connection)
			create login_provider.make (a_connection)
			is_successful := True
		end

feature -- Access

	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: INTEGER): TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
			-- All Problem reports for guest users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- Only not confidential reports
		local
			l_status: LIST[ESA_REPORT_STATUS]
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			l_status := status

			data_provider.connect
			create {ARRAYED_LIST[ESA_REPORT]} l_list.make (0)
			create l_statistics
			data_provider.connect
			across data_provider.problem_reports_guest (a_page_number, a_rows_per_page, a_category, a_status) as c loop
				l_report := c.item
				if attached l_report.status as ll_status then
					update_statistics (l_statistics, ll_status)
					l_report.set_status (ll_status)
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
			Result := [l_statistics, l_list]
		end

	problem_reports_guest_2 (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: INTEGER; a_column: READABLE_STRING_32; a_order: INTEGER): TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
			-- All Problem reports for guest users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- Only not confidential reports
		local
			l_status: LIST[ESA_REPORT_STATUS]
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			l_status := status

			data_provider.connect
			create {ARRAYED_LIST[ESA_REPORT]} l_list.make (0)
			create l_statistics
			data_provider.connect
			across data_provider.problem_reports_guest_2 (a_page_number, a_rows_per_page, a_category, a_status, a_column, a_order) as c loop
				l_report := c.item
				if attached l_report.status as ll_status then
						update_statistics (l_statistics, ll_status)
						l_report.set_status (ll_status)
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
			Result := [l_statistics, l_list]
		end


	problem_reports_responsibles (a_page_number, a_rows_per_page, a_category, a_severity, a_priority, a_responsible: INTEGER_32; a_column: READABLE_STRING_32; a_order: INTEGER_32; a_status, a_username: READABLE_STRING_32):TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
			-- All Problem reports for responsible users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- and category `a_category', severity `a_severity', priority, `a_priority', `a_responsible'
		local
			l_status: LIST[ESA_REPORT_STATUS]
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			l_status := status

			data_provider.connect
			create {ARRAYED_LIST[ESA_REPORT]} l_list.make (0)
			create l_statistics
			data_provider.connect
			across data_provider.problem_reports_responsibles (a_page_number, a_rows_per_page, a_category, a_severity, a_priority, a_responsible, a_column, a_order, a_status, a_username) as c loop
				l_report := c.item
				if attached l_report.status as ll_status then
						update_statistics (l_statistics, ll_status)
						l_report.set_status (ll_status)
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
			Result := [l_statistics, l_list]
		end


	problem_reports (a_username: STRING; a_open_only: BOOLEAN; a_category, a_status: INTEGER): TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
			-- Problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise.
		local
			l_status: LIST[ESA_REPORT_STATUS]
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			l_status := status
			create {ARRAYED_LIST[ESA_REPORT]} l_list.make (0)
			create l_statistics
			data_provider.connect
			across data_provider.problem_reports (a_username, a_open_only, a_category, a_status) as c loop
				l_report := c.item
				if attached l_report.status as ll_status then
					update_statistics (l_statistics, ll_status)
					l_report.set_status (ll_status)
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
			Result := [l_statistics, l_list]
		end

	problem_reports_2 (a_page_number, a_rows_per_page: INTEGER_32; a_username: STRING_8; a_open_only: BOOLEAN; a_category, a_status: INTEGER_32; a_column: READABLE_STRING_32; a_order: INTEGER_32): TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
				-- Problem reports for user with username `a_username'
				-- Open reports only if `a_open_only', all reports otherwise.
		local
			l_status: LIST[ESA_REPORT_STATUS]
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			l_status := status
			create {ARRAYED_LIST[ESA_REPORT]} l_list.make (0)
			create l_statistics
			data_provider.connect
			across data_provider.problem_reports_2 (a_page_number, a_rows_per_page, a_username, a_open_only, a_category, a_status, a_column, a_order) as c loop
				l_report := c.item
				if attached l_report.status as ll_status then
					update_statistics (l_statistics, ll_status)
					l_report.set_status (ll_status)
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
			Result := [l_statistics, l_list]
		end

	status: LIST[ESA_REPORT_STATUS]
			-- Possible problem report status
		local
			l_report_status: ESA_REPORT_STATUS
		do
			create {ARRAYED_LIST[ESA_REPORT_STATUS]} Result.make (0)
			data_provider.connect
			across data_provider.status as c  loop
					l_report_status := c.item
					Result.force (l_report_status)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	all_categories: LIST[ESA_REPORT_CATEGORY]
			-- Report Categories
		do
			create {ARRAYED_LIST[ESA_REPORT_CATEGORY]} Result.make (0)
			data_provider.connect
			across data_provider.all_categories as c  loop Result.force (c.item) end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	problem_report_details (a_username: STRING; a_number: INTEGER): detachable ESA_REPORT
			-- Problem report details for user `a_user_name' (Interactions and Attachments)with number `a_number'.
		local
			l_interactions: LIST[ESA_REPORT_INTERACTION]
			l_attachments: LIST [ESA_REPORT_ATTACHMENT]
		do
			if attached data_provider.problem_report (a_number) as l_report then
				l_interactions := data_provider.interactions (a_username, a_number, l_report)
				l_report.set_interactions (l_interactions)
				across l_interactions as c loop
					l_attachments := data_provider.attachments_headers (c.item)
					c.item.set_attachments (l_attachments)
				end
				Result := l_report
			end
			is_successful := data_provider.is_successful
		end

	problem_report_details_guest (a_number: INTEGER): detachable ESA_REPORT
			-- Problem report details for Guest user (Interactions and Attachments)with number `a_number'.
		local
			l_interactions: LIST[ESA_REPORT_INTERACTION]
			l_attachments: LIST [ESA_REPORT_ATTACHMENT]
		do
			if attached data_provider.problem_report (a_number) as l_report then
				l_interactions := data_provider.interactions_guest (a_number, l_report)
				l_report.set_interactions (l_interactions)
				across l_interactions as c loop
					l_attachments := data_provider.attachments_headers_guest (c.item)
					c.item.set_attachments (l_attachments)
				end
				Result := l_report
			end
			is_successful := data_provider.is_successful
		end

	attachments_content (a_attachment_id: INTEGER): STRING
			-- Attachment content of attachment with ID `a_attachment_id'
		do
			Result := data_provider.attachments_content (a_attachment_id)
			is_successful := data_provider.is_successful
		end


	user_role (a_username: STRING): ESA_USER_ROLE
			-- Role associated with user with username `a_username'
		do
			if attached login_provider.role (a_username) as l_role then
			  	if attached login_provider.role_description (l_role) as l_description then
			  		create Result.make (l_role, l_description)
			  	else
			  		create Result.make (l_role, "")
			  	end
			else
			create Result.make ("Guest", "Users who only can browse public content")
			end
			is_successful := login_provider.is_successful
		end

	severities: LIST[ESA_REPORT_SEVERITY]
			-- Possible problem report severity
		do
			create {ARRAYED_LIST[ESA_REPORT_SEVERITY]}Result.make (0)
			data_provider.connect
			across data_provider.severities as c  loop Result.force (c.item)  end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end


	classes: LIST[ESA_REPORT_CLASS]
			-- Possible problem report classes
		do
			create {ARRAYED_LIST[ESA_REPORT_CLASS]}Result.make (0)
			data_provider.connect
			across data_provider.classes as c  loop Result.force (c.item)  end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	priorities: LIST[ESA_REPORT_PRIORITY]
			-- Possible problem report classes
		do
			create {ARRAYED_LIST[ESA_REPORT_PRIORITY]}Result.make (0)
			data_provider.connect
			across data_provider.priorities as c  loop Result.force (c.item)  end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	temporary_problem_report (a_report_id: INTEGER): detachable TUPLE[synopsis : detachable STRING;
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
				-- Temporary problem report `a_report_id', if any.
		do
			Result := data_provider.temporary_problem_report (a_report_id)
			is_successful := data_provider.is_successful
		end

	role (a_username: READABLE_STRING_32): ESA_USER_ROLE
			-- Role associated with username `a_username'
		do
			if attached login_provider.role (a_username) as l_role and then
			   attached login_provider.role_description (l_role) as l_description then
				create Result.make (l_role, l_description)
			else
				create Result.make ("Guest", "Anonymous Users")
			end
			is_successful := login_provider.is_successful
		end

	responsibles: LIST [ESA_USER]
			-- Problem report responsibles
			-- Columns ContactID, Username, Name
		do
			create {ARRAYED_LIST[ESA_USER]}Result.make (0)
			data_provider.connect
			across data_provider.responsibles as c loop Result.force (c.item)   end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	security_questions: LIST[ESA_SECURITY_QUESTION]
			-- Security questions
		do
			create {ARRAYED_LIST[ESA_SECURITY_QUESTION]}Result.make (0)
			login_provider.connect
			across login_provider.security_questions as c loop Result.force (c.item)  end
			login_provider.disconnect
			is_successful := login_provider.is_successful
		end

	temporary_interaction (a_interaction_id: INTEGER): detachable TUPLE[content : detachable READABLE_STRING_32;
															   username: detachable READABLE_STRING_32;
															   status: detachable READABLE_STRING_32;
															   private: detachable READABLE_STRING_32
															   ]
			-- Temporary problem report interaction
			--			Content,
			--			Username,
			--			Status,
			--			Private,	

		do
			Result := data_provider.temporary_interaction (a_interaction_id)
			is_successful := data_provider.is_successful
		end

	temporary_problem_report_attachments (a_report_id: INTEGER): LIST[ESA_FILE_VIEW]
		local
			l_file: ESA_FILE_VIEW
		do
			create {ARRAYED_LIST[ESA_FILE_VIEW]}Result.make (0)
			across data_provider.temporary_problem_report_attachments (a_report_id) as c loop
				create l_file.make (c.item.filename, c.item.length, "")
				l_file.set_id (c.item.id)
				Result.force (l_file)
			end
			is_successful := data_provider.is_successful
		end


	temporary_interation_attachments (a_interaction_id: INTEGER): LIST[ESA_FILE_VIEW]
			-- Attachments for temporary interaction `a_interaction_id'
		local
			l_file: ESA_FILE_VIEW
		do
			create {ARRAYED_LIST[ESA_FILE_VIEW]}Result.make (0)
			across data_provider.temporary_interation_attachments (a_interaction_id) as c loop
				create l_file.make (c.item.filename, c.item.length, "")
				l_file.set_id (c.item.id)
				Result.force (l_file)
			end
			is_successful := data_provider.is_successful
		end

	remove_all_temporary_report_attachments (a_report_id: INTEGER)
			-- Remove all temporary attachments used by temporary report `a_report_id'.
		do
			data_provider.remove_all_temporary_report_attachments (a_report_id)
			is_successful := data_provider.is_successful
		end


	remove_temporary_report_attachment (a_report_id: INTEGER; a_filename: STRING)
			-- Remove a temporary attachment `a_filename' for the report `a_report_id'
		do
			data_provider.remove_temporary_report_attachment (a_report_id, a_filename)
			is_successful := data_provider.is_successful
		end

	remove_temporary_interaction_attachment (a_interaction_id: INTEGER; a_filename: STRING)
			-- Remove a temporary attachment `a_filename' for the interaction `a_interaction_id'
		do
			data_provider.remove_temporary_interaction_attachment (a_interaction_id, a_filename)
			is_successful := data_provider.is_successful
		end

	remove_all_temporary_interaction_attachments (a_interaction_id: INTEGER)
			-- Remove all temporary attachments used by temporary interaction `a_interaction_id'.
		do
			data_provider.remove_all_temporary_interaction_attachments (a_interaction_id)
			is_successful := data_provider.is_successful
		end



feature -- Basic Operations

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER; a_username: READABLE_STRING_32): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do
			Result := data_provider.row_count_problem_report_guest (a_category, a_status, a_username)
			is_successful := data_provider.is_successful
		end

	row_count_problem_report_responsible (a_category, a_severity, a_priority, a_responsible: INTEGER_32; a_status, a_username: READABLE_STRING_32): INTEGER
			-- Number of problems reports for responsible users.
			-- With filters by category `a_category', severity 'a_severity', priority `a_priority', responsible `a_responsible',
			-- status `a_status' and submitter `a_submitter'
		do
			Result := data_provider.row_count_problem_report_responsible (a_category, a_severity, a_priority, a_responsible, a_status, a_username)
			is_successful := data_provider.is_successful
		end

	row_count_problem_report_user (a_username: STRING_8; a_open_only: BOOLEAN; a_category, a_status: INTEGER_32): INTEGER
			-- Number of problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise, filetred by category and status
		do
			Result := data_provider.row_count_problem_report_user (a_username, a_open_only, a_category, a_status)
			is_successful := data_provider.is_successful
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
		do
			data_provider.initialize_problem_report (a_report_id, a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential, a_synopsis, a_release, a_environment, a_description, a_to_reproduce)
			is_successful := data_provider.is_successful
		end

	new_problem_report_id (a_username: STRING): INTEGER
			-- Initialize new problem report row and returns ReportID.
		do
			Result := data_provider.new_problem_report_id (a_username)
			is_successful := data_provider.is_successful
		end

	commit_problem_report (a_report_id: INTEGER)
			-- Commit a temporary problem report.
		do
			data_provider.commit_problem_report (a_report_id)
			is_successful := data_provider.is_successful
		end

	remove_temporary_problem_report (a_report_id: INTEGER_32)
			-- Remove temporary problem report `a_report_id'
		do
			data_provider.remove_temporary_problem_report (a_report_id)
			is_successful := data_provider.is_successful
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
		do
			data_provider.update_problem_report (a_pr, a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential, a_synopsis, a_release, a_environment, a_description, a_to_reproduce)
			is_successful := data_provider.is_successful
		end


	set_problem_report_responsible (a_number, a_contact_id: INTEGER_32)
			-- Assign responsible with id `a_contact_id' to problem report number `a_report_number'.
		do
			data_provider.set_problem_report_responsible (a_number, a_contact_id)
			is_successful := data_provider.is_successful
		end


	new_interaction_id (a_username: STRING; a_pr_number: INTEGER): INTEGER
			-- Id of added interaction by user `a_username' to interactions of pr with number `a_pr_number'.
		do
			Result := data_provider.new_interaction_id (a_username, a_pr_number)
			is_successful := data_provider.is_successful
		end

	initialize_interaction (a_interaction_id: INTEGER_32; a_content: STRING_8; a_new_status: INTEGER_32; a_private: BOOLEAN)
			-- Initialize temporary interaction `a_interaction_id' with content `a_content'.
		do
			data_provider.initialize_interaction (a_interaction_id, a_content, a_new_status, a_private)
			is_successful := data_provider.is_successful
		end

	commit_interaction (a_interaction_id: INTEGER)
			-- Commit temporary interaction report `a_report_id'.
		do
			data_provider.commit_interaction (a_interaction_id)
			is_successful := data_provider.is_successful
		end



	upload_temporary_report_attachment (a_report_id: INTEGER; a_file: ESA_FILE_VIEW)
			-- Upload attachment in temporary table for temporary report `a_report_id'
		do
			data_provider.upload_temporary_report_attachment (a_report_id, a_file.size, a_file.name, a_file.content)
			is_successful := data_provider.is_successful
		end

	upload_temporary_interaction_attachment	(a_interaction_id: INTEGER; a_file: ESA_FILE_VIEW)
			-- Upload attachment in temporary table for temporary interaction `a_interaction_id'
		do
			data_provider.upload_temporary_interaction_attachment (a_interaction_id, a_file.size, a_file.name, a_file.content)
			is_successful := data_provider.is_successful
		end

feature -- Element Settings

	add_user (a_first_name, a_last_name, a_email, a_username, a_password, a_answer, a_token: STRING; a_question_id: INTEGER): BOOLEAN
			-- Add user with username `a_username', first name `a_first_name' and last name `a_last_name'.
		require
			attached_username: a_username /= Void
			attached_first_name: a_first_name /= Void
			attached_last_name: a_last_name /= Void
		do
			if login_provider.user_from_username (a_username) = Void and then
				login_provider.user_from_email (a_email) = Void then
				data_provider.add_user (a_first_name, a_last_name, a_email, a_username, a_password, a_answer, a_token, a_question_id)
				is_successful := data_provider.is_successful
				if is_successful and then
				   attached login_provider.user_from_username (a_username) then
				   	Result := True
				else
					is_successful := login_provider.is_successful
				end
			else
					-- 	"Could not create user: Username/Email address already registered"
				Result := False
			end
		end

	remove_user (a_username: STRING_8)
			-- Remove username `a_username' from database
		do
			login_provider.remove_user (a_username)
			is_successful := login_provider.is_successful
		end

feature -- Status Report

	is_active (a_username: STRING): BOOLEAN
			-- Is membership for user with username `a_username' active?
		do
			Result := login_provider.is_active (a_username)
			is_successful := login_provider.is_successful
		end

	login_valid (a_username: STRING; a_password: STRING): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		local
			l_security: ESA_SECURITY_PROVIDER
			l_sha_password: STRING
		do
			if attached data_provider.user_password_salt (a_username) as l_hash and then
			   attached a_password then
				create l_security
				l_sha_password := l_security.password_hash (a_password, l_hash)
				Result := login_provider.validate_login (a_username, l_sha_password)
			end
			is_successful := login_provider.is_successful
		end

	is_report_visible_guest (a_report: INTEGER): BOOLEAN
			-- Can user `guest' see report number `a_number'?
		do
			Result := data_provider.is_report_visible_guest (a_report)
			is_successful := data_provider.is_successful
		end

	is_report_visible ( a_username: READABLE_STRING_32; a_number: INTEGER): BOOLEAN
			-- Can user `a_username' see report number `a_number'?
		do
			Result := data_provider.is_report_visible (a_username, a_number)
			is_successful := data_provider.is_successful
		end


	activation_valid (a_email, a_token: STRING): BOOLEAN
			-- Is activation for user with email `a_email' using token `a_token' valid?
		do
			Result := login_provider.activation_valid (a_email, a_token)
			if login_provider.successful then
				set_successful
			else
				set_last_error_from_handler (login_provider.last_error)
			end
		end


feature -- Statistics

	update_statistics (a_statistics: ESA_REPORT_STATISTICS; a_status: ESA_REPORT_STATUS)
		do
			inspect a_status.id
			when 1 then a_statistics.increment_open
			when 2 then a_statistics.increment_analyzed
			when 3 then a_statistics.increment_closed
			when 4 then a_statistics.increment_suspended
			when 5 then a_statistics.increment_wont_fix
			else
			end
		end

feature -- Status Report

	is_successful: BOOLEAN

feature {NONE} -- Implementation

	data_provider: ESA_REPORT_DATA_PROVIDER
			-- Report Data provider

	login_provider: ESA_LOGIN_DATA_PROVIDER
			-- Login data provider
end
