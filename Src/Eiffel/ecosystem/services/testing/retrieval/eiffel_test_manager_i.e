indexing
	description: "[
		Interface for retrieving, adding and removing tests from an eiffe project.
		
		Tests are added or removed by the service internally. Usually the list of tests is updated after
		a compilation. However clients such as test factories can request that the test suite
		synchronizes with classes changed since last compilation. Since in these cases it can not be
		determined whether a class is a valid test class, the test suite will assume it. After the system
		has compiled, it assures all tests are actually valid tests.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_MANAGER_I

inherit
	EIFFEL_TEST_COLLECTION_I
		rename
			are_tests_available as is_project_initialized
		end

feature -- Access

	project: !E_PROJECT
		require
			usable: is_interface_usable
			initialized: is_project_initialized
		deferred
		ensure
			project_initialized: Result.initialized and Result.workbench.universe_defined and
			                     Result.system_defined and then Result.universe.target /= Void
		end

	last_created_cluster: ?CONF_TEST_CLUSTER
			-- Cluster last created by calling `add_test_cluster'
		require
			usable: is_interface_usable
		deferred
		end

	last_created_class: ?CLASS_I
			-- Class last created by calling `add_class'
		require
			usable: is_interface_usable
		deferred
		end

feature -- Status report

	is_project_initialized: BOOLEAN
			-- Has `Current' already received a project for which it should manage tests?
		deferred
		end

	is_updating_tests: BOOLEAN
			-- Is test list currently beeing updated?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Element change

	add_test_cluster (a_name: !STRING; a_path: !STRING; a_parent: ?CONF_CLUSTER) is
			-- Add a new testing cluster to `project'. New cluster will be available thro
			--
			-- `
		require
			a_name_not_empty: a_name.is_empty
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
		do
		end

	add_class (a_path: !STRING; a_cluster: !CONF_CLUSTER)
			-- Make existing class file appear as class in system
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
		do
		end

	synchronize_with_class (a_class: !CLASS_I)
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
			a_class_in_project: is_class_in_project (a_class)
		do
		end

	remove_class (a_class: !CLASS_I)
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
			a_class_in_project: is_class_in_project (a_class)
		do
		end

feature -- Query

	is_class_in_project (a_class: !CLASS_I): BOOLEAN is
			-- Does `a_class' belong to `project'?
			--
			-- `a_class': Class for which it should be determined whether it exists in `project'.
			-- `Result': True is class can be found in `project', False otherwise
		require
			usable: is_interface_usable
			project_available: is_project_initialized
		do
			Result := project.universe.class_named (a_class.name, a_class.group) /= Void
		end

	is_test_class (a_class: !CLASS_I): BOOLEAN is
			-- Does `Current' recognize `a_class' as a valid test class?
			--
			-- `a_class': Class for which it should be determined whether it is a test class.
			-- `Result': True if `a_class' is a test class, False otherwise.
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
		deferred
		end

	tests_for_class (a_class: !CLASS_I): !DS_LINEAR [!EIFFEL_TEST_I]
			-- Returns a list containing the tests defined in the given class.
			--
			-- `a_class': Class for which a list of tests defined in the class will be returned.
			-- `Result': List of tests defined in `a_class'.
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
			a_class_is_test_class: is_test_class (a_class)
		deferred
		end

end
