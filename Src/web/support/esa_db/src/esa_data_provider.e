note
	description: "Provides access to database tables via stored procedures calls"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATA_PROVIDER

create
	make

feature -- Initialization

	make
			-- Create a data provider
		do
			create {ESA_DATABASE_HANDLER_IMPL} db_handler.make_common
		end

	db_handler: ESA_DATABASE_HANDLER
		-- Db handler

feature -- Access

	problem_reports (a_username: STRING; a_open_only: BOOLEAN; a_category, a_status: INTEGER): LIST[REPORT]
			-- Problem reports for user with username `a_username'
			-- Open reports only if `a_open_only', all reports otherwise.
		require
			non_void_username: a_username /= Void
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
			l_report : REPORT
		do
			connect
			create l_parameters.make (4)
			l_parameters.put (a_username, {ESA_DATA_PARAMETERS_NAMES}.Username_param)
			l_parameters.put (a_open_only, {ESA_DATA_PARAMETERS_NAMES}.Openonly_param)
			l_parameters.put (a_category, {ESA_DATA_PARAMETERS_NAMES}.Categoryid_param)
			l_parameters.put (a_status, {ESA_DATA_PARAMETERS_NAMES}.Statusid_param)
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReports2", l_parameters))
			db_handler.execute_reader

			-- Build list
			create {ARRAYED_LIST[REPORT]} Result.make (0)
			from
				db_handler.start
			until
				db_handler.after
			loop
				if attached {DB_TUPLE} db_handler.item as l_item then
					Result.force (new_report (l_item))
				end

				db_handler.forth
			end
			disconnect
		end


	problem_reports_guest (a_page_number: INTEGER; a_rows_per_page: INTEGER): ESA_DATA_VALUE
			-- All Problem reports for guest users
			-- Only not confidential reports
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
			l_report : REPORT
		do
			create l_parameters.make (2)
			l_parameters.put (a_rows_per_page, "RowsPerPage")
			l_parameters.put (a_page_number, "PageNumber")
			db_handler.set_store (create {ESA_DATABASE_STORE_PROCEDURE}.data_reader ("GetProblemReportsGuest", l_parameters))
			db_handler.execute_reader
			create Result.make (db_handler)
		end


	problem_report (a_number: INTEGER): detachable REPORT
			-- Problem report with number `a_number'.
		local
			l_parameters: HASH_TABLE[ANY,STRING_32]
			l_res: INTEGER
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
		local
			l_number: INTEGER
			l_synopsis: STRING_8
			l_status: INTEGER
			l_date: DATE_TIME
		do
			create Result.make (-1, "Null", False)
			if attached {INTEGER_32_REF} a_tuple.item (1) as l_item_1 then
					Result.set_number (l_item_1.item)
			end
			if attached {STRING} a_tuple.item (2) as  l_item_2 then
				Result.set_synopsis (l_item_2)
			end
			if attached {STRING} a_tuple.item (3) as  l_item_3 then
				Result.set_report_category (create {REPORT_CATEGORY}.make (-1,l_item_3, True))
			end
			if attached {DATE_TIME} a_tuple.item (4) as  l_item_4 then
				Result.set_submission_date (l_item_4)
			end

			if attached {INTEGER_32_REF} a_tuple.item (5) as  l_item_5 then
				Result.set_status (create {REPORT_STATUS}.make (l_item_5.item,""))
			end
		end

	new_report_detail (a_tuple: DB_TUPLE): REPORT
		local
			l_number: INTEGER
			l_synopsis: STRING_8
			l_status: INTEGER
			l_date: DATE_TIME
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
		local
			l_number: INTEGER
			l_synopsis: STRING_8
			l_status: INTEGER
			l_date: DATE_TIME
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
			l_number: INTEGER
			l_synopsis: STRING_8
			l_status: INTEGER
			l_date: DATE_TIME
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
