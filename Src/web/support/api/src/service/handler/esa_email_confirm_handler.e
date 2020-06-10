note
	description: "[
					Handle email confirmation, show a form and also handle the post.
				    ]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_EMAIL_CONFIRM_HANDLER

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
			-- Execute request handler.
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_view: ESA_EMAIL_VIEW
			l_tuple: TUPLE [age:INTEGER; email: detachable STRING_32]
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if 	attached current_user_name (req) as l_user then
					if attached {WSF_STRING} req.query_parameter ("token") as l_token then
						l_tuple := api_service.user_token_new_email (l_token.value, l_user)
						create l_view
						if attached l_tuple.email as l_new_email then
							l_view.set_email (l_new_email)
						end
						if api_service.successful then
							l_view.set_token (l_token.value)
						else
							l_view.add_error ("Confirm New Email Error", api_service.last_error_message)
						end
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).confirm_change_email (req, res, l_view)
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).confirm_change_email (req, res, Void)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached current_user_name (req) as l_user then
					if attached extract_data_from_request(req, l_type) as l_token then
						api_service.update_email_from_user_and_token (l_user, l_token)
					   	if api_service.successful then
						 	 l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).post_confirm_email_change_page (req, res)
						else
                        	 api_service.set_successful
                        	 l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
						end
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).bad_request_page (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config,Empty_string, media_type_variants (req)).post_confirm_email_change_page (req, res)
			end
		end

feature -- Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_8): detachable STRING
			-- Is the form data populated?
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): detachable STRING
			-- Extract token.
		local
			l_parser: JSON_PARSER
		do
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if
				attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   	attached {JSON_OBJECT} jv.item ("template") as l_template and then
			  	attached {JSON_ARRAY}l_template.item ("data") as l_data and then
					--  <"name": "token", "prompt": "Token", "value": "{$form.token/}">,
				attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then
				attached {JSON_STRING} l_form_data.item ("name") as l_name and then
				l_name.item.same_string ("token") and then
				attached {JSON_STRING} l_form_data.item ("value") as l_value
			then
				Result := l_value.item
			end
		end

	extract_data_from_form (req: WSF_REQUEST): detachable STRING_8
			-- Extract token.
		do
			if attached {WSF_STRING} req.form_parameter ("token") as l_email then
				Result := l_email.value.to_string_8
			end
		end

end




