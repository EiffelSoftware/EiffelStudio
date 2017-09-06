note
	description: "Summary description for {CMS_STORAGE_STORE_MYSQL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_STORE_MYSQL

inherit
	CMS_STORAGE_NULL

create
	make

feature

	make
		do
			default_create
		end

end -- class CMS_STORAGE_STORE_MYSQL
