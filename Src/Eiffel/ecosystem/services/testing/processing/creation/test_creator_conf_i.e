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
	TEST_CREATOR_CONF_I

inherit
	USABLE_I

feature -- Access: tags

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
			-- Name of the new class. If `is_multiple_new_classes' is true, it will be used as a prefix for
			-- all new classes.
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	cluster: !CONF_CLUSTER
			-- Cluster in which new test classes will be created
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

	path: !STRING
			-- Path relativ to location of `cluster' where new test classes will be created
		require
			usable: is_interface_usable
			new_class: is_new_class
		deferred
		end

feature -- Status report

	is_new_class: BOOLEAN
			-- Will test be created in a new class?
		require
			usable: is_interface_usable
		deferred
		end

	is_multiple_new_classes: BOOLEAN
			-- Will factory create one or more new test classes?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_new_class: Result implies is_new_class
		end

end
