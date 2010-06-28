note
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
			a_test_attached: a_test /= Void
		do
			test_set := a_test
			initialize_directories
		end

	initialize_directories
			-- Initialize `source_directory' and `target_directory'.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_info: EQA_EVALUATION_INFO
			l_source_var, l_testing_var: detachable STRING
		do
			create l_env
			create l_info
			l_source_var := l_env.get (source_env)
			if l_source_var /= Void then
				set_source_directory (l_source_var)
			end
			l_testing_var := l_env.get (testing_env)
			if l_testing_var /= Void then
				set_target_directory (l_testing_var)
			else
				set_target_directory (l_info.test_directory)
			end
		end

feature -- Access

	test_set: EQA_SYSTEM_TEST_SET
			-- Current test set

	source_directory: READABLE_STRING_8
			-- Directory name where source file for system level testing are stored
			--
			-- Note: this directory must exists before executing `test_set'.
		require
			source_directory_set: is_source_directory_set
		local
			l_cache: like source_directory_cache
		do
			l_cache := source_directory_cache
			check set: l_cache /= Void end
			Result := l_cache
		end

	target_directory: READABLE_STRING_8
			-- Directory name where files needed for system level testing are created or copied to
			--
			-- Note: working directory by default

	test_suffix: READABLE_STRING_8
			-- Directory suffix for `test_set'
			--
			-- Note: this should be unique for all tests, so each test has its private testing directory

	executable_name: READABLE_STRING_8
			-- Executable for launching the system under test.
		local
			l_exec_env: EXECUTION_ENVIRONMENT
			l_cmd: detachable STRING
		do
			l_cmd := get (executable_env)
			if l_cmd = Void then
				create l_exec_env
				l_cmd := l_exec_env.command_line.argument (0)
			end
			Result := substitute_recursive (l_cmd)
		end

feature {NONE} -- Access

	source_directory_cache: detachable like source_directory
			-- Internal storage for `source_directory'

feature -- Status report

	is_source_directory_set: BOOLEAN
			-- Has `source_direcoty' been set through `set_source_directory'?
		do
			Result := source_directory_cache /= Void
		end

feature -- Command

	set_source_directory (a_source_directory: like source_directory)
			-- Set `source_directory' to `a_source_directory'.
			--
			-- Note: use this to manually specify where `test_set' retrieves its source files from.
		require
			a_source_directory_attached: a_source_directory /= Void
		do
			create {STRING} source_directory_cache.make_from_string (a_source_directory)
		ensure
			source_directory_set: source_directory ~ a_source_directory
		end

	set_target_directory (a_target_directory: like target_directory)
			-- Set `target_directory' to `a_testing_directory'.
			--
			-- Note: use this to manually specify where `test_set' is executed.
		require
			a_target_directory_attached: a_target_directory /= Void
		do
			create {STRING} target_directory.make_from_string (a_target_directory)
		ensure
			testing_directory_set: target_directory ~ a_target_directory
		end

	substitute_recursive (a_line: STRING): STRING
			-- Call `substitute' recursively util no '$' found anymore
		require
			not_void: a_line /= Void
		local
			l_temp: STRING
			l_stop: BOOLEAN
		do
			from
				Result := a_line
			until
				not Result.has ('$') or l_stop
			loop
				l_temp := substitute (Result)
				if l_temp.is_equal (Result) then
					l_stop := True
				else
					l_stop := False
					Result := l_temp
				end
			end
		ensure
			not_void: Result /= Void
		end

	substitute (a_line: STRING): STRING
			-- `line' with all environment variables replaced
			-- by their values (or left alone if not in
			-- environment)
		require
			line_not_void: a_line /= Void
		local
			k, l_count, l_start: INTEGER
			c: CHARACTER
			l_word: STRING
			l_replacement: detachable STRING
			l_subst_started, l_in_group: BOOLEAN
		do
			create Result.make (a_line.count)
			from
				l_count := a_line.count
				k := 1
			until
				k > l_count
			loop
				c := a_line.item (k)
				if c = Substitute_char then
					if l_subst_started then
						l_subst_started := False
						Result.extend (c)
					else
						l_subst_started := True
					end
				elseif l_subst_started then
					if c = Left_group_char then
						l_in_group := True
					else
						from
							l_start := k
						until
							k > l_count or not is_identifier_char (a_line.item (k))
						loop
							k := k + 1
						end
						k := k - 1
						l_word := a_line.substring (l_start, k)
						l_replacement := value (l_word)
						if l_replacement /= Void then
							Result.append (l_replacement)
						else
							Result.extend (Substitute_char)
							Result.append (l_word)
						end
						if l_in_group then
							l_in_group := False
							k := k + 1
							-- Skip right paren
						end
						l_subst_started := False
					end
				else
					Result.extend (c)
				end
				k := k + 1
			end
			if l_subst_started then
				Result.extend (c)
			end
		end

	value (a_var: STRING): detachable STRING
			-- Value associated with environment variable
			-- `var' (Void if no associated value)
		require
			variable_not_void: a_var /= Void
		do
			Result := get (a_var)
		end

feature -- Constants

	executable_env: STRING = "EQA_EXECUTABLE"
			-- Name of environment variable holding executable name

	source_env: STRING = "EQA_SOURCE"
	testing_env: STRING = "EQA_TARGET"
			-- Environment variable names specifying testing directories.

feature {NONE} -- Constants

	default_source_directory: READABLE_STRING_8
			-- Default value for `source_directory'
		once
			if is_windows then
				Result := "C:\Temp\Source"
			else
				Result := "~/source"
			end
		end

	default_target_directory: READABLE_STRING_8
			-- Default value for `target_directory'
		once
			if is_windows then
				Result := "C:\Temp\Testing"
			else
				Result := "/tmp/testing"
			end
		end

	Substitute_char: CHARACTER = '$'
			-- Character which triggers environment variable
			-- substitution

	Left_group_char: CHARACTER = '('
	Right_group_char: CHARACTER = ')'
			-- Characters which are used for setting environment
			-- variable name off from surrounding text

feature {NONE} -- Implementation

	is_identifier_char (c: CHARACTER): BOOLEAN
			-- Is `c' an identifier character?
		do
			Result := (c >= 'A' and c <= 'Z') or
				(c >= 'a' and c <= 'z') or
				(c >= '0' and c <= '9') or
				(c = '_');
		end

invariant
	test_suffix_not_empty: not test_suffix.is_empty

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
