note
	description: "[
		DB problem report persistence
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_PROBLEM_REPORT_PERSISTENCE

inherit
	PROBLEM_REPORT_PERSISTENCE
	DATABASE_APPL [ODBC]

create
	make

feature -- Initialization

	make
		do
			is_connected := False
			if not open then
				print ("UIUIUIUI")
			end
		end

feature {NONE} -- Access

	host: STRING is "localhost"
	datasource: STRING is "mysql_support_super"
	database: STRING is "eiffeldb_dbo"
	username: STRING is "support"
	password: STRING is "support"

	session_control: DB_CONTROL
	base_update: DB_CHANGE
	base_selection: DB_SELECTION
	--repository: DB_REPOSITORY
	--storage: DB_STORE

	is_connected: BOOLEAN

feature -- Basic database operations

	open: BOOLEAN is
			-- <Precursor>
			-- Opens a connection to the database
		do
			set_data_source(datasource)

			-- Set user's name and password
			login (username, password)

			-- Initialization of the Relational Database:
			-- This will set various informations to perform a correct
			-- Connection to the Relational database
			set_base

			-- Create usefull classes
			-- 'session_control' provides informations control access and
			--  the status of the database.
			-- 'base_selection' provides a SELECT query mechanism.
			-- 'base_update' provides updating facilities.
			create session_control.make
			create base_selection.make
			create base_update.make

			-- Start session
			if not session_control.is_connected then
				session_control.connect
			end


			if  session_control.is_connected then
				Result := True
			else
					-- Something went wrong, and the connection failed
				session_control.raise_error
				Result := False
			end

			is_connected := Result
		end

	close is
			-- Terminate session
		do
			session_control.disconnect
			is_connected := False
		end

	query_not_evil (msg: STRING): BOOLEAN is
			-- Checks if msg contains harmful sql-keywords
		require
			msg_not_Void: msg /= Void
		local
			ok: BOOLEAN
		do
			ok := True

			if msg.as_lower.has_substring ("select") then
				ok := False
			end

			if msg.as_lower.has_substring (";") then
				ok := False
			end

			if msg.as_lower.has_substring ("insert") then
				ok :=  False
			end

			if msg.as_lower.has_substring ("alter") then
				ok :=  False
			end

			if msg.as_lower.has_substring ("*") then
				ok :=  False
			end

			if msg.as_lower.has_substring ("delete") then
				ok := False
			end

			if msg.as_lower.has_substring ("table") then
				ok :=  False
			end

			Result := ok
		end

	reset is
				-- Resets the db
			do
				session_control.reset
				if session_control.is_connected then
					create base_update.make
					base_update.modify ("TRUNCATE TABLE `user`")
					base_update.modify ("TRUNCATE TABLE `user_advicecategory`")
					base_update.modify ("TRUNCATE TABLE `advice`")
					base_update.modify ("TRUNCATE TABLE `advicemedia`")
					base_update.modify ("TRUNCATE TABLE `advice_advicecategory`")
					base_update.modify ("TRUNCATE TABLE `advice_advicemedia`")

				end
			end

feature -- Problem report specific data manipulation

	save_new_problem_report (a_report: PROBLEM_REPORT_BEAN)
			-- Saves a new bug report
		do

		end

	try_select (a_query: STRING): LIST [DB_RESULT]
			-- Tries to select
		require
			a_query_attached: attached a_query
		local
			temp_advice_list: ARRAYED_LIST [STRING]
			advice_filling: DB_ACTION [STRING]
			l_db_advice: STRING
			l_container: ARRAYED_LIST [DB_RESULT]
		do
			create {ARRAYED_LIST [DB_RESULT]} Result.make (0)
			session_control.reset
			if session_control.is_connected then
				create l_db_advice.make_empty
				create base_selection.make
				--base_selection.object_convert (l_db_advice)

				create advice_filling.make (base_selection, l_db_advice)

				--base_selection.set_action (advice_filling)
				create l_container.make (10)
				base_selection.set_container (l_container)
				base_selection.query (a_query)

				if session_control.is_ok then
					base_selection.load_result
				else
				--	create {BTW_ERROR_D_CONTROL [LINKED_LIST [PROBLEM_REPORT_BEAN]]} Result.make_with_sql_error (session_control.error_message)
				end

				if base_selection.is_ok then
					Result := l_container
				else
				 --	Result := create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_ADVICE]]}.make (Void,True)
				end

				base_selection.terminate

			else
			--	Result := create {BTW_ERROR_D_NOT_CONNECTED [LINKED_LIST [BTW_ADVICE]]}.make (Void, True)
			end
		end

	load_skeleton_problem_reports (a_query: PROBLEM_REPORT_QUERY): TUPLE [list: LIST [PROBLEM_REPORT_BEAN]; row_count: INTEGER]
			-- Retrieves all bug reports
		local
			l_select_statement: STRING
			l_tuple: DB_TUPLE
			l_count: INTEGER
			l_result: LIST [PROBLEM_REPORT_BEAN]
			l_count_result: LIST [STRING]
		do
			l_select_statement := generate_sql_statement_for_problem_reports (a_query)
			create {ARRAYED_LIST [PROBLEM_REPORT_BEAN]} l_result.make (2)
			if attached {ARRAYED_LIST [DB_RESULT]} try_select (l_select_statement) as l_res then
				from
					l_res.start

				until
					l_res.after
				loop
					if attached l_res.item as ll_res then
						create l_tuple.copy (ll_res)
						l_result.extend (convert_to_problem_report_bean (l_tuple))
					end
					l_res.forth
				end
			end
				-- Also load the number of actual entries
			if attached {ARRAYED_LIST [DB_RESULT]} try_select ("select found_rows()") as l_res then
				if attached l_res.first as ll_res then
					create l_tuple.copy (ll_res)
					if attached l_tuple.item (1) as l_first_tuple_item then
						l_count := l_first_tuple_item.out.to_integer_32
					end
				end
			end
			Result := [l_result, l_count]
		end

	generate_sql_statement_for_problem_reports (a_query: PROBLEM_REPORT_QUERY): STRING
		do
			Result := "[
select 
	SQL_CALC_FOUND_ROWS Number, Synopsis, SFIrstName, SLastName, PRelease, 
	SubmissionDate, RFirstName, RLastName, StatusSynopsis, SeveritySynopsis, PrioritySynopsis, CategorySynopsis 
from
	(select
		SeverityID, StatusID, PriorityID, CategoryID, Number, Synopsis,
		SFirstName, SLastName, PRelease, SubmissionDate, c2.FirstName as RFirstName, c2.LastName as RLastName 
	from
		((select 
			ReportID, SeverityID, StatusID, PriorityID, CategoryID, Number,
			Synopsis, SubmissionDate, c1.FirstName as SFirstName, c1.LastName as SLastName, p1.Release as PRelease
		from 
			problemreports p1 join contacts c1 on (c1.ContactID = p1.ContactID
]"
		if not a_query.submitter.is_empty then
				Result := Result + " AND CONCAT_WS(' ', c1.FirstName, c1.LastName) LIKE '%%" + a_query.submitter + "%%'"
			end
		Result := Result +
"[
)) p2
		left join 
			(problemreportresponsibles pr1 join contacts c2 on (c2.ContactID = pr1.ResponsibleID
]"
			if not a_query.responsible.is_empty then
				Result := Result + " AND CONCAT_WS(' ', c2.FirstName, c2.LastName) LIKE '%%" + a_query.responsible + "%%'"
			end
			Result := Result + "[
)) on pr1.ReportID=p2.ReportID
)
order by Number asc) t1
join problemreportstatus pstat1 on (pstat1.StatusID=t1.StatusID)
join problemreportseverities psev1 on psev1.SeverityID=t1.SeverityID
]"
		if not a_query.severity.is_empty then
			Result := Result + " and psev1.SeveritySynopsis LIKE '%%" + a_query.severity + "%%'"
		end
		Result := Result +
"[
join problemreportpriorities pprio1 on (pprio1.PriorityID=t1.PriorityID
]"
		if not a_query.priority.is_empty then
			Result := Result + " and pprio1.PrioritySynopsis LIKE '%%" + a_query.priority + "%%'"
		end
		Result := Result +
"[
) join problemreportcategories pcat1 on (pcat1.CategoryID=t1.CategoryID
]"
		if not a_query.category.is_empty then
			Result := Result + " and pcat1.CategorySynopsis LIKE '%%" + a_query.category + "%%'"
		end
		Result := Result  + "%N )limit " + a_query.page_size
			print (Result + "%N")
		end

	convert_to_problem_report_bean (l_tuple: DB_TUPLE): PROBLEM_REPORT_BEAN
			-- Converts a tuple to a problem report bean
		require
			l_tuple_attached: attached l_tuple
		local
			l_tmp: STRING
		do
			create Result.make
			if attached l_tuple.item (1) as l_number then
				Result.number := l_number.out
			end
			if attached l_tuple.item (2) as l_synopsis then
				Result.set_synopsis (l_synopsis.out)
			end
			if attached l_tuple.item (3) as l_s_first_name then
				if attached l_tuple.item (4) as l_s_last_name then
					Result.set_submitter (l_s_first_name.out + " " + l_s_last_name.out)
				end
			end
			if attached l_tuple.item (5) as l_release then
				Result.set_release (l_release.out)
			end
			if attached l_tuple.item (6) as l_submission_date then
				Result.set_date (l_submission_date.out)
			end
			if attached l_tuple.item (7) as l_r_first_name then
				if attached l_tuple.item (8) as l_r_last_name then

				end
			end
			if attached l_tuple.item (9) as l_status then
				l_tmp := l_status.out.as_lower
				l_tmp.replace_substring_all ("-", "_")
				Result.set_status ("status_" + l_tmp)
			end
			if attached l_tuple.item (10) as l_severity then
				l_tmp := l_severity.out.as_lower
				l_tmp.replace_substring_all ("-", "_")
				Result.set_severity ("severity_" + l_tmp)
			end
			if attached l_tuple.item (11) as l_priority then
				l_tmp := l_priority.out.as_lower
				l_tmp.replace_substring_all ("-", "_")
				Result.set_priority ("priority_" + l_tmp)
			end
			if attached l_tuple.item (12) as l_category then
				Result.set_category (l_category.out)
			end
		end

	classes: LIST [STRING]
			-- Get all the available classes
		local
			l_tuple: DB_TUPLE
		do
			if attached {ARRAYED_LIST [DB_RESULT]} try_select ("select ClassSynopsis from problemreportclasses") as res then
				create {ARRAYED_LIST [STRING]} Result.make (10)
				from
					res.start
				until
					res.after
				loop
					if attached res.item as l_res then
						create l_tuple.copy (l_res)
						if attached l_tuple.item (1) as l_first_tuple_item then
							Result.extend (l_first_tuple_item.out)
						end
					end
					res.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (2)
			end
		end

	priorities: LIST [STRING]
			-- Get the available priorities
		local
			l_tuple: DB_TUPLE
		do
			if attached {ARRAYED_LIST [DB_RESULT]} try_select ("select PrioritySynopsis from problemreportpriorities") as res then
				create {ARRAYED_LIST [STRING]} Result.make (10)
				from
					res.start
				until
					res.after
				loop
					if attached res.item as l_res then
						create l_tuple.copy (l_res)
						if attached l_tuple.item (1) as l_first_tuple_item then
							Result.extend (l_first_tuple_item.out)
						end
					end
					res.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (2)
			end
		end

	severities: LIST [STRING]
		-- Get the available priorities
		local
			l_tuple: DB_TUPLE
		do
			if attached {ARRAYED_LIST [DB_RESULT]} try_select ("select SeveritySynopsis from problemreportseverities") as res then
				create {ARRAYED_LIST [STRING]} Result.make (10)
				from
					res.start
				until
					res.after
				loop
					if attached res.item as l_res then
						create l_tuple.copy (l_res)
						if attached l_tuple.item (1) as l_first_tuple_item then
							Result.extend (l_first_tuple_item.out)
						end
					end
					res.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (3)
			end
		end

	categories: LIST [STRING]
		-- Get the available priorities
		local
			l_tuple: DB_TUPLE
		do
			if attached {ARRAYED_LIST [DB_RESULT]} try_select ("select CategorySynopsis from problemreportcategories") as res then
				create {ARRAYED_LIST [STRING]} Result.make (10)
				from
					res.start
				until
					res.after
				loop
					if attached res.item as l_res then
						create l_tuple.copy (l_res)
						if attached l_tuple.item (1) as l_first_tuple_item then
							Result.extend (l_first_tuple_item.out)
						end
					end
					res.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
			end
		end

	responsibles: LIST [STRING]
		-- Get the available priorities
		local
			l_tuple: DB_TUPLE
		do
			if attached {ARRAYED_LIST [DB_RESULT]} try_select ("select FirstName, LastName from contacts limit 20") as res then
				create {ARRAYED_LIST [STRING]} Result.make (10)
				from
					res.start
				until
					res.after
				loop
					if attached res.item as l_res then
						create l_tuple.copy (l_res)
						if attached l_tuple.item (1) as l_first_tuple_item then
							Result.extend (l_first_tuple_item.out)
						end
					end
					res.forth
				end
			else
				create {ARRAYED_LIST [STRING]} Result.make (3)
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
