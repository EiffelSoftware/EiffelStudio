note
	description: "API Service facade to the underlying business logic"
	date: "$Date$"
	revision: "$Revision$"

class
	API_SERVICE

create
	make

feature {NONE} -- Initialization

	make
			-- Create the API service
		do
			create data_provider.make
		end

feature -- Access

	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER): LIST[REPORT]
			-- All Problem reports for guest users, filter by page `a_page_numer' and rows per page `a_row_per_page'
			-- Only not confidential reports
		local
			l_data_value: ESA_DATA_VALUE
			l_status: LIST[REPORT_STATUS]
		do
			l_status := status
			data_provider.connect
			l_data_value := data_provider.problem_reports_guest (a_page_number, a_rows_per_page)


				-- Build List
			create {ARRAYED_LIST[REPORT]} Result.make (0)
			from
				l_data_value.start
			until
				l_data_value.after
			loop
				if attached l_data_value.item  then
					Result.force (new_report_guest (l_data_value))
				end
				l_data_value.forth
			end
			data_provider.disconnect
		end

	status: LIST[REPORT_STATUS]
			-- Possible problem report status
		local
			l_data_value: ESA_DATA_VALUE
			l_report_status: REPORT_STATUS
		do
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

	row_count_problem_report_guest: INTEGER
			-- Row count table `PROBLEM_REPORT table' for guest users
		do
			Result := data_provider.row_count_problem_report_guest
		end

feature -- Status Report


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


feature {NONE} -- Implementation

	data_provider: ESA_DATA_PROVIDER
			-- Data provider
end
