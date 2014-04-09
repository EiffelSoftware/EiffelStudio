note
	description: "Summary description for {ESA_REPORT_CONFIRM_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_CONFIRM_HANDLER

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
			if attached {STRING_32} current_user_name (req) as l_user and then
			   attached {WSF_STRING} req.path_parameter("id") as l_id and then l_id.is_integer then
			   	api_service.commit_problem_report (l_id.integer_value)
			   	to_implement ("l_number := Data_provider.last_problem_report_number")
			   	to_implement ("send_new_report_email (l_number)")
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).report_form_confirm_redirect (req, res)
				else
					l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).report_form_confirm_redirect (req, res)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end
end
