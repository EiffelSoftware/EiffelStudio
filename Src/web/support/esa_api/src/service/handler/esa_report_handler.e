note
	description: "[
				{REPORT_HANDLER} it's in charge to retrieve reports for Guests and logged in users. 
				Logged-in Users ::= {USER, INTERNAL, RESPONSIBLE, ADMIN }
				Responsible userS will be able to update reports assigning a responsible to it.
				Logged-in User whose role is `User', will be able to read visible reports and his own reports
				Guest User will only see visible reports.
				Other features
				Allow filter reports, by severity, category, status, responsible, submitter.
				Sorting by report number, severirty, category, submissionDate, release, etc.

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_HANDLER

inherit

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_FILTER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using GET to retrieve resource information.
			-- If the GET request is SUCCESS, we response with
			-- 200 OK, and a representation of the root collection JSON
			-- If the GET request is not SUCCESS, we response with
			-- 404 Resource not found and their corresponding error in collection json
		local
			l_role: ESA_USER_ROLE
		do
			if attached current_user_name (req) as l_user then
				log.write_information ( generator+".do_get Processing request: user:" + l_user  )
				l_role := api_service.role (l_user)
				if l_role.is_user then
						-- List of reports visible for registered user.
						-- They are able to see his own reports and also visible reports.
					user_reports (req, res, l_user)
					log.write_information (generator+".do_get Executed List of reports for registered users" )
				elseif l_role.is_administrator or else l_role.is_responsible then
						-- List of reports visible for reponsible and admin users
					if
						attached {WSF_STRING} req.path_parameter ("id") as l_id and then
						l_id.is_integer
					then
						responsible_report_detail (req, res, l_id.integer_value)
					else
						responsible_reports (req, res)
					end
					log.write_information (generator+".do_get Executed List of reports for reponsible" )
				else
						-- Internal Users?
				end
			else
					-- List of reports visisble for Guest Users
				log.write_information (generator+".do_get ExecutList of reports visisble for Guest Users" )
				user_reports (req, res, "")
				log.write_information (generator+".do_get Executed List of reports visisble for Guest Users" )
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_role: ESA_USER_ROLE
		do
			log.write_information (generator+".do_post Processing request"  )
			if attached current_user_name (req) as l_user then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id and then
				   	l_id.is_integer and then attached extract_data_from_request(req, current_media_type (req)) as l_responsible and then
				   	l_responsible.is_integer then
				   	l_role := api_service.role (l_user)
					if l_role.is_administrator or else l_role.is_responsible then
						-- List of reports visible for reponsible and admin users
						api_service.set_problem_report_responsible (l_id.integer_value, l_responsible.to_integer)
						to_implement ("send_responsible_change_email (l_pr_number, l_new_responsible, authenticated_username)")
						update_report_responsible (req,res)
					else
					    ---	
					end
				else
					to_implement ("Unauthorized")
					-- Unauthorized
				end
			else
				to_implement ("Unauthorized")
				-- Unauthorized
			end
		end


feature -- Implementation

	responsible_reports (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- List of reports for users with role Admin or Responsible.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_pages: INTEGER
			l_row: TUPLE [ESA_REPORT_STATISTICS, LIST [ESA_REPORT]]
			l_report_view: ESA_REPORT_VIEW
			list_status: LIST [ESA_REPORT_STATUS]
			l_categories: LIST [ESA_REPORT_CATEGORY]
			l_priorities: LIST [ESA_REPORT_PRIORITY]
			l_severities: LIST [ESA_REPORT_SEVERITY]
			l_responsibles: LIST[ESA_USER]
			l_category: INTEGER
			l_severity: INTEGER
			l_priority: INTEGER
			l_responsible: INTEGER
			l_order_by: READABLE_STRING_32
			l_direction: READABLE_STRING_32
			l_dir: INTEGER
			l_submitter: READABLE_STRING_32
			l_status_selected: STRING
			l_page: INTEGER
			l_size: INTEGER
		do
			to_implement ("Clean, refactor too complex code!!!")
			create l_rhf
			if attached current_media_type (req) as l_type then
				l_categories := api_service.all_categories
				list_status := api_service.status
				l_responsibles := api_service.responsibles
				l_priorities := api_service.priorities
				l_severities := api_service.severities
				l_submitter := ""
					-- Hardcoded selected values
				l_status_selected := ""
				l_order_by := "number"
				l_direction := "ASC"
				l_dir := 0

					-- Page setup
				if attached {WSF_STRING} req.query_parameter ("page") as ll_page and then ll_page.is_integer then
					l_page := ll_page.integer_value
				else
					-- default page number 1
					l_page := 1
				end

					-- Page Size
				if attached {WSF_STRING} req.query_parameter ("size") as ll_size and then ll_size.is_integer then
					l_size := ll_size.integer_value
				else
					-- default page size is 10
					l_size := 10
				end

					-- Page query parameters
				if attached {WSF_STRING} req.query_parameter ("category") as ll_category and then
				   attached {WSF_STRING} req.query_parameter ("severity") as ll_severity and then
				   attached {WSF_STRING} req.query_parameter ("priority") as ll_priority and then
				   attached {WSF_STRING} req.query_parameter ("responsible") as ll_responsible and then
				   attached {WSF_STRING} req.query_parameter ("submitter") as ll_submitter and then
				   attached {WSF_MULTIPLE_STRING} req.query_parameter ("status") as ll_status and then
				   ll_category.is_integer and then ll_severity.is_integer and then
				   ll_priority.is_integer and then ll_responsible.is_integer then
				   l_category := ll_category.integer_value
				   l_severity := ll_severity.integer_value
				   l_priority := ll_priority.integer_value
				   l_responsible := ll_responsible.integer_value
				   l_submitter := ll_submitter.value
				   across ll_status.values as c loop
				   		if c.item.integer_value > 0 then
				   			set_selected_status (list_status, c.item.integer_value)
				   			l_status_selected.append_string (c.item.value)
				   			l_status_selected.append_character (',')
				   		end
				   end
				   if l_status_selected.is_empty then
				   		l_status_selected := "0"
				   else
				   		l_status_selected.remove_tail (1) -- remove the last ','
				   end
				else
						-- Default Setup
					to_implement ("Improve this code!!!")
					l_status_selected := "1,2,3,4"
					set_selected_status (list_status, 1)
					set_selected_status (list_status, 2)
					set_selected_status (list_status, 3)
					set_selected_status (list_status, 4)
				end
					-- Order By and Direction
				if attached {WSF_STRING} req.query_parameter ("orderBy") as l_orderby and then attached {WSF_STRING} req.query_parameter ("dir") as ll_dir then
					if not l_orderby.value.is_empty then
						l_order_by := l_orderby.value
					end
					if not ll_dir.value.is_empty then
						l_direction := ll_dir.value
						if ll_dir.value.same_string ("ASC") then
							l_dir := 1
						end
					end
				end
				l_pages := api_service.row_count_problem_report_responsible (l_category, l_severity, l_priority, l_responsible, l_status_selected, l_submitter)
				l_row :=  api_service.problem_reports_responsibles (l_page, l_size, l_category, l_severity,l_priority, l_responsible, l_order_by, l_dir, l_status_selected, l_submitter)
				create l_report_view.make (l_row, l_page, l_pages // l_size, l_categories, list_status, current_user_name (req))
				l_report_view.set_selected_category (l_category)
				l_report_view.set_selected_priority (l_priority)
				l_report_view.set_selected_severity (l_severity)
				l_report_view.set_selected_responsible (l_responsible)
				l_report_view.set_responsibles (l_responsibles)
				l_report_view.set_priorities (l_priorities)
				l_report_view.set_severities (l_severities)
				l_report_view.set_size (l_size)
				l_rhf.new_representation_handler (esa_config, l_type,  media_type_variants (req)).problem_reports_responsible (req, res, l_report_view)
			else
				l_rhf.new_representation_handler (esa_config, "",  media_type_variants (req)).problem_reports_responsible (req, res, Void)
			end
		end

	responsible_report_detail (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: INTEGER)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_report_view: ESA_REPORT_VIEW
			l_list: LIST[ESA_REPORT]
		do
			create l_rhf
			if
				attached current_media_type (req) as l_type and then
				attached current_user_name (req) as l_user
			then
				if attached api_service.problem_report_details (l_user, a_id) as l_report then
					create {ARRAYED_LIST[ESA_REPORT]} l_list.make (1)
					l_list.force (l_report)
					create l_report_view.make ([create {ESA_REPORT_STATISTICS},l_list],0,0, api_service.all_categories,api_service.status, l_user)
					l_report_view.set_id (a_id.out)
					l_report_view.set_responsibles (api_service.responsibles)
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_reports_responsible (req, res, l_report_view)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).not_found_page (req, res)
				end
			end
		end


	user_reports (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: READABLE_STRING_32)
			-- List of reports for a user `a_user' with role Guest or User
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_row: TUPLE [ESA_REPORT_STATISTICS, LIST [ESA_REPORT]]
			l_pages: INTEGER
			l_category: INTEGER
			l_status: INTEGER
			list_status: LIST [ESA_REPORT_STATUS]
			l_categories: LIST [ESA_REPORT_CATEGORY]
			l_report_view: ESA_REPORT_VIEW
			l_order_by: STRING
			l_direction: STRING
			l_dir: INTEGER
			l_page: INTEGER
			l_size: INTEGER
		do
			to_implement ("Validate request parameters!!!")
			--| At the moment the page size is hardcoded as 10 items per page.
			--| we can set a defaut and then let the user customize it, but it's not
			--| critical at the moment.
			log.write_information ( generator+".user_reports" )
			create l_rhf
			if attached current_media_type (req) as l_type then
				l_categories := api_service.all_categories
				list_status := api_service.status

					-- Page setup
				if attached {WSF_STRING} req.query_parameter ("page") as ll_page and then ll_page.is_integer then
					l_page := ll_page.integer_value
				else
						-- default page number 1
					l_page := 1
				end

						-- Page Size
				if attached {WSF_STRING} req.query_parameter ("size") as ll_size and then ll_size.is_integer then
					l_size := ll_size.integer_value
				else
						-- default page size is 10
					l_size := 10
				end

					-- Page query parameters
				if attached {WSF_STRING} req.query_parameter ("category") as ll_category and then attached {WSF_STRING} req.query_parameter ("status") as ll_status and then ll_category.is_integer and then ll_status.is_integer then
					l_category := ll_category.integer_value
					l_status := ll_status.integer_value
				else
					l_category := 0
					l_status := 0
				end
					-- Order by and Direction
				if attached {WSF_STRING} req.query_parameter ("orderBy") as l_orderby and then attached {WSF_STRING} req.query_parameter ("dir") as ll_dir then
					l_order_by := l_orderby.value
					l_direction := ll_dir.value
					if ll_dir.value.same_string ("ASC") then
						l_dir := 1
					end
				else
					l_order_by := "number"
					l_direction := "ASC"
					l_dir := 1
				end
				l_pages := api_service.row_count_problem_report_guest (l_category, l_status, a_user)
				l_row := api_service.problem_reports_guest_2 (l_page, l_size, l_category, l_status, l_order_by, l_dir)
				create l_report_view.make (l_row, l_page, l_pages // l_size, l_categories, list_status, current_user_name (req))
				l_report_view.set_size (l_size)
				l_report_view.set_selected_category (l_category)
				l_report_view.set_selected_status (l_status)
				l_report_view.set_order_by (l_order_by)
				l_report_view.set_direction (l_direction)
				l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_reports_guest (req, res, l_report_view)
				log.write_information (generator+".user_reports Executed reports guest" )
			else
				l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).problem_reports_guest (req, res, Void)
			end
		end


	update_report_responsible (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached {STRING_32} current_user_name (req) as l_user and then api_service.is_active (l_user) then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).update_report_responsible (req, res,build_redirect_uri (req, l_type))
				else
						-- The user is not active anymore, send response with an error.
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).update_report_responsible (req, res,build_redirect_uri (req, l_type))
				end
			else
				l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).update_report_responsible (req, res,build_redirect_uri (req, ""))
			end
		end

	set_selected_status (a_status: LIST[ESA_REPORT_STATUS]; a_selected_status:  INTEGER)
			-- Set the current selected status
		do
			across a_status as c  loop
				if c.item.id = a_selected_status then
					c.item.set_selected_id (a_selected_status)
				end
			end
		end

feature {NONE} --Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: detachable READABLE_STRING_32): detachable STRING
			-- Is the form data populated?
		do

			if a_type /= Void and then a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): detachable STRING
			-- Extract request form CJ data and build a object
			-- password view.
		local
			l_parser: JSON_PARSER
		do
			create l_parser.make_parser (retrieve_data (req))
			if attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY}l_template.item ("data") as l_data then
					--  <"name": "email", "prompt": "Password", "value": "{$form.email/}">,
				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("user_responsible") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result := l_value.item
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST): detachable STRING
			-- Extract request form data and build a object email view.
			-- email, check_email.
		do
			if attached {WSF_STRING}req.form_parameter ("user_responsible") as l_responsible then
				Result := l_responsible.value
			end
		end


	build_redirect_uri (req: WSF_REQUEST; a_type: STRING): STRING
					--	<input type="hidden" name="page" value="{$index/}"/>
					--  <input type="hidden" name="category" value="{$view.selected_category/}"/>
					--  <input type="hidden" name="severity" value="{$view.selected_severity/}"/>
					--  <input type="hidden" name="priority" value="{$view.selected_priority/}"/>
					--  <input type="hidden" name="responsible" value="{$view.selected_responsible/}"/>
					--  <input type="hidden" name="status_query" value="{$status_query/}"/>
					--  <input type="hidden" name="orderBy" value="{$view.orderBy/}"/>
					--  <input type="hidden" name="dir" value="{$view.dir/}"/>
		do
			if a_type.same_string ("application/vnd.collection+json") then
				Result := req.path_info
			else
				create Result.make_from_string ("/reports/")
				if attached {WSF_STRING} req.form_parameter ("page") as l_page then
					Result.append ("page=")
					Result.append_string (l_page.value)
					Result.append_string ("?")
				end
				if attached {WSF_STRING} req.form_parameter ("category") as l_category then
					Result.append_string ("category=")
					Result.append_string (l_category.value)
					Result.append_string ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("severity") as l_severity then
					Result.append_string ("severity=")
					Result.append_string (l_severity.value)
					Result.append_string ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("priority") as l_priority then
					Result.append_string ("priority=")
					Result.append_string (l_priority.value)
					Result.append_string ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("responsible") as l_responsible then
					Result.append_string ("responsible=")
					Result.append_string (l_responsible.value)
					Result.append_string ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("status_query") as l_status then
					Result.append_string (l_status.value)
				end
				if attached {WSF_STRING} req.form_parameter ("orderBy") as l_orderby then
					Result.append_string ("orderBy=")
					Result.append_string (l_orderBy.value)
					Result.append_string ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("dir") as l_dir then
					Result.append_string ("dir=")
					Result.append_string (l_dir.value)
				end
			end
		end

end
