note
	description: "Abstract class to converts data into the proper representation for responses and handles incoming representations from requests"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPRESENTATION_HANDLER

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		deferred
		end

feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
				-- Generate a Reponse based on the Media Type
			deferred
			end
end
