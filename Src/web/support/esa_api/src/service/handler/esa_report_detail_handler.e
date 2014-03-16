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
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
						retrieve_report_details (req, res, l_type, l_id.integer_value, l_rhf, media_variants)
					elseif attached {WSF_STRING} req.query_parameter ("search") as l_id and then l_id.is_integer then
						retrieve_report_details (req, res, l_type, l_id.integer_value, l_rhf, media_variants)
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_variants).bad_request_page (req, res)
					end
				end
			else
				create l_rhf
				l_rhf.new_representation_handler (esa_config, "", media_variants).problem_report (req, res, Void)
			end
		end

feature -- Implementation

	retrieve_report_details (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_8; a_id: INTEGER; a_rhf: ESA_REPRESENTATION_HANDLER_FACTORY; media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS)
		do
			if attached current_user_name (req) as l_user and then api_service.is_report_visible (l_user, a_id)then
				retrieve_report_details_internal (req, res, a_type, a_id, a_rhf, media_variants)
			elseif api_service.is_report_visible_guest (a_id) then
				retrieve_report_details_internal (req, res, a_type, a_id, a_rhf, media_variants)
			else
				a_rhf.new_representation_handler (esa_config, a_type, media_variants).new_response_unauthorized (req, res)
			end
		end


	retrieve_report_details_internal (req: WSF_REQUEST; res: WSF_RESPONSE; a_type: READABLE_STRING_8; a_id: INTEGER; a_rhf: ESA_REPRESENTATION_HANDLER_FACTORY; media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS)
		do
			if attached api_service.problem_report (a_id) as l_report then
				a_rhf.new_representation_handler (esa_config, a_type, media_variants).problem_report (req, res, l_report)
			else
				a_rhf.new_representation_handler (esa_config, a_type, media_variants).not_found_page (req, res)
			end
		end

end
