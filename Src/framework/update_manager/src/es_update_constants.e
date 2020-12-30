note
	description: "Summary description for {ES_UPDATE_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_CONSTANTS

feature -- Access

	update_service_url: STRING = "https://account.eiffel.com"
			-- Official Eiffel.org site url.

	beta_channel: STRING = "beta"
			-- Update Service beta channel.

	stable_channel: STRING = "stable"
			-- Update service stable channel.

end
