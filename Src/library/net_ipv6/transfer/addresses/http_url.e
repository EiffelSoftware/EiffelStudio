indexing
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

	Service: STRING is "http"
			-- Name of service (Answer: "http")

feature -- Status report

	Default_port: INTEGER is 80
			-- Number of default port for service (Answer: 80)
			
	Is_proxy_supported: BOOLEAN is True
			-- Are proxy connections supported? (Answer: yes)

	Has_username: BOOLEAN is True;
			-- Can address contain a username?
			
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HTTP_URL

