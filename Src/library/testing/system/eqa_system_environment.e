indexing
	description: "[
		Objects representing a environment for system testing.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_SYSTEM_ENVIRONMENT

inherit
	EXECUTION_ENVIRONMENT

	PLATFORM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_test: like test_set)
			-- Initialize `Current'.
			--
			-- `a_test': Prepared system test for which environment should be initialized.
		require
			a_test_has_name: a_test.has_valid_name
		local
			l_source_var, l_testing_var: STRING
		do
			test_set := a_test
			l_source_var := get (source_env)
			if l_source_var /= Void then
				set_source_directory (l_source_var)
			else
				set_source_directory (default_source_directory)
			end
			l_testing_var := get (testing_env)
			if l_testing_var /= Void then
				set_target_directory (l_testing_var)
			else
				set_target_directory (default_target_directory)
			end
			initialize_test_suffix
		end

	initialize_test_suffix
			-- Initialize testing directory suffix for `test_set'
		local
			l_gen, l_name, l_suffix: STRING
		do
			l_gen := test_set.generator
			l_name := test_set.current_test_name
			create l_suffix.make (l_gen.count + l_name.count + 1)
			l_suffix.append (l_gen)
			l_suffix.append_character ('_')
			l_suffix.append (l_name)
			test_suffix := l_suffix
		end

feature -- Access

	test_set: !EQA_SYSTEM_TEST_SET
			-- Current test set

	source_directory: !READABLE_STRING_8
			-- Directory name where source file for testing are stored
			--
			-- Note: this directory must exists before executing `test_set'

	target_directory: !READABLE_STRING_8
			-- Directory name where files needed for testing are created or copied to
			--
			-- Note: this directory must exist before executing `test_set'

	test_suffix: !READABLE_STRING_8
			-- Directory suffix for `test_set'
			--
			-- Note: this should be unique for all tests, so each test has its private testing directory

feature -- Status setting

	set_source_directory (a_source_directory: like source_directory)
			-- Set `source_directory' to `a_source_directory'.
			--
			-- Note: use this to manually specify where `test_set' retrieves its source files from.
		do
			create {STRING} source_directory.make_from_string (a_source_directory)
		ensure
			source_directory_set: source_directory ~ a_source_directory
		end

	set_target_directory (a_target_directory: like target_directory)
			-- Set `target_directory' to `a_testing_directory'.
			--
			-- Note: use this to manually specify where `test_set' is executed.
		do
			create {STRING} target_directory.make_from_string (a_target_directory)
		ensure
			testing_directory_set: target_directory ~ a_target_directory
		end

feature {NONE} -- Constants

	source_env: !STRING = "EQA_SOURCE"
	testing_env: !STRING = "EQA_TARGET"
			-- Environment variable names specifying testing directories.

	default_source_directory: !READABLE_STRING_8
			-- Default value for `source_directory'
		once
			if is_windows then
				Result := "C:\Temp\Source"
			else
				Result := "~/source"
			end
		end

	default_target_directory: !READABLE_STRING_8
			-- Default value for `target_directory'
		once
			if is_windows then
				Result := "C:\Temp\Testing"
			else
				Result := "/tmp/testing"
			end
		end

invariant
	test_set_has_name: test_set.has_valid_name
	test_suffix_not_empty: not test_suffix.is_empty

end
