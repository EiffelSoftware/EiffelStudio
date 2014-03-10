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
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_row: TUPLE[REPORT_STATISTICS,LIST[REPORT]]
			l_view: ESA_REPORT_VIEW
			l_status: INTEGER
			l_category: INTEGER
			list_status: LIST[REPORT_STATUS]
			l_categories: LIST[REPORT_CATEGORY]

		do
			media_variants := media_type_variants (req)
			if attached {STRING_32} req.execution_variable ("user") as l_user then
					-- Logged in user
				to_implement ("retrieve number of reports by a given user")
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						create l_rhf
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
						l_row := api_service.problem_reports (l_user, False, l_category, l_status)
						create l_view.make (l_row, 0, 0, l_categories, list_status, l_user)
						l_view.set_selected_category (l_category)
						l_view.set_selected_status (l_status)
						l_rhf.new_representation_handler (esa_config,l_type,media_variants).problem_user_reports (req, res, l_view)
					end
				else
					create l_rhf
					l_rhf.new_representation_handler (esa_config,"",media_variants).problem_user_reports (req, res, Void)
				end
			else -- Not a logged in user
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						create l_rhf
						l_rhf.new_representation_handler (esa_config,l_type,media_variants).new_response_unauthorized (req, res)
					end
				else
					create l_rhf
					l_rhf.new_representation_handler (esa_config,"",media_variants).new_response_unauthorized (req, res)
				end
			end

		end


end
