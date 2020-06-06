note
	description: "API Service facade to the underlying business logic"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_API_SERVICE

inherit

	SHARED_ERROR

create
	make,
	make_with_database

feature {NONE} -- Initialization

	make
			-- Create the API service
		local
			l_connection: DATABASE_CONNECTION
		do
			create {DATABASE_CONNECTION_ODBC} l_connection.make_common
			create data_provider.make (l_connection)
			create login_provider.make (l_connection)
			post_data_provider_execution
			post_login_provider_execution
		end

	make_with_database (a_connection: DATABASE_CONNECTION)
			-- Create the API service
		require
			is_connected: a_connection.is_connected
		do
			log.write_information (generator+".make_with_database is database connected?  "+ a_connection.is_connected.out )
			create data_provider.make (a_connection)
			create login_provider.make (a_connection)
			post_data_provider_execution
			post_login_provider_execution
			set_successful
		end

feature -- Access

	problem_report (a_number: INTEGER): detachable REPORT
			-- Problem report with number `a_number'.
		do
			Result := data_provider.problem_report (a_number)
			post_data_provider_execution
		end


	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: READABLE_STRING_8; a_column: READABLE_STRING_8; a_order: INTEGER; a_username: READABLE_STRING_32; a_filter:READABLE_STRING_32; a_content:INTEGER): LIST[REPORT]
			-- All Problem reports for guest users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- Only not confidential reports
		local
			l_list: LIST [REPORT]
		do
			log.write_information (generator + ".problem_reports_guest_2 All Problem reports for guest users, filter by: page" + a_page_number.out + " rows_per_page:" + a_rows_per_page.out + " category:" + a_category.out + " status:" + a_status.out +  " column:" + a_column + " order:" + a_order.out)
			create {ARRAYED_LIST [REPORT]} l_list.make (0)
			-- data_provider.connect
			across data_provider.problem_reports_guest (a_page_number, a_rows_per_page, a_category, a_status, a_column, a_order, a_username, a_filter, a_content) as c loop
				l_list.force (c.item)
			end
			-- data_provider.disconnect
			Result := l_list
			post_data_provider_execution
		end


	problem_reports_responsibles (a_page_number, a_rows_per_page, a_category, a_severity, a_priority, a_responsible: INTEGER_32; a_column: READABLE_STRING_32; a_order: INTEGER_32; a_status, a_username: READABLE_STRING_32; a_filter: detachable READABLE_STRING_32; a_content: INTEGER_32): LIST[REPORT]
			-- All Problem reports for responsible users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- and category `a_category', severity `a_severity', priority, `a_priority', `a_responsible'
		local
			l_list: LIST [REPORT]
		do
			log.write_debug (generator + ".problem_reports_responsibles All Problem reports for responsibles users, filter by: page" + a_page_number.out + " rows_per_page:" + a_rows_per_page.out + " category:" + a_category.out + " priority:" + a_priority.out + " serverity:" + a_severity.out + " responsible:" + a_responsible.out +" status:" + a_status.out + " username:" + a_username)

			create {ARRAYED_LIST [REPORT]} l_list.make (0)
			-- data_provider.connect
			across data_provider.problem_reports_responsibles (a_page_number, a_rows_per_page, a_category, a_severity, a_priority, a_responsible, a_column, a_order, a_status, a_username, a_filter, a_content) as c loop
				l_list.force (c.item)
			end
			-- data_provider.disconnect
			Result := l_list
			post_data_provider_execution
		end

	problem_reports (a_page_number, a_rows_per_page: INTEGER_32; a_username: STRING_8;  a_category: INTEGER; a_status, a_column: READABLE_STRING_32; a_order: INTEGER_32; a_filter: READABLE_STRING_32; a_content: INTEGER): LIST[REPORT]
				-- Problem reports for user with username `a_username'
				-- Open reports only if `a_open_only', all reports otherwise.
		local
			l_list: LIST [REPORT]
		do
			create {ARRAYED_LIST [REPORT]} l_list.make (0)
			-- data_provider.connect
			across data_provider.problem_reports (a_page_number, a_rows_per_page, a_username, a_category, a_status, a_column, a_order, a_filter, a_content) as c loop
				l_list.force (c.item)
			end
			-- data_provider.disconnect
			Result := l_list
			post_data_provider_execution
		end


	problem_report_category_subscribers (a_category: READABLE_STRING_32): LIST [STRING]
			-- Possible list of subscriber to category `a_category'	
		do
			log.write_debug (generator+".status" )
			create {ARRAYED_LIST [STRING]} Result.make (0)
			Result.compare_objects
			across data_provider.problem_report_category_subscribers (a_category) as c loop
				Result.force (c.item)
			end
			post_data_provider_execution
		end

	status: LIST [REPORT_STATUS]
			-- Possible problem report status
		do
			log.write_debug (generator+".status" )
			create {ARRAYED_LIST [REPORT_STATUS]} Result.make (0)
			-- data_provider.connect
			across data_provider.status as c  loop
				Result.force (c.item)
			end
			-- data_provider.disconnect
			post_data_provider_execution
		end

	all_categories: LIST [REPORT_CATEGORY]
			-- Report Categories
		do
			log.write_debug (generator+".all_categories" )
			create {ARRAYED_LIST [REPORT_CATEGORY]} Result.make (0)
			-- data_provider.connect
			across data_provider.all_categories as c  loop Result.force (c.item) end
			-- data_provider.disconnect
			post_data_provider_execution
		end

	problem_report_details (a_username: READABLE_STRING_32; a_number: INTEGER): detachable REPORT
			-- Problem report details for user `a_user_name' (Interactions and Attachments)with number `a_number'.
		local
			l_interactions: LIST [REPORT_INTERACTION]
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
			post_data_provider_execution
		end

	problem_report_details_guest (a_number: INTEGER): detachable REPORT
			-- Problem report details for Guest user (Interactions and Attachments)with number `a_number'.
		local
			l_interactions: LIST [REPORT_INTERACTION]
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
			post_data_provider_execution
		end

	attachments_content (a_attachment_id: INTEGER): STRING
			-- Attachment content of attachment with ID `a_attachment_id'
		do
			log.write_debug (generator + ".attachments_content Attachment content of attachment with ID:" + a_attachment_id.out)
			Result := data_provider.attachments_content (a_attachment_id)
			post_data_provider_execution
		end

	user_role (a_username: STRING): USER_ROLE
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
			post_login_provider_execution
		end

	severities: LIST [REPORT_SEVERITY]
			-- Possible problem report severity
		local
			l_result: ARRAYED_LIST [REPORT_SEVERITY]
		do
			log.write_debug (generator + ".severities")
			create l_result.make (0)
				-- Put the items (rows) in the reverse order we retrieve from the database
				-- and we avoid to touch the database's sp.
				--! this new order will be from `Non-critical' to `Critical'
			across data_provider.severities as c loop l_result.put_front (c.item)  end
			Result := l_result
			post_data_provider_execution
		end


	classes: LIST [REPORT_CLASS]
			-- Possible problem report classes
		do
			log.write_debug (generator + ".classes")
			create {ARRAYED_LIST [REPORT_CLASS]}Result.make (0)
			-- data_provider.connect
			across data_provider.classes as c  loop Result.force (c.item)  end
			-- data_provider.disconnect
			post_data_provider_execution
		end

	priorities: LIST [REPORT_PRIORITY]
			-- Possible problem report priorities.
		local
			l_result: ARRAYED_LIST [REPORT_PRIORITY]
		do
			log.write_information (generator +".priorities")
			create l_result.make (0)
				-- Put the items (rows) in the reverse order we retrieve from the database
				-- and we avoid to touch the database's sp.
				--! this new order will be from `Low' to `High'
			across data_provider.priorities as c  loop l_result.put_front (c.item)  end
			Result := l_result
			post_data_provider_execution
		end

	countries: LIST [COUNTRY]
			-- List of countries.
		do
			log.write_information (generator +".countries")
			create {ARRAYED_LIST [COUNTRY]}Result.make (0)
			across login_provider.countries as c loop Result.force (c.item)  end
			post_data_provider_execution
		end

	temporary_problem_report (a_report_id: INTEGER): detachable TUPLE [synopsis: detachable STRING_32;
																		release: detachable STRING;
																		confidential: detachable STRING;
																		environment: detachable STRING;
																		description: detachable STRING_32;
																		toreproduce: detachable STRING_32;
																		priority_synopsis: detachable STRING_32;
																		category_synopsis: detachable STRING;
																		severity_synopsis: detachable STRING;
																		class_synopsis: detachable STRING;
																		user_name: detachable STRING;
																		responsible: detachable STRING]
				-- Temporary problem report `a_report_id', if any.
		do
			log.write_debug (generator + ".temporary_problem_report report_id:" + a_report_id.out)

			Result := data_provider.temporary_problem_report (a_report_id)
			post_data_provider_execution
		end

	role (a_username: READABLE_STRING_32): USER_ROLE
			-- Role associated with username `a_username'
		do
			log.write_debug (generator + ".role username:" + a_username)
			if attached login_provider.role (a_username) as l_role and then
			   attached login_provider.role_description (l_role) as l_description then
				create Result.make (l_role, l_description)
			else
				create Result.make ("Guest", "Anonymous Users")
			end
			post_login_provider_execution
		end

	responsibles: LIST [USER]
			-- Problem report responsibles
			-- Columns ContactID, Username, Name
		do
			log.write_debug (generator + ".responsibles")
			create {ARRAYED_LIST [USER]}Result.make (0)
			-- data_provider.connect
			across data_provider.responsibles as c loop Result.force (c.item)   end
			-- data_provider.disconnect
			post_data_provider_execution
		end

	security_questions: LIST [SECURITY_QUESTION]
			-- Security questions
		do
			log.write_debug (generator+".security_questions")
			create {ARRAYED_LIST [SECURITY_QUESTION]}Result.make (0)
			across login_provider.security_questions as c loop Result.force (c.item)  end
			post_login_provider_execution
		end

	temporary_interaction_2 (a_interaction_id: INTEGER): detachable TUPLE [content : detachable READABLE_STRING_32;
															   username: detachable READABLE_STRING_32;
															   status: detachable READABLE_STRING_32;
															   private: detachable READABLE_STRING_32;
															   category: detachable READABLE_STRING_32
															   ]
			-- Temporary problem report interaction
			--			Content,
			--			Username,
			--			Status,
			--			Private,
			-- 			Category	

		do
			log.write_debug (generator+".temporary_interaction interaction_id:" + a_interaction_id.out)
			Result := data_provider.temporary_interaction_2 (a_interaction_id)
			post_data_provider_execution
		end



	temporary_interaction_3 (a_interaction_id: INTEGER): detachable TUPLE [
															   status: INTEGER;
															   category: INTEGER
															   ]
			-- Temporary problem report interaction
			--			Status,
			-- 			Category	

		do
			log.write_debug (generator+".temporary_interaction interaction_id:" + a_interaction_id.out)
			Result := data_provider.temporary_interaction_3 (a_interaction_id)
			post_data_provider_execution
		end

	temporary_problem_report_attachments (a_report_id: INTEGER): LIST [ESA_FILE_VIEW]
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
			post_data_provider_execution
		end

	temporary_interation_attachments (a_interaction_id: INTEGER): LIST [ESA_FILE_VIEW]
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
			post_data_provider_execution
		end

	remove_all_temporary_report_attachments (a_report_id: INTEGER)
			-- Remove all temporary attachments used by temporary report `a_report_id'.
		do
			log.write_debug (generator+".remove_all_temporary_report_attachments report_id:" + a_report_id.out)
			data_provider.remove_all_temporary_report_attachments (a_report_id)
			post_data_provider_execution
		end

	remove_temporary_report_attachment (a_report_id: INTEGER; a_filename: STRING)
			-- Remove a temporary attachment `a_filename' for the report `a_report_id'
		do
			log.write_debug (generator+".remove_temporary_report_attachment report_id:" + a_report_id.out + " filename:" + a_filename)
			data_provider.remove_temporary_report_attachment (a_report_id, a_filename)
			post_data_provider_execution
		end

	remove_temporary_interaction_attachment (a_interaction_id: INTEGER; a_filename: STRING)
			-- Remove a temporary attachment `a_filename' for the interaction `a_interaction_id'
		do
			log.write_debug (generator+".remove_temporary_interaction_attachment interaction_id:" + a_interaction_id.out + " filename:" + a_filename)
			data_provider.remove_temporary_interaction_attachment (a_interaction_id, a_filename)
			post_data_provider_execution
		end

	remove_all_temporary_interaction_attachments (a_interaction_id: INTEGER)
			-- Remove all temporary attachments used by temporary interaction `a_interaction_id'.
		do
			log.write_debug (generator+".remove_all_temporary_interaction_attachments interaction_id:" + a_interaction_id.out)
			data_provider.remove_all_temporary_interaction_attachments (a_interaction_id)
			post_data_provider_execution
		end

	token_from_email (a_email: READABLE_STRING_32): detachable STRING
			-- Activation token for user with email `a_email' if any.
		do
			log.write_debug (generator+".token_from_email Activation token from user email:" + a_email)
			Result := login_provider.token_from_email (a_email)
			post_login_provider_execution
		end

	question_from_email (a_email: READABLE_STRING_8): detachable STRING_8
			-- Security question associated with account with email `a_email' if any
		do
			log.write_debug (generator+".question_from_email user email:" + a_email)
			Result := login_provider.question_from_email (a_email)
			post_login_provider_execution
		end

	user_from_email (a_email: READABLE_STRING_32): detachable TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]
			-- User with email `a_email' if any.
		do
			log.write_debug (generator+".user_from_email user email:" + a_email)
			Result := login_provider.user_from_email (a_email)
			post_login_provider_execution
		end

	user_account_information (a_username: READABLE_STRING_32): USER_INFORMATION
			-- User information for `a_username' if any.
		do
			Result := login_provider.user_information (a_username)
			post_login_provider_execution
		end

	subscribed_categories (a_username: STRING): LIST [ ESA_CATEGORY_SUBSCRIBER_VIEW ]
			-- Table associating each category with boolean value specifying whether responsible `a_username'
			-- is subscribed for receiving email notifications when reports or interactions are created in
			-- category
		local
			l_item: ESA_CATEGORY_SUBSCRIBER_VIEW
		do
			create  {ARRAYED_LIST [ESA_CATEGORY_SUBSCRIBER_VIEW]} Result.make (0)
			across data_provider.subscribed_categories (a_username) as c loop
					create l_item
					l_item.set_id (c.item.categoryId)
					l_item.set_synopsis (c.item.synopsis)
					l_item.set_subscribed (c.item.subscribed)
					Result.force (l_item)
			end
			post_data_provider_execution
		end

	interaction_content (a_id: INTEGER): STRING_32
				-- 	Retrieve the content given the id of the interaction
			do
				create Result.make_empty
				if attached data_provider.interaction_content (a_id) as l_result then
					Result := l_result
				end
				post_data_provider_execution
			end

	email_from_reset_password (a_token: READABLE_STRING_32): detachable STRING_32
			-- Retrieve user email using the generated token `a_token` from the
			-- reset password action.
		do
			log.write_debug (generator+".email_from_reset_password token:" + a_token)
			Result := login_provider.email_from_reset_password (a_token)
			post_login_provider_execution
		end

feature -- Basic Operations

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER; a_username: READABLE_STRING_32): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do
			log.write_debug (generator+".row_count_problem_report_guest filter by category:" + a_category.out + " status:" + a_status.out + " username:" + a_username)
			Result := data_provider.row_count_problem_report_guest (a_category, a_status, a_username)
			post_data_provider_execution
		end

	row_count_problem_reports (a_category: INTEGER; a_status: STRING; a_username: READABLE_STRING_32; a_filter: READABLE_STRING_32; a_content:INTEGER ): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do

			log.write_debug (generator+".row_count_problem_report_guest filter by category:" + a_category.out + " status:" + a_status.out + " username:" + a_username)
			Result := data_provider.row_count_problem_reports (a_category, a_status, a_username, a_filter, a_content)
			post_data_provider_execution
		end

	row_count_problem_report_responsible (a_category, a_severity, a_priority, a_responsible: INTEGER_32; a_status, a_username: READABLE_STRING_32; a_filter: detachable READABLE_STRING_32; a_content: INTEGER_32): INTEGER
			-- Number of problems reports for responsible users.
			-- With filters by category `a_category', severity 'a_severity', priority `a_priority', responsible `a_responsible',
			-- status `a_status' and submitter `a_submitter'
		do
			log.write_debug (generator+".row_count_problem_report_responsible filter by category:" + a_category.out + " severity:" + a_severity.out + " priority:" + a_priority.out + " status:" + a_status.out + " username:" + a_username)
			Result := data_provider.row_count_problem_report_responsible (a_category, a_severity, a_priority, a_responsible, a_status, a_username, a_filter, a_content)
			post_data_provider_execution
		end

	row_count_problem_report_user (a_username: READABLE_STRING_32;  a_category: INTEGER_32; a_status: READABLE_STRING_8; a_filter: READABLE_STRING_32; a_content: INTEGER): INTEGER
			-- Number of problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise, filetred by category and status
		do
			Result := data_provider.row_count_problem_report_user (a_username,a_category, a_status, a_filter, a_content)
			post_data_provider_execution
		end

	initialize_problem_report (a_report_id: INTEGER; a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential: READABLE_STRING_8
	; a_synopsis, a_release, a_environment, a_description, a_to_reproduce: READABLE_STRING_32)
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
			log.write_debug (generator+".initialize_problem_report report_id" + a_report_id.out + " priority_id:" + a_priority_id + " category_id:" + a_category_id + " class_id:" + a_class_id + " confidential:" + a_confidential + " synopsis:" + a_synopsis.out + " release:" + a_release + " environment:" + a_environment.out + " description:" + a_description.out + " to_reprodude:" + a_to_reproduce.out)
			data_provider.initialize_problem_report (a_report_id, a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential.to_string_32, a_synopsis, a_release, a_environment, a_description, a_to_reproduce)
			post_data_provider_execution
		end

	new_problem_report_id (a_username: READABLE_STRING_32): INTEGER
			-- Initialize new problem report row and returns ReportID.
		do
			log.write_debug (generator+".new_problem_report_id username" + a_username )
			Result := data_provider.new_problem_report_id (a_username)
			post_data_provider_execution
		end

	commit_problem_report (a_report_id: INTEGER)
			-- Commit a temporary problem report.
		do
				-- Should we return the last report number?
				-- CQS
			log.write_debug (generator+".commit_problem_report report_id" + a_report_id.out )
			data_provider.commit_problem_report (a_report_id)
			set_last_problem_report_number (data_provider.last_problem_report_number)
			post_data_provider_execution
		end

	remove_temporary_problem_report (a_report_id: INTEGER_32)
			-- Remove temporary problem report `a_report_id'
		do
			log.write_debug (generator+".remove_temporary_problem_report report_id" + a_report_id.out )
			data_provider.remove_temporary_problem_report (a_report_id)
			post_data_provider_execution
		end

	update_problem_report (a_pr: INTEGER; a_priority_id, a_severity_id, a_category_id, a_class_id, a_confidential: READABLE_STRING_8; a_synopsis,
			a_release, a_environment, a_description, a_to_reproduce: READABLE_STRING_32)
			-- Handle update report problem
		require
			attached_priority: a_priority_id /= Void
			valid_pr: a_pr > 0
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
			post_data_provider_execution
		end

	set_problem_report_responsible (a_number, a_contact_id: INTEGER_32)
			-- Assign responsible with id `a_contact_id' to problem report number `a_report_number'.
		do
			log.write_debug (generator + ".set_problem_report_responsible report_number:" + a_number.out + " contact_id:" + a_contact_id.out)
			data_provider.set_problem_report_responsible (a_number, a_contact_id)
			post_data_provider_execution
		end

	new_interaction_id (a_username: STRING; a_pr_number: INTEGER): INTEGER
			-- Id of added interaction by user `a_username' to interactions of pr with number `a_pr_number'.
		do
			log.write_debug (generator + ".new_interaction_id report_number:" + a_pr_number.out + " username:" + a_username)
			Result := data_provider.new_interaction_id (a_username, a_pr_number)
			post_data_provider_execution
		end

	initialize_interaction (a_interaction_id: INTEGER_32; a_category_id: INTEGER; a_content: STRING_32; a_new_status: INTEGER_32; a_private: BOOLEAN)
			-- Initialize temporary interaction `a_interaction_id' with content `a_content'.
		do
			log.write_debug (generator + ".initialize_interaction [Interaction_Id:" + a_interaction_id.out + ", content: " + a_content + ", new_status: " + a_new_status.out + ", private: "+ a_private.out)
			data_provider.initialize_interaction (a_interaction_id, a_category_id, a_content, a_new_status, a_private)
			post_data_provider_execution
		end

	commit_interaction (a_interaction_id: INTEGER)
			-- Commit temporary interaction report `a_report_id'.
		do
			log.write_debug (generator + ".commit_interaction Interaction_Id:" + a_interaction_id.out)
			data_provider.commit_interaction (a_interaction_id)
			set_last_interaction_id (data_provider.last_interaction_id)
			post_data_provider_execution
		end

	upload_temporary_report_attachment (a_report_id: INTEGER; a_file: ESA_FILE_VIEW)
			-- Upload attachment in temporary table for temporary report `a_report_id'
		do
			log.write_debug (generator + ".upload_temporary_report_attachment Report_id:" + a_report_id.out + " filename:" + a_file.name)
			data_provider.upload_temporary_report_attachment (a_report_id, a_file.size, a_file.name, a_file.content)
			post_data_provider_execution
		end

	upload_temporary_interaction_attachment	(a_interaction_id: INTEGER; a_file: ESA_FILE_VIEW)
			-- Upload attachment in temporary table for temporary interaction `a_interaction_id'
		do
			log.write_debug (generator + ".upload_temporary_interaction_attachment InteractionId:" + a_interaction_id.out + " filename:" + a_file.name)
			data_provider.upload_temporary_interaction_attachment (a_interaction_id, a_file.size, a_file.name, a_file.content)
			post_data_provider_execution
		end

	set_problem_report_category (a_number, a_category_id: INTEGER)
			-- Set category of problem report with number `a_number' to category with category ID `a_category_id'.	
		do
			data_provider.set_problem_report_category (a_number, a_category_id)
			post_data_provider_execution
		end


	set_problem_report_status (a_number, a_status_id: INTEGER)
			-- Set status of problem report with number `a_number' to status with status ID `a_status_id'.
		do
			data_provider.set_problem_report_status (a_number, a_status_id)
			post_data_provider_execution
		end

feature -- Element Settings

	add_user (a_first_name, a_last_name, a_email, a_username, a_password, a_answer, a_token: READABLE_STRING_32; a_question_id: INTEGER): BOOLEAN
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
				if data_provider.successful and then
				   attached login_provider.user_from_username (a_username) then
				   	Result := True
				else
					set_last_error_from_handler (data_provider.last_error)
				end
			else
					-- 	"Could not create user: Username/Email address already registered"
				log.write_alert (generator + ".add_user Could not create user: Username/Email address already registered" )
				set_last_error ("Could not create user: Username/Email address already registered", generator + ".add_user")
				Result := False
			end
		end

	user_from_username (a_username: READABLE_STRING_32): detachable USER
			-- User from username `a_username', if any.
		do
			log.write_debug (generator + ".user_from_username:" + a_username)
			Result := login_provider.user_from_username (a_username)
			post_login_provider_execution
		end

	remove_user (a_username: READABLE_STRING_32)
			-- Remove username `a_username' from database
		do
			log.write_debug (generator + ".remove_user username:" + a_username)
			login_provider.remove_user (a_username)
			post_login_provider_execution
		end

	update_password (a_email: STRING; a_password: STRING)
			-- Update password of user with email `a_email'.
		do
			log.write_debug (generator + ".update_password email:" + a_email)
			login_provider.update_password (a_email, a_password)
			post_login_provider_execution
		end

	update_personal_information (a_username: STRING; a_first_name, a_last_name, a_position, a_address, a_city, a_country, a_region, a_code, a_tel, a_fax: detachable STRING): BOOLEAN
			-- Update personal information of user with username `a_username'.
		do
			if login_provider.user_from_username (a_username) /= Void then
				login_provider.update_personal_information (a_username, a_first_name, a_last_name, a_position, a_address, a_city, a_country, a_region, a_code, a_tel, a_fax)
				if login_provider.successful then
				   	Result := True
				else
					set_last_error_from_handler (login_provider.last_error)
				end
			else
					-- 	"Could not update user: Username does not exist"
				log.write_alert (generator + ".update_personal_information Could not update user info: Username not registered" )
				set_last_error ("Could not update user info: Username not registered", generator + ".update_personal_information")
				Result := False
			end
		end

	change_user_email (a_user: READABLE_STRING_32; a_new_email: READABLE_STRING_32; a_token: READABLE_STRING_32)
			-- Change user email.
		do
			if login_provider.user_from_username (a_user) /= Void then
				login_provider.change_user_email (a_user, a_new_email, a_token)
				set_successful
			else
					-- 	"Could not update user: Username does not exist"
				log.write_alert (generator + ".update_personal_information Could not update user info: Username not registered" )
				set_last_error ("Username does not exist", generator + ".change_user_email")
			end
		end

	update_email_from_user_and_token (a_user: READABLE_STRING_32; a_token: READABLE_STRING_32)
		do
			login_provider.update_email_from_user_and_token (a_token, a_user)
			post_login_provider_execution
		end


	change_password (a_user: READABLE_STRING_32; a_email: READABLE_STRING_32; a_token: READABLE_STRING_32)
			-- Change user passord.
		do
			if login_provider.user_from_username (a_user) /= Void then
				login_provider.change_password (a_user, a_email, a_token)
				set_successful
			else
					-- 	"Could not update user: Username does not exist"
				log.write_alert (generator + ".change_password Could not update user password: Username not registered" )
				set_last_error ("Username does not exist", generator + ".change_password")
			end
		end

feature -- Access: Auth Session

	user_by_session_token (a_token: READABLE_STRING_8): detachable USER
			-- Retrieve user by token `a_token', if any.
		do
			log.write_debug (generator + ".user_by_session_token for a_token:" + a_token )
			if attached login_provider.user_by_session_token (a_token) as l_user then
				Result := l_user
			end
			post_login_provider_execution
		end

	has_user_token (a_user: USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		do
			log.write_debug (generator + ".has_user_token for user:" + a_user.name )
			Result := login_provider.has_user_token (a_user)
			post_login_provider_execution
		end

feature -- Change: Auth Session

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: USER; a_maxage: INTEGER)
			-- New user session for user `a_user' with token `a_token'.
		do
			log.write_debug (generator + ".new_user_session_auth for user:" + a_user.name )
			login_provider.new_user_session_auth (a_token, a_user, a_maxage)
			post_login_provider_execution
		end


	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: USER; a_maxage: INTEGER)
			-- Update user session for user `a_user' with token `a_token'.
		do
			log.write_debug (generator + ".update_user_session_auth for user:" + a_user.name )
			login_provider.update_user_session_auth (a_token, a_user, a_maxage)
			post_login_provider_execution
		end

feature -- Status Report

	is_active (a_username: READABLE_STRING_32): BOOLEAN
			-- Is membership for user with username `a_username' active?
		do
			log.write_debug (generator + ".is_active Is Membership for username:" + a_username + " active?")
			Result := login_provider.is_active (a_username)
			log.write_debug (generator + ".is_active Is Membership for username:" + a_username + " active?" + Result.out )
			post_login_provider_execution
		end

	login_valid (a_username: READABLE_STRING_32; a_password: READABLE_STRING_32): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		local
			l_sha_password: STRING
		do
			log.write_debug (generator + ".login_valid for username:" + a_username )
			if attached data_provider.user_password_salt (a_username) as l_hash and then
			   attached a_password then
				l_sha_password := (create {SECURITY_PROVIDER}).password_hash (a_password, l_hash)
				Result := login_provider.validate_login (a_username, l_sha_password)
			end
			post_login_provider_execution
		end

	user_login_valid (a_username: READABLE_STRING_32; a_password: READABLE_STRING_32): detachable USER
			-- Does account with username `a_username' and password `a_password' exist?
			-- if true return a User in other case Void.
		do
				-- Login with email
			if attached {TUPLE [first_name: STRING; last_name: STRING; user_name: STRING]} login_provider.user_from_email (a_username) as l_user_info then
				if login_valid (l_user_info.user_name, a_password) and then is_active (l_user_info.user_name) then
					Result := user_from_username (l_user_info.user_name)
				end
			else
				-- Login with username
				if login_valid (a_username, a_password) and then is_active (a_username) then
					Result := user_from_username (a_username)
				end
			end
		end

	is_report_visible_guest (a_report: INTEGER): BOOLEAN
			-- Can user `guest' see report number `a_number'?
		do
			log.write_debug (generator + ".is_report_visible_guest report:" + a_report.out)
			Result := data_provider.is_report_visible_guest (a_report)
			post_data_provider_execution
		end

	is_report_visible ( a_username: READABLE_STRING_32; a_number: INTEGER): BOOLEAN
			-- Can user `a_username' see report number `a_number'?
		do
			log.write_debug (generator + ".is_report_visible for username:" + a_username + " report:" + a_number.out )
			Result := data_provider.is_report_visible (a_username, a_number)
			post_data_provider_execution
		end

	is_interaction_visible (a_username: detachable READABLE_STRING_32; a_interaction_id: INTEGER): BOOLEAN
			-- Is a given interaction  `interaction_id' visible ?
			-- if the username is void means `Guest user'.
		do
			if attached a_username then
				log.write_debug (generator + ".is_interaction_visible for username:" + a_username + " interaction:" + a_interaction_id.out )
				Result := data_provider.interaction_visible (a_username, a_interaction_id)
				post_data_provider_execution
			else
				log.write_debug (generator + ".is_interaction_visible_guest for interaction:" + a_interaction_id.out )
				Result := data_provider.interaction_visible_guest (a_interaction_id)
				post_data_provider_execution
			end
		end

	is_attachment_visible (a_username: detachable READABLE_STRING_32; a_attachment_id: INTEGER): BOOLEAN
			-- Is a given attachement `a_attachment_id' visible?
			-- if the username is void it means 'Guest users'.
		do
			if attached a_username then
				log.write_debug (generator + ".is_attachment_visible for user:" + a_username + " attachment:" + a_attachment_id.out )
				Result := data_provider.attachment_visible (a_username, a_attachment_id)
				post_data_provider_execution
			else
				log.write_debug (generator + ".is_attachment_visible guest  attachmebt:" + a_attachment_id.out )
				Result := data_provider.attachment_visible_guest (a_attachment_id)
				post_data_provider_execution
			end
		end

	activation_valid (a_email, a_token: READABLE_STRING_32): BOOLEAN
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

	user_token_new_email (a_token: READABLE_STRING_32; a_user: READABLE_STRING_32): TUPLE [age:INTEGER; email:detachable STRING_32]
			-- A token `a_token' is valid if it exist for the given user `a_user' and is not expired (24 hours since his request).
		local
			l_age: INTEGER
		do
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

	last_problem_report_number: INTEGER
			-- last_problem_report_number created.

	last_interaction_id: INTEGER
			-- last_interaction_id created.		


	register_subscriber (a_user: STRING; a_categories: LIST [INTEGER])
			-- Subscribe responsible `a_user' to category with category ID in the list of categories'
		local
			l_categories: LIST [ESA_CATEGORY_SUBSCRIBER_VIEW]
			l_exist: BOOLEAN
		do
			l_categories := subscribed_categories (a_user)
			across a_categories as c  loop
				-- data_provider.connect
				data_provider.register_subscriber (a_user, c.item, True)
				-- data_provider.disconnect
			end

			across l_categories as nc loop
				if nc.item.subscribed then
					across a_categories as ec loop
						if ec.item = nc.item.id then
							l_exist := True
						end
					end
					if not l_exist then
						-- data_provider.connect
						data_provider.register_subscriber (a_user, nc.item.id, False)
						-- data_provider.disconnect
					end
					l_exist := False
				end
			end
			post_data_provider_execution
		end


	exist_report (a_report_number: INTEGER): BOOLEAN
			-- Exist a report with  number `a_report_number'?
		do
			Result := attached problem_report (a_report_number)
		end


feature -- Statistics

	update_statistics (a_statistics: REPORT_STATISTICS; a_status: REPORT_STATUS)
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


feature {NONE} -- Implementation

	set_last_problem_report_number (a_number: INTEGER)
			-- Set `last_problem_report_number' to `a_number'.
		do
			last_problem_report_number := a_number
		ensure
			set: last_problem_report_number = a_number
		end

	set_last_interaction_id (a_id: INTEGER)
			-- Set `last_interaction_id' to `a_id'.
		do
			last_interaction_id := a_id
		ensure
			set: last_interaction_id = a_id
		end


	post_data_provider_execution
		do
			if data_provider.successful then
				set_successful
			else
				if attached data_provider.last_error then
					set_last_error_from_handler (data_provider.last_error)
				end
			end
		end

	post_login_provider_execution
		do
			if login_provider.successful then
				set_successful
			else
				if attached login_provider.last_error then
					set_last_error_from_handler (login_provider.last_error)
				end
			end
		end

	data_provider: REPORT_DATA_PROVIDER
			-- Report Data provider

	login_provider: LOGIN_DATA_PROVIDER
			-- Login data provider
end
