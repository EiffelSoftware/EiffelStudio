note
	description: "[
			Handle a user wish item form and update an existing wish
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_FORM_HANDLER

inherit

	CMS_MOTION_LIST_ABSTRACT_HANDLER

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
			if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					-- Edit a Wish item
				edit_wish_form (req, res, l_id.value)
			else
					-- New WISH
				new_wish_form (req, res)
			end
		end

feature -- POST

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			save_wish (req, res)
		end

feature {NONE} --GET Implementation

	edit_wish_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: READABLE_STRING_32)
			-- <Precursor>
		local
			r: CMS_RESPONSE
		do
			if a_id.is_integer then
				if attached {CMS_MOTION_LIST} motion_api.motion_by_id (a_id.to_integer) as l_wish then
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					if attached template_block (get_block_form, r) as l_tpl_block then
						l_tpl_block.set_value (motion_api.categories, "categories")
						l_tpl_block.set_value (l_wish.description, "description")
						l_tpl_block.set_value (l_wish.synopsis, "synopsis")
						l_tpl_block.set_Value (l_wish.status, "status")
						if attached l_wish.attachments then
							l_tpl_block.set_Value (l_wish.attachments, "uploaded_files")
						end
						if attached l_wish.category as l_category then
							l_tpl_block.set_value (l_category.id, "category")
						end
						if l_wish.has_id then
							l_tpl_block.set_value (l_wish.id, "id")
						end
						r.add_block (l_tpl_block, "content")
					end
					r.execute
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.execute
				end
			else
					-- Bad request
			end
		end

	new_wish_form (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			r: CMS_RESPONSE
			l_form: CMS_MOTION_FORM_VIEW
		do
			if attached api.user_is_authenticated then
				create l_form.make (motion_api.categories)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached template_block (get_block_form, r) as l_tpl_block then
					l_tpl_block.set_value (l_form.categories, "categories")
					l_tpl_block.set_value (l_form.description, "description")
					l_tpl_block.set_value (l_form.synopsis, "synopsis")
					l_tpl_block.set_value (l_form.category, "category")
					if l_form.id > 0 then
						l_tpl_block.set_value (l_form.id, "id")
					end
					r.add_block (l_tpl_block, "content")
				end
				r.execute
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

feature {NONE} -- POST Implementation

	save_wish (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Save or update a wish item.
		local
			l_form: CMS_MOTION_FORM_VIEW
			r: CMS_RESPONSE
			l_wish: CMS_MOTION_LIST
		do
			if attached api.user as l_user then
				l_form := extract_form_data (req)
				if l_form.is_valid_form then
					create l_wish.make_empty
					l_wish.set_contact (l_user)
					l_wish.set_wish_list_category (create {CMS_MOTION_LIST_CATEGORY}.make (l_form.category, "", True))
					l_wish.set_description (l_form.description)
					if attached l_form.synopsis as l_synopsis then
						l_wish.set_synopsis (l_synopsis)
					end
					l_wish.set_status (create {CMS_MOTION_LIST_STATUS}.make (l_form.status, ""))
					l_wish.set_id (l_form.id)
					motion_api.save_motion (l_wish)
					l_form.set_id (l_wish.id)

						-- Upload temporary files and handle uploaded files
					upload_temporary_files_html (req, l_form)

						-- View:
						--! TODO refactor: extract code.
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					if attached template_block (get_block_form, r) as l_tpl_block then
						l_tpl_block.set_value (motion_api.categories, "categories")
						l_tpl_block.set_value (l_wish.description, "description")
						l_tpl_block.set_value (l_wish.synopsis, "synopsis")
						l_tpl_block.set_Value (l_wish.status, "status")
						if attached motion_api.motion_attachments (l_wish.id) as l_attachments then
							l_tpl_block.set_value (l_attachments, "uploaded_files")
						end
						if attached l_wish.category as l_category then
							l_tpl_block.set_value (l_category.id, "category")
						end
						if l_wish.has_id then
							l_tpl_block.set_value (l_wish.id, "id")
						end
						r.add_block (l_tpl_block, "content")
					end
					r.execute
				else
						-- Bad request
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end


feature {NONE} -- Upload and temporary file processing.

	upload_temporary_files_html (req: WSF_REQUEST; a_form: CMS_MOTION_FORM_VIEW)
			-- Handle temporary and uploaded files
		local
			l_found: BOOLEAN
		do
				-- text/html
			if req.form_parameter ("uploaded_files") = Void then
					-- remove all the attached files.
				motion_api.remove_motion_attachments (a_form.id)
			elseif attached {WSF_STRING} req.form_parameter ("uploaded_files") as l_file and then
					l_file.is_string then
				across motion_api.motion_attachments (a_form.id) as c loop
					if not c.item.name.same_string (l_file.value) then
						motion_api.remove_motion_attachment_by_name (a_form.id, c.item.name)
					end
				end
				a_form.add_temporary_file_name (l_file.value)
			elseif attached {WSF_MULTIPLE_STRING} req.form_parameter ("uploaded_files") as l_files then
				across motion_api.motion_attachments (a_form.id) as c loop
					across l_files as lf loop
						if c.item.name.same_string (lf.item.value) then
							l_found := True
						end
					end
					if not l_found then
						motion_api.remove_motion_attachment_by_name (a_form.id, c.item.name)
					else
						l_found := False
					end
				end
				across l_files as lf loop
					a_form.add_temporary_file_name (lf.item.value)
				end

			end
				-- Add new uploaded files
			if attached a_form.temporary_files as l_files then
				across l_files as c loop
						-- Max Size File 10MB.
					if c.item.size.to_natural_64 <= ({NATURAL_64}10*1024*1024) then
						motion_api.upload_motion_attachment (a_form.id, c.item)
					else
						-- (generator + ".initialize_report_problem_internal File " + c.item.name + " rejected, too big." )
					end
				end
			end
  	end

feature {NONE} -- Form Processing

	extract_form_data (req: WSF_REQUEST): CMS_MOTION_FORM_VIEW
			-- Example form parameters
			--"category=5"
			--"synopsis=test"
			--"description=test"
		local
			l_size: INTEGER
			l_name: READABLE_STRING_32
			l_content: STRING
			l_list: LIST [CMS_MOTION_FILE]
		do
			create Result.make (motion_api.categories)

			if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
				Result.set_id (l_id.integer_value)
			end
				--Category
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer then
				Result.set_category (l_category.integer_value)
			end
				--Synopsis
			if attached {WSF_STRING} req.form_parameter ("synopsis") as l_synopsis then
				Result.set_synopsis (l_synopsis.value)
			end
				--Description
			if attached {WSF_STRING} req.form_parameter ("description") as l_description then
				Result.set_description (l_description.value)
			end
			if attached {WSF_STRING} req.form_parameter ("status") as l_status then
				Result.set_status (l_status.integer_value)
			end
			if req.has_uploaded_file then
				create {ARRAYED_LIST [CMS_MOTION_FILE]} l_list.make (0)
				across
					req.uploaded_files as c
				loop
					create l_content.make_empty
					l_size := c.item.size
					l_name := c.item.filename
					c.item.append_content_to_string (l_content)
					l_list.force (create {CMS_MOTION_FILE}.make (l_name, l_size, l_content))
				end
				Result.set_temporary_files (l_list)
			end
		end


feature {NONE} -- Implementation

	get_block_form: STRING
		do
			create Result.make_from_string (motion_api.item)
			Result.append ("_form")
		end

end
