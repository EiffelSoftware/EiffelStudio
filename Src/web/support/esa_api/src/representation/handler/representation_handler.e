note
	description: "Abstract class to converts data into the proper representation for responses and handles incoming representations from requests"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPRESENTATION_HANDLER

inherit

	SHARED_API_SERVICE

feature -- Initialization

	make (a_media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS)
			-- Create an object with a `a_media_variant'
		do
			media_variants := a_media_variants
		ensure
			media_set: media_variants = a_media_variants
		end

feature -- Media Variants

	media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
		-- Media type accepted.

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		deferred
		end


	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Problem report representation
		deferred
		end

	problem_reports_guest  (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Problem reports representation for a guest user
		deferred
		end


	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Not found page
		deferred
		end

feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
				-- Generate a Reponse based on the Media Type
			deferred
			end
end
