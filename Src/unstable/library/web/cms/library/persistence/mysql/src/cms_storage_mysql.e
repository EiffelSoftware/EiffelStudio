note
	description: "Summary description for {CMS_STORAGE_MYSQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_MYSQL

inherit
	CMS_STORAGE

	CMS_STORAGE_STORE_SQL

	CMS_USER_STORAGE_MYSQL

	CMS_NODE_STORAGE_MYSQL

	REFACTORING_HELPER

create
	make

feature -- Status report

	is_initialized: BOOLEAN
			-- Is storage initialized?
		do
			Result := has_user
		end

end
