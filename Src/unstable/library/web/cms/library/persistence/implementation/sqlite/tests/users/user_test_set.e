note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	USER_TEST_SET

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		select
			default_create
		end
	ABSTRACT_DB_TEST
		rename
			default_create as default_db_test
		end


feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			(create {CLEAN_DB}).clean_db(connection)
			user_provider.new_user ("admin", "admin","admin@admin.com")
		end

	on_clean
			-- <Precursor>
		do
		end

feature -- Test routines

	test_user_exist
			-- User admin exist			
		do
			assert ("Not void",  attached user_provider.user_by_email ("admin@admin.com"))
			assert ("Not void",  attached user_provider.user (1))
			assert ("Not void",  attached user_provider.user_by_name ("admin"))
		end

	test_user_not_exist
			-- Uset test does not exist.
		do
			assert ("Void", user_provider.user_by_email ("test@admin.com") = Void)
			assert ("Void", user_provider.user(2) = Void )
			assert ("Void", user_provider.user_by_name ("test") = Void)
		end

	test_new_user
		do
			user_provider.new_user ("test", "test","test@admin.com")
			assert ("Not void",  attached user_provider.user_by_email ("test@admin.com"))
			assert ("Not void",  attached user_provider.user (2))
			assert ("Not void",  attached user_provider.user (2) as l_user and then l_user.id = 2 and then l_user.name ~ "test")
			assert ("Not void",  attached user_provider.user_by_name ("test"))
		end


feature {NONE} -- Implementation

	user_provider: USER_DATA_PROVIDER
			-- user provider.
		once
			create Result.make (connection)
		end
end


