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

	EIFFEL_TEST_EXTRACTOR_CONFIGURATION_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			set_new_manual_test_class
			create tag_list.make_default
			create call_stack_elements.make_default
		end

feature -- Access

	name: !STRING
			-- <Precursor>
		do
			if {l_name: like name} name_cache then
				Result := l_name
			end
		end

	tags: !DS_LINEAR [!STRING]
			-- <Precursor>
		local
			l_list: DS_ARRAYED_LIST [!STRING]
			l_cover: !STRING
		do
			create l_list.make_from_linear (tag_list)
			if class_covered /= Void then
				create l_cover.make (30)
				l_cover.append ("covers/{")
				l_cover.append (class_covered.name)
				l_cover.append_character ('}')
				if feature_covered /= Void then
					l_cover.append_character ('.')
					l_cover.append (feature_covered.name)
				end
			end
		end

	new_class_name: !STRING
			-- <Precursor>
		do
			if {l_name: like new_class_name} new_class_name_cache then
				Result := l_name
			end
		end

	cluster: !CONF_CLUSTER
			-- <Precursor>
		do
			if {l_cluster: like cluster} cluster_cache then
				Result := l_cluster
			end
		end

	path: !STRING
			-- <Precursor>
		do
			if {l_path: like path} path_cache then
				Result := l_path
			end
		end

	test_class: !EIFFEL_CLASS_I
			-- <Precursor>
		do
			if {l_class: like test_class} test_class_cache then
				Result := l_class
			end
		end

	feature_clause: !FEATURE_CLAUSE_AS
			-- <Precursor>
		do
			if {l_fc: like feature_clause} feature_clause_cache then
				Result := l_fc
			end
		end

	feature_clause_name: !STRING
			-- <Precursor>
		do
			if {l_name: like feature_clause_name} feature_clause_name_cache then
				Result := l_name
			end
		end

	call_stack_elements: !DS_HASH_SET [INTEGER]
			-- <Precursor>

feature {ES_EIFFEL_TEST_WIZARD_WINDOW} -- Access

	type: NATURAL
			-- Type of test class

	name_cache: ?like name assign set_name
			-- Cache for `name'

	new_class_name_cache: ?like new_class_name assign set_new_class_name
			-- Cache for `new_class_name'

	cluster_cache: ?like cluster assign set_cluster
			-- Cache for `cluster'

	path_cache: ?like path assign set_path
			-- Cache for `path'

	test_class_cache: ?like test_class assign set_test_class
			-- Cache for `test_class'

	feature_clause_cache: ?like feature_clause assign set_feature_clause
			-- Cache for `feature_clause'

	feature_clause_name_cache: ?like feature_clause_name assign set_feature_clause_name
			-- Cache for `feature_clause_name'

	class_covered: ?CLASS_I assign set_class_covered
			-- Class which new test will cover

	feature_covered: ?E_FEATURE assign set_feature_covered
			-- Feature which new test will cover

	tag_list: !DS_HASH_SET [!STRING]
			-- List of tags for new test routine

	is_new_feature_clause_cache: BOOLEAN assign set_is_new_feature_clause
			-- Cache for `is_new_feature_clause'

	has_prepare_cache: BOOLEAN assign set_has_prepare
			-- Cache for `has_prepare'

	has_clean_cache: BOOLEAN assign set_has_clean
			-- Cache for `has_clean'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := True
			if Result and is_single_routine then
				Result := name_cache /= Void
			end
			if Result and not is_manual_test_class then
				Result := new_class_name_cache /= Void and
				          cluster_cache /= Void and
				          path_cache /= Void
			elseif Result then
				Result := test_class_cache /= Void
				if Result and is_new_feature_clause then
					Result := feature_clause_name_cache /= Void
				elseif Result then
					Result := feature_clause_cache /= Void
				end
			end
		end

	is_new_manual_test_class: BOOLEAN
			-- Are we creating a manual test routine in a new class?
		do
			Result := type = new_manual_test_class_code
		ensure
			correct_result: Result = (type = new_manual_test_class_code)
		end

	is_manual_test_class: BOOLEAN
			-- Are we creating a manual test in an existing class?
		do
			Result := type = manual_test_class_code
		ensure
			correct_result: Result = (type = manual_test_class_code)
		end

	is_extracted_test_class: BOOLEAN
			-- Are we creating an extracted test class?
		do
			Result := type = extracted_test_class_code
		ensure
			correct_result: Result = (type = extracted_test_class_code)
		end

	is_generated_test_class: BOOLEAN
			-- Are we creating a generated test class?
		do
			Result := type = generated_test_class_code
		ensure
			correct_result: Result = (type = generated_test_class_code)
		end

	is_single_routine: BOOLEAN
			-- <Precursor>
		do
			Result := is_new_manual_test_class or is_manual_test_class
		end

	is_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := not is_manual_test_class
		end

	has_prepare: BOOLEAN assign set_has_prepare
			-- <Precursor>
		do
			Result := has_prepare_cache
		end

	has_clean: BOOLEAN assign set_has_clean
			-- <Precursor>
		do
			Result := has_clean_cache
		end

	is_new_feature_clause: BOOLEAN assign set_is_new_feature_clause
			-- <Precursor>
		do
			Result := is_new_feature_clause_cache
		end

	is_system_level_test: BOOLEAN assign set_is_system_level_test
			-- Is new test a system level test?

feature -- Status setting

	set_new_manual_test_class
			-- Set `type' to `new_manual_test_class_code'.
		do
			type := new_manual_test_class_code
		end

	set_manual_test_class
			-- Set `type' to `manual_test_class_code'.
		do
			type := manual_test_class_code
		end

	set_extracted_test_class
			-- Set `type' to `extracted_test_class_code'.
		do
			type := extracted_test_class_code
		end

	set_generated_test_class
			-- Set `type' to `generated_test_class_code'.
		do
			type := generated_test_class_code
		end

	set_name (a_name: like name_cache)
			-- Set `name_cache' to `a_name'.
		do
			name_cache := a_name
		ensure
			name_set: name_cache = a_name
		end

	set_new_class_name (a_name: like new_class_name_cache)
			-- Set `new_class_name_cache' to `a_name'.
		do
			new_class_name_cache := a_name
		ensure
			new_class_name_cache_set: new_class_name_cache = a_name
		end

	set_cluster (a_cluster: like cluster_cache)
			-- Set `cluster_cache' to `a_cluster'.
		do
			cluster_cache := a_cluster
		ensure
			cluster_set: cluster_cache = a_cluster
		end

	set_path (a_path: like path_cache)
			-- Set `path_cache' to `a_path'.
		do
			path_cache := a_path
		ensure
			path_set: path_cache = a_path
		end

	set_test_class (a_test_class: like test_class_cache)
			-- Set `test_class_cache' to `a_test_class'.
		do
			test_class_cache := a_test_class
		ensure
			test_class_set: test_class_cache = a_test_class
		end

	set_feature_clause (a_feature_clause: like feature_clause_cache)
			-- Set `feature_clause_cache' to `a_feature_clause'.
		do
			feature_clause_cache := a_feature_clause
		ensure
			feature_clause_set: feature_clause_cache = a_feature_clause
		end

	set_feature_clause_name (a_name: like feature_clause_name_cache)
			-- Set `feature_clause_name_cache' to `a_name'.
		do
			feature_clause_name_cache := a_name
		ensure
			name_set: feature_clause_name_cache = a_name
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

	set_is_new_feature_clause (a_is_new_feature_clause: like is_new_feature_clause_cache)
			-- Set `is_new_feature_clause' to `a_is_new_feature_clause'.
		do
			is_new_feature_clause_cache := a_is_new_feature_clause
		ensure
			is_is_new_feature_clause: is_new_feature_clause_cache = a_is_new_feature_clause
		end

	set_has_prepare (a_has_prepare: like has_prepare_cache)
			-- Set `has_prepare' to `a_has_prepare'.
		do
			has_prepare_cache := a_has_prepare
		ensure
			has_prepare_set: has_prepare_cache = a_has_prepare
		end

	set_has_clean (a_has_clean: like has_clean_cache)
			-- Set `has_clean' to `a_has_clean'.
		do
			has_clean_cache := a_has_clean
		ensure
			has_clean_set: has_clean_cache = a_has_clean
		end

	set_is_system_level_test (a_is_system_level_test: like is_system_level_test)
			-- Set `is_system_level_test' to `a_is_system_level_test'.
		do
			is_system_level_test := a_is_system_level_test
		ensure
			is_system_level_test_set: is_system_level_test = a_is_system_level_test
		end

feature {NONE} -- Constants

	new_manual_test_class_code: NATURAL = 1
	manual_test_class_code: NATURAL = 2
	extracted_test_class_code: NATURAL = 3
	generated_test_class_code: NATURAL = 4

invariant
	type_valid: type = new_manual_test_class_code or
	            type = manual_test_class_code or
	            type = extracted_test_class_code or
	            type = generated_test_class_code

end
