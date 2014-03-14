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
			list_status: LIST[ESA_REPORT_STATUS]
			l_categories: LIST[ESA_REPORT_CATEGORY]
			l_report_view: ESA_REPORT_VIEW
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				create l_rhf
				if attached media_variants.media_type as l_type then
					l_categories := api_service.all_categories
					list_status:= api_service.status
					if attached {WSF_STRING} req.query_parameter ("category") as ll_category and then
					   attached {WSF_STRING} req.query_parameter ("status") as ll_status and then
				 	  ll_category.is_integer and then ll_status.is_integer then
				 	  	l_category := ll_category.integer_value
						l_status := ll_status.integer_value
					 else
				 		l_category := 0
				 		l_status := 0
				 	end
					l_pages := api_service.row_count_problem_report_guest (l_category,l_status)
					if attached {WSF_STRING} req.path_parameter ("id") as l_id then
						if l_id.is_integer then
							l_row := api_service.problem_reports_guest (l_id.as_string.integer_value, 10, l_category,l_status)
							create l_report_view.make (l_row, l_id.as_string.integer_value, l_pages // 10, l_categories, list_status, current_user_name (req))
							l_report_view.set_selected_category (l_category)
							l_report_view.set_selected_status (l_status)
							l_rhf.new_representation_handler (esa_config,l_type,media_variants).problem_reports_guest (req, res, l_report_view)
						else
							l_rhf.new_representation_handler (esa_config,l_type,media_variants).bad_request_page (req, res)
						end
					else
						l_row := api_service.problem_reports_guest (1, 10, l_category,l_status)
						create l_report_view.make (l_row, 1, l_pages // 10, l_categories, list_status, current_user_name (req))
						l_report_view.set_selected_category (l_category)
						l_report_view.set_selected_status (l_status)
						l_rhf.new_representation_handler (esa_config,l_type,media_variants).problem_reports_guest (req, res, l_report_view)
					end
				end
			else
				create l_rhf
				l_rhf.new_representation_handler (esa_config,"",media_variants).problem_reports_guest (req, res,Void)
			end
		end



end
