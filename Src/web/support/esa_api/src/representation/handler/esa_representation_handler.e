note
	description: "Abstract class to converts data into the proper representation for responses and handles incoming representations from requests"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_REPRESENTATION_HANDLER

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

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_report: detachable REPORT)
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
