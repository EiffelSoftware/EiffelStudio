note
	description: "[
		Interface responsible to instantiate CMS_STORAGE_STORE_MYSQL object.
	]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_STORE_MYSQL_BUILDER

inherit
	CMS_STORAGE_NULL_BUILDER
		redefine
			storage
		end

create
	make

feature {NONE}

	make
		do
		end

feature

	storage (a_db_cfg: DATABASE_CONFIGURATION; a_setup: CMS_SETUP; a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE_NULL
			-- CMS Storage object based on CMS setup `a_setup`.
		do
			a_error_handler.add_custom_error (0, "Could not connect to the MySQL storage (fake)", Void)
		end

end
