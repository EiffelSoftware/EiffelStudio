note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing:"execution/isolated"

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
--			(create {CLEAN_DB}).clean_db(connection)
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
			assert ("User by email: Void", user_provider.user_by_email ("test1@test.com") = Void)
			assert ("User by id: Void", user_provider.user(5) = Void )
			assert ("User by name: Void", user_provider.user_by_name ("test1") = Void)
		end

	test_new_user
		do
			user_provider.new_user ("test", "test","test@admin.com")
			assert ("Not void",  attached user_provider.user_by_email ("test@admin.com"))
			assert ("Not void",  attached user_provider.user (2))
			assert ("Not void",  attached user_provider.user (2) as l_user and then l_user.id = 2 and then l_user.name ~ "test")
			assert ("Not void",  attached user_provider.user_by_name ("test"))
		end

	test_new_user_with_roles
		do
			user_provider.new_user ("test", "test","test@admin.com")
		    role_provider.new_role ("Admin")
		    assert ("Empty roles for given user", user_provider.user_roles (1).after)
		    user_provider.add_role (1, 1)
		    assert ("Not empty roles for given user", not user_provider.user_roles (1).after)
		end

	test_new_user_without_profile
		do
			user_provider.new_user ("test", "test","test@admin.com")
			assert ("Empty", user_provider.user_profile (1).new_cursor.after)
		end

	test_new_user_with_profile
		local
			l_profile: CMS_USER_PROFILE
			l_db_profile: CMS_USER_PROFILE
		do
			user_provider.new_user ("test", "test","test@admin.com")
			if attached {CMS_USER} user_provider.user_by_name ("test") as l_user then
				assert ("Empty", user_provider.user_profile (l_user.id).new_cursor.after)
				create l_profile.make
				l_profile.force ("Eiffel", "language")
				l_profile.force ("Argentina", "country")
				l_profile.force ("GMT-3", "time zone")
				user_provider.save_profile (l_user.id, l_profile)
				l_db_profile := user_provider.user_profile (l_user.id)
				assert ("Not Empty", not l_db_profile.new_cursor.after)

				assert ("Expected language Eiffel", attached l_db_profile.item ("language") as l_language and then l_language ~ "Eiffel")
				assert ("Expected time zone GMT-3", attached l_db_profile.item ("time zone") as l_language and then l_language ~ "GMT-3")
			end
		end


feature {NONE} -- Implementation

	user_provider: USER_DATA_PROVIDER
			-- user provider.
		once
			create Result.make (connection)
		end

	role_provider: ROLE_DATA_PROVIDER
			-- user provider.
		once
			create Result.make (connection)
		end

end


