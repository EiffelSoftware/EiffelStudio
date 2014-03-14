note
	description: "Summary description for {ESA_REPORT_PROBLEM_HANDLER}."
	author: ""
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
		do
			if attached req.path_parameter ("id") then
					-- Edit a Report Problem
				edit_report_problem (req, res)
			else
					-- New Report Problem
				new_report_problem (req, res)
			end
		end




	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_temp_report_id: INTEGER
		do
			if attached req.path_parameter ("id") then
					-- Update a Report Problem
				update_report_problem (req, res)
			else
					-- Initialize Report Problem
				initialize_report_problem (req, res)
			end
		end

feature -- Edit Report Problem

	edit_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_form: ESA_REPORT_FORM_VIEW
		do
			create l_rhf
			if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
				media_variants := media_type_variants (req)
				if attached {STRING_32} current_user_name (req) as l_user then
						-- Logged in user
					to_implement ("Check user roles")
					if media_variants.is_acceptable then
						if attached media_variants.media_type as l_type then
							l_rhf.new_representation_handler (esa_config, l_type, media_variants).report_form (req, res, edit_form (l_id.integer_value))
						end
					else
						l_rhf.new_representation_handler (esa_config, "", media_variants).report_form (req, res, Void)
					end
				else -- Not a logged in user
					if media_variants.is_acceptable then
						if attached media_variants.media_type as l_type then
							l_rhf.new_representation_handler (esa_config, l_type, media_variants).new_response_unauthorized (req, res)
						end
					else
						l_rhf.new_representation_handler (esa_config, "", media_variants).new_response_unauthorized (req, res)
					end
				end
			else
				to_implement ("Find a better way to handle not acceptable")
				media_variants := media_type_variants (req)
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).bad_request_page (req, res)
					else
						l_rhf.new_representation_handler (esa_config, "", media_variants).bad_request_page (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).bad_request_page (req, res)
				end
			end
		end

	edit_form (a_report_id: INTEGER): ESA_REPORT_FORM_VIEW
		local
			l_tuple: detachable TUPLE [synopsis: detachable STRING; release: detachable STRING; confidential: detachable STRING; environment: detachable STRING; description: detachable STRING; toreproduce: detachable STRING; priority_synopsis: detachable STRING; category_synopsis: detachable STRING; severity_synopsis: detachable STRING; class_synopsis: detachable STRING; user_name: detachable STRING; responsible: detachable STRING]
		do
			create Result.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)
			l_tuple := api_service.temporary_problem_report (a_report_id)
			if attached l_tuple as l_row then
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
					set_selected_item_by_synopsis (Result.priorities, l_synopsis)
				end
				if attached l_row.category_synopsis as l_category then
					set_selected_item_by_synopsis (Result.categories, l_category)
				end
				if attached l_row.severity_synopsis as l_severity then
					set_selected_item_by_synopsis (Result.severities, l_severity)
				end
				if attached l_row.class_synopsis as l_class then
					set_selected_item_by_synopsis (Result.classes, l_class)
				end
			end
		end

feature -- New Report Problem

	new_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_form: ESA_REPORT_FORM_VIEW
		do
			create l_rhf
			media_variants := media_type_variants (req)
			if attached {STRING_32} current_user_name (req) as l_user then
					-- Logged in user
				to_implement ("Check user roles")
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						create l_form.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).report_form (req, res, l_form)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).report_form (req, res, Void)
				end
			else -- Not a logged in user
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).new_response_unauthorized (req, res)
				end
			end
		end


feature -- Update Report Problem

	update_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_temp_report_id: INTEGER
		do
			to_implement ("Clean code and make it simpler")
			create l_rhf
			if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
				media_variants := media_type_variants (req)
				if attached {STRING_32} current_user_name (req) as l_user then
						-- Logged in user
					to_implement ("Check user roles")
					if attached extract_form_data (req) as l_form then
					 	if is_valid (req) then
					  		update_report_problem_internal (req, l_id.integer_value)
							if media_variants.is_acceptable then
								if attached media_variants.media_type as l_type then
									l_rhf.new_representation_handler (esa_config, l_type, media_variants).report_form_confirm (req, res, l_form)
								end
							else
								l_rhf.new_representation_handler (esa_config, "", media_variants).report_form_confirm (req, res, Void)
							end
						end
					end
				else -- Not a logged in user
					if media_variants.is_acceptable then
						if attached media_variants.media_type as l_type then
							l_rhf.new_representation_handler (esa_config, l_type, media_variants).new_response_unauthorized (req, res)
						end
					else
						l_rhf.new_representation_handler (esa_config, "", media_variants).new_response_unauthorized (req, res)
					end
				end
			else
				to_implement ("Find a better way to handle not acceptable")
				media_variants := media_type_variants (req)
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).bad_request_page (req, res)
					else
						l_rhf.new_representation_handler (esa_config, "", media_variants).bad_request_page (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, "", media_variants).bad_request_page (req, res)
				end
			end
		end


	update_report_problem_internal (req: WSF_REQUEST; a_report_id: INTEGER)
			-- Update problem report
		require
			is_valid: is_valid (req)
		local
			l_reproduce: STRING_32
		do
			create l_reproduce.make_empty
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer and then attached {WSF_STRING} req.form_parameter ("severity") as l_severity and then l_severity.is_integer and then attached {WSF_STRING} req.form_parameter ("priority") as l_priority and then l_priority.is_integer and then attached {WSF_STRING} req.form_parameter ("class") as l_class and then l_class.is_integer and then attached {WSF_STRING} req.form_parameter ("confidential") as l_confidential and then l_confidential.is_integer and then l_confidential.integer_value >= 0 and then l_confidential.integer_value <= 1 and then attached {WSF_STRING} req.form_parameter ("release") as l_release and then attached {WSF_STRING} req.form_parameter ("synopsis") as l_synopsis and then attached {WSF_STRING} req.form_parameter ("environment") as l_environment and then attached {WSF_STRING} req.form_parameter ("description") as l_description then
				if attached {WSF_STRING} req.form_parameter ("to_reproduce") as l_to_reproduce then
					create l_reproduce.make_from_string (l_to_reproduce)
				end
				api_service.update_problem_report (a_report_id, l_priority.value, l_severity.value, l_category.value, l_class.value, l_confidential.integer_value.to_boolean.out, l_synopsis.value, l_release.value, l_environment.value, l_description.value, l_reproduce)
			end
		end


feature -- Initialize Report Problem

	initialize_report_problem (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_temp_report_id: INTEGER
		do
			create l_rhf
			media_variants := media_type_variants (req)
			if attached {STRING_32} current_user_name (req) as l_user then
					-- Logged in user
					-- Extract data from the req
				l_temp_report_id := api_service.new_problem_report_id (l_user)
				if attached extract_form_data (req) as l_form then
					if is_valid (req) then
						initialize_report_problem_internal (req, l_temp_report_id)
						l_form.set_id (l_temp_report_id)
						if media_variants.is_acceptable then
							if attached media_variants.media_type as l_type then
								l_rhf.new_representation_handler (esa_config, l_type, media_variants).report_form_confirm (req, res, l_form)
							end
						else
							l_rhf.new_representation_handler (esa_config, "", media_variants).report_form_confirm (req, res, Void)
						end
					else
							-- Validation Error
					end
				else
						-- Validation Error
				end
			else -- Not a logged in user
				if media_variants.is_acceptable then
					if attached media_variants.media_type as l_type then
						create l_rhf
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).new_response_unauthorized (req, res)
					end
				else
					create l_rhf
					l_rhf.new_representation_handler (esa_config, "", media_variants).new_response_unauthorized (req, res)
				end
			end
		end

	initialize_report_problem_internal (req: WSF_REQUEST; a_report_id: INTEGER)
			-- Initialize problem report
		require
			is_valid: is_valid (req)
		local
			l_reproduce: STRING_32
		do
			create l_reproduce.make_empty
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer and then attached {WSF_STRING} req.form_parameter ("severity") as l_severity and then l_severity.is_integer and then attached {WSF_STRING} req.form_parameter ("priority") as l_priority and then l_priority.is_integer and then attached {WSF_STRING} req.form_parameter ("class") as l_class and then l_class.is_integer and then attached {WSF_STRING} req.form_parameter ("confidential") as l_confidential and then l_confidential.is_integer and then l_confidential.integer_value >= 0 and then l_confidential.integer_value <= 1 and then attached {WSF_STRING} req.form_parameter ("release") as l_release and then attached {WSF_STRING} req.form_parameter ("synopsis") as l_synopsis and then attached {WSF_STRING} req.form_parameter ("environment") as l_environment and then attached {WSF_STRING} req.form_parameter ("description") as l_description then
				if attached {WSF_STRING} req.form_parameter ("to_reproduce") as l_to_reproduce then
					create l_reproduce.make_from_string (l_to_reproduce)
				end
				api_service.initialize_problem_report (a_report_id, l_priority.value, l_severity.value, l_category.value, l_class.value, l_confidential.integer_value.to_boolean.out, l_synopsis.value, l_release.value, l_environment.value, l_description.value, l_reproduce)
			end
		end

feature -- Status Report

	is_valid (req: WSF_REQUEST): BOOLEAN
			-- Are the form values valid?
		do
			Result := attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer and then
					attached {WSF_STRING} req.form_parameter ("severity") as l_severity and then l_severity.is_integer and then
					attached {WSF_STRING} req.form_parameter ("priority") as l_priority and then l_priority.is_integer and then
					attached {WSF_STRING} req.form_parameter ("class") as l_class and then l_class.is_integer and then
					attached {WSF_STRING} req.form_parameter ("confidential") as l_confidential and then l_confidential.is_integer and then
						l_confidential.integer_value >= 0 and then l_confidential.integer_value <= 1 and then
					attached {WSF_STRING} req.form_parameter ("release") as l_release and then
					attached {WSF_STRING} req.form_parameter ("synopsis") as l_synopsis and then
					attached {WSF_STRING} req.form_parameter ("environment") as l_environment and then
					attached {WSF_STRING} req.form_parameter ("description") as l_description
		end

feature {NONE} -- Implementation



	extract_form_data (req: WSF_REQUEST): ESA_REPORT_FORM_VIEW
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
			--"to_reproduce=test"
		do
			create Result.make (api_service.all_categories, api_service.severities, api_service.classes, api_service.priorities)

				--Category
			if attached {WSF_STRING} req.form_parameter ("category") as l_category and then l_category.is_integer then
				set_selected_item (Result.categories, l_category.integer_value)
			else
				to_implement ("Error Handling")
			end
				--Severity
			if attached {WSF_STRING} req.form_parameter ("severity") as l_severity and then l_severity.is_integer then
				set_selected_item (Result.severities, l_severity.integer_value)
			else
				to_implement ("Error Handling")
			end
				--Priority
			if attached {WSF_STRING} req.form_parameter ("priority") as l_priority and then l_priority.is_integer then
				set_selected_item (Result.priorities, l_priority.integer_value)
			else
				to_implement ("Error Handling")
			end
				--Class
			if attached {WSF_STRING} req.form_parameter ("class") as l_class and then l_class.is_integer then
				set_selected_item (Result.classes, l_class.integer_value)
			else
				to_implement ("Error Handling")
			end
				--Confidential
			if attached {WSF_STRING} req.form_parameter ("confidential") as l_confidential and then l_confidential.is_integer and then l_confidential.integer_value >= 0 and then l_confidential.integer_value <= 1 then
				Result.set_confidential (l_confidential.integer_value.to_boolean)
			else
				to_implement ("Error Handling")
			end
				--Release
			if attached {WSF_STRING} req.form_parameter ("release") as l_release then
				Result.set_release (l_release.value)
			else
				to_implement ("Error Handling")
			end
				--Synopsis
			if attached {WSF_STRING} req.form_parameter ("synopsis") as l_synopsis then
				Result.set_synopsis (l_synopsis.value)
			else
				to_implement ("Error Handling")
			end
				--Environment
			if attached {WSF_STRING} req.form_parameter ("environment") as l_environment then
				Result.set_environment (l_environment.value)
			else
				to_implement ("Error Handling")
			end
				--Description
			if attached {WSF_STRING} req.form_parameter ("description") as l_description then
				Result.set_description (l_description.value)
			else
				to_implement ("Error Handling")
			end
				--To Reproduce (Optional)
			if attached {WSF_STRING} req.form_parameter ("to_reproduce") as l_to_reproduce then
				Result.set_to_reproduce (l_to_reproduce.value)
			end
		end

	set_selected_item (a_items: LIST [ESA_REPORT_SELECTABLE]; a_selected_item: INTEGER)
			-- Set the current selected item
		do
			across
				a_items as c
			loop
				c.item.set_selected_id (a_selected_item)
			end
		end

	set_selected_item_by_synopsis (a_items: LIST [ESA_REPORT_SELECTABLE]; a_synopsis: READABLE_STRING_32)
			-- Set the current selected item
		local
			l_found: BOOLEAN
			l_item: ESA_REPORT_SELECTABLE
		do
			from
				a_items.start
			until
				a_items.after or l_found
			loop
				l_item := a_items.item_for_iteration
				if a_synopsis.is_case_insensitive_equal (l_item.synopsis) then
					l_item.set_selected_id (l_item.id)
					l_found := True
				end
				a_items.forth
			end
		end

end
