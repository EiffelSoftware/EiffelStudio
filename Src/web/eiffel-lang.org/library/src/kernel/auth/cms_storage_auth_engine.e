note
	description: "Summary description for {CMS_STORAGE_AUTH_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_AUTH_ENGINE

inherit
	CMS_AUTH_ENGINE

create
	make

feature {NONE} -- Initialization

	make (a_storage: like storage)
		do
			storage := a_storage
		end

	storage: CMS_STORAGE

feature -- Status

	valid_credential (u,p: READABLE_STRING_32): BOOLEAN
		do
			Result := storage.is_valid_credential (u, p)
		end

end
