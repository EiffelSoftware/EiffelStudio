note
	description: "{Handle user interactions for wish list items }"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_INTERACTION_FORM_HANDLER

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
			if
				attached {WSF_STRING} req.path_parameter ("wish_id") as l_wish_id and then l_wish_id.is_integer and then attached {WSF_STRING} req.path_parameter ("id") as l_interaction_id and then
				l_interaction_id.is_integer
			then
					-- Edit a Wish Interaction
				edit_wish_interaction_form (req, res, l_wish_id.integer_value, l_interaction_id.integer_value)
			elseif attached {WSF_STRING} req.path_parameter ("wish_id") as l_wish_id and then l_wish_id.is_integer then
					-- New Wish Interaction
				new_wish_interaction_form (req, res, l_wish_id.integer_value)
			end
		end

feature -- POST

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			save_wish_interaction (req, res)
		end

feature {NONE} --GET Implementation

	edit_wish_interaction_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_wish_id:INTEGER; a_interaction_id: INTEGER)
			-- <Precursor>
		local
			r: CMS_RESPONSE
			l_form: CMS_MOTION_INTERACTION_FORM_VIEW
		do
			if attached api.user as l_user then
				create l_form.make (motion_api.status, motion_api.categories)
				l_form.set_wish (motion_api.motion_by_id (a_wish_id))
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached template_block (get_block_interaction_form, r) as l_tpl_block then
					l_tpl_block.set_value (l_form, "form")
					l_tpl_block.set_value (l_form.categories, "categories")
					l_tpl_block.set_value (l_form.status, "status")
					l_tpl_block.set_value (l_form.description, "description")
					l_tpl_block.set_value (l_form.category, "category")

						 -- TODO add permissions.
						 -- Workaround
					if attached l_form.wish as l_wish then
							-- can edit status?
						l_wish.set_type (motion_api.item)
						l_wish.mark_wish_status
						if motion_api.has_permission_for_action_on_motion ("update", l_wish , l_user) then
							l_tpl_block.set_value (True, "can_edit_status" )
						end
						l_wish.mark_motion_category
						if motion_api.has_permission_for_action_on_motion ("update", l_wish , l_user) then
							l_tpl_block.set_value (True, "can_edit_category" )
						end
					end

					if l_form.id > 0 then
						l_tpl_block.set_value (l_form.id, "id")
						if attached motion_api.motion_interactions_attachments (a_wish_id, l_form.id ) as l_attachments then
							l_tpl_block.set_value (l_attachments, "uploaded_files")
						end
					end
					r.add_block (l_tpl_block, "content")
				end
				r.execute
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end

	new_wish_interaction_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_wish_id: INTEGER)
			-- <Precursor>
		local
			r: CMS_RESPONSE
			l_form: CMS_MOTION_INTERACTION_FORM_VIEW
		do
			if attached api.user as l_user then
				create l_form.make (motion_api.status, motion_api.categories)
				l_form.set_wish (motion_api.motion_by_id (a_wish_id))
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached template_block (get_block_interaction_form, r) as l_tpl_block then
					l_tpl_block.set_value (l_form, "form")
					l_tpl_block.set_value (l_form.categories, "categories")
					l_tpl_block.set_value (l_form.status, "status")
					l_tpl_block.set_value (l_form.description, "description")
					l_tpl_block.set_value (l_form.category, "category")

					if attached l_form.wish as l_wish then
							-- can edit status?
						l_wish.set_type (motion_api.item)
						l_wish.mark_wish_status
						if motion_api.has_permission_for_action_on_motion ("update", l_wish , l_user) then
							l_tpl_block.set_value (True, "can_edit_status" )
						end
						l_wish.mark_motion_category
						if motion_api.has_permission_for_action_on_motion ("update", l_wish , l_user) then
							l_tpl_block.set_value (True, "can_edit_category" )
						end
					end


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

	save_wish_interaction (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Save or update a wish item.
		local
			l_form: CMS_MOTION_INTERACTION_FORM_VIEW
			r: CMS_RESPONSE
			l_interaction: CMS_MOTION_LIST_INTERACTION
		do
			if attached api.user as l_user then
				if
					attached {WSF_STRING} req.path_parameter ("wish_id") as l_wish_id and then l_wish_id.is_integer and then
					attached  {CMS_MOTION_LIST} motion_api.motion_by_id (l_wish_id.integer_value) as l_wish
				then
					l_form := extract_form_data (req)
					if l_form.is_valid_form then
						l_form.confirm_changes
						create l_interaction.make_empty
						l_interaction.set_wish_id (l_wish.id)
						l_interaction.set_contact (l_user)
						l_interaction.set_content (l_form.description)
						l_interaction.set_id (l_form.id)
						motion_api.save_motion_interaction (l_interaction)
						l_form.set_id (l_interaction.id)

							-- Update wish item.
						if l_form.selected_status > 0 then
							l_wish.set_status (create {CMS_MOTION_LIST_STATUS}.make (l_form.selected_status, ""))
						end
						if l_form.category > 0  then
							l_wish.set_wish_list_category (create {CMS_MOTION_LIST_CATEGORY}.make (l_form.category, "", True))
						end

						motion_api.save_motion (l_wish)

						l_form.set_wish (l_wish)
							-- Upload temporary files and handle uploaded files
						upload_temporary_files_html (req, l_form)

							-- View:
							--! TODO refactor: extract code.
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
						if attached template_block (get_block_interaction_form, r) as l_tpl_block then
							l_tpl_block.set_value (l_form, "form")
							l_tpl_block.set_value (l_form.categories, "categories")
							l_tpl_block.set_value (l_form.status, "status")
							l_tpl_block.set_value (l_form.description, "description")
							l_tpl_block.set_value (l_form.category, "category")

							 -- TODO add permissions.
							 -- Workaround
							l_tpl_block.set_value (True, "has_permissions")

							if l_form.id > 0 then
								l_tpl_block.set_value (l_form.id, "id")

							if attached motion_api.motion_interactions_attachments (l_wish.id, l_form.id ) as l_attachments then
								l_tpl_block.set_value (l_attachments, "uploaded_files")
							end

							end

							r.add_block (l_tpl_block, "content")
						end
						r.execute
					else
							-- Bad request
					end
				else
					-- Bad Request	
				end
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
			end
		end


feature {NONE} -- Upload and temporary file processing.

	upload_temporary_files_html (req: WSF_REQUEST; a_form: CMS_MOTION_INTERACTION_FORM_VIEW)
			-- Handle temporary and uploaded files
		local
			l_found: BOOLEAN
		do
			if attached a_form.wish as l_wish then

					-- text/html
				if req.form_parameter ("uploaded_files") = Void then
						-- remove all the attached files.
					motion_api.remove_motion_attachments (a_form.id)
				elseif attached {WSF_STRING} req.form_parameter ("uploaded_files") as l_file and then
						l_file.is_string then
					across motion_api.motion_attachments (a_form.id) as c loop
						if not c.item.name.same_string (l_file.value) then
							motion_api.remove_wish_interaction_attachment_by_name (l_wish.id, a_form.id, c.item.name)
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
							motion_api.remove_wish_interaction_attachment_by_name (l_wish.id, a_form.id, c.item.name)
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
							motion_api.upload_motion_interaction_attachment (l_wish.id, a_form.id, c.item)
						else
							-- (generator + ".initialize_report_problem_internal File " + c.item.name + " rejected, too big." )
						end
					end
				end
			end
  		end

feature {NONE} -- Form Processing

	extract_form_data (req: WSF_REQUEST): CMS_MOTION_INTERACTION_FORM_VIEW
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
			create Result.make (motion_api.status, motion_api.categories)

			if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
				Result.set_id (l_id.integer_value)
			end
				--Category
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer then
				Result.set_category (l_category.integer_value)
			end
				--Description
			if attached {WSF_STRING} req.form_parameter ("description") as l_description then
				Result.set_description (l_description.value)
			end
			if attached {WSF_STRING} req.form_parameter ("status") as l_status then
				Result.set_selected_status (l_status.integer_value)
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

	get_block_interaction_form: STRING
		do
			create Result.make_from_string (motion_api.item)
			Result.append_character ('_')
			Result.append ("interaction_form")
		end

end
