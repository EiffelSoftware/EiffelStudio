note
	description : "REST Buck server"
	date        : "$Date$"
	revision    : "$Revision$"

class RESTBUCKS_SERVER

inherit
	WSF_DEFAULT_SERVICE [RESTBUCKS_SERVER_EXECUTION]

create
	make

feature {NONE} -- Initialization

	make
		do
			set_service_option ("port", 9090)
			import_service_options (create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("server.ini"))
			make_and_launch
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
