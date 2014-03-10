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

	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: INTEGER): TUPLE[REPORT_STATISTICS,LIST[REPORT]]
			-- All Problem reports for guest users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- Only not confidential reports
		local
			l_data_value: ESA_DATA_VALUE
			l_status: LIST[REPORT_STATUS]
			l_report: REPORT
			l_list: LIST[REPORT]
			l_statistics: REPORT_STATISTICS
		do
			l_status := status

			data_provider.connect
			create {ARRAYED_LIST[REPORT]} l_list.make (0)
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

	problem_reports (a_username: STRING; a_open_only: BOOLEAN; a_category, a_status: INTEGER): TUPLE[REPORT_STATISTICS,LIST[REPORT]]
			-- Problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise.
		local
			l_status: LIST[REPORT_STATUS]
			l_report: REPORT
			l_list: LIST[REPORT]
			l_statistics: REPORT_STATISTICS
		do
			l_status := status
			create {ARRAYED_LIST[REPORT]} l_list.make (0)
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

	status: LIST[REPORT_STATUS]
			-- Possible problem report status
		local
			l_data_value: ESA_DATA_VALUE
			l_report_status: REPORT_STATUS
		do
			if attached status_cache as l_cache then
				Result := l_cache.linear_representation
			else
				create {ARRAYED_LIST[REPORT_STATUS]} Result.make (0)
				create status_cache.make (4)
				data_provider.connect
				l_data_value := data_provider.status

					--Build List
				from
					l_data_value.start
				until
					l_data_value.after
				loop
					if attached l_data_value.item  then
						l_report_status := new_report_status (l_data_value)
						Result.force (l_report_status)
						if attached status_cache as l_cache then
							l_cache.force (l_report_status,l_report_status.id)
						end
					end
					l_data_value.forth
				end
				data_provider.disconnect
			end
		end

	all_categories: LIST[REPORT_CATEGORY]
			-- Report Categories
		do
			create {ARRAYED_LIST[REPORT_CATEGORY]} Result.make (0)
			data_provider.connect
			across data_provider.all_categories as c  loop Result.force (c.item) end
			data_provider.disconnect
		end

	problem_report (a_number: INTEGER): detachable REPORT
			-- Problem report with number `a_number'.
		local
			l_interactions: LIST[REPORT_INTERACTION]
			l_attachments: LIST [REPORT_ATTACHMENT]
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

feature -- Basic Operations

	row_count_problem_report_guest (a_category: INTEGER; a_status: INTEGER): INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do
			Result := data_provider.row_count_problem_report_guest (a_category, a_status)
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

	status_cache: detachable HASH_TABLE[REPORT_STATUS,INTEGER_32]
			-- Cache for Status

feature {NONE} -- Factories

	new_report_guest (a_data_value: ESA_DATA_VALUE): REPORT
			-- New `Report' guest users
		do
			create Result.make (-1, "", False)
			Result.set_number (a_data_value.read_integer_32 (1))
			if attached a_data_value.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
			if attached a_data_value.read_string (3)as l_category  then
				Result.set_report_category (create {REPORT_CATEGORY}.make (-1,l_category, True))
			end
			Result.set_submission_date (a_data_value.read_date_time (4))
			if attached a_data_value.read_integer_32 (5) as l_status then
				if attached status_cache as l_cache and then attached l_cache.item (l_status) as ll_status then
					Result.set_status (ll_status)
				else
					Result.set_status (create {REPORT_STATUS}.make (l_status,""))
				end
			end
		end


	new_report_status (a_data_value: ESA_DATA_VALUE): REPORT_STATUS
			-- New `Report Status'
		do
			create Result.make (-1, "")
			Result.set_id (a_data_value.read_integer_32 (1))
			if attached a_data_value.read_string (2) as l_synopsis then
				Result.set_synopsis (l_synopsis)
			end
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

	data_provider: ESA_REPORT_DATA_PROVIDER
			-- Report Data provider

	login_provider: ESA_LOGIN_DATA_PROVIDER
			-- Login data provider
end
