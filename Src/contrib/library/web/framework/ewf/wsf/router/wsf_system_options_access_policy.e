note

	description: "[
						Policy to decide if OPTIONS * is honoured.
                  Servers that wish to forbid OPTIONS * requests
						can redefine `is_system_options_forbidden'.

						Response 403 Forbidden is meant to be accompanied
						by an entity body describing the reason for the refusal.
						Since authentication cannot be used for OPTIONS *, there
						are limited grounds for selective refusal (the IP address might
						be used though), so we provide a convenient default for
						`system_options_forbidden_text'.
					]"

	date: "$Date$"
	revision: "$Revision$"
	
class	WSF_SYSTEM_OPTIONS_ACCESS_POLICY

feature -- Access

	is_system_options_forbidden (req: WSF_REQUEST): BOOLEAN
			-- Should we return 403 Forbidden in response to OPTIONS * requests?
		require
			req_attached: req /= Void		
		do
			-- by default, unconditionally no.
		end

	system_options_forbidden_text (req: WSF_REQUEST): detachable READABLE_STRING_8
			-- Content of 403 Forbidden response;
			-- Returning `Void' means instead respond with 403 Not found
		require
			req_attached: req /= Void
		do
			Result := "OPTIONS * is not permitted"
		end

end
