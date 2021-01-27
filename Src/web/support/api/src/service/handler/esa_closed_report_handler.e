note
	description: "[
		{ESA_CLOSED_REPORT_HANDLER} it's in charge to retrieve the latest closed and won't fix reports for Guests and logged in users.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CLOSED_REPORT_HANDLER

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

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_role: USER_ROLE
		do
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
				debug
					log.write_information (generator + ".do_get Processing request: user:" + l_user.to_string_8)
				end
				l_role := api_service.role (l_user)
				if l_role.is_user then
						-- List of reports visible for registered user.
						-- They are able to see his own reports and also visible reports.
					user_reports (req, res, l_user)
					debug
						log.write_information (generator + ".do_get Executed List of reports for registered users")
					end
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
					debug
						log.write_information (generator + ".do_get Executed List of reports for reponsible")
					end
				else
						-- Internal Users?
				end
			else
					-- List of reports visisble for Guest Users
				user_reports (req, res, Empty_string)
			end
		end

feature -- Implementation

	responsible_reports (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- List of reports for users with role Admin or Responsible.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_pages: INTEGER
			l_row: LIST [REPORT]
			l_report_view: ESA_REPORT_VIEW
			list_status: LIST [REPORT_STATUS]
			l_categories: LIST [REPORT_CATEGORY]
			l_priorities: LIST [REPORT_PRIORITY]
			l_severities: LIST [REPORT_SEVERITY]
			l_responsibles: LIST [USER]
			l_input_validator: ESA_RESPONSIBLE_REPORT_INPUT_VALIDATOR
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				create l_input_validator
				l_input_validator.input_from (req.query_parameters)

				if not l_input_validator.has_error then
					l_categories := api_service.all_categories
					list_status := api_service.status
					l_responsibles := api_service.responsibles
					l_priorities := api_service.priorities
					l_severities := api_service.severities

					l_pages := api_service.row_count_problem_report_responsible_closed

						-- Check if the query parameter page has a value less than or equal the the number of existing pages for the current request, if not, we set it as a default value=1
					if l_input_validator.page > (l_pages // l_input_validator.size) + 1 then
						l_input_validator.set_page (1)
					end

					l_row := api_service.problem_reports_responsibles_closed (l_input_validator.page, l_input_validator.size)

					create l_report_view.make (l_row, l_input_validator.page, l_pages // l_input_validator.size, l_categories, list_status, current_user_name (req), l_pages)
					l_report_view.set_selected_category (l_input_validator.category)
					l_report_view.set_selected_priority (l_input_validator.priority)
					l_report_view.set_selected_severity (l_input_validator.severity)
					l_report_view.set_selected_responsible (l_input_validator.responsible)
					l_report_view.set_responsibles (l_responsibles)
					l_report_view.set_priorities (l_priorities)
					l_report_view.set_severities (l_severities)
					l_report_view.set_size (l_input_validator.size)
					l_report_view.set_submitter (l_input_validator.submitter)
					l_report_view.set_order_by (l_input_validator.orderBy)
					l_report_view.set_filter (l_input_validator.filter)
					l_report_view.set_filter_content (l_input_validator.filter_content)
					l_report_view.set_direction (l_input_validator.direction)
					mark_selected_status (list_status, l_input_validator.status)

					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_reports_responsible_closed (req, res, l_report_view)
				else
						-- Bad request
					log.write_error (generator + ".responsible_reports " + l_input_validator.error_message)
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_with_errors_page (req, res, l_input_validator.errors)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).problem_reports_responsible_closed (req, res, Void)
			end
		end

	responsible_report_detail (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: INTEGER)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_report_view: ESA_REPORT_VIEW
			l_list: LIST [REPORT]
		do
			create l_rhf
			if
				attached current_media_type (req) as l_type and then
				attached current_user_name (req) as l_user
			then
				if attached api_service.problem_report_details (l_user, a_id) as l_report then
					create {ARRAYED_LIST [REPORT]} l_list.make (1)
					l_list.force (l_report)
					create l_report_view.make (l_list, 0, 0, api_service.all_categories, api_service.status, l_user, 0)
					l_report_view.set_id (a_id.out)
					l_report_view.set_responsibles (api_service.responsibles)
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_reports_responsible (req, res, l_report_view)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).not_found_page (req, res)
				end
			end
		end

	user_reports (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: READABLE_STRING_32)
			-- List of reports for a user `a_user' with role Guest or User.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_row: LIST [REPORT]
			l_pages: INTEGER
			list_status: LIST [REPORT_STATUS]
			l_categories: LIST [REPORT_CATEGORY]
			l_report_view: ESA_REPORT_VIEW
			l_input_validator: ESA_REPORT_INPUT_VALIDATOR
		do
			to_implement ("Validate request parameters!!!")
				--| At the moment the page size is hardcoded as 10 items per page.
				--| we can set a defaut and then let the user customize it, but it's not
				--| critical at the moment.
			debug
				log.write_information (generator + ".user_reports")
			end
			create l_rhf
			if attached current_media_type (req) as l_type then
				create l_input_validator
					-- Closed and Won't Fix.
				l_categories := api_service.all_categories
				list_status := api_service.status

				l_pages := api_service.row_count_problem_reports_closed (a_user, l_input_validator.filter)

					-- Check if the query parameter page has a value less than or equal the the number of existing pages for the current request, if not, we set it as a default value=1
				if l_input_validator.page > (l_pages // l_input_validator.size) + 1 then
					l_input_validator.set_page (1)
				end

				l_row := api_service.problem_reports_closed_guest (l_input_validator.page, l_input_validator.size, l_input_validator.orderby, l_input_validator.dir_selected, a_user, l_input_validator.filter)
				create l_report_view.make (l_row, l_input_validator.page, l_pages // l_input_validator.size, l_categories, list_status, current_user_name (req), l_pages)
				l_report_view.set_size (l_input_validator.size)
				l_report_view.set_selected_category (l_input_validator.category)
				l_report_view.set_order_by (l_input_validator.orderby)
				l_report_view.set_direction (l_input_validator.direction)
				l_report_view.set_filter (l_input_validator.filter)
				l_report_view.set_filter_content (l_input_validator.filter_content)
				mark_selected_status (list_status, l_input_validator.status)

				l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_closed_reports_guest (req, res, l_report_view)
				debug
					log.write_information (generator + ".user_reports Executed reports guest")
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).problem_closed_reports_guest (req, res, Void)
			end
		end

	update_report_responsible (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached {READABLE_STRING_32} current_user_name (req) as l_user and then api_service.is_active (l_user) then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).update_report_responsible (req, res, build_redirect_uri (req, l_type))
				else
						-- The user is not active anymore, send response with an error.
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).update_report_responsible (req, res, build_redirect_uri (req, l_type))
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).update_report_responsible (req, res, build_redirect_uri (req, ""))
			end
		end

	set_selected_status (a_status: LIST [REPORT_STATUS]; a_selected_status: INTEGER)
			-- Set the current selected status
		do
			across a_status as c loop
				if c.item.id = a_selected_status then
					c.item.set_selected_id (a_selected_status)
				end
			end
		end

	mark_selected_status (a_status: LIST [REPORT_STATUS]; a_status_selected: LIST [INTEGER])
			-- Set the current selected status
		do
			across a_status_selected as c loop
				set_selected_status (a_status, c.item)
			end
		end

feature {NONE} --Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: detachable READABLE_STRING_8): detachable STRING_32
			-- Is the form data populated?
		do

			if a_type /= Void and then a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result := extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): detachable STRING_32
			-- Extract request form CJ data and build a object
			-- password view.
		local
			l_parser: JSON_PARSER
		do
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
				attached {JSON_OBJECT} jv.item ("template") as l_template and then
				attached {JSON_ARRAY} l_template.item ("data") as l_data and then
					--  <"name": "email", "prompt": "Password", "value": "{$form.email/}">,
				attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				l_name.item.same_string ("responsible") and then attached {JSON_STRING} l_form_data.item ("value") as l_value
			then
				Result := l_value.item
			end
		end

	extract_data_from_form (req: WSF_REQUEST): detachable STRING_32
			-- Extract request form data and build a object email view.
			-- email, check_email.
		do
			if attached {WSF_STRING} req.form_parameter ("user_responsible") as l_responsible then
				Result := l_responsible.value
			end
		end

	build_redirect_uri (req: WSF_REQUEST; a_type: READABLE_STRING_8): STRING_8
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
				Result := (create {URL_ENCODER}).encoded_string (req.path_info)
			else
				create Result.make_from_string ("/reports?")
				if attached {WSF_STRING} req.form_parameter ("page") as l_page then
					Result.append_string_general ("page=")
					Result.append_string_general (l_page.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("size") as l_size then
					Result.append_string_general ("size=")
					Result.append_string_general (l_size.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("category") as l_category then
					Result.append_string_general ("category=")
					Result.append_string_general (l_category.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("severity") as l_severity then
					Result.append_string_general ("severity=")
					Result.append_string_general (l_severity.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("priority") as l_priority then
					Result.append_string_general ("priority=")
					Result.append_string_general (l_priority.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("responsible") as l_responsible then
					Result.append_string_general ("responsible=")
					Result.append_string_general (l_responsible.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("status") as l_status then
					Result.append_string_general (l_status.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("orderBy") as l_orderby then
					Result.append_string_general ("orderBy=")
					Result.append_string_general (l_orderBy.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("dir") as l_dir then
					Result.append_string_general ("dir=")
					Result.append_string_general (l_dir.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("submitter") as l_submitter then
					Result.append_string_general ("submitter=")
					Result.append_string_general (l_submitter.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("filter") as l_filter then
					Result.append_string_general ("filter=")
					Result.append_string_general (l_filter.value)
					Result.append_string_general ("&")
				end
				if attached {WSF_STRING} req.form_parameter ("filter_content") as l_filter_content then
					Result.append_string_general ("filter_content=")
					Result.append_string_general (l_filter_content.value)
				end
			end
		end

	send_responsible_change_email (a_user: READABLE_STRING_GENERAL; a_report_id: INTEGER; a_url: STRING)
			-- Send email to new problem report responsible.
		do
			if
				api_service.successful and then
				attached api_service.problem_report (a_report_id) as l_report and then
				attached l_report.assigned as l_assigned and then
				attached l_assigned.name as l_name
			then
				email_notification_service.send_responsible_change_email (a_user, l_report, api_service.user_account_information (l_name), a_url)
			else
				log.write_error (generator + ".send_responsible_change_email")
			end
		end

end
