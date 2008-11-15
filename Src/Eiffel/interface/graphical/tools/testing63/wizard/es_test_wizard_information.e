indexing
	description: "[
		Information gathered by the eiffel test wizard to create new test.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_INFORMATION

inherit
	EB_WIZARD_INFORMATION

	TEST_CREATOR_CONF_I
		select
			is_interface_usable
		end

	TEST_MANUAL_CREATOR_CONF_I
		rename
			is_interface_usable as is_manual_configuration_usable
		end

	TEST_EXTRACTOR_CONF_I
		rename
			is_interface_usable as is_extractor_configuration_usable
		end

	TEST_GENERATOR_CONF_I
		rename
			is_interface_usable as is_generator_configuration_usable
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			set_new_manual_test_class
			create tag_list.make_default
			create call_stack_elements.make_default
			create types.make_default

				-- Auto Test defaults
			is_slicing_enabled := True
			time_out := 15
			proxy_time_out := 5
			is_html_output := True
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
			l_cache: like cached_tags
		do
			l_cache := cached_tags
			if l_cache = Void then
				create l_list.make_from_linear (tag_list)
				if class_covered /= Void then
					create l_cover.make (30)
					l_cover.append ("covers/{")
					l_cover.append (class_covered.name)
					l_cover.append_character ('}')
					if feature_covered /= Void then
						l_cover.append_character ('.')
						if feature_covered.is_prefix then
							l_cover.append ("prefix_")
							l_cover.append (feature_covered.prefix_symbol)
						elseif feature_covered.is_infix then
							l_cover.append ("infix_")
							l_cover.append (feature_covered.infix_symbol)
						else
							l_cover.append (feature_covered.name)
						end
					end
					l_list.force_last (l_cover)
				end
				Result := l_list
				cached_tags := Result
			else
				Result := l_cache
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

feature -- Access: AutoTest

	time_out: NATURAL assign set_time_out
			-- <Precursor>

	proxy_time_out: NATURAL assign set_proxy_time_out
			-- <Precursor>

	seed: NATURAL assign set_seed
			-- <Precursor>

	types: !DS_HASH_SET [!STRING]
			-- <Precursor>

feature {ES_TEST_WIZARD_WINDOW} -- Access

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

feature {NONE} -- Access

	cached_tags: ?like tags
			-- Cache for `tags'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			if not is_manual_test_class then
				Result := new_class_name_cache /= Void and
			              cluster_cache /= Void and
			              path_cache /= Void
			elseif test_class_cache /= Void then
				if is_new_feature_clause then
					Result := feature_clause_name_cache /= Void
				else
					Result := feature_clause_cache /= Void
				end
			end
		end

	is_manual_configuration_usable: BOOLEAN
			-- <Precursor>
		do
			Result := is_interface_usable and then name_cache /= Void
		end

	is_extractor_configuration_usable: BOOLEAN
			-- <Precursor>
		do
			Result := is_interface_usable and is_extracted_test_class
		end

	is_generator_configuration_usable: BOOLEAN
			-- <Precursor>
		do
			Result := is_interface_usable and is_generated_test_class
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

	is_new_class: BOOLEAN
			-- <Precursor>
		do
			Result := not is_manual_test_class
		end

	is_multiple_new_classes: BOOLEAN
			-- <Precursor>
		do
			if is_new_class then
				Result := is_generated_test_class
			end
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

	is_benchmarking: BOOLEAN assign set_benchmarking
			-- <Precursor>

	is_slicing_enabled: BOOLEAN assign set_slicing_enabled
			-- <Precursor>

	is_ddmin_enabled: BOOLEAN assign set_ddmin_enabled
			-- <Precursor>

	is_html_output: BOOLEAN assign set_html_output

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
			cached_tags := Void
		ensure
			class_covered_set: class_covered = a_class_covered
		end

	set_feature_covered (a_feature_covered: like feature_covered)
			-- Set `feature_covered' to `a_feature_covered'.
		do
			feature_covered := a_feature_covered
			cached_tags := Void
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

	set_benchmarking (a_is_benchmarking: like is_benchmarking)
			-- Set `is_benchmarking' to `a_is_benchmarking'.
		do
			is_benchmarking := a_is_benchmarking
		ensure
			is_benchmarking_set: is_benchmarking = a_is_benchmarking
		end

	set_ddmin_enabled (a_is_ddmin_enabled: like is_ddmin_enabled)
			-- Set `is_ddmin_enabled' to `a_is_ddmin_enabled'.
		do
			is_ddmin_enabled := a_is_ddmin_enabled
		ensure
			is_ddmin_enabled_set: is_ddmin_enabled = a_is_ddmin_enabled
		end

	set_slicing_enabled (a_is_slicing_enabled: like is_slicing_enabled)
			-- Set `is_slicing_enabled' to `a_is_slicing_enabled'.
		do
			is_slicing_enabled := a_is_slicing_enabled
		ensure
			is_slicing_enabled_set: is_slicing_enabled = a_is_slicing_enabled
		end

	set_html_output (a_is_html_output: like is_html_output)
			-- Set `is_html_output' to `a_is_html_output'.
		do
			is_html_output := a_is_html_output
		ensure
			is_html_output_set: is_html_output = a_is_html_output
		end

	set_seed (a_seed: like seed)
			-- Set `seed' to `a_seed'.
		do
			seed := a_seed
		ensure
			seed_set: seed = a_seed
		end

	set_time_out (a_time_out: like time_out)
			-- Set `time_out' to `a_time_out'.
		do
			time_out := a_time_out
		ensure
			time_out_set: time_out = a_time_out
		end

	set_proxy_time_out (a_proxy_time_out: like proxy_time_out)
			-- Set `proxy_time_out' to `a_proxy_time_out'.
		do
			proxy_time_out := a_proxy_time_out
		ensure
			proxy_time_out_set: proxy_time_out = a_proxy_time_out
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
