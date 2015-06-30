note
	description: "Summary description for {NOTIFICATION_STORAGE_MAILER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_STORAGE_MAILER

inherit
	NOTIFICATION_MAILER

create
	make

feature {NONE} -- Initialization

	make (a_storage: NOTIFICATION_EMAIL_STORAGE)
		do
			storage := a_storage
		end

	storage: NOTIFICATION_EMAIL_STORAGE

feature -- Status report

	is_available: BOOLEAN
			-- <Precursor>	
		do
			Result := storage.is_available
		end

feature -- Basic operation		

	process_email (a_email: NOTIFICATION_EMAIL)
			-- <Precursor>
		do
			storage.put (a_email)
			if storage.has_error then
				report_error ("Issue storing email.")
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
