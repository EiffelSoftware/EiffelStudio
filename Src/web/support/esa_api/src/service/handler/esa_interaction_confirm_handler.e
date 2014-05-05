note
	description: "Summary description for {ESA_INTERACTION_CONFIRM_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_INTERACTION_CONFIRM_HANDLER

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
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached {STRING_32} current_user_name (req) as l_user and then
			   attached {WSF_STRING} req.path_parameter("report_id") as l_report_id and then l_report_id.is_integer and then
			   attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer  then
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).interaction_form_confirm_page (req, res, l_report_id.integer_value, l_id.integer_value)
				else
					l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).interaction_form_confirm_page (req, res, l_report_id.integer_value, l_id.integer_value)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached {STRING_32} current_user_name (req) as l_user then
				if attached current_media_type (req) as l_type then
					to_implement ("send_new_report_email (l_number)")
					api_service.commit_interaction (extract_form_data(req, l_type))
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).interaction_form_confirm_redirect (req, res)
				else
					l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).interaction_form_confirm_redirect (req, res)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config,l_type,media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config,"",media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

	extract_form_data (req: WSF_REQUEST; a_type: READABLE_STRING_32): INTEGER
		local
			l_parser: JSON_PARSER
		do
			if a_type.same_string ("application/vnd.collection+json") then
				create l_parser.make_parser (retrieve_data (req))
				if attached {JSON_OBJECT} l_parser.parse as jv and then l_parser.is_parsed and then
					attached {JSON_OBJECT}jv.item ("template") as l_template and then
					attached {JSON_ARRAY}l_template.item ("data") as l_data then
					if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
						 l_name.item.same_string ("confirm") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value and then l_value.item.is_integer then
						Result := l_value.item.to_integer
					end
				end
			else
				if attached {WSF_STRING} req.form_parameter ("confirm") as l_confirm and then l_confirm.is_integer then
					Result := l_confirm.integer_value
				end
			end
		end
end
