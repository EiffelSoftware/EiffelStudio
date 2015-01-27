note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing:"execution/isolated"

class
	NODE_TEST_SET

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
			assert ("Empty Nodes", storage.nodes_count = 0)
		end

	on_clean
			-- <Precursor>
		do
		end

feature -- Test routines

	test_new_node
		note
				testing:  "execution/isolated"
		do
			assert ("Empty Nodes", storage.nodes_count = 0)
			storage.new_node (default_node)
			assert ("Not empty Nodes after new_node", not storage.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached storage.node_by_id (1))
				-- Not exist node with id 2
			assert ("Not exist node with id 2",  storage.node_by_id (2) = Void)
		end


	test_update_node
		note
				testing:  "execution/isolated"
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", storage.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			storage.new_node (l_node)
			assert ("Not empty Nodes after new_node", not storage.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node (content and summary)

			if attached {CMS_NODE} storage.node_by_id (1) as l_un then
				l_un.set_content ("<h1>Updating test node udpate </h1>")
				l_un.set_summary ("updating summary")
				storage.update_node (l_un)
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then not (ll_node.content ~ l_node.content) and then not (ll_node.summary ~ l_node.summary)  and then ll_node.title ~ l_node.title )
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_un.content and then ll_node.summary ~ l_un.summary and then ll_node.title ~ l_un.title )
			end

				-- Update node (content and summary and title)
			if attached {CMS_NODE} storage.node_by_id (1) as l_un then
				l_un.set_content ("<h1>Updating test node udpate </h1>")
				l_un.set_summary ("updating summary")
				l_un.set_title ("Updating Test case")
				storage.update_node (l_un)
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then not (ll_node.content ~ l_node.content) and then not (ll_node.summary ~ l_node.summary)  and then not (ll_node.title ~ l_node.title) )
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_un.content and then ll_node.summary ~ l_un.summary and then ll_node.title ~ l_un.title )
			end
		end

	test_update_title
		note
				testing:  "execution/isolated"
		local
			l_node: CMS_NODE
			u: CMS_USER
		do
			u := default_user
			storage.new_user (u)

			assert ("Empty Nodes", storage.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			storage.new_node (l_node)
			assert ("Not empty Nodes after new_node", not storage.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node title

			if attached {CMS_NODE} storage.node_by_id (1) as l_un then
				storage.update_node_title (u.id, l_un.id, "New Title")
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_un.content and then ll_node.summary ~ l_un.summary and then not ( ll_node.title ~ l_un.title) and then  ll_node.title ~ "New Title" )
			end
		end

	test_update_summary
		note
				testing:  "execution/isolated"
		local
			l_node: CMS_NODE
			u: CMS_USER
		do
			u := default_user
			storage.new_user (u)

			assert ("Empty Nodes", storage.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			storage.new_node (l_node)
			assert ("Not empty Nodes after new_node", not storage.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node summary

			if attached {CMS_NODE} storage.node_by_id (1) as l_un then
				storage.update_node_summary (u.id, l_un.id, "New Summary")
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_un.content and then not (ll_node.summary ~ l_un.summary) and then ll_node.summary ~ "New Summary" and then  ll_node.title ~ l_un.title)
			end
		end

	test_update_content
		note
			testing:  "execution/isolated"
		local
			l_node: CMS_NODE
			u: CMS_USER
		do
			u := default_user
			storage.new_user (u)

			assert ("Empty Nodes", storage.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			storage.sql_begin_transaction
			storage.new_node (l_node)
			assert ("Not empty Nodes after new_node", not storage.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node content

			if attached {CMS_NODE} storage.node_by_id (1) as l_un then
				storage.update_node_content (u.id, l_un.id, "New Content")
				assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then not (ll_node.content ~ l_un.content) and then ll_node.content ~ "New Content" and then ll_node.summary ~ l_un.summary  and then  ll_node.title ~ l_un.title)
			end
			storage.sql_commit_transaction
		end


	test_delete_node
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", storage.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			storage.new_node (l_node)
			assert ("Not empty Nodes after new_node", not storage.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Delte node 1

			storage.delete_node_by_id (1)
			assert ("Node does not exist", storage.node_by_id (1) = Void)
		end

	test_recent_nodes
			-- Content_10, Summary_10, Title_10
			-- Content_9, Summary_9, Title_9
			-- ..
			-- Content_1, Summary_1, Title_1
		local
			i : INTEGER
		do
			assert ("Empty Nodes", storage.nodes.after)
			across 1 |..| 10  as c loop
				storage.new_node (custom_node ("Content_" + c.item.out, "Summary_" + c.item.out, "Title_" + c.item.out))
			end

				-- Scenario (0,10) rows, recents (10 down to 1)
			i := 10
			across storage.recent_nodes (0, 10) as c loop
				assert ("Same id:" + i.out, c.item.id = i)
				i := i - 1
			end

				-- Scenario (5, 10) rows, recent nodes (5 down to 1)
			i := 5
			across storage.recent_nodes (5, 10) as c loop
				assert ("Same id:" + i.out, c.item.id = i)
				i := i - 1
			end

				-- Scenario (9,10) rows, recent node 1
			i := 1
			across storage.recent_nodes (9, 10) as c loop
				assert ("Same id:" + i.out, c.item.id = i)
				i := i - 1
			end

				-- Scenrario 10..10 empty
			assert ("Empty", storage.recent_nodes (10, 10).after)
		end

	test_new_node_add_author
		do
			storage.new_node (default_node)
			assert ("Exist node with id 1", attached {CMS_NODE} storage.node_by_id (1))
			storage.new_user (custom_user ("u1", "u1", "email"))
			if attached storage.user_by_name ("u1") as l_user then
				if attached storage.node_by_id (1) as l_node then
					l_node.set_author (l_user)
					storage.update_node (l_node)
					assert ("Author not void for node 1", attached storage.node_author (1))
				end
			end
		end


end



