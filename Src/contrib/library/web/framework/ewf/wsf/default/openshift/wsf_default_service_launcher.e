note
	description: "[
			Default launcher for WSF_SERVICE based on {WSF_OPENSHIFT_SERVICE_LAUNCHER}
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_DEFAULT_SERVICE_LAUNCHER [G -> WSF_EXECUTION create make end]

inherit
	WSF_OPENSHIFT_SERVICE_LAUNCHER [G]

create
	make,
	make_and_launch

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
