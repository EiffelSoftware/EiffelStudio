indexing
	description: "[
		Configuration used by test factories to create new eiffel tests
		
		An eiffel test is a routine in some class. If the test shall be
		created in a new class, class name and location must be provided.
		Otherwise an existing class is provided in which the test will
		simply be added.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_CONFIGURATION_I

feature -- Access

	name: !STRING
			-- Name used for new test
		deferred
		end

	new_parent_name: !STRING
			-- Name of the new class
		require
			create_new_parent: create_new_parent
		deferred
		end

	new_location: !CONF_CLUSTER
			-- Cluster in which the new class will be created
		require
			create_new_parent: create_new_parent
		deferred
		end

	parent: EIFFEL_CLASS_I
			-- Class to which new test will be added
		require
			not_create_new_parent: not create_new_parent
		deferred
		end

	covered_classes: !DS_BILINEAR [!CLASS_I]
			-- Classes beeing tested by new test
		deferred
		ensure
			result_consistent: Result = covered_classes
		end

	covered_features: !DS_BILINEAR [!FEATURE_I]
			-- Features beeing tested by new test
		deferred
		ensure
			result_consistent: Result = covered_features
		end

	tags: !DS_LINEAR [!STRING]
			-- Predefined tags for new test
		deferred
		ensure
			result_consistent: Result = tags
			not_contains_empty: not Result.there_exists (agent {!STRING}.is_empty)
		end

feature -- Query

	create_new_parent: BOOLEAN
			-- Will test be created in a new class?
		deferred
		end

end
