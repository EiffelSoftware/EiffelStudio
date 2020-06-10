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

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods


	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_row: LIST [REPORT]
			l_view: ESA_REPORT_VIEW
			list_status: LIST [REPORT_STATUS]
			l_categories: LIST [REPORT_CATEGORY]
			l_pages : INTEGER
			l_input_validator: ESA_REPORT_INPUT_VALIDATOR
		do
			create l_rhf
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				debug
					log.write_information (generator+".do_get Processing request with user:" + l_user.to_string_8  )
				end
				if attached current_media_type (req) as l_type then
					create l_input_validator
					l_input_validator.input_from (req.query_parameters)
					if not l_input_validator.has_error then
						l_categories := api_service.all_categories
						list_status := api_service.status

						l_pages := api_service.row_count_problem_report_user (l_user, l_input_validator.category, l_input_validator.status_selected, l_input_validator.filter, l_input_validator.filter_content)
						l_row := api_service.problem_reports (l_input_validator.page, l_input_validator.size, l_user, l_input_validator.category, l_input_validator.status_selected, l_input_validator.orderby, l_input_validator.dir_selected, l_input_validator.filter, l_input_validator.filter_content)
						create l_view.make (l_row, l_input_validator.page, l_pages // l_input_validator.size, l_categories, list_status, l_user, l_pages)
						l_view.set_selected_category (l_input_validator.category)
						l_view.set_size (l_input_validator.size)
						l_view.set_order_by (l_input_validator.orderby)
						l_view.set_filter (l_input_validator.filter)
						l_view.set_filter_content (l_input_validator.filter_content)
						mark_selected_status (list_status, l_input_validator.status)
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_user_reports (req, res, l_view)
					else
							-- Bad request
						log.write_error (generator + ".user_reports " + l_input_validator.error_message)
						l_rhf.new_representation_handler (esa_config, l_type,  media_type_variants (req)).bad_request_with_errors_page (req, res, l_input_validator.errors)
					end
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).problem_user_reports (req, res, Void)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					log.write_alert (generator+".do_get Processing request not authorized")
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					log.write_alert (generator+".do_get Processing request not acceptable")
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end


feature {NONE} --Implementation

	set_selected_status (a_status: LIST [REPORT_STATUS]; a_selected_status: INTEGER)
			-- Set the current selected status.
		do
			across a_status as c  loop
				if c.item.id = a_selected_status then
					c.item.set_selected_id (a_selected_status)
				end
			end
		end

	mark_selected_status (a_status: LIST [REPORT_STATUS]; a_status_selected: LIST[INTEGER] )
			-- Set the current selected status.
		do
			across a_status_selected as c  loop
				set_selected_status (a_status, c.item)
			end
		end

end
