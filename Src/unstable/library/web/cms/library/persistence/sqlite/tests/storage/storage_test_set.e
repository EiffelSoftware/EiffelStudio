note
	description: "Summary description for {STORAGE_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STORAGE_TEST_SET

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

	test_has_user
		do
			assert ("Not has user", not storage.has_user)
		end

	test_all_users
		do
			assert ("to implement all_users", False)
		end

	test_user_by_id_not_exist
		do
			assert ("User does not exist", storage.user_by_id (1) = Void)
		end

	test_user_by_name_not_exist
		do
			assert ("User does not exist", storage.user_by_name ("test") = Void)
		end

	test_user_by_email_not_exist
		do
			assert ("User does not exist", storage.user_by_name ("test@test.com") = Void)
		end

	test_user_with_bad_id
		local
			l_retry: BOOLEAN
			l_user: detachable CMS_USER
		do
			if not l_retry then
				l_user := storage.user_by_id (0)
				assert ("Precondition does not get the wrong value", False)
			else
				assert ("Expected precondition violation", True)
			end
		rescue
			l_retry := True
			retry
		end

	test_user_with_bad_name_empty
		local
			l_retry: BOOLEAN
			l_user: detachable CMS_USER
		do
			if not l_retry then
				l_user := storage.user_by_name ("")
				assert ("Precondition does not get the wrong value", False)
			else
				assert ("Expected precondition violation", True)
			end
		rescue
			l_retry := True
			retry
		end

	test_user_with_bad_email_empty
		local
			l_retry: BOOLEAN
			l_user: detachable CMS_USER
		do
			if not l_retry then
				l_user := storage.user_by_email ("")
				assert ("Precondition does not get the wrong value", False)
			else
				assert ("Expected precondition violation", True)
			end
		rescue
			l_retry := True
			retry
		end

	test_save_user
		do
			storage.save_user (default_user)
			assert ("Has user", storage.has_user)
		end

	test_user_by_id
		do
			storage.save_user (default_user)
			assert ("Has user", storage.has_user)
			if attached {CMS_USER} storage.user_by_id (1) as l_user then
				assert ("Exist", True)
				assert ("User test", l_user.name ~ "test")
				assert ("User id = 1", l_user.id = 1)
			else
				assert ("Wrong Implementation", False)
			end
		end

	test_user_by_name
		do
			storage.save_user (default_user)
			assert ("Has user", storage.has_user)
			if attached {CMS_USER} storage.user_by_name ("test") as l_user then
				assert ("Exist", True)
				assert ("User nane: test", l_user.name ~ "test")
			else
				assert ("Wrong Implementation", False)
			end
		end

	test_user_by_email
		do
			storage.save_user (default_user)
			assert ("Has user", storage.has_user)
			if attached {CMS_USER} storage.user_by_email ("test@test.com") as l_user then
				assert ("Exist", True)
				assert ("User email: test@test.com", l_user.email ~ "test@test.com")
			else
				assert ("Wrong Implementation", False)
			end
		end

	test_invalid_credential
		do
			storage.save_user (default_user)
			assert ("Has user test", attached storage.user_by_name ("test"))
			assert ("Wrong password", not storage.is_valid_credential ("test", "test"))
			assert ("Wrong user", not storage.is_valid_credential ("test1", "test"))
		end

	test_valid_credential
		do
			storage.save_user (default_user)
			assert ("Has user test", attached storage.user_by_name ("test"))
			assert ("Valid password", storage.is_valid_credential ("test", "password"))
		end

--	test_recent_nodes_empty
--		do
--			assert ("No recent nodes", storage.recent_nodes (0, 10).is_empty)
--		end

--	test_recent_nodes
--		local
--			l_nodes: LIST[CMS_NODE]
--		do
--			across 1 |..| 10 as c loop
--				storage.new_node (custom_node ("Content_" + c.item.out, "Summary_" + c.item.out, "Title_" + c.item.out))
--			end
--			l_nodes := storage.recent_nodes (0, 10)
--			assert ("10 recent nodes", l_nodes.count = 10)
--			assert ("First node id=10", l_nodes.first.id = 10)
--			assert ("Last node id=1", l_nodes.last.id = 1)


--			l_nodes := storage.recent_nodes (5, 10)
--			assert ("5 recent nodes", l_nodes.count = 5)
--			assert ("First node id=5", l_nodes.first.id = 5)
--			assert ("Last node id=1", l_nodes.last.id = 1)

--			l_nodes := storage.recent_nodes (9, 10)
--			assert ("1 recent nodes", l_nodes.count = 1)
--			assert ("First node id=1", l_nodes.first.id = 1)
--			assert ("Last node id=1", l_nodes.last.id = 1)

--			l_nodes := storage.recent_nodes (10, 10)
--			assert ("Is empty", l_nodes.is_empty)
--		end

--	test_node_does_not_exist
--		do
--			across 1 |..| 10 as c loop
--				storage.new_node (custom_node ("Content_" + c.item.out, "Summary_" + c.item.out, "Title_" + c.item.out))
--			end
--			assert ("Not exist node id: 12", storage.node_by_id (12) = Void)
--		end

--	test_node
--		do
--			across 1 |..| 10 as c loop
--				storage.new_node (custom_node ("Content_" + c.item.out, "Summary_" + c.item.out, "Title_" + c.item.out))
--			end
--			assert ("has nodes", storage.nodes.count > 5)
--			assert ("Node id: 10", attached storage.node_by_id (10) as l_node and then l_node.title ~ "Title_10" )
--		end

--	test_update_node
--		local
--			l_node: CMS_NODE
--		do
--			storage.new_node (custom_node ("Content", "Summary", "Title"))
--			if attached {CMS_NODE} storage.node_by_id (1) as ll_node then
--				l_node := ll_node.twin
--				l_node.set_content ("New Content")
--				l_node.set_summary ("New Summary")
--				l_node.set_title("New Title")

----				storage.update_node (l_node)
--				assert ("Updated", attached {CMS_NODE} storage.node_by_id (1) as u_node and then not (u_node.title ~ ll_node.title) and then not (u_node.content ~ ll_node.content) and then not (u_node.summary ~ ll_node.summary))
--			end
--		end

--	test_update_node_title
--		do
--			storage.new_node (custom_node ("Content", "Summary", "Title"))
--			if attached {CMS_NODE} storage.node_by_id (1) as ll_node then
----				storage.update_node_title (ll_node.id, "New Title")
--				assert ("Updated", attached {CMS_NODE} storage.node_by_id (1) as u_node and then not (u_node.title ~ ll_node.title) and then u_node.content ~ ll_node.content and then u_node.summary ~ ll_node.summary)
--			end
--		end

--	test_update_node_summary
--		do
--			storage.new_node (custom_node ("Content", "Summary", "Title"))
--			if attached {CMS_NODE} storage.node_by_id (1) as ll_node then
----				storage.update_node_summary (ll_node.id, "New Summary")
--				assert ("Updated", attached {CMS_NODE} storage.node_by_id (1) as u_node and then u_node.title ~ ll_node.title and then u_node.content ~ ll_node.content and then not (u_node.summary ~ ll_node.summary))
--			end
--		end

--	test_update_node_content
--		do
--			storage.new_node (custom_node ("Content", "Summary", "Title"))
--			if attached {CMS_NODE} storage.node_by_id (1) as ll_node then
----				storage.update_node_content (ll_node.id, "New Content")
--				assert ("Updated", attached {CMS_NODE} storage.node_by_id (1) as u_node and then u_node.title ~ ll_node.title and then not (u_node.content ~ ll_node.content) and then u_node.summary ~ ll_node.summary)
--			end
--		end

--	test_delete_node
--		do
--			across 1 |..| 10 as c loop
--				storage.new_node (custom_node ("Content_" + c.item.out, "Summary_" + c.item.out, "Title_" + c.item.out))
--			end
--			assert ("Exist node id: 10", attached storage.node_by_id (10) as l_node and then l_node.title ~ "Title_10" )
--			storage.delete_node_by_id (10)
--			assert ("Not exist node id: 10", storage.node_by_id (10) = Void)
--		end


end
