note
	description: "Summary description for {REPORT_HANDLER}."
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
			do_get
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
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
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
			l_role: ESA_USER_ROLE
		do
			if attached current_user_name (req) as l_user then
				l_role := api_service.role (l_user)
				if l_role.is_user then
						-- List of reports visible for registered user.
						-- They are able to see his own reports and also visible reports.
					user_reports (req, res, l_user)
				elseif l_role.is_administrator or else l_role.is_responsible then
						-- List of reports visible for reponsible and admin users
					responsible_reports (req, res)
				else
						-- Internal Users?
				end
			else
					-- List of reports visisble for Guest Users
				user_reports (req, res, "")
			end
		end

feature -- Implementation

	responsible_reports (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- List of reports for users with role Admin or Responsible.
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
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
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				create l_rhf
				if attached media_variants.media_type as l_type then
					l_categories := api_service.all_categories
					list_status := api_service.status
					l_responsibles := api_service.responsibles
					l_priorities := api_service.priorities
					l_severities := api_service.severities
					l_submitter := ""
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
					   		end
					   end
					end
					if attached {WSF_STRING} req.query_parameter ("orderBy") as l_orderby and then attached {WSF_STRING} req.query_parameter ("dir") as ll_dir then
						l_order_by := l_orderby.value
						l_direction := ll_dir.value
						if ll_dir.value.same_string ("ASC") then
							l_dir := 1
						end
					else
						l_order_by := "number"
						l_direction := "ASC"
						l_dir := 0
					end

					l_pages := api_service.row_count_problem_report_responsible (l_category, l_severity, l_priority, l_responsible, "1,2,3,4,5", l_submitter)
					if attached {WSF_STRING} req.path_parameter ("id") as l_id then
						if l_id.is_integer then
							l_row :=  api_service.problem_reports_responsibles (l_id.integer_value, 10, l_category, l_severity,l_priority, l_responsible, "number", l_dir, "1,2,3,4,5", l_submitter)
							create l_report_view.make (l_row, l_id.as_string.integer_value, l_pages // 10, l_categories, list_status, current_user_name (req))
							l_report_view.set_selected_category (l_category)
							l_report_view.set_selected_priority (l_priority)
							l_report_view.set_selected_severity (l_severity)
							l_report_view.set_selected_responsible (l_responsible)

							l_report_view.set_responsibles (l_responsibles)
							l_report_view.set_priorities (l_priorities)
							l_report_view.set_severities (l_severities)

							l_rhf.new_representation_handler (esa_config, l_type, media_variants).problem_reports_responsible (req, res, l_report_view)
						else
							l_rhf.new_representation_handler (esa_config, l_type, media_variants).bad_request_page (req, res)
						end
					else
						l_row :=  api_service.problem_reports_responsibles (1, 10, l_category, l_severity,l_priority, l_responsible, "number", l_dir, "1,2,3,4,5", l_submitter)
						create l_report_view.make (l_row, 1, l_pages // 10, l_categories, list_status, current_user_name (req))
						l_report_view.set_selected_category (l_category)
						l_report_view.set_selected_priority (l_priority)
						l_report_view.set_selected_severity (l_severity)
						l_report_view.set_selected_responsible (l_responsible)

						l_report_view.set_responsibles (l_responsibles)
						l_report_view.set_priorities (l_priorities)
						l_report_view.set_severities (l_severities)
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).problem_reports_responsible (req, res, l_report_view)
					end
				end
			else
				create l_rhf
				l_rhf.new_representation_handler (esa_config, "", media_variants).problem_reports_responsible (req, res, Void)
			end
		end

	user_reports (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: READABLE_STRING_32)
			-- List of reports for a user `a_user' with role Guest or User
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
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
		do
			to_implement ("Validate request parameters!!!")
				--| At the moment the page size is hardcoded as 10 items per page.
				--| we can set a defaut and then let the user customize it, but it's not
				--| critical at the moment.
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				create l_rhf
				if attached media_variants.media_type as l_type then
					l_categories := api_service.all_categories
					list_status := api_service.status
					if attached {WSF_STRING} req.query_parameter ("category") as ll_category and then attached {WSF_STRING} req.query_parameter ("status") as ll_status and then ll_category.is_integer and then ll_status.is_integer then
						l_category := ll_category.integer_value
						l_status := ll_status.integer_value
					else
						l_category := 0
						l_status := 0
					end
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
					if attached {WSF_STRING} req.path_parameter ("id") as l_id then
						if l_id.is_integer then
							l_row := api_service.problem_reports_guest_2 (l_id.as_string.integer_value, 10, l_category, l_status, l_order_by, l_dir)
							create l_report_view.make (l_row, l_id.as_string.integer_value, l_pages // 10, l_categories, list_status, current_user_name (req))
							l_report_view.set_order_by (l_order_by)
							l_report_view.set_direction (l_direction)
							l_report_view.set_selected_category (l_category)
							l_report_view.set_selected_status (l_status)
							l_rhf.new_representation_handler (esa_config, l_type, media_variants).problem_reports_guest (req, res, l_report_view)
						else
							l_rhf.new_representation_handler (esa_config, l_type, media_variants).bad_request_page (req, res)
						end
					else
						l_row := api_service.problem_reports_guest_2 (1, 10, l_category, l_status, l_order_by, l_dir)
						create l_report_view.make (l_row, 1, l_pages // 10, l_categories, list_status, current_user_name (req))
						l_report_view.set_selected_category (l_category)
						l_report_view.set_selected_status (l_status)
						l_report_view.set_order_by (l_order_by)
						l_report_view.set_direction (l_direction)
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).problem_reports_guest (req, res, l_report_view)
					end
				end
			else
				create l_rhf
				l_rhf.new_representation_handler (esa_config, "", media_variants).problem_reports_guest (req, res, Void)
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

end
