note
	description: "[
					Handle user report a new problem as a temporary report problem.
				    Also handle update a temporary report problem after completing the first step.
				   ]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_FORM_HANDLER

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
			-- <Precursor>
		do
			if attached req.path_parameter ("id") then
					-- Edit a Report Problem
				debug
					log.write_information (generator+".do_get Processing request edit_report_problem")
				end
				edit_report_problem (req, res)
			else
					-- New Report Problem
				debug
					log.write_information (generator+".do_get Processing request new_report_problem")
				end
				new_report_problem (req, res)
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			if attached req.path_parameter ("id") then
					-- Update a Report Problem
				debug
					log.write_information (generator+".do_post Processing request update_report_problem")
				end
				update_report_problem (req, res)
			else
					-- Initialize Report Problem
				debug
					log.write_information (generator+".do_post Processing request initialize_report_problem")
				end
				initialize_report_problem (req, res)
			end
		end

feature {NONE} -- Edit Report Problem

	edit_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Edit an existing temporary report problem.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
				if attached {READABLE_STRING_32} current_user_name (req) as l_user then
						-- Logged in user
					if attached  current_media_type (req) as l_type then
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form (req, res, edit_form (l_id.integer_value))
					else
						l_rhf.new_representation_handler (esa_config, Empty_string,  media_type_variants (req)).report_form (req, res, Void)
					end
				else -- Not a logged in user
					if attached  current_media_type (req) as l_type then
						l_rhf.new_representation_handler (esa_config, l_type,  media_type_variants (req)).new_response_unauthorized (req, res)
					else
						l_rhf.new_representation_handler (esa_config, Empty_string,  media_type_variants (req)).new_response_unauthorized (req, res)
					end
				end
			else
				to_implement ("Find a better way to handle not acceptable")
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).bad_request_page (req, res)
				end
			end
		end

	edit_form (a_report_id: INTEGER): ESA_REPORT_FORM_VIEW
			-- edit form realted to `a_report_id'.
		do
			create Result.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)
			Result.set_id (a_report_id)
			if attached {TUPLE [synopsis: detachable STRING_32;
							release: detachable STRING;
							confidential: detachable STRING;
							environment: detachable STRING;
							description: detachable STRING_32;
							toreproduce: detachable STRING_32;
							priority_synopsis: detachable STRING_32;
							category_synopsis: detachable STRING;
							severity_synopsis: detachable STRING;
							class_synopsis: detachable STRING;
							user_name: detachable STRING;
							responsible: detachable STRING]} api_service.temporary_problem_report (a_report_id) as l_row then
				if attached l_row.synopsis as l_synopsis then
					Result.set_synopsis (l_synopsis)
				end
				if attached l_row.release as l_release then
					Result.set_release (l_release)
				end
				if attached l_row.confidential as l_confidential then
					Result.set_confidential (l_confidential.to_boolean)
				end
				if attached l_row.environment as l_environment then
					Result.set_environment (l_environment)
				end
				if attached l_row.description as l_description then
					Result.set_description (l_description)
				end
				if attached l_row.toreproduce as l_toreproduce then
					Result.set_to_reproduce (l_toreproduce)
				end
				if attached l_row.priority_synopsis as l_synopsis then
					Result.set_priority (selected_item_by_synopsis (Result.priorities, l_synopsis))
				end
				if attached l_row.category_synopsis as l_category then
					Result.set_category (selected_item_by_synopsis (Result.categories, l_category))
				end
				if attached l_row.severity_synopsis as l_severity then
					Result.set_severity (selected_item_by_synopsis (Result.severities, l_severity))
				end
				if attached l_row.class_synopsis as l_class then
					Result.set_selected_class (selected_item_by_synopsis (Result.classes, l_class))
				end
			end
			Result.set_temporary_files (api_service.temporary_problem_report_attachments (a_report_id))
		end

feature {NONE} -- New Report Problem

	new_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Create a new report problem.
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_form: ESA_REPORT_FORM_VIEW
			l_user_agent: ESA_USER_AGENT
		do
			create l_rhf
			media_variants := media_type_variants (req)
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				to_implement ("Check user roles")
				create l_user_agent.make_from_string (req.http_user_agent)
				if attached current_media_type (req) as l_type then
					create l_form.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)
					l_form.set_environment (l_user_agent.os_family)
					l_form.set_stable_version (eiffel_versions)
					l_rhf.new_representation_handler (esa_config, l_type, media_variants).report_form (req, res, l_form)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_variants).report_form (req, res, Void)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_variants).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_variants).new_response_unauthorized (req, res)
				end
			end
		end

feature {NONE} -- Update Report Problem

	update_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Update a temporary report problem.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_form: ESA_REPORT_FORM_VIEW
		do
			create l_rhf
			if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
				if attached {READABLE_STRING_32} current_user_name (req) as l_user then
						-- Logged in user
					to_implement ("Check user roles")
					if attached current_media_type (req) as l_type then
						l_form := extract_form_data (req, l_type)
						l_form.set_id (l_id.integer_value)
						if l_form.is_valid_form then
							update_report_problem_internal (req, l_form, l_type)
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form_confirm (req, res, l_form)
						else
								-- Bad request
							l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form_confirm (req, res, l_form)
						end
					else
						l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).report_form_confirm (req, res, Void)
					end
				else -- Not a logged in user
					if attached current_media_type (req) as l_type then
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
					else
						l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				end
			else
				to_implement ("Find a better way to handle not acceptable")
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).bad_request_page (req, res)
				end
			end
		end


	update_report_problem_internal (req: WSF_REQUEST; a_form: ESA_REPORT_FORM_VIEW; a_type: READABLE_STRING_8)
			-- Update problem report.
		local
			l_reproduce: STRING_32
		do
			l_reproduce := Empty_string
			if attached a_form.synopsis as l_synopsis and then attached a_form.release as l_release and then
				   attached a_form.environment as l_environment and then attached a_form.description as l_description then
				   if  attached a_form.to_reproduce as ll_reproduce then
				     l_reproduce := ll_reproduce
				   end
				api_service.update_problem_report (a_form.id, a_form.priority.out, a_form.severity.out, a_form.category.out, a_form.selected_class.out, a_form.confidential.out, l_synopsis, l_release, l_environment, l_description, l_reproduce)

					-- Update temporary files
				if a_type.same_string ("application/vnd.collection+json") then

					upload_temporary_files_cj (a_form)
				else
					upload_temporary_files_html (req, a_form)
				end

			end
		end


feature -- Initialize Report Problem

	initialize_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Initialize a new temporay report problem.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_temp_report_id: INTEGER
			l_form: ESA_REPORT_FORM_VIEW
		do
			create l_rhf
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
					-- Logged in user
					-- Extract data from the req
				l_temp_report_id := api_service.new_problem_report_id (l_user)
				if attached current_media_type (req) as l_type then
					l_form := extract_form_data (req, l_type)
					l_form.set_id (l_temp_report_id)
					if l_form.is_valid_form then
						initialize_report_problem_internal (req, l_form)
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form_confirm (req, res, l_form)
					else
							-- Bad Request
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form_error (req, res, l_form)
					end
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).report_form_confirm (req, res, Void)
				end
			else
					-- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

	initialize_report_problem_internal (req: WSF_REQUEST; a_form: ESA_REPORT_FORM_VIEW)
			-- Initialize problem report.
		require
			is_valid: a_form.is_valid_form
		local
			l_reproduce: STRING_32
		do
		    l_reproduce := Empty_string
			if attached a_form.synopsis as l_synopsis and then attached a_form.release as l_release and then
			   attached a_form.environment as l_environment and then attached a_form.description as l_description then

			    if  attached a_form.to_reproduce as ll_reproduce then
			      l_reproduce := ll_reproduce
			    end
				api_service.initialize_problem_report (a_form.id, a_form.priority.out, a_form.severity.out, a_form.category.out, a_form.selected_class.out, a_form.confidential.out, l_synopsis, l_release, l_environment, l_description, l_reproduce)

				if attached a_form.uploaded_files as l_files then
					across l_files as c loop
						-- Max Size File 10MB.
						to_implement ("Refactor code, extract hardcoded variable to a constant.")
						if c.item.size.to_natural_64 <= ({NATURAL_64}10*1024*1024) then
							api_service.upload_temporary_report_attachment (a_form.id, c.item)
							a_form.add_temporary_file_name (c.item.name)
						else
								-- Not accepted file too big.
							to_implement("Add the name of the file as a list of rejected files.")
						end
					end
				end
			end

		end

feature {NONE} -- Implementation


	extract_form_data (req: WSF_REQUEST; a_type: READABLE_STRING_8): ESA_REPORT_FORM_VIEW
			-- Example form parameters
			--"category=5"
			--"severity=1"
			--"priority=1"
			--"class=1"
			--"confidential=0"
			--"release=14.05"
			--"synopsis=test"
			--"environment=download"
			--"description=test"
			--"to_reproduce=test".
		do

			create Result.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_form_data_cj (req)
			else
				Result := extract_form_data_form_parameters (req)
			end
		end


	extract_form_data_cj (req: WSF_REQUEST): ESA_REPORT_FORM_VIEW
			-- Extract data from collection+json template.
		local
			l_parser: JSON_PARSER
			l_content: STRING
			l_list: LIST [ESA_FILE_VIEW]
			l_test: STRING_8
		do
			create Result.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY} l_template.item ("data") as l_data then
				--		 <"name":  "category", "prompt": "Category", "value": "">,
				--        <"name": "severity", "prompt": "Severity", "value": "">,
				--        <"name": "priority", "prompt": "Priority", "value": "">,
				--        <"name": "class", "prompt": "Class", "value": "">,
				--        <"name": "release", "prompt": "Release", "value": "">,
				--        <"name": "confidential", "prompt": "Confidential", "value": "">,
				--        <"name": "synopsis", "prompt": "Synopsis", "value": "">,
				--        <"name": "environment", "prompt": "Environment", "value": "">,
				--        <"name": "description", "prompt": "Description", "value": "">,
				--        <"name": "to_reproduce", "prompt": "To Reproduce", "value": "">

				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("category") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
					Result.set_category (l_value.item.to_integer)
				end
				if attached {JSON_OBJECT} l_data.i_th (2) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("severity") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
					Result.set_severity (l_value.item.to_integer)
				end
				if attached {JSON_OBJECT} l_data.i_th (3) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("priority") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
					Result.set_priority (l_value.item.to_integer)
				end
				if attached {JSON_OBJECT} l_data.i_th (4) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("class") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
					Result.set_selected_class (l_value.item.to_integer)
				end
				if attached {JSON_OBJECT} l_data.i_th (5) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("release") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then not l_value.item.is_empty then
					Result.set_release (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (6) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				    l_name.item.same_string ("confidential") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
					Result.set_confidential (l_value.item.to_integer.to_boolean)
				end
				if attached {JSON_OBJECT} l_data.i_th (7) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("synopsis") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then not l_value.item.is_empty then
					create l_test.make_empty
					l_value.unescape_to_string_8 (l_test)
					Result.set_synopsis ((create {UTF8_ENCODER}).encoded_string (l_test))
				end
				if attached {JSON_OBJECT} l_data.i_th (8) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("environment") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then not l_value.item.is_empty then
					Result.set_environment (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (9) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("description") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then not l_value.item.is_empty then
					create l_test.make_empty
					l_value.unescape_to_string_8 (l_test)
					Result.set_description ((create {UTF8_ENCODER}).encoded_string (l_test))
				end
				if attached {JSON_OBJECT} l_data.i_th (10) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				   l_name.item.same_string ("to_reproduce") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then not l_value.item.is_empty then
					create l_test.make_empty
					l_value.unescape_to_string_8 (l_test)
					Result.set_to_reproduce ((create {UTF8_ENCODER}).encoded_string (l_test))
				end
				if attached {JSON_OBJECT} l_data.i_th (11) as l_form_data and then attached {JSON_ARRAY} l_form_data.item ("files") as l_files  then
					create {ARRAYED_LIST [ESA_FILE_VIEW]} l_list.make (0)
					across l_files as c  loop
						if attached {JSON_OBJECT} c.item as jo and then attached {JSON_STRING} jo.item("name") as l_key and then
							attached {JSON_STRING} jo.item("value") as ll_content then
							l_content := (create {BASE64}).decoded_string (ll_content.item)
							l_list.force (create {ESA_FILE_VIEW}.make (l_key.item, l_content.count, l_content))
						end
					end
					Result.set_files (l_list)
				end
			end
		end

	extract_form_data_form_parameters (req: WSF_REQUEST): ESA_REPORT_FORM_VIEW
			-- Extract data from form parameters.
		local
			l_size: INTEGER
			l_name: READABLE_STRING_32
			l_content: STRING
			l_list: LIST[ESA_FILE_VIEW]
		do
			create Result.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)
				--Category
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer then
				Result.set_category (l_category.integer_value)
			end
				--Severity
			if attached {WSF_STRING} req.form_parameter ("severity") as l_severity and then l_severity.is_integer then
				Result.set_severity (l_severity.integer_value)
			end
				--Priority
			if attached {WSF_STRING} req.form_parameter ("priority") as l_priority and then l_priority.is_integer then
				Result.set_priority (l_priority.integer_value)
			end
				--Class
			if attached {WSF_STRING} req.form_parameter ("class") as l_class and then l_class.is_integer then
				Result.set_selected_class (l_class.integer_value)
			end
				--Confidential
			if attached {WSF_STRING} req.form_parameter ("confidential") as l_confidential and then l_confidential.is_integer and then l_confidential.integer_value >= 0 and then l_confidential.integer_value <= 1 then
				Result.set_confidential (l_confidential.integer_value.to_boolean)
			end
				--Release
			if attached {WSF_STRING} req.form_parameter ("release") as l_release then
				Result.set_release (l_release.value)
			end
				--Synopsis
			if attached {WSF_STRING} req.form_parameter ("synopsis") as l_synopsis then
				Result.set_synopsis (l_synopsis.value)
			end
				--Environment
			if attached {WSF_STRING} req.form_parameter ("environment") as l_environment then
				Result.set_environment (l_environment.value)
			end
				--Description
			if attached {WSF_STRING} req.form_parameter ("description") as l_description then
				Result.set_description (l_description.value)
			end
				--To Reproduce (Optional)
			if attached {WSF_STRING} req.form_parameter ("to_reproduce") as l_to_reproduce then
				Result.set_to_reproduce (l_to_reproduce.value)
			end
			if req.has_uploaded_file then
				create {ARRAYED_LIST [ESA_FILE_VIEW]} l_list.make (0)
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


	upload_temporary_files_cj (a_form: ESA_REPORT_FORM_VIEW)
			-- Handle temporary and uploaded files from an CJ template with attachment extensions.
		local
			l_found : BOOLEAN
			l_temporary_files : LIST [ESA_FILE_VIEW]
		do
			l_temporary_files := api_service.temporary_problem_report_attachments (a_form.id)
				-- Remove not selected files
			across l_temporary_files as c loop
				if attached a_form.uploaded_files as l_uploaded_files then
					across l_uploaded_files as lf loop
						if c.item.name.same_string (lf.item.name) then
							l_found := True
						end
					end
					if not l_found then
						api_service.remove_temporary_report_attachment (a_form.id, c.item.name)
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
						api_service.upload_temporary_report_attachment (a_form.id, lf.item)
					else
						l_found := False
					end
				end
			end
		end

	upload_temporary_files_html (req: WSF_REQUEST; a_form: ESA_REPORT_FORM_VIEW)
			-- Handle temporary and uploaded files from an HTML form.
		local
			l_found: BOOLEAN
		do
			-- text/html
			if req.form_parameter ("temporary_files") = Void then
					-- remove all the attached files.
				api_service.remove_all_temporary_report_attachments (a_form.id)
			elseif attached {WSF_STRING} req.form_parameter ("temporary_files") as l_file and then
					l_file.is_string then
				across api_service.temporary_problem_report_attachments (a_form.id) as c loop
					if not c.item.name.same_string (l_file.value) then
						api_service.remove_temporary_report_attachment (a_form.id, c.item.name)
					end
				end
				a_form.add_temporary_file_name (l_file.value)
			elseif attached {WSF_MULTIPLE_STRING} req.form_parameter ("temporary_files") as l_files then
				across api_service.temporary_problem_report_attachments (a_form.id) as c loop
					across l_files as lf loop
						if c.item.name.same_string (lf.item.value) then
							l_found := True
						end
					end
					if not l_found then
						api_service.remove_temporary_report_attachment (a_form.id, c.item.name)
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
						-- Max Size File 10MB.
					to_implement ("Refactor code, extract hardcoded variable to a constant.")
					if c.item.size.to_natural_64 <= ({NATURAL_64}10*1024*1024) then
						api_service.upload_temporary_report_attachment (a_form.id, c.item)
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
			-- Retrieve the current selected item
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
