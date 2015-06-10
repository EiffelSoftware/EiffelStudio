note
	description: "Common interface for all EWSGI connectors."
	specification: "Eiffel WGI/connector specification https://github.com/EiffelWebFramework/EWF/wiki/WGI-specification"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WGI_CONNECTOR

feature -- Access

	name: READABLE_STRING_8
			-- Name of Current connector
		deferred
		end

	version: READABLE_STRING_8
			-- Version of Current connector
		deferred
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
