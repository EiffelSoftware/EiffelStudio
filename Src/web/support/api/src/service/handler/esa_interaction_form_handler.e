note
	description: "[
					Handle interaction, add a new interaction as a temporary interaction report problem.
				    Also handle update a temporary interaction  report problem after completing the first step.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_FORM_HANDLER

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
			do_get,
			do_put,
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
		do
			if
				attached {WSF_STRING} req.path_parameter ("report_id") as l_report_id and then
				l_report_id.is_integer and then
				attached {WSF_STRING} req.path_parameter ("id") as l_interaction_id and then
				l_interaction_id.is_integer
			then
					-- Edit a Report Interaction
				debug
					log.write_information (generator + ".do_get Processing edit_report_interaction")
				end
				edit_report_interaction (req, res, l_report_id.integer_value, l_interaction_id.integer_value)
			elseif
				attached {WSF_STRING} req.path_parameter ("report_id") as l_report_id and then
				l_report_id.is_integer
			then
					-- New Report Interaction
				debug
					log.write_information (generator + ".do_get Processing new_report_interaction")
				end
				new_report_interaction (req, res, l_report_id.integer_value)
			end
		end

	do_put	(req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			do_post (req, res)
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached {WSF_STRING} req.path_parameter ("report_id") as l_report_id and then l_report_id.is_integer and then attached {WSF_STRING} req.path_parameter ("id") as l_interaction_id and then
				l_interaction_id.is_integer then
					-- Update a Report Problem
				debug
					log.write_information (generator + ".do_post Processing update_report_interaction")
				end
				update_report_interaction (req, res, l_report_id.integer_value, l_interaction_id.integer_value)
			elseif attached {WSF_STRING} req.path_parameter ("report_id") as l_report_id and then l_report_id.is_integer then
					-- Initialize Report Problem
				debug
					log.write_information (generator + ".do_post Processing initialize_interaction_report_problem")
				end
				initialize_interaction_report_problem (req, res, l_report_id.integer_value)
			end
		end

feature -- Edit Report Problem

	edit_report_interaction (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_id: INTEGER; a_interaction_id: INTEGER)
			-- Edit an existing report interaction `a_interaction_id' for report `a_report_id'.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).add_interaction_form (req, res, edit_form (a_report_id, a_interaction_id, l_user))
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).add_interaction_form (req, res, Void)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

	edit_form (a_report_id, a_interaction_id: INTEGER; a_user: READABLE_STRING_32): ESA_INTERACTION_FORM_VIEW
		local
			l_tuple: detachable TUPLE[content : detachable READABLE_STRING_32;
									   username: detachable READABLE_STRING_32;
									   status: detachable READABLE_STRING_32;
									   private: detachable READABLE_STRING_32;
									   category: detachable READABLE_STRING_32]
			l_role: USER_ROLE
		do
			create Result.make (api_service.status, api_service.all_categories)
			Result.set_report (api_service.problem_report_details_guest (a_report_id))
			if attached Result.report as l_report and then
			   attached l_report.category as l_category then
			   	Result.set_category_by_synopsis (l_category.synopsis)
			end

			l_role := api_service.user_role (a_user)
			if l_role.is_administrator or else l_role.is_responsible then
				Result.set_responsible_or_admin (True)
			end

			Result.set_id (a_interaction_id)
			l_tuple := api_service.temporary_interaction_2 (a_interaction_id)
			if l_tuple /= Void then
				if l_tuple.content /= Void then
					Result.set_description (l_tuple.content)
				end
				if attached l_tuple.status as l_status then
					Result.set_status_by_synopsis (l_status)
				end
				if attached l_tuple.private as l_private and then l_private.is_boolean then
					Result.set_private (l_private.to_boolean)
				end
				if attached l_tuple.category as l_category then
					Result.set_category_by_synopsis (l_category)
				end
			end
			Result.set_temporary_files (api_service.temporary_interation_attachments (a_interaction_id))
		end

feature -- New Report Problem

	new_report_interaction (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_id: INTEGER_32)
			--  Interaction form for the report `a_report_id'
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_form: ESA_INTERACTION_FORM_VIEW
			l_role: USER_ROLE
		do
			create l_rhf
			media_variants := media_type_variants (req)
			if
				attached {READABLE_STRING_32} current_user_name (req) as l_user and then
			 	api_service.is_report_visible (l_user, a_report_id)
			then
					-- Logged in user with access to the given report id.
				if attached current_media_type (req) as l_type then
					if attached api_service.problem_report_details (l_user, a_report_id) as l_report then
						create l_form.make (api_service.status, api_service.all_categories)
						l_form.set_report (l_report)
						l_role := api_service.user_role (l_user)
						if l_role.is_administrator or else l_role.is_responsible then
							l_form.set_responsible_or_admin (True)
						end
						if attached l_report.status as l_status then
							l_form.set_status_by_synopsis (l_status.synopsis)
						end
						if attached l_report.category as l_category then
							l_form.set_category_by_synopsis (l_category.synopsis)
						end
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).add_interaction_form (req, res, l_form)
					else
							-- Resource not found
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).not_found_page (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).add_interaction_form (req, res, Void)
				end
			else -- Not a logged in user or the user does not have permissions to add an interaction.
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_variants).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).new_response_unauthorized (req, res)
				end
			end
		end

feature -- Update Report Problem

	update_report_interaction (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_id: INTEGER; a_interaction_id: INTEGER)
			-- Update temporary interaction `a_interaction_id' for the report `a_report'
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_form: ESA_INTERACTION_FORM_VIEW
			l_role: USER_ROLE
		do
			create l_rhf
			if attached {STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				to_implement ("Check user roles")
				if attached current_media_type (req) as l_type then
					if attached api_service.problem_report_details_guest (a_report_id) as l_report then
						l_form := extract_form_data (req, l_type)
						l_form.set_id (a_interaction_id)
						l_form.set_report (l_report)

						l_role := api_service.user_role (l_user)
						if l_role.is_administrator or else l_role.is_responsible then
							l_form.set_responsible_or_admin (True)
						end
						if l_form.is_valid_form then
							update_report_problem_internal (req, l_form, l_type)
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).interaction_form_confirm (req, res, l_form)
						else
								-- Bad request
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).interaction_form_confirm (req, res, l_form)
						end
					else
							-- Resource not found	
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).not_found_page (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).interaction_form_confirm (req, res, Void)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end

		end

	update_report_problem_internal (req: WSF_REQUEST; a_form: ESA_INTERACTION_FORM_VIEW; a_type: READABLE_STRING_8)
			-- Update problem report.
		do
			if attached a_form.description as l_description then
				api_service.initialize_interaction (a_form.id, a_form.category, l_description, a_form.selected_status, a_form.private)
			end
				-- Update temporary files
			if a_type.same_string ("application/vnd.collection+json") then
				upload_temporary_files_cj (a_form)
			else
				upload_temporary_files_html (req, a_form)
			end
		end

feature -- Initialize Report Problem

	initialize_interaction_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_id: INTEGER)
			-- Initialize temporary interaction for the report `a_report_id'.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_temp_interaction_id: INTEGER
			l_form: ESA_INTERACTION_FORM_VIEW
			l_role: USER_ROLE
		do
			create l_rhf
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				l_temp_interaction_id := api_service.new_interaction_id (l_user, a_report_id)
				if attached current_media_type (req) as l_type then
					if attached api_service.problem_report_details_guest (a_report_id) as l_report then
						l_form := extract_form_data (req, l_type)
						l_role := api_service.user_role (l_user)
						if l_role.is_administrator or else l_role.is_responsible then
								l_form.set_responsible_or_admin (True)
						end

						l_form.set_id (l_temp_interaction_id)
						l_form.set_report (l_report)
						l_form.confirm_changes
						if l_form.is_valid_form then
							initialize_interaction_report_problem_internal (req, l_form)
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).interaction_form_confirm (req, res, l_form)
						else
								-- Bad Request
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).interaction_form_error (req, res, l_form)
						end
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).report_form_confirm (req, res, Void)
				end
			else
					-- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

	initialize_interaction_report_problem_internal (req: WSF_REQUEST; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Initialize interaction report problem.
		require
			is_valid: a_form.is_valid_form
		do
			if attached a_form.description as l_description then
				api_service.initialize_interaction (a_form.id, a_form.category, l_description, a_form.selected_status, a_form.private)
			end
			if attached a_form.uploaded_files as l_files then
				across l_files as c loop
					to_implement ("Refactor code, extract hardcoded variable to a constant.")
					if c.item.size.to_natural_64 <= ({NATURAL_64}10*1024*1024) then
						api_service.upload_temporary_interaction_attachment (a_form.id, c.item)
						a_form.add_temporary_file_name (c.item.name)
					else
						-- Not accepted file too big.
						to_implement("Add the name of the file as a list of rejected files.")
						log.write_alert (generator + ".initialize_interaction_report_problem_internal File " + c.item.name.to_string_8 + " rejected, too big." )
					end
				end
			end
		end

feature {NONE} -- Implementation

	extract_form_data (req: WSF_REQUEST; a_type: READABLE_STRING_8): ESA_INTERACTION_FORM_VIEW
			-- Example form parameters.
			--"category=5"
			--"status=1"
			--"private=0"
			--"description=test"
		do
			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result := extract_data_from_form_parameters (req)
			end
		end

	extract_data_from_form_parameters (req: WSF_REQUEST): ESA_INTERACTION_FORM_VIEW
			-- Extract data from form parameters.
		local
			l_size: INTEGER
			l_name: READABLE_STRING_32
			l_content: STRING
			l_list: LIST[ESA_FILE_VIEW]
		do
			create Result.make (api_service.status, api_service.all_categories)
				--Category
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer then
				Result.set_category (l_category.integer_value)
			end
				--Severity
			if attached {WSF_STRING} req.form_parameter ("status") as l_severity and then l_severity.is_integer then
				Result.set_selected_status (l_severity.integer_value)
			end
				--Private
			if attached {WSF_STRING} req.form_parameter ("private") as l_priority and then l_priority.value.is_boolean then
				Result.set_private (l_priority.value.to_boolean)
			end
				--Description
			if attached {WSF_STRING} req.form_parameter ("description") as l_description then
				Result.set_description (l_description.value)
			end
			if req.has_uploaded_file then
				create {ARRAYED_LIST[ESA_FILE_VIEW]} l_list.make (0)
				across req.uploaded_files as c loop
					create l_content.make_empty
					l_size := c.item.size
					l_name := c.item.filename
					c.item.append_content_to_string (l_content)
					l_list.force (create {ESA_FILE_VIEW}.make (l_name, l_size, l_content))
				end
				Result.set_files (l_list)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): ESA_INTERACTION_FORM_VIEW
			-- Extract data from Collection+JSON template.
		local
			l_parser: JSON_PARSER
			l_list: LIST [ESA_FILE_VIEW]
			l_content: STRING
			i: INTEGER
		do
			create Result.make (api_service.status, api_service.all_categories)
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then attached {JSON_ARRAY} l_template.item ("data") as l_data then
					--		description
					--    	category *
					--      status *
					--      private *
					--	    attachments
				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("description") and then attached {JSON_STRING} l_form_data.item ("value") as l_value and then not l_value.item.is_empty then
					Result.set_description (l_value.item)
				end
				i := 2
				if attached {JSON_OBJECT} l_data.i_th (i) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("category") then
					if attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
						Result.set_category (l_value.item.to_integer)
					end
					i := i + 1
				end
				if attached {JSON_OBJECT} l_data.i_th (i) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("status") then
					if attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
						Result.set_selected_status (l_value.item.to_integer)
					end
					i := i + 1
				end
				if attached {JSON_OBJECT} l_data.i_th (i) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("private") then
					if attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
						if l_value.item.to_integer = 0 then
							Result.set_private (False)
						else
							Result.set_private (True)
						end

					end
					i := i + 1
				end

				if attached {JSON_OBJECT} l_data.i_th (i) as l_form_data and then attached {JSON_ARRAY} l_form_data.item ("files") as l_files  then
					create {ARRAYED_LIST [ESA_FILE_VIEW]} l_list.make (0)
					across l_files as c  loop
						if attached {JSON_OBJECT} c.item as jo and then attached {JSON_STRING} jo.item("name") as l_key and then
							attached {JSON_STRING} jo.item("value") as ll_content then
								l_content := (create {BASE64}).decoded_string (ll_content.item)
								l_list.force (create {ESA_FILE_VIEW}.make (l_key.item, l_content.count, (create {BASE64}).decoded_string (ll_content.item)))
							end
						end
					Result.set_files (l_list)
				end
			end
		end

	upload_temporary_files_cj (a_form: ESA_INTERACTION_FORM_VIEW)
			-- Handle temporary and uploaded files from an CJ template with attachment extensions.
		local
			l_found : BOOLEAN
			l_temporary_files : LIST[ESA_FILE_VIEW]
		do
			l_temporary_files := api_service.temporary_interation_attachments (a_form.id)
				-- Remove not selected files
			across l_temporary_files as c loop
				if attached a_form.uploaded_files as l_uploaded_files then
					across l_uploaded_files as lf loop
						if c.item.name.same_string (lf.item.name) then
							l_found := True
						end
					end
					if not l_found then
						api_service.remove_temporary_interaction_attachment (a_form.id, c.item.name)
					else
						l_found := False
					end
				end
			end

				-- Upload new files.
			if attached a_form.uploaded_files as l_uploaded_files then
				across l_uploaded_files as lf loop
					across l_temporary_files as c loop
						if c.item.name.same_string (lf.item.name) then
							l_found := True
						end
					end
					if not l_found then
						api_service.upload_temporary_interaction_attachment (a_form.id, lf.item)
					else
						l_found := False
					end
				end
			end
		end

	upload_temporary_files_html (req: WSF_REQUEST; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Handle temporary and uploaded files from an HTML form.
		local
			l_found: BOOLEAN
		do
					-- Update temporary files
			if req.form_parameter ("temporary_files") = Void then
					-- remove all the attached files.
				api_service.remove_all_temporary_interaction_attachments (a_form.id)
			elseif attached {WSF_STRING} req.form_parameter ("temporary_files") as l_file and then
				l_file.is_string then
				across api_service.temporary_interation_attachments (a_form.id) as c loop
					if not c.item.name.same_string (l_file.value) then
						api_service.remove_temporary_interaction_attachment (a_form.id, c.item.name)
					end
				end
				a_form.add_temporary_file_name (l_file.value)
			elseif attached {WSF_MULTIPLE_STRING} req.form_parameter ("temporary_files") as l_files then
				across api_service.temporary_interation_attachments (a_form.id) as c loop
					across l_files as lf loop
						if c.item.name.same_string (lf.item.value) then
							l_found := True
						end
					end
					if not l_found then
						api_service.remove_temporary_interaction_attachment (a_form.id, c.item.name)
					else
						l_found := False
					end
				end
				across l_files as lf loop
					a_form.add_temporary_file_name (lf.item.value)
				end
			end
				-- Add new uploaded files
			if attached a_form.uploaded_files as l_files then
				across l_files as c loop
					to_implement ("Refactor code, extract hardcoded variable to a constant.")
					if c.item.size.to_natural_64 <= ({NATURAL_64}10*1024*1024) then
						api_service.upload_temporary_interaction_attachment (a_form.id, c.item)
						a_form.add_temporary_file_name (c.item.name)
					else
						-- Not accepted file too big.
						to_implement("Add the name of the file as a list of rejected files.")
						log.write_alert (generator + ".upload_temporary_files_html File " + c.item.name.to_string_8 + " rejected, too big." )
					end
				end
			end
  		end

	selected_item_by_synopsis (a_items: LIST [REPORT_SELECTABLE]; a_synopsis: READABLE_STRING_32): INTEGER
			-- Retrieve the current selected item.
		local
			l_found: BOOLEAN
			l_item: REPORT_SELECTABLE
		do
			from
				a_items.start
			until
				a_items.after or l_found
			loop
				l_item := a_items.item_for_iteration
				if a_synopsis.is_case_insensitive_equal (l_item.synopsis) then
					Result := l_item.id
					l_found := True
				end
				a_items.forth
			end
		end

end
