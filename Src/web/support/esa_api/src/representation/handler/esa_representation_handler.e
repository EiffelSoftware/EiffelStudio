note
	description: "Abstract class to converts data into the proper representation for responses and handles incoming representations from requests"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_REPRESENTATION_HANDLER

inherit

	ESA_HANDLER

feature -- Initialization

	make (a_esa_config: like esa_config; a_media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS)
			-- Create an object with a `a_media_variant'
			-- and `a_esa_config'
		do
			media_variants := a_media_variants
			esa_config := a_esa_config
		ensure
			media_set: media_variants = a_media_variants
			config_set: esa_config = a_esa_config
		end

feature -- Config

	esa_config: ESA_CONFIG

	api_service: ESA_API_SERVICE
		do
			Result := esa_config.api_service
		end

feature -- Media Variants

	media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			-- Media type accepted.

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		deferred
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_report: detachable ESA_REPORT)
			-- Problem report representation
		deferred
		end

	problem_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: detachable ESA_REPORT_VIEW)
			-- Problem reports representation for a guest user
		deferred
		end

	problem_user_reports (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: detachable ESA_REPORT_VIEW)
			-- Problem reports representation for a given user
		deferred
		end

	problem_reports_responsible	(req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: detachable ESA_REPORT_VIEW)
			-- Problem reports representation for a given user
		deferred
		end

	report_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: detachable ESA_REPORT_FORM_VIEW)
			-- Report form
		deferred
		end

	report_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: detachable ESA_REPORT_FORM_VIEW)
			-- Report form confirm
		deferred
		end

	report_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Report form confirm redirect
		deferred
		end

	report_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form error
		deferred
		end

	update_report_responsible (req: WSF_REQUEST; res: WSF_RESPONSE; a_redirect_uri: READABLE_STRING_32)
			-- Update report responsible
		deferred
		end

	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Not found page
		deferred
		end

	login_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Login page
		deferred
		end

	logout_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Logout page
		deferred
		end

	bad_request_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Bad request page
		deferred
		end

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- internal_server_error
		deferred
		end

	register_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_REGISTER_VIEW)
			-- Register form
		deferred
		end

	post_register_page 	(req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Post Register page
		deferred
		end

	activation_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_ACTIVATION_VIEW)
			-- Activation Page
		deferred
		end

	activation_confirmation_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Confirmation page
		deferred
		end

feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
			-- Generate a Reponse based on the Media Type
		deferred
		end

	new_response_unauthorized (req: WSF_REQUEST; res: WSF_RESPONSE;)
			-- Generate a Reponse based on the Media Type
		deferred
		end

	new_response_authenticate (req: WSF_REQUEST; res: WSF_RESPONSE)
		deferred
		end

end
