note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LOGIN_TEST_SET

inherit
	EQA_TEST_SET
		select
			default_create
		end
	SHARED_LOGIN_TEST
		rename
			default_create as l_shared_create
		end
feature -- Test routines

	test_password_salt_success
			-- The user exist
		local
			db: REPORT_DATA_PROVIDER
		do
			create db.make (connection)
 			assert("Expected not Void",attached db.user_password_salt ("jvelilla"))
		end

	test_password_hash_success
			-- The user exist
		local
			db: REPORT_DATA_PROVIDER
			ld: LOGIN_DATA_PROVIDER
			l_sha_password: STRING
			l_value: BOOLEAN
		do
			create db.make (connection)
			if attached db.user_password_salt ("jvelilla") as l_hash and then
			   attached password as l_password then
				l_sha_password := sha1_string (l_password + l_hash)
				l_value := ld.validate_login ("jvelilla", l_sha_password)
				assert("Expected True", l_value)
			else
				assert("False", False)
			end

		end

	test_is_active_true
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			assert("Expected True:", l_db.is_active ("jvelilla"))
		end

	test_is_active_false
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			assert("Expected False:", not l_db.is_active ("raphaels"))
		end

	test_is_active_user_not_exist
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			assert("Expected False:", not l_db.is_active ("notexist_001"))
		end


	test_countries
		local
			l_db: LOGIN_DATA_PROVIDER
		do
			create l_db.make (connection)
			l_db.connect
			across l_db.countries  as c loop
				io.error.put_string (c.item.ouput)
			end
			l_db.disconnect
		end

feature -- Helpers


	sha1_string (a_str: STRING): STRING
		do
			sha1.update_from_string (a_str)
			Result := sha1.digest_as_string
			sha1.reset
		end

	sha1: SHA1
		once
			create Result.make
		end

	connection: DATABASE_CONNECTION
		once
			create {DATABASE_CONNECTION_ODBC}Result.make_common
		end

end


