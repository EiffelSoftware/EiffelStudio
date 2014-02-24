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
			db: ESA_REPORT_DATA_PROVIDER
		do
			create db.make
			assert("Expected not Void",attached db.user_password_salt ("jvelilla"))
		end

	test_password_hash_success
			-- The user exist
		local
			db: ESA_REPORT_DATA_PROVIDER
			l_sha_password: STRING
			l_value: BOOLEAN
		do
			create db.make
			if attached db.user_password_salt ("jvelilla") as l_hash and then
			   attached password as l_password then
				l_sha_password := sha1_string (l_password + l_hash)
				l_value := db.validate_login ("jvelilla", l_sha_password)
				assert("Expected True", l_value)
			else
				assert("False", False)
			end

		end


	test_countries
		local
			l_db: ESA_LOGIN_DATA_PROVIDER
		do
			create l_db.make
			l_db.connect
			across l_db.countries  as c loop
				print (c.item.ouput)
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


end


