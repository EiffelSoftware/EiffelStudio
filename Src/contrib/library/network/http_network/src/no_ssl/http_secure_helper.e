note
	description: "[
			Interface helping using SSL.
			For now, mainly for `is_secure_connection_supported' to indicate if current project is compiled with SSL support.
			i.e compiled with EiffelNet-SSL library.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_SECURE_HELPER

feature -- Status

	is_secure_connection_supported: BOOLEAN = False
			-- Is Current system compiled with EiffelNet-SSL support?

end
