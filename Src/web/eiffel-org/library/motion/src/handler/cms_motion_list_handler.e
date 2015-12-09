note
	description: "Summary description for {CMS_MOTION_LIST_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_HANDLER

inherit

	CMS_MOTION_LIST_ABSTRACT_HANDLER

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
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- GET


	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			wish_list (req, res)
		end

	wish_list (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- List of wish liar.
		local
			l_input_validator: CMS_MOTION_LIST_INPUT_VALIDATOR
			l_categories: LIST [CMS_MOTION_LIST_CATEGORY]
			l_status: LIST [CMS_MOTION_LIST_STATUS]
			l_pages: INTEGER
			l_row: LIST [CMS_MOTION_LIST]
			l_view: CMS_MOTION_LIST_VIEW
			r: CMS_RESPONSE
			tpl_inspector: TEMPLATE_INSPECTOR
		do
			create l_input_validator
			l_input_validator.input_from (req.query_parameters)
			if not l_input_validator.has_error then
				l_categories := motion_api.categories
				l_status := motion_api.status

				l_pages := motion_api.row_count_motion_list (l_input_validator.category, l_input_validator.status_selected, l_input_validator.filter, l_input_validator.filter_content)

					-- Check if the query parameter page has a value less than or equal the the number of existing pages for the current request, if not, we set it as a default value=1
				if l_input_validator.page > (l_pages // l_input_validator.size) + 1 then
					l_input_validator.set_page (1)
				end

				l_row := motion_api.motion_list (l_input_validator.page, l_input_validator.size, l_input_validator.category, l_input_validator.status_selected, l_input_validator.orderby, l_input_validator.dir_selected, l_input_validator.filter, l_input_validator.filter_content )
				create l_view.make (l_row, l_input_validator.page, l_pages // l_input_validator.size, l_categories, l_status)
				l_view.set_size (l_input_validator.size)
				l_view.set_selected_category (l_input_validator.category)
				l_view.set_order_by (l_input_validator.orderby)
				l_view.set_direction (l_input_validator.direction)
				l_view.set_filter (l_input_validator.filter)
				l_view.set_filter_content (l_input_validator.filter_content)
				mark_selected_status (l_status, l_input_validator.status)
				set_selected_category (l_categories, l_input_validator.category)

				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached template_block (motion_api.name, r) as l_tpl_block then
					create {CMS_MOTION_LIST_STATUS_INSPECTOR} tpl_inspector.register (({detachable CMS_MOTION_LIST_STATUS}).out)
					create {CMS_MOTION_LIST_CATEGORY_INSPECTOR} tpl_inspector.register (({detachable CMS_MOTION_LIST_CATEGORY}).out)

					l_tpl_block.set_value (l_view, "view")
					l_tpl_block.set_value ("wish_list", "module")
					l_tpl_block.set_value (l_view.wish_list, "wish_list")
					l_tpl_block.set_value (l_view.categories, "categories")
					l_tpl_block.set_value (l_view.status, "status")
					l_tpl_block.set_value (l_view.selected_category, "selected_category")
					l_tpl_block.set_value (l_view.index, "index")
					l_tpl_block.set_value (l_view.order_by, "orderBy")
					l_tpl_block.set_value (l_view.direction, "dir")
					l_tpl_block.set_value (l_view.size, "size")
					l_tpl_block.set_value (retrieve_status_query (l_view.status), "status_query")
					if l_view.index > 1 then
						l_tpl_block.set_value (l_view.index - 1, "prev")
					end
					if l_view.index <= l_view.pages then
						l_tpl_block.set_value (l_view.index + 1, "next")
					end
					l_tpl_block.set_value (l_view.pages + 1, "last")
					l_tpl_block.set_value (l_view.pages + 1, "pages")
					if attached l_view.filter as l_filter then
						l_tpl_block.set_value (l_filter, "filter")
					end
					if l_view.filter_content = 1 then
						l_tpl_block.set_value (l_view.filter_content, "filter_content")
					end

					r.add_block (l_tpl_block, "content")
				end
				r.execute
			else
				-- error
			end
		end

feature -- Helpers

	retrieve_status_query (a_status: LIST [CMS_MOTION_LIST_STATUS]): STRING_8
		do
			Result := "0&"
			across
				a_status as c
			loop
				if c.item.is_selected then
					Result.append_string ("status=")
					Result.append_string (c.item.id.out)
					Result.append_string ("&")
				end
			end
			Result.remove_tail (1)
		end

	set_selected_status (a_status: LIST [CMS_MOTION_LIST_STATUS]; a_selected_status:  INTEGER)
			-- Set the current selected status
		do
			across a_status as c  loop
				if c.item.id = a_selected_status then
					c.item.set_selected_id (a_selected_status)
				end
			end
		end

	mark_selected_status (a_status: LIST [CMS_MOTION_LIST_STATUS]; a_status_selected: LIST [INTEGER] )
			-- Set the current selected status
		do
			across a_status_selected as c  loop
				set_selected_status (a_status, c.item)
			end
		end

	set_selected_category (a_categories: LIST [CMS_MOTION_LIST_CATEGORY]; a_selected_category:  INTEGER)
			-- Set the current selected category
		do
			across a_categories as c  loop
				c.item.set_selected_id (a_selected_category)
			end
		end

end
