note
	description: "Problem reports reported by user"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER_REPORT_HANDLER

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
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_row: TUPLE[ESA_REPORT_STATISTICS,LIST[ESA_REPORT]]
			l_view: ESA_REPORT_VIEW
			l_status: INTEGER
			l_category: INTEGER
			list_status: LIST[ESA_REPORT_STATUS]
			l_categories: LIST[ESA_REPORT_CATEGORY]
			l_pages : INTEGER
			l_page: INTEGER
			l_size: INTEGER
			l_direction: STRING
			l_order_by : STRING
			l_dir: INTEGER
		do
			create l_rhf
			if attached {STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				if attached current_media_type (req) as l_type then

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
					l_pages := api_service.row_count_problem_report_user (l_user, False, l_category, l_status)
					l_row := api_service.problem_reports_2 (l_page, l_size, l_user, False, l_category, l_status, l_order_by, l_dir)
					create l_view.make (l_row, l_page, l_pages // l_size, l_categories, list_status, l_user)
					l_view.set_selected_category (l_category)
					l_view.set_selected_status (l_status)
					l_view.set_size (l_size)
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_user_reports (req, res, l_view)
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).problem_user_reports (req, res, Void)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

end
