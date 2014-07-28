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
			l_row: LIST[ESA_REPORT]
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
			l_filter: STRING
			l_content: INTEGER
			l_status_selected: STRING
		do
			create l_rhf
			if attached {STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				log.write_information (generator+".do_get Processing request with user:" + l_user  )
				if attached current_media_type (req) as l_type then

					l_categories := api_service.all_categories
					list_status:= api_service.status

					create l_filter.make_empty

					l_order_by := "submissionDate"
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
						-- default page size is 30
						l_size := 30
					end

				    -- Filter text
	                if attached {WSF_STRING} req.query_parameter ("filter") as ll_filter then
		                 l_filter := ll_filter.value
	                end

			             -- Filter by description
		            if attached {WSF_STRING} req.query_parameter ("filter_content") as l_filter_content and then l_filter_content.is_integer then
		                 l_content := l_filter_content.integer_value
		            end

					create l_status_selected.make_empty
					if  attached {WSF_MULTIPLE_STRING} req.query_parameter ("status") as ll_status then
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
						-- Order by and Direction
					if attached {WSF_STRING} req.query_parameter ("orderBy") as l_orderby and then attached {WSF_STRING} req.query_parameter ("dir") as ll_dir then
						l_order_by := l_orderby.value
						l_direction := ll_dir.value
						if ll_dir.value.same_string ("ASC") then
							l_dir := 1
						end
					else
						l_order_by := "submissionDate"
						l_direction := "ASC"
						l_dir := 0
					end
					l_pages := api_service.row_count_problem_report_user (l_user, l_category, l_status_selected, l_filter, l_content)
					l_row := api_service.problem_reports_2 (l_page, l_size, l_user,l_category, l_status_selected, l_order_by, l_dir, l_filter, l_content)
					create l_view.make (l_row, l_page, l_pages // l_size, l_categories, list_status, l_user)
					l_view.set_selected_category (l_category)
					l_view.set_selected_status (l_status)
					l_view.set_size (l_size)
					l_view.set_order_by (l_order_by)
					l_view.set_filter (l_filter)
					l_view.set_filter_content (l_content)


					if l_dir = 1 then
						l_view.set_direction ("ASC")
					else
						l_view.set_direction ("DESC")
					end

					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).problem_user_reports (req, res, l_view)
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).problem_user_reports (req, res, Void)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					log.write_alert (generator+".do_get Processing request not authorized")
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					log.write_alert (generator+".do_get Processing request not acceptable")
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).new_response_unauthorized (req, res)
				end
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
