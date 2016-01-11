note
	description: "Activation handler."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACTIVATION_HANDLER

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
			l_activation_view: ESA_ACTIVATION_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				create l_activation_view
				if
					attached {WSF_STRING} req.query_parameter ("code") as l_code and then
					attached {WSF_STRING} req.query_parameter ("email") as l_email
				then
					l_activation_view.set_email (l_email.value)
					l_activation_view.set_token (l_code.value)
				end

				log.write_information (generator + ".do_get Procesing Request using media_type: " + l_type)
		    		-- Activation Form

				l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).activation_page (req, res, l_activation_view)
			else
					-- Get request to /activation
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).activation_page (req, res, Void)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_activation_view: ESA_ACTIVATION_VIEW
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				log.write_information (generator + ".do_post Procesing Request using media_type: " + l_type)
				l_activation_view := extract_data_from_request (req, l_type)
				if l_activation_view.is_valid_form and then
					attached l_activation_view.email as l_email and then
					attached l_activation_view.token as l_token and then
		    		api_service.activation_valid (l_email, l_token) then
		    				-- Activation was ok
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).activation_confirmation_page (req, res)
		    	else
		    			-- Activation failed
		    		if attached api_service.last_error as l_error then
		    			l_activation_view.set_error_message (l_error.error_message)
		    		else
		    				-- Default message
			    		l_activation_view.set_error_message ("Activation failed, check activation code and e-mail.")
					end
					api_service.set_successful
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).activation_page (req, res, l_activation_view)
				end
			else
					-- Get request to /activation
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).activation_page (req, res, Void)
			end
		end

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_32): ESA_ACTIVATION_VIEW
			-- Is the form data populated?
			-- Create a new activation view object based on request parameters, if any
		do

			if a_type.same_string ({STRING_32} "application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): ESA_ACTIVATION_VIEW
			-- Extract request form CJ data and build a object
			-- register view.
		local
			l_parser: JSON_PARSER
		do
			create Result
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY}l_template.item ("data") as l_data then
					--	<"name": "first_name", "prompt": "Frist Name", "value": "{$form.first_name/}">,
					-- 	<"name": "last_name", "prompt": "Last Name", "value": "{$form.last_name/}">,
				if attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("email") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_email (l_value.item)
				end
				if attached {JSON_OBJECT} l_data.i_th (2) as l_form_data and then attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("token") and then  attached {JSON_STRING} l_form_data.item ("value") as l_value  then
					Result.set_token (l_value.item)
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST): ESA_ACTIVATION_VIEW
			-- Extract request form data and build a object
			-- register view.
		do
			create Result
			if attached {WSF_STRING} req.form_parameter ("email") as l_email then
				Result.set_email (l_email.value)
			end
			if attached {WSF_STRING} req.form_parameter ("token") as l_token then
				Result.set_token (l_token.value)
			end
		end
end
