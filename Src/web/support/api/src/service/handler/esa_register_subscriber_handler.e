note
	description: "[
			This handler allows problem reports responsibles to register with categories
			so they receive notifications when a pr in that category is received.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REGISTER_SUBSCRIBER_HANDLER

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
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_role: USER_ROLE
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				if attached current_user_name (req) as l_user then
					debug
						log.write_information ( generator+".do_get Processing request: user:" + l_user.to_string_8  )
					end
					l_role := api_service.role (l_user)
					if l_role.is_administrator or else l_role.is_responsible then
						-- Show subscribe to category page
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).subscribe_to_category (req, res, api_service.subscribed_categories (l_user))
					else
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_authenticate (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).subscribe_to_category (req, res, Void)
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
					api_service.register_subscriber (l_user, extract_data_from_request (req, l_type))
					if api_service.successful then
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).subscribe_to_category (req, res, api_service.subscribed_categories (l_user))
					else
						log.write_critical (generator + ".do_post" +  api_service.last_error_message.to_string_8)
						l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).internal_server_error (req, res)
					end
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			else
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).change_email (req, res, Void)
			end
		end

feature -- Implementation

	extract_data_from_request (req: WSF_REQUEST; a_type: READABLE_STRING_8): LIST [INTEGER]
			-- Is the form data populated?
		do

			if a_type.same_string ("application/vnd.collection+json") then
				Result := extract_data_from_cj (req)
			else
				Result :=  extract_data_from_form (req)
			end
		end

	extract_data_from_cj (req: WSF_REQUEST): LIST [INTEGER]
			-- Extract request form CJ data and build a object
			-- password view.
		local
			l_parser: JSON_PARSER
		do
			create {ARRAYED_LIST[INTEGER]} Result.make (5)
			create l_parser.make_with_string (retrieve_data (req))
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
			   attached {JSON_OBJECT} jv.item ("template") as l_template and then
			   attached {JSON_ARRAY} l_template.item ("data") as l_data and then
			   l_data.count > 0 and then attached {JSON_OBJECT} l_data.i_th (1) as l_elem and then
			   attached {JSON_ARRAY} l_elem.item ("array") as l_array
			then
				across l_array as c  loop
					if attached {JSON_STRING} c.item as jo  then
							Result.force (jo.item.to_integer)
					end
				end
			end
		end

	extract_data_from_form (req: WSF_REQUEST): LIST [INTEGER]
			-- Extract request form data and build a list of id.
		do
			create {ARRAYED_LIST [INTEGER]}Result.make (5)
			if attached {WSF_STRING} req.form_parameter ("subscriber_to_category") as l_category then
				Result.force (l_category.integer_value)
			elseif attached {WSF_MULTIPLE_STRING} req.form_parameter ("subscriber_to_category") as l_multiple_category then
				across l_multiple_category.values as c loop Result.force (c.item.integer_value) end
			end
		end

end

