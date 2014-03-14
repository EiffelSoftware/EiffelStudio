note
	description: "API Service facade to the underlying business logic"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_API_SERVICE

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
		end

	make_with_database (a_connection: ESA_DATABASE_CONNECTION)
			-- Create the API service
		require
			is_connected: a_connection.is_connected
		do
			create data_provider.make (a_connection)
			create login_provider.make (a_connection)
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
				if attached status_cache as l_cache and then attached l_report.status as ll_status then
					if attached l_cache.item (ll_status.id) as l_item then
						update_statistics (l_statistics, l_item)
						l_report.set_status (l_item)
					end
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
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
				if attached status_cache as l_cache and then attached l_report.status as ll_status then
					if attached l_cache.item (ll_status.id) as l_item then
						update_statistics (l_statistics, l_item)
						l_report.set_status (l_item)
					end
				end
				l_list.force (l_report)
			end
			data_provider.disconnect
			Result := [l_statistics, l_list]
		end

	status: LIST[ESA_REPORT_STATUS]
			-- Possible problem report status
		local
			l_report_status: ESA_REPORT_STATUS
		do
			if attached status_cache as l_cache then
				Result := l_cache.linear_representation
			else
				create {ARRAYED_LIST[ESA_REPORT_STATUS]} Result.make (0)
				create status_cache.make (4)
				data_provider.connect
				across data_provider.status as c  loop
						l_report_status := c.item
						Result.force (l_report_status)
						if attached status_cache as l_cache then
							l_cache.force (l_report_status,l_report_status.id)
						end
				end
				data_provider.disconnect
			end
		end

	all_categories: LIST[ESA_REPORT_CATEGORY]
			-- Report Categories
		do
			create {ARRAYED_LIST[ESA_REPORT_CATEGORY]} Result.make (0)
			data_provider.connect
			across data_provider.all_categories as c  loop Result.force (c.item) end
			data_provider.disconnect
		end

	problem_report (a_number: INTEGER): detachable ESA_REPORT
			-- Problem report with number `a_number'.
		local
			l_interactions: LIST[ESA_REPORT_INTERACTION]
			l_attachments: LIST [ESA_REPORT_ATTACHMENT]
		do
			if attached data_provider.problem_report (a_number) as l_report then
				l_interactions := data_provider.interactions_guest (a_number, l_report)
				l_report.set_interactions (l_interactions)
				across l_interactions as c loop
					l_attachments := data_provider.attachments_headers (c.item)
					c.item.set_attachments (l_attachments)
				end
				Result := l_report
			end
		end

	attachments_content (a_attachment_id: INTEGER): STRING
			-- Attachment content of attachment with ID `a_attachment_id'
		do
			Result := data_provider.attachments_content (a_attachment_id)
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
		end

	severities: LIST[ESA_REPORT_SEVERITY]
			-- Possible problem report severity
		do
			create {ARRAYED_LIST[ESA_REPORT_SEVERITY]}Result.make (0)
			data_provider.connect
			across data_provider.severities as c  loop Result.force (c.item)  end
			data_provider.disconnect
		end


	classes: LIST[ESA_REPORT_CLASS]
			-- Possible problem report classes
		do
			create {ARRAYED_LIST[ESA_REPORT_CLASS]}Result.make (0)
			data_provider.connect
			across data_provider.classes as c  loop Result.force (c.item)  end
			data_provider.disconnect
		end

	priorities: LIST[ESA_REPORT_PRIORITY]
			-- Possible problem report classes
		do
			create {ARRAYED_LIST[ESA_REPORT_PRIORITY]}Result.make (0)
			data_provider.connect
			across data_provider.priorities as c  loop Result.force (c.item)  end
			data_provider.disconnect
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
		end

feature -- Basic Operations

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do
			Result := data_provider.row_count_problem_report_guest (a_category, a_status)
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
		end

	new_problem_report_id (a_username: STRING): INTEGER
			-- Initialize new problem report row and returns ReportID.
		do
			Result := data_provider.new_problem_report_id (a_username)
		end

	commit_problem_report (a_report_id: INTEGER)
			-- Commit a temporary problem report.
		do
			data_provider.commit_problem_report (a_report_id)
		end

	remove_temporary_problem_report (a_report_id: INTEGER_32)
			-- Remove temporary problem report `a_report_id'
		do
			data_provider.remove_temporary_problem_report (a_report_id)
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
		end

feature -- Status Report

	is_active (a_username: STRING): BOOLEAN
			-- Is membership for user with username `a_username' active?
		do
			Result := login_provider.is_active (a_username)
		end

	login_valid (a_username: STRING; a_password: STRING): BOOLEAN
			-- Does account with username `a_username' and password `a_password' exist?
		local
			l_security: ESA_SECURITY_PROVIDER
			l_sha_password: STRING
		do
			if attached data_provider.user_password_salt (a_username) as l_hash and then
			   attached a_password as l_password then
				create l_security
				l_sha_password := l_security.password_hash (l_password, l_hash)
				Result := login_provider.validate_login (a_username, l_sha_password)
			end
		end


	is_report_visible_guest (a_report: INTEGER): BOOLEAN
			-- Can user `guest' see report number `a_number'?
		do
			Result := data_provider.report_visible_guest (a_report)
		end

feature -- Cache

	status_cache: detachable HASH_TABLE[ESA_REPORT_STATUS,INTEGER_32]
			-- Cache for Status


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

feature {NONE} -- Implementation

	data_provider: ESA_REPORT_DATA_PROVIDER
			-- Report Data provider

	login_provider: ESA_LOGIN_DATA_PROVIDER
			-- Login data provider
end
