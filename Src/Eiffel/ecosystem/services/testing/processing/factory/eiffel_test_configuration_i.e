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

inherit
	USABLE_I

feature -- Access: general

	name: !STRING
			-- Name used for new test
		require
			usable: is_interface_usable
			single_routine: is_single_routine
		deferred
		end

	tags: !DS_LINEAR [!STRING]
			-- Predefined tags for new test
		require
			usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = tags
			not_contains_empty: not Result.there_exists (agent {!STRING}.is_empty)
		end

feature -- Access: new class

	new_class_name: !STRING
			-- Name of the new class
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	cluster: !CONF_CLUSTER
			-- Cluster in which the new class will be created
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	path: !STRING
			-- Path relativ to `cluster' location where new test class will be created
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

feature -- Access: existing class

	test_class: !EIFFEL_CLASS_I
			-- Class to which new test will be added
		require
			usable: is_interface_usable
			not_new_class: not is_new_class
		deferred
		end

	feature_clause: !FEATURE_CLAUSE_AS
			-- Feature clause to which new test routine will be written to
		require
			usable: is_interface_usable
			not_new_class: not is_new_class
			not_new_feature_clause: not is_new_feature_clause
		deferred
		end

	feature_clause_name: !STRING
			-- Name of new feature clause
		require
			usable: is_interface_usable
			not_new_class: not is_new_class
			new_feature_clause: is_new_feature_clause
		deferred
		end

feature -- Status report

	is_single_routine: BOOLEAN
			-- Will new test be a single test routine?
		require
			usable: is_interface_usable
		deferred
		end

	is_new_class: BOOLEAN
			-- Will test be created in a new class?
		require
			usable: is_interface_usable
		deferred
		end

	is_new_feature_clause: BOOLEAN
			-- Should test be created in new feature clause?
		require
			usable: is_interface_usable
			not_new_class: not is_new_class
		deferred
		end

	has_prepare: BOOLEAN
			-- Should new test class redefine `on_prepare' routine?
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	has_clean: BOOLEAN
			-- Should new test class redefine `on_clean' routine?
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

end
