note
	description: "Authentication Filter"
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

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached {READABLE_STRING_32} current_user_name (req) as l_user and then
			   attached {WSF_STRING} req.path_parameter("id") as l_id and then l_id.is_integer then
				if attached current_media_type (req) as l_type then
					debug
						log.write_information (generator + ".do_get Processing request: User:" + l_user.to_string_8 + " Id:" + l_id.value.to_string_8)
					end
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form_confirm_page (req, res, l_id.integer_value)
				else
					log.write_alert (generator + ".do_get Processing request not acceptable")
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).report_form_confirm_page (req, res, l_id.integer_value)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					log.write_alert (generator + ".do_get Processing request, unauthorized" )
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					log.write_alert (generator + ".do_get Processing request not acceptable")
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			create l_rhf
			if attached {READABLE_STRING_32} current_user_name (req) as l_user then
				if attached current_media_type (req) as l_type then
					api_service.commit_problem_report (extract_form_data(req, l_type))
					debug
						log.write_information (generator +"do_post Send email to report number:" + api_service.last_problem_report_number.out)
					end
					send_new_report_email (l_user, absolute_host (req,""))
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).report_form_confirm_redirect (req, res)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).report_form_confirm_redirect (req, res)
				end
			else -- Not a logged in user
				if attached current_media_type (req) as l_type then
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).new_response_unauthorized (req, res)
				else
					l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).new_response_unauthorized (req, res)
				end
			end
		end

feature -- Implementation

	extract_form_data (req: WSF_REQUEST; a_type: READABLE_STRING_8): INTEGER
			-- Extract confirmation numnber.
		local
			l_parser: JSON_PARSER
		do
			if a_type.same_string ("application/vnd.collection+json") then
				create l_parser.make_with_string (retrieve_data (req))
				l_parser.parse_content
				if
					attached {JSON_OBJECT} l_parser.parsed_json_object as jv and then l_parser.is_parsed and then
					attached {JSON_OBJECT} jv.item ("template") as l_template and then
					attached {JSON_ARRAY} l_template.item ("data") as l_data and then
					attached {JSON_OBJECT} l_data.i_th (1) as l_form_data and then
					attached {JSON_STRING} l_form_data.item ("name") as l_name and then
					l_name.item.same_string ("confirm") and then
					attached {JSON_STRING} l_form_data.item ("value") as l_value and then
					l_value.item.is_integer
				then
					Result := l_value.item.to_integer
				end
			else
				if attached {WSF_STRING} req.form_parameter ("confirm") as l_confirm and then l_confirm.is_integer then
					Result := l_confirm.integer_value
				end
			end
		end

	send_new_report_email (a_user: READABLE_STRING_32; a_url: STRING)
			-- Send report creation confirmation email to interested parties.	
		local
			l_subscribers: LIST [STRING]
		do
			if
				attached api_service.user_account_information (a_user).email as l_email and then
				attached api_service.problem_report_details (a_user,api_service.last_problem_report_number) as l_report and then
				attached l_report.category as l_category and then
				attached l_category.synopsis as l_synopsis
			then
				l_subscribers := api_service.problem_report_category_subscribers (l_synopsis)
--				email_service.send_new_report_email (api_service.user_account_information (a_user).displayed_name, l_report, l_email, l_subscribers, a_url)
				email_notification_service.send_new_report_email (api_service.user_account_information (a_user).displayed_name, l_report, l_email, l_subscribers, a_url)
			else
					-- Not expected.
				log.write_critical (generator + ".send_new_report_email Unexpected behavior user [" + a_user.to_string_8 +"]" + "does not has email, or the report does not exist or does not has synopsis")
			end
		end
end
