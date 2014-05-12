note
	description: "Object that handle report details resources, for guest and registered users."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_DETAIL_HANDLER

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
		do
			if attached current_user_name (req) as l_user then
					-- Logged in user
					-- Report, Interactions, Attachments
				log.write_information (generator + ".do_get Processing request user_report_details ")
				user_report_details (req, res, l_user)
			else
					-- Guest user
					-- Report, Interactions, Attachments
				log.write_information (generator + ".do_get Processing request guest_report_details ")
				guest_report_details (req, res)
			end
		end

feature -- Implementation

	user_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: STRING)
			-- Retrieve report details for a logged in user `a_user'
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer and then api_service.is_report_visible (a_user, l_id.integer_value) then
					retrieve_report_details (req, res, l_type, a_user, l_id.integer_value)
				elseif attached {WSF_STRING} req.query_parameter ("search") as l_id then
					if l_id.is_integer and then api_service.is_report_visible (a_user, l_id.integer_value) then
						retrieve_report_details (req, res, l_type, a_user, l_id.integer_value)
					elseif not l_id.is_integer then
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)). problem_report(req, res, Void)
			end
		end

	retrieve_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_8; a_user: STRING; a_id: INTEGER)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached api_service.problem_report_details (a_user, a_id) as l_report then
				l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).problem_report (req, res, l_report)
			else
				l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).not_found_page (req, res)
			end
		end

	guest_report_details (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Retrieve report details for `Guest' users.
			-- Include visible interactions and attachments.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer and then api_service.is_report_visible_guest (l_id.integer_value) then
					retrieve_guest_report_details (req, res, l_type, l_id.integer_value)
				elseif attached {WSF_STRING} req.query_parameter ("search") as l_id and then l_id.is_integer and then api_service.is_report_visible_guest (l_id.integer_value) then
					retrieve_guest_report_details (req, res, l_type, l_id.integer_value)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, "", media_type_variants (req)). problem_report(req, res, Void)
			end
		end

	retrieve_guest_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_8; a_id: INTEGER)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached api_service.problem_report_details_guest (a_id) as l_report then
				l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).problem_report (req, res, l_report)
			else
				l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).not_found_page (req, res)
			end
		end

end
