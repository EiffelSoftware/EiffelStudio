note
	description : "[
						In order to run the test:
						1. Install MySQL server, env variables MYSQL for windows, or MYSQLINC and MYSQLLIB for unix should be set.
						2. Call setup_database.bat (Windows) to setup the following:
							* A database on local machine named "store_eweasel_test".
							* A user "eweasel_user" with password "123456".
					]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_data_app: DATABASE_APPL [MYSQL]
			l_manager: DATABASE_STORAGE_MANAGER
		do
			create l_data_app
			create l_manager.make (l_data_app, "store_eweasel_test", "eweasel_user", "123456", "localhost", Void, Void, Void, Void)
			l_manager.test_no_arg_stored_procedure

		end

end
