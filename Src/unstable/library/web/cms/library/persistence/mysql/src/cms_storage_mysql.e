note
	description: "Summary description for {CMS_STORAGE_MYSQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_MYSQL

inherit
	CMS_STORAGE_STORE_SQL

	CMS_CORE_STORAGE_SQL_I

	CMS_USER_STORAGE_SQL_I

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
