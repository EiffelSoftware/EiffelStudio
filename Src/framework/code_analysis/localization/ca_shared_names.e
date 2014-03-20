note
	description: "Provides shared access to name and message strings for the Code Analyzer."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SHARED_NAMES

feature -- Names

	ca_names: CA_NAMES
			-- Name strings for the Code Analyzer.
		once
			create Result
		ensure
			valid_result: Result /= Void
		end

	ca_messages: CA_MESSAGES
			-- Message strings for the Code Analyzer.
		once
			create Result
		ensure
			valid_result: Result /= Void
		end

end
