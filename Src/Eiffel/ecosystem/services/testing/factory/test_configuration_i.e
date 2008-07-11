indexing
	description: "[
		Configuration used by test factories to create new tests
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CONFIGURATION_I

feature -- Access

	name: !STRING
			-- Name used for new test
		deferred
		end

	tags: !DS_LINEAR [!STRING]
			-- Predefined tags for new test
		deferred
		ensure
			result_consistent: Result = tags
			not_contains_empty: not Result.there_exists (agent {!STRING}.is_empty)
		end

feature -- Query

	is_complete: BOOLEAN
			-- Can the current configuration be used to create a new test?
		do
			Result := name.is_empty
		end

end
