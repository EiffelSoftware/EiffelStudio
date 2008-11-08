indexing
	description: "[
		Interface which scans project for potential test classes.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CLASS_LOCATOR_I

inherit
	USABLE_I

feature -- Access

	project: !TEST_PROJECT_I
			-- Project for which `Current' is locating test classes
		require
			usable: is_interface_usable
			locating: is_locating
		deferred
		end

feature -- Status report

	is_locating: BOOLEAN
			-- Is `Current' scanning for test classes?
		require
			usable: is_interface_usable
		deferred
		end

feature {TEST_PROJECT_I} -- Status setting

	locate_classes (a_project: like project) is
			-- Locate potential test classes in project
			--
			-- `a_project': Test project for which test classes shall be reported
		require
			usable: is_interface_usable
			a_project_usable: a_project.is_interface_usable
			a_project_synchronizing: a_project.is_updating_tests
			not_locating: not is_locating
		deferred
		ensure
			not_locating: not is_locating
		end

feature {TEST_PROJECT_I} -- Query

	is_test_class (a_class: !EIFFEL_CLASS_I; a_project: like project): BOOLEAN
			-- Does class represent a test class?
			--
			-- `a_class': Class for which should be determined whether it is a test class.
			-- `a_project': Project in which `a_class' is located.
			-- `Result': True if `a_class' is a test class, False otherwise.
		require
			usable: is_interface_usable
			not_locating: not is_locating
		deferred
		ensure
			not_locating: not is_locating
		end

end
