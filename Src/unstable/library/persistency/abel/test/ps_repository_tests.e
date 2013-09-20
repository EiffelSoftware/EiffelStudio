note
	description: "Ancestor to all classes that test a repository. The descendants can just call the provider class tests in order to add a test for their specific repository"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_REPOSITORY_TESTS

inherit

	PS_EIFFELSTORE_EXPORT
		undefine
			default_create
		end

	EQA_TEST_SET
		redefine
			on_prepare
		end

feature

	on_prepare
			-- Create the repository instance and all tests
		do
			repository := make_repository
			create crud_tests.make (repository)
			create criteria_tests.make (repository)
			create transaction_tests.make (repository)
			create object_graph_tests.make (repository)
		end

feature {NONE} -- Initialization

	make_repository: PS_REPOSITORY
			-- Create the specific repository for `Current' test suite
		deferred
		end

feature {PS_REPOSITORY_TESTS} -- Access

	repository: PS_REPOSITORY
			-- The repository of the current test.

	crud_tests: PS_CRUD_TESTS
			-- Provider for CRUD tests

	criteria_tests: PS_CRITERIA_TESTS
			-- Provider for criteria tests

	transaction_tests: PS_TRANSACTION_TESTS
			-- Provider for transaction tests

	object_graph_tests: PS_OBJECT_GRAPH_SETTINGS_TEST
			-- Provider for object graph settings tests

feature {PS_REPOSITORY_TESTS} -- Utilities

	stop
			-- Manually stop execution (e.g. to inspect the database)
		do
			check
				manual_stop: False
			end
		end

end
