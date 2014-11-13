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
			(create {CLEAN_DB}).clean_db(connection)
		end

	on_clean
			-- <Precursor>
		do
		end

feature -- Test routines

	test_user_rollback
		note
			testing:  "execution/isolated"
		do
			connection.begin_transaction
			user_provider.new_user ("test", "test","test@admin.com")
			assert ("Has user:", user_provider.has_user)
			connection.rollback
			assert ("Not has user:", not user_provider.has_user)
		end

	test_user_node_rollback
		note
			testing:  "execution/isolated"
		do
			connection.begin_transaction
			user_provider.new_user ("test", "test","test@admin.com")
			assert ("Has user:", user_provider.has_user)
			node_provider.new_node (default_node)
			node_provider.add_author (1, 1)
			assert ("Has one node:", node_provider.count = 1)
			connection.rollback
			assert ("Not has user:", not user_provider.has_user)
			assert ("Not has nodes:", node_provider.count = 0)
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


