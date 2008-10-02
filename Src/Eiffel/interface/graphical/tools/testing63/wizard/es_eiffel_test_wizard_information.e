indexing
	description: "[
		Information gathered by the eiffel test wizard to create new test.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_WIZARD_INFORMATION

inherit
	EB_WIZARD_INFORMATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			is_new_class := True
			create tag_list.make_default
		end

feature -- Access

	new_class_name: ?STRING
			-- Name of new test class

	parent: ?CONF_CLUSTER
			-- Cluster in which new class will be created

	path: ?STRING
			-- Additional path of new test class in `parent'

	test_class: ?CLASS_I
			-- Existing test class in which test routine will be created

	feature_clause: ?FEATURE_CLAUSE_AS
			-- Feature clause in which new test will be written

	feature_clause_name: ?STRING
			-- Name for new feature clause

	test_name: ?STRING
			-- Name for new test routine?

	class_covered: ?CLASS_I
			-- Class which new test will cover

	feature_covered: ?E_FEATURE
			-- Feature which new test will cover

	tag_list: !DS_HASH_SET [!STRING]
			-- List of tags for new test routine

feature -- Status report

	is_feature_clause_new: BOOLEAN
			-- Should test be written to a new feature clause?

	is_new_class: BOOLEAN
			-- Should test be written to a new test class?

	has_setup: BOOLEAN
			-- Should `set_up' routine be redefined in new test class?

	has_tear_down: BOOLEAN
			-- Should `tear_down' routine be redefined in new test class?

	is_system_level_test: BOOLEAN
			-- Is new test a system level test?

feature -- Status setting

	set_new_class_name (a_name: like new_class_name)
			-- Set `new_class_name' to `a_name'.
		do
			new_class_name := a_name
		ensure
			new_class_name_set: new_class_name = a_name
		end

	set_parent (a_cluster: like parent)
			-- Set `parent' to `a_cluster'.
		do
			parent := a_cluster
		ensure
			cluster_set: parent = a_cluster
		end

	set_path (a_path: like path)
			-- Set `path' to `a_path'.
		do
			path := a_path
		ensure
			path_set: path = a_path
		end

	set_test_class (a_test_class: like test_class)
			-- Set `test_class' to `a_test_class'.
		do
			test_class := a_test_class
		ensure
			test_class_set: test_class = a_test_class
		end

	set_feature_clause (a_feature_clause: like feature_clause)
			-- Set `feature_clause' to `a_feature_clause'.
		do
			feature_clause := a_feature_clause
		ensure
			feature_clause_set: feature_clause = a_feature_clause
		end

	set_feature_clause_name (a_feature_clause_name: like feature_clause_name)
			-- Set `feature_clause_name' to `a_feature_clause_name'.
		do
			feature_clause_name := a_feature_clause_name
		ensure
			feature_clause_name_set: feature_clause_name = a_feature_clause_name
		end

	set_test_name (a_test_name: like test_name)
			-- Set `test_name' to `a_test_name'.
		do
			test_name := a_test_name
		ensure
			test_name_set: test_name = a_test_name
		end

	set_class_covered (a_class_covered: like class_covered)
			-- Set `class_covered' to `a_class_covered'.
		do
			class_covered := a_class_covered
		ensure
			class_covered_set: class_covered = a_class_covered
		end

	set_feature_covered (a_feature_covered: like feature_covered)
			-- Set `feature_covered' to `a_feature_covered'.
		do
			feature_covered := a_feature_covered
		ensure
			feature_covered_set: feature_covered = a_feature_covered
		end

	set_is_feature_clause_new (a_is_feature_clause_new: like is_feature_clause_new)
			-- Set `is_feature_clause_new' to `a_is_feature_clause_new'.
		do
			is_feature_clause_new := a_is_feature_clause_new
		ensure
			is_feature_clause_new_set: is_feature_clause_new = a_is_feature_clause_new
		end

	set_is_new_class (a_is_new_class: like is_new_class)
			-- Set `is_new_class' to `a_is_new_class'.
		do
			is_new_class := a_is_new_class
		ensure
			is_new_class_set: is_new_class = a_is_new_class
		end

	set_has_set_up (a_has_set_up: like has_setup)
			-- Set `has_setup' to `a_has_set_up'.
		do
			has_setup := a_has_set_up
		ensure
			has_set_up_set: has_setup = a_has_set_up
		end

	set_has_tear_down (a_has_tear_down: like has_tear_down)
			-- Set `has_tear_down' to `a_has_tear_down'.
		do
			has_tear_down := a_has_tear_down
		ensure
			has_tear_down_set: has_tear_down = a_has_tear_down
		end

	set_is_system_level_test (a_is_system_level_test: like is_system_level_test)
			-- Set `is_system_level_test' to `a_is_system_level_test'.
		do
			is_system_level_test := a_is_system_level_test
		ensure
			is_system_level_test_set: is_system_level_test = a_is_system_level_test
		end

end
