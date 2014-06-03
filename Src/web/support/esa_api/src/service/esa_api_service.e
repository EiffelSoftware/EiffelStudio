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
			log.write_information (generator+".make_with_database is database connected?  "+ a_connection.is_connected.out )
			create data_provider.make (a_connection)
			create login_provider.make (a_connection)
			is_successful := True
		end

feature -- Access

	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: INTEGER): TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
			-- All Problem reports for guest users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- Only not confidential reports
		local
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			log.write_debug (generator + ".problem_reports_guest All Problem reports for guest users, filter by: page" + a_page_number.out + " rows_per_page:" + a_rows_per_page.out + " category:" + a_category.out + " status:" + a_status.out)
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
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			log.write_debug (generator + ".problem_reports_guest_2 All Problem reports for guest users, filter by: page" + a_page_number.out + " rows_per_page:" + a_rows_per_page.out + " category:" + a_category.out + " status:" + a_status.out +  " column:" + a_column + " order:" + a_order.out)
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
			log.write_debug (generator + ".problem_reports_responsibles All Problem reports for responsibles users, filter by: page" + a_page_number.out + " rows_per_page:" + a_rows_per_page.out + " category:" + a_category.out + " priority:" + a_priority.out + " serverity:" + a_severity.out + " responsible:" + a_responsible.out +" status:" + a_status.out + " username:" + a_username)
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
			l_report: ESA_REPORT
			l_list: LIST[ESA_REPORT]
			l_statistics: ESA_REPORT_STATISTICS
		do
			log.write_debug (generator + ".problem_reports Problem reports for username:" + a_username + " open_only:" + a_open_only.out + " category:" + a_category.out  +" status:" + a_status.out )

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
			log.write_debug (generator + ".problem_reports2 Problem reports for username:" + a_username + " page_number:" + a_page_number.out + "rows_per_page:" + a_rows_per_page.out + " open_only:" + a_open_only.out + " category:" + a_category.out  +" status:" + a_status.out + " column:" + a_column + " order:" + a_order.out)

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
		do
			log.write_debug (generator+".status" )
			create {ARRAYED_LIST[ESA_REPORT_STATUS]} Result.make (0)
			data_provider.connect
			across data_provider.status as c  loop
				Result.force (c.item)
			end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	all_categories: LIST[ESA_REPORT_CATEGORY]
			-- Report Categories
		do
			log.write_debug (generator+".all_categories" )
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
		do
			log.write_debug (generator+".problem_report_details for user:"+ a_username + " interaction and attachments:" + a_number.out )
			if attached data_provider.problem_report (a_number) as l_report then
				l_interactions := data_provider.interactions (a_username, a_number, l_report)
				l_report.set_interactions (l_interactions)
				across l_interactions as c loop
					c.item.set_attachments (data_provider.attachments_headers (c.item))
				end
				Result := l_report
			end
			is_successful := data_provider.is_successful
		end

	problem_report_details_guest (a_number: INTEGER): detachable ESA_REPORT
			-- Problem report details for Guest user (Interactions and Attachments)with number `a_number'.
		local
			l_interactions: LIST[ESA_REPORT_INTERACTION]
		do
			log.write_debug (generator+".problem_report_details_guest for guest:  interaction and attachments:" + a_number.out )
			if attached data_provider.problem_report (a_number) as l_report then
				l_interactions := data_provider.interactions_guest (a_number, l_report)
				l_report.set_interactions (l_interactions)
				across l_interactions as c loop
					c.item.set_attachments (data_provider.attachments_headers_guest (c.item))
				end
				Result := l_report
			end
			is_successful := data_provider.is_successful
		end

	attachments_content (a_attachment_id: INTEGER): STRING
			-- Attachment content of attachment with ID `a_attachment_id'
		do
			log.write_debug (generator + ".attachments_content Attachment content of attachment with ID:" + a_attachment_id.out)
			Result := data_provider.attachments_content (a_attachment_id)
			is_successful := data_provider.is_successful
		end

	user_role (a_username: STRING): ESA_USER_ROLE
			-- Role associated with user with username `a_username'.
		do
			log.write_debug (generator + ".user_role:" + a_username)
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
			log.write_debug (generator + ".severities")
			create {ARRAYED_LIST[ESA_REPORT_SEVERITY]}Result.make (0)
			data_provider.connect
			across data_provider.severities as c  loop Result.force (c.item)  end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end


	classes: LIST[ESA_REPORT_CLASS]
			-- Possible problem report classes
		do
			log.write_debug (generator + ".classes")
			create {ARRAYED_LIST[ESA_REPORT_CLASS]}Result.make (0)
			data_provider.connect
			across data_provider.classes as c  loop Result.force (c.item)  end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	priorities: LIST[ESA_REPORT_PRIORITY]
			-- Possible problem report priorities.
		do
			log.write_information (generator +".priorities")
			create {ARRAYED_LIST[ESA_REPORT_PRIORITY]}Result.make (0)
			data_provider.connect
			across data_provider.priorities as c  loop Result.force (c.item)  end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	countries: LIST [ESA_COUNTRY]
			-- List of countries.
		do
			log.write_information (generator +".countries")
			create {ARRAYED_LIST[ESA_COUNTRY]}Result.make (0)
			login_provider.connect
			across login_provider.countries as c loop Result.force (c.item)  end
			login_provider.disconnect
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
			log.write_debug (generator + ".temporary_problem_report report_id:" + a_report_id.out)

			Result := data_provider.temporary_problem_report (a_report_id)
			is_successful := data_provider.is_successful
		end

	role (a_username: READABLE_STRING_32): ESA_USER_ROLE
			-- Role associated with username `a_username'
		do
			log.write_debug (generator + ".role username:" + a_username)
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
			log.write_debug (generator + ".responsibles")
			create {ARRAYED_LIST[ESA_USER]}Result.make (0)
			data_provider.connect
			across data_provider.responsibles as c loop Result.force (c.item)   end
			data_provider.disconnect
			is_successful := data_provider.is_successful
		end

	security_questions: LIST[ESA_SECURITY_QUESTION]
			-- Security questions
		do
			log.write_debug (generator+".security_questions")
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
			log.write_debug (generator+".temporary_interaction interaction_id:" + a_interaction_id.out)
			Result := data_provider.temporary_interaction (a_interaction_id)
			is_successful := data_provider.is_successful
		end

	temporary_problem_report_attachments (a_report_id: INTEGER): LIST[ESA_FILE_VIEW]
		local
			l_file: ESA_FILE_VIEW
		do
			log.write_debug (generator+".temporary_problem_report_attachments  report_id:" + a_report_id.out)
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
			log.write_debug (generator+".temporary_interation_attachments interaction_id:" + a_interaction_id.out)
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
			log.write_debug (generator+".remove_all_temporary_report_attachments report_id:" + a_report_id.out)
			data_provider.remove_all_temporary_report_attachments (a_report_id)
			is_successful := data_provider.is_successful
		end


	remove_temporary_report_attachment (a_report_id: INTEGER; a_filename: STRING)
			-- Remove a temporary attachment `a_filename' for the report `a_report_id'
		do
			log.write_debug (generator+".remove_temporary_report_attachment report_id:" + a_report_id.out + " filename:" + a_filename)
			data_provider.remove_temporary_report_attachment (a_report_id, a_filename)
			is_successful := data_provider.is_successful
		end

	remove_temporary_interaction_attachment (a_interaction_id: INTEGER; a_filename: STRING)
			-- Remove a temporary attachment `a_filename' for the interaction `a_interaction_id'
		do
			log.write_debug (generator+".remove_temporary_interaction_attachment interaction_id:" + a_interaction_id.out + " filename:" + a_filename)
			data_provider.remove_temporary_interaction_attachment (a_interaction_id, a_filename)
			is_successful := data_provider.is_successful
		end

	remove_all_temporary_interaction_attachments (a_interaction_id: INTEGER)
			-- Remove all temporary attachments used by temporary interaction `a_interaction_id'.
		do
			log.write_debug (generator+".remove_all_temporary_interaction_attachments interaction_id:" + a_interaction_id.out)
			data_provider.remove_all_temporary_interaction_attachments (a_interaction_id)
			is_successful := data_provider.is_successful
		end

	token_from_email (a_email: READABLE_STRING_32): detachable STRING
			-- Activation token for user with email `a_email' if any.
		do
			log.write_debug (generator+".token_from_email Activation token from user email:" + a_email)
			Result := login_provider.token_from_email (a_email)
			is_successful := login_provider.is_successful
		end

	question_from_email (a_email: STRING_8): detachable STRING
			-- Security question associated with account with email `a_email' if any
		do
			log.write_debug (generator+".question_from_email user email:" + a_email)
			Result := login_provider.question_from_email (a_email)
			is_successful := login_provider.is_successful
		end

	user_from_email (a_email: STRING): detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
			-- User with email `a_email' if any.
		do
			log.write_debug (generator+".user_from_email user email:" + a_email)
			Result := login_provider.user_from_email (a_email)
			is_successful := login_provider.is_successful
		end

	user_account_information (a_username: STRING): ESA_USER_INFORMATION
			-- User information for `a_username' if any.
		do
			Result := login_provider.user_information (a_username)
			is_successful := login_provider.is_successful
		end

feature -- Basic Operations

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER; a_username: READABLE_STRING_32): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do
			log.write_debug (generator+".row_count_problem_report_guest filter by category:" + a_category.out + " status:" + a_status.out + " username:" + a_username)
			Result := data_provider.row_count_problem_report_guest (a_category, a_status, a_username)
			is_successful := data_provider.is_successful
		end

	row_count_problem_report_responsible (a_category, a_severity, a_priority, a_responsible: INTEGER_32; a_status, a_username: READABLE_STRING_32): INTEGER
			-- Number of problems reports for responsible users.
			-- With filters by category `a_category', severity 'a_severity', priority `a_priority', responsible `a_responsible',
			-- status `a_status' and submitter `a_submitter'
		do
			log.write_debug (generator+".row_count_problem_report_responsible filter by category:" + a_category.out + " severity:" + a_severity.out + " priority:" + a_priority.out + " status:" + a_status.out + " username:" + a_username)
			Result := data_provider.row_count_problem_report_responsible (a_category, a_severity, a_priority, a_responsible, a_status, a_username)
			is_successful := data_provider.is_successful
		end

	row_count_problem_report_user (a_username: STRING_8; a_open_only: BOOLEAN; a_category, a_status: INTEGER_32): INTEGER
			-- Number of problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise, filetred by category and status
		do
			log.write_debug (generator+".row_count_problem_report_user filter by username:" + a_username + " open_only:" + a_open_only.out + " category:" + a_category.out + " status:" + a_status.out)
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
			log.write_debug (generator+".initialize_problem_report report_id" + a_report_id.out + " priority_id:" + a_priority_id + " category_id:" + a_category_id + " class_id:" + a_class_id + " confidential:" + a_confidential + " synopsis:" + a_synopsis + " release:" + a_release + " environment:" + a_environment + " description:" + a_description + " to_reprodude:" + a_to_reproduce)
			data_provider.initialize_problem_report (a_report_id, a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential, a_synopsis, a_release, a_environment, a_description, a_to_reproduce)
			is_successful := data_provider.is_successful
		end

	new_problem_report_id (a_username: STRING): INTEGER
			-- Initialize new problem report row and returns ReportID.
		do
			log.write_debug (generator+".new_problem_report_id username" + a_username )
			Result := data_provider.new_problem_report_id (a_username)
			is_successful := data_provider.is_successful
		end

	commit_problem_report (a_report_id: INTEGER)
			-- Commit a temporary problem report.
		do
			log.write_debug (generator+".commit_problem_report report_id" + a_report_id.out )
			data_provider.commit_problem_report (a_report_id)
			is_successful := data_provider.is_successful
		end

	remove_temporary_problem_report (a_report_id: INTEGER_32)
			-- Remove temporary problem report `a_report_id'
		do
			log.write_debug (generator+".remove_temporary_problem_report report_id" + a_report_id.out )
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
			log.write_debug (generator+".update_problem_report report_problem:" + a_pr.out + " priority_id:" + a_priority_id.out + " severity_id:" + a_severity_id + " category_id:" + a_category_id + " class_id:" + a_class_id + " confidential:" + a_confidential + " synopsis:" + a_synopsis + " release:" + a_release + " environment:" + a_environment + " description" + a_description + " to_reproduce:" + a_to_reproduce )
			data_provider.update_problem_report (a_pr, a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential, a_synopsis, a_release, a_environment, a_description, a_to_reproduce)
			is_successful := data_provider.is_successful
		end


	set_problem_report_responsible (a_number, a_contact_id: INTEGER_32)
			-- Assign responsible with id `a_contact_id' to problem report number `a_report_number'.
		do
			log.write_debug (generator + ".set_problem_report_responsible report_number:" + a_number.out + " contact_id:" + a_contact_id.out)
			data_provider.set_problem_report_responsible (a_number, a_contact_id)
			is_successful := data_provider.is_successful
		end


	new_interaction_id (a_username: STRING; a_pr_number: INTEGER): INTEGER
			-- Id of added interaction by user `a_username' to interactions of pr with number `a_pr_number'.
		do
			log.write_debug (generator + ".new_interaction_id report_number:" + a_pr_number.out + " username:" + a_username)
			Result := data_provider.new_interaction_id (a_username, a_pr_number)
			is_successful := data_provider.is_successful
			log.write_debug (generator + ".new_interaction_id " + Result.out + ", is_successful:" + is_successful.out)
		end

	initialize_interaction (a_interaction_id: INTEGER_32; a_content: STRING_8; a_new_status: INTEGER_32; a_private: BOOLEAN)
			-- Initialize temporary interaction `a_interaction_id' with content `a_content'.
		do
			log.write_debug (generator + ".initialize_interaction [Interaction_Id:" + a_interaction_id.out + ", content: " + a_content + ", new_status: " + a_new_status.out + ", private: "+ a_private.out)
			data_provider.initialize_interaction (a_interaction_id, a_content, a_new_status, a_private)
			is_successful := data_provider.is_successful
		end

	commit_interaction (a_interaction_id: INTEGER)
			-- Commit temporary interaction report `a_report_id'.
		do
			log.write_debug (generator + ".commit_interaction Interaction_Id:" + a_interaction_id.out)
			data_provider.commit_interaction (a_interaction_id)
			is_successful := data_provider.is_successful
		end



	upload_temporary_report_attachment (a_report_id: INTEGER; a_file: ESA_FILE_VIEW)
			-- Upload attachment in temporary table for temporary report `a_report_id'
		do
			log.write_debug (generator + ".upload_temporary_report_attachment Report_id:" + a_report_id.out + " filename:" + a_file.name)
			data_provider.upload_temporary_report_attachment (a_report_id, a_file.size, a_file.name, a_file.content)
			is_successful := data_provider.is_successful
		end

	upload_temporary_interaction_attachment	(a_interaction_id: INTEGER; a_file: ESA_FILE_VIEW)
			-- Upload attachment in temporary table for temporary interaction `a_interaction_id'
		do
			log.write_debug (generator + ".upload_temporary_interaction_attachment InteractionId:" + a_interaction_id.out + " filename:" + a_file.name)
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
			log.write_debug (generator + ".add_user First Name:" + a_first_name + " Last Name:" + a_last_name + " email:" + a_email +
			" Username:" + a_username + " a_token:" + a_token + " question:" + a_question_id.out)
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
				log.write_alert (generator + ".add_user Could not create user: Username/Email address already registered" )
				Result := False
			end
		end

	remove_user (a_username: STRING_8)
			-- Remove username `a_username' from database
		do
			log.write_debug (generator + ".remove_user username:" + a_username)
			login_provider.remove_user (a_username)
			is_successful := login_provider.is_successful
		end

	update_password (a_email: STRING; a_password: STRING)
			-- Update password of user with email `a_email'.
		do
			log.write_debug (generator + ".update_password email:" + a_email)
			login_provider.update_password (a_email, a_password)
			is_successful := login_provider.is_successful
		end

	update_personal_information (a_username: STRING; a_first_name, a_last_name, a_position, a_address, a_city, a_country, a_region, a_code, a_tel, a_fax: detachable STRING): BOOLEAN
			-- Update personal information of user with username `a_username'.
		do
			if login_provider.user_from_username (a_username) /= Void then
				login_provider.update_personal_information (a_username, a_first_name, a_last_name, a_position, a_address, a_city, a_country, a_region, a_code, a_tel, a_fax)
				is_successful := login_provider.is_successful
				if is_successful then
				   	Result := True
				else
					is_successful := login_provider.is_successful
				end
			else
					-- 	"Could not update user: Username does not exist"
				log.write_alert (generator + ".update_personal_information Could not update user info: Username not registered" )
				Result := False
			end
		end


	change_user_email (a_user: READABLE_STRING_32; a_new_email: READABLE_STRING_32; a_token: READABLE_STRING_32)
			-- Change user email.
		do
			if login_provider.user_from_username (a_user) /= Void then
				login_provider.change_user_email (a_user, a_new_email, a_token)
				is_successful := login_provider.is_successful
			else
					-- 	"Could not update user: Username does not exist"
				log.write_alert (generator + ".update_personal_information Could not update user info: Username not registered" )
				set_last_error ("Username does not exist", generator + ".change_user_email")
			end
		end


	update_email_from_user_and_token (a_user: STRING; a_token: STRING)
		do
			login_provider.update_email_from_user_and_token (a_token, a_user)
			is_successful := login_provider.is_successful
		end


feature -- Status Report

	is_active (a_username: STRING): BOOLEAN
			-- Is membership for user with username `a_username' active?
		do
			log.write_debug (generator + ".is_active Is Membership for username:" + a_username + " active?")
			Result := login_provider.is_active (a_username)
			log.write_debug (generator + ".is_active Is Membership for username:" + a_username + " active?" + Result.out )
			is_successful := login_provider.is_successful
		end

	login_valid (a_username: STRING; a_password: STRING): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		local
			l_sha_password: STRING
		do
			log.write_debug (generator + ".login_valid for username:" + a_username )
			if attached data_provider.user_password_salt (a_username) as l_hash and then
			   attached a_password then
				l_sha_password := (create {ESA_SECURITY_PROVIDER}).password_hash (a_password, l_hash)
				Result := login_provider.validate_login (a_username, l_sha_password)
			end
			is_successful := login_provider.is_successful
		end

	is_report_visible_guest (a_report: INTEGER): BOOLEAN
			-- Can user `guest' see report number `a_number'?
		do
			log.write_debug (generator + ".is_report_visible_guest report:" + a_report.out)
			Result := data_provider.is_report_visible_guest (a_report)
			is_successful := data_provider.is_successful
		end

	is_report_visible ( a_username: READABLE_STRING_32; a_number: INTEGER): BOOLEAN
			-- Can user `a_username' see report number `a_number'?
		do
			log.write_debug (generator + ".is_report_visible for username:" + a_username + " report:" + a_number.out )
			Result := data_provider.is_report_visible (a_username, a_number)
			is_successful := data_provider.is_successful
		end


	activation_valid (a_email, a_token: STRING): BOOLEAN
			-- Is activation for user with email `a_email' using token `a_token' valid?
		do
			log.write_debug (generator + ".activation_valid Processing user activation with email:" + a_email + " token: " + a_token )
			Result := login_provider.activation_valid (a_email, a_token)
			if login_provider.successful then
				set_successful
				log.write_debug (generator + ".activation_valid User activated with email:" + a_email )
			else
				set_last_error_from_handler (login_provider.last_error)
				log.write_error (generator + ".activation_valid " + last_error_message)
			end
		end


	user_token_new_email (a_token: STRING; a_user: STRING): TUPLE[age:INTEGER; email:detachable STRING]
			-- A token `a_token' is valid if it exist for the given user `a_user' and is not expired (24 hours since his request).
		local
			l_age: INTEGER
		do
				--login_provider.token_email (a_token: STRING; a_user: STRING)

			Result := login_provider.email_token_age (a_token, a_user)
			l_age := Result.age
			if
				l_age >= 0 and then
				l_age <= 24
			then
				set_successful
			elseif l_age = -1 then
				set_last_error ("Token: " + a_token + " is invalid " , generator + ".is_token_email_valid")
			else
				set_last_error ("Token: " + a_token + " has expired " , generator + ".is_token_email_valid")
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
