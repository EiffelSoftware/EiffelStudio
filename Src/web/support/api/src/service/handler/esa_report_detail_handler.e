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

feature {NONE} -- Implementation

	user_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_user: READABLE_STRING_32)
			-- Retrieve report details for a logged in user `a_user'
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if	attached {WSF_STRING} req.path_parameter ("id") as l_id then
					retrieve_report_by (req, res, l_type, a_user, l_id.value)
				elseif attached {WSF_STRING} req.query_parameter ("search") as l_id then
					search_report (req, res, l_type, a_user)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)). problem_report(req, res, Void)
			end
		end

	retrieve_report_by (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_32; a_user: READABLE_STRING_32; a_id: READABLE_STRING_32 )
			-- Retrieve a report by a given ID in a path parameter /{$id}
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if	a_id.is_integer	then
				if api_service.exist_report (a_id.to_integer) then
					if  api_service.is_report_visible (a_user, a_id.to_integer) then
						retrieve_report_details (req, res, a_type, a_user, a_id.to_integer)
					else
						l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).not_found_page (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).bad_request_page (req, res)
			end

		end

	search_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_32; a_user: READABLE_STRING_32)
			-- Search a report by a given if from a query, search=?.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_validator: ESA_REPORT_DETAIL_INPUT_VALIDATOR
		do
			create l_rhf
			create l_validator
			l_validator.input_from (req.query_parameters)
			if not l_validator.has_error then
				if api_service.exist_report (l_validator.search) then
					if  api_service.is_report_visible (a_user, l_validator.search ) then
						retrieve_report_details (req, res, a_type, a_user, l_validator.search)
					else
						l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).not_found_page (req, res)
				end
			else
				-- Bad request
				log.write_error (generator + ".responsible_reports " + l_validator.error_message)
				l_rhf.new_representation_handler (esa_config, a_type,  media_type_variants (req)).bad_request_with_errors_page (req, res, l_validator.errors)
			end
		end

	retrieve_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_32; a_user: READABLE_STRING_32; a_id: INTEGER)
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
				if	attached {WSF_STRING} req.path_parameter ("id") as l_id then
					retrieve_guest_report_by (req, res, l_type, l_id.value)
				elseif attached {WSF_STRING} req.query_parameter ("search") as l_id then
					search_guest_report (req, res, l_type)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)). problem_report(req, res, Void)
			end
		end

	retrieve_guest_report_by (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_32; a_id: READABLE_STRING_32 )
			-- Retrieve a report by a given ID in a path parameter /{$id}.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if	a_id.is_integer	then
				if api_service.exist_report (a_id.to_integer) then
					if  api_service.is_report_visible_guest (a_id.to_integer) then
						retrieve_guest_report_details (req, res, a_type, a_id.to_integer)
					else
						l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).not_found_page (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).bad_request_page (req, res)
			end

		end

	search_guest_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_32)
			-- Search a report by a given if from a query, search=?.
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_validator: ESA_REPORT_DETAIL_INPUT_VALIDATOR
		do
			create l_rhf
			create l_validator
			l_validator.input_from (req.query_parameters)
			if not l_validator.has_error then
				if api_service.exist_report (l_validator.search) then
					if  api_service.is_report_visible_guest ( l_validator.search ) then
						retrieve_guest_report_details (req, res, a_type, l_validator.search)
					else
						l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, a_type, media_type_variants (req)).not_found_page (req, res)
				end
			else
				-- Bad request
				log.write_error (generator + ".responsible_reports " + l_validator.error_message)
				l_rhf.new_representation_handler (esa_config, a_type,  media_type_variants (req)).bad_request_with_errors_page (req, res, l_validator.errors)
			end
		end

	retrieve_guest_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_32; a_id: INTEGER)
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
