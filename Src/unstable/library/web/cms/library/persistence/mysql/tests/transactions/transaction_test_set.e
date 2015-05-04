note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TRANSACTION_TEST_SET

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
			(create {CLEAN_DB}).clean_db (connection)
		end

	on_clean
			-- <Precursor>
		do
		end

feature -- Test routines

	test_user_rollback
		note
			testing:  "execution/isolated"
		local
			u: detachable CMS_USER
		do
			u := storage.user_by_name ("test")
			if u = Void then
				u := custom_user ("test", "test","test@admin.com")
				storage.new_user (u)
			end
			assert ("Has user:", storage.has_user)
			u.set_email ("test@example.com")
			storage.sql_begin_transaction
			storage.update_user (u)
			assert ("Has user:", storage.user_by_email ("test@example.com") /= Void)
			storage.sql_rollback_transaction
			assert ("Not has user:", storage.user_by_email ("test@example.com") = Void)
		end

	test_user_node_rollback
		note
			testing:  "execution/isolated"
		local
			u: detachable CMS_USER
		do
			u := storage.user_by_name ("test")
			if u = Void then
				u := custom_user ("test", "test","test@admin.com")
				storage.new_user (u)
			end

			connection.begin_transaction
			u.set_email ("test@example.com")
			assert ("Has user:", storage.user_by_email ("test@example.com") /= Void)
--			storage.new_node (default_node)
--			assert ("Has one node:", storage.nodes_count = 1)
			connection.rollback
			assert ("Not has user:", storage.user_by_email ("test@example.com") = Void)
--			assert ("Has no node:", storage.nodes_count = 0)
		end

end


