indexing
	description: "[
		Interface containing configuration options for manual test classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_MANUAL_CREATOR_CONF_I

inherit
	TEST_CREATOR_CONF_I

feature -- Access

	name: !STRING
			-- Name used for new test
		require
			usable: is_interface_usable
		deferred
		end

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
