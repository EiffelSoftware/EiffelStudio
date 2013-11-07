note
	description: "[
		The ancestor for provider classes of backend-neutral tests.
		Each test defined in a descendants of this class should provide the following:
			- The test does not take any arguments
			- The test shall leave an empty database after execution
			- The test can assume an empty database before execution
		Additionaly, the provider class should be instantiated using the make feature defined here.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_TEST_PROVIDER

inherit

	PS_EIFFELSTORE_EXPORT
		undefine
			default_create
		end

	EQA_TEST_SET
		export
			{NONE} all
		end

feature {PS_TEST_PROVIDER}

	repository: PS_REPOSITORY
			-- The repository to operate on

	executor: PS_EXECUTOR
			-- An executor for `repository'

	repo_access: PS_TRANSACTION_CONTEXT

	test_data: PS_TEST_DATA
			-- Some useful test data

	make (a_repository: PS_REPOSITORY)
			-- Initialization for `Current'
		do
			default_create
			repository := a_repository
			create executor.make (repository)
			repo_access := repository.new_transaction_context
--			create {PS_REPOSITORY_ACCESS_IMPL} repo_access.make (repository)
			create test_data.make
			initialize
		end

	initialize
			-- Initialize every other field
		do
		end

end
