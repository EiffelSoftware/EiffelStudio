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
			(create {CLEAN_DB}).clean_db(connection)
			assert ("Empty Nodes", node_provider.nodes.after)
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
			assert ("Empty Nodes", node_provider.nodes.after)
			node_provider.new_node (default_node)
			assert ("Not empty Nodes after new_node", not node_provider.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached node_provider.node (1))
				-- Not exist node with id 2
			assert ("Not exist node with id 2",  node_provider.node (2) = Void)
		end


	test_update_node
		note
				testing:  "execution/isolated"
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", node_provider.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			node_provider.new_node (l_node)
			assert ("Not empty Nodes after new_node", not node_provider.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node (content and summary)

			if attached {CMS_NODE} node_provider.node (1) as l_un then
				l_un.set_content ("<h1>Updating test node udpate </h1>")
				l_un.set_summary ("updating summary")
				node_provider.update_node (0,l_un)
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then not (ll_node.content ~ l_node.content) and then not (ll_node.summary ~ l_node.summary)  and then ll_node.title ~ l_node.title )
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_un.content and then ll_node.summary ~ l_un.summary and then ll_node.title ~ l_un.title )
			end

				-- Update node (content and summary and title)
			if attached {CMS_NODE} node_provider.node (1) as l_un then
				l_un.set_content ("<h1>Updating test node udpate </h1>")
				l_un.set_summary ("updating summary")
				l_un.set_title ("Updating Test case")
				node_provider.update_node (0,l_un)
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then not (ll_node.content ~ l_node.content) and then not (ll_node.summary ~ l_node.summary)  and then not (ll_node.title ~ l_node.title) )
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_un.content and then ll_node.summary ~ l_un.summary and then ll_node.title ~ l_un.title )
			end
		end

	test_update_title
		note
				testing:  "execution/isolated"
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", node_provider.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			node_provider.new_node (l_node)
			assert ("Not empty Nodes after new_node", not node_provider.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node title

			if attached {CMS_NODE} node_provider.node (1) as l_un then
				node_provider.update_node_title (l_un.id, "New Title")
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_un.content and then ll_node.summary ~ l_un.summary and then not ( ll_node.title ~ l_un.title) and then  ll_node.title ~ "New Title" )
			end
		end

	test_update_summary
		note
				testing:  "execution/isolated"
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", node_provider.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			node_provider.new_node (l_node)
			assert ("Not empty Nodes after new_node", not node_provider.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node summary

			if attached {CMS_NODE} node_provider.node (1) as l_un then
				node_provider.update_node_summary (l_un.id,"New Summary")
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_un.content and then not (ll_node.summary ~ l_un.summary) and then ll_node.summary ~ "New Summary" and then  ll_node.title ~ l_un.title)
			end
		end

	test_update_content
		note
			testing:  "execution/isolated"
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", node_provider.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			connection.begin_transaction
			node_provider.new_node (l_node)
			assert ("Not empty Nodes after new_node", not node_provider.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Update node content

			if attached {CMS_NODE} node_provider.node (1) as l_un then
				node_provider.update_node_content (l_un.id,"New Content")
				assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then not (ll_node.content ~ l_un.content) and then ll_node.content ~ "New Content" and then ll_node.summary ~ l_un.summary  and then  ll_node.title ~ l_un.title)
			end
			connection.commit
		end


	test_delete_node
		local
			l_node: CMS_NODE
		do
			assert ("Empty Nodes", node_provider.nodes.after)
			l_node := custom_node ("<h1> test node udpate </h1>", "Update node", "Test case update")
			node_provider.new_node (l_node)
			assert ("Not empty Nodes after new_node", not node_provider.nodes.after)
				-- Exist node with id 1
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1) as ll_node and then ll_node.content ~ l_node.content and then ll_node.summary ~ l_node.summary  and then ll_node.title ~ l_node.title )

				-- Delte node 1

			node_provider.delete_node (1)
			assert ("Node does not exist", node_provider.node (1) = Void)
		end

	test_recent_nodes
			-- Content_10, Summary_10, Title_10
			-- Content_9, Summary_9, Title_9
			-- ..
			-- Content_1, Summary_1, Title_1
		local
			i : INTEGER
		do
			assert ("Empty Nodes", node_provider.nodes.after)
			across 1 |..| 10  as c loop
				node_provider.new_node (custom_node ("Content_" + c.item.out, "Summary_" + c.item.out, "Title_" + c.item.out))
			end

				-- Scenario (0,10) rows, recents (10 down to 1)
			i := 10
			across node_provider.recent_nodes (0, 10) as c loop
				assert ("Same id:" + i.out, c.item.id = i)
				i := i - 1
			end

				-- Scenario (5, 10) rows, recent nodes (5 down to 1)
			i := 5
			across node_provider.recent_nodes (5, 10) as c loop
				assert ("Same id:" + i.out, c.item.id = i)
				i := i - 1
			end

				-- Scenario (9,10) rows, recent node 1
			i := 1
			across node_provider.recent_nodes (9, 10) as c loop
				assert ("Same id:" + i.out, c.item.id = i)
				i := i - 1
			end

				-- Scenrario 10..10 empty
			assert ("Empty", node_provider.recent_nodes (10, 10).after)
		end


	test_new_node_without_user
		do
			node_provider.new_node (default_node)
			user_provider.new_user ("u1", "u1", "email")
			if attached user_provider.user_by_name ("u1") as l_user then
				assert ("Empty nodes", node_provider.author_nodes (l_user.id).after)
			end
		end

	test_new_node_add_author
		do
			node_provider.new_node (default_node)
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1))
			user_provider.new_user ("u1", "u1", "email")
			if attached user_provider.user_by_name ("u1") as l_user then
				node_provider.add_author (l_user.id, 1)
				assert ("Author not void for node 1", attached node_provider.node_author (1))
			end
		end

	test_new_node_add_collaborator
		do
			node_provider.new_node (default_node)
			assert ("Exist node with id 1", attached {CMS_NODE} node_provider.node (1))
			user_provider.new_user ("u1", "u1", "email")
			if attached user_provider.user_by_name ("u1") as l_user then
				node_provider.add_collaborator (l_user.id, 1)
				assert ("Not Empty Collaborator for node 1", not node_provider.node_collaborators (1).after)
			end
		end

	test_multiple_nodes_add_collaborator
		local
			l_list: LIST[CMS_NODE]
		do
			create {ARRAYED_LIST[CMS_NODE]} l_list.make (0)
			node_provider.new_node (default_node)
			node_provider.new_node (custom_node ("content1", "summary1", "title1"))
			node_provider.new_node (custom_node ("content2", "summary2", "title2"))
			node_provider.new_node (custom_node ("content3", "summary3", "title3"))
			user_provider.new_user ("u1", "u1", "email")
			if attached user_provider.user_by_name ("u1") as l_user then
				node_provider.add_collaborator (l_user.id, 1)
				node_provider.add_collaborator (l_user.id, 2)
				node_provider.add_collaborator (l_user.id, 3)
				node_provider.add_collaborator (l_user.id, 4)
				assert ("Not Empty Collaborator for node 1", not node_provider.node_collaborators (1).after)
				assert ("Not Empty Collaborator for node 2", not node_provider.node_collaborators (2).after)
				assert ("Not Empty Collaborator for node 3", not node_provider.node_collaborators (3).after)
				assert ("Not Empty Collaborator for node 4", not node_provider.node_collaborators (4).after)
			end
		end

	test_nodes_collaborator
		local
			l_list: LIST[CMS_NODE]
		do
			create {ARRAYED_LIST[CMS_NODE]} l_list.make (0)
			node_provider.new_node (default_node)
			node_provider.new_node (custom_node ("content1", "summary1", "title1"))
			node_provider.new_node (custom_node ("content2", "summary2", "title2"))
			node_provider.new_node (custom_node ("content3", "summary3", "title3"))
			user_provider.new_user ("u1", "u1", "email")
			if attached user_provider.user_by_name ("u1") as l_user then
				node_provider.add_collaborator (l_user.id, 1)
				node_provider.add_collaborator (l_user.id, 2)
				node_provider.add_collaborator (l_user.id, 3)
				node_provider.add_collaborator (l_user.id, 4)
				across node_provider.collaborator_nodes (l_user.id) as c loop
					l_list.force (c.item)
				end

				assert ("User is collaborating in 4 nodes", l_list.count = 4)
			end
		end



feature {NONE} -- Implementation

	node_provider: NODE_DATA_PROVIDER
			-- node provider.
		once
			create Result.make (connection)
		end

	user_provider: USER_DATA_PROVIDER
			-- user provider.
		once
			create Result.make (connection)
		end


feature {NONE} -- Implementation Fixture Factories

	default_node: CMS_NODE
		do
			Result := custom_node ("Default content", "default summary", "Default")
		end

	custom_node (a_content, a_summary, a_title: READABLE_STRING_32): CMS_NODE
		do
			create Result.make (a_content, a_summary, a_title)
		end

end



