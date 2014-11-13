note
	description: "Summary description for {ROLE_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROLE_TEST_SET
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
		end

	on_clean
			-- <Precursor>
		do
		end

feature -- Test routines

	test_roles_empty
		do
			assert ("Not elements",role_provider.roles.after)
			assert ("Count = 0", role_provider.count = 0)
		end

	test_roles_by_id_not_exist
		do
			assert ("Void", role_provider.role (1) = Void)
		end

	test_roles_by_name_not_exist
		do
			assert ("Void", role_provider.role_by_name ("admin") = Void)
		end

	test_new_role
		do
			assert ("Count = 0", role_provider.count = 0)
			role_provider.new_role ("admin")
			assert ("Count = 1", role_provider.count = 1)
			assert ("Expected role", attached role_provider.role (1) as l_role and then l_role.name ~ "admin")
			assert ("Expected role", attached role_provider.role_by_name ("admin") as l_role and then l_role.id = 1)
		end

	test_permissions_empty_not_exist_role
		do
			assert ("Not elements",role_provider.permission_by_role (1).after)
		end

	test_permissions_empty_exist_role
		do
			assert ("Count = 0", role_provider.count = 0)
			role_provider.new_role ("admin")
			assert ("Count = 1", role_provider.count = 1)
			assert ("Exist role",not role_provider.roles.after)
			assert ("Not permission by role 1 elements",role_provider.permission_by_role (1).after)
		end

	test_new_role_with_permissions
		do
			assert ("Count = 0", role_provider.count = 0)
			role_provider.new_role ("admin")
			role_provider.save_role_permission (1, "Create Page")
			role_provider.save_role_permission (1, "Edit Page")
			role_provider.save_role_permission (1, "Delete Page")
			assert ("Count = 1", role_provider.count = 1)
			assert ("Exist role",not role_provider.roles.after)
			assert ("Exist role permissions",not role_provider.permission_by_role (1).after)
			assert ("Not Exist role permissions, for id 2",role_provider.permission_by_role (2).after)
		end




feature {NONE} -- Implementation

	role_provider: ROLE_DATA_PROVIDER
			-- role provider.
		once
			create Result.make (connection)
		end
end
