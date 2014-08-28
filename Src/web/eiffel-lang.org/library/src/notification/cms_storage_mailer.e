note
	description: "Summary description for {CMS_CHAIN_MAILER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_MAILER

inherit
	NOTIFICATION_MAILER

create
	make

feature {NONE} -- Initialization

	make (a_storage: like storage)
		do
			storage := a_storage
		end

feature -- Access

	storage: CMS_STORAGE

feature -- Status

	is_available: BOOLEAN = True

feature -- Basic operation

	process_email (a_email: NOTIFICATION_EMAIL)
		do
			storage.save_email (a_email)
		end

end
