note
	description:
		"URLs for HTTP resources"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class HTTP_URL inherit

	NETWORK_RESOURCE_URL

create

	make

feature -- Access

	Service: STRING_8 = "http"
			-- Name of service (Answer: "http")

feature -- Status report

	Default_port: INTEGER = 80
			-- Number of default port for service (Answer: 80)

	Is_proxy_supported: BOOLEAN = True
			-- Are proxy connections supported? (Answer: yes)

	Has_username: BOOLEAN = True;
			-- Can address contain a username?

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class HTTP_URL

