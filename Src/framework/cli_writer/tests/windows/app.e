note
	description: "Summary description for {APPLICATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	APP

inherit
	ARGUMENTS_32

	SHARED_EXECUTION_ENVIRONMENT

create
	make


feature -- Testing

	default_tests: ARRAY [READABLE_STRING_GENERAL]
		once
			Result := {ARRAY [READABLE_STRING_GENERAL]} <<"empty_assembly">>
		end

	process_test (tn: READABLE_STRING_GENERAL)
		local
			curr: PATH
		do
			curr := execution_environment.current_working_path

			pre_test (tn)
			test_metadata_tables (tn.substring (5, tn.count))
			post_test (tn)

			execution_environment.change_working_path (curr)
		rescue
			if attached curr then
				execution_environment.change_working_path (curr)
			end
		end

feature {NONE} -- Implementation

	test_metadata_tables (a_pattern: READABLE_STRING_GENERAL)
		do
			if is_test_included ("empty_assembly", a_pattern) then
				(create {TEST_METADATA_TABLES}).test_empty_assembly;
			end
			if is_test_included ("define_assembly", a_pattern) then
				(create {TEST_METADATA_TABLES}).test_define_assembly;
			end
			if is_test_included ("cli_directory_size", a_pattern) then
				(create {TEST_METADATA_TABLES}).test_cli_directory_size;
			end
			if is_test_included ("cli_header_size", a_pattern) then
				(create {TEST_METADATA_TABLES}).test_cli_header_size;
			end
		end

feature -- Initialization

	make
		local
			tn: READABLE_STRING_GENERAL
			i, n: INTEGER
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
			tests: ITERABLE [READABLE_STRING_GENERAL]
		do
			n := argument_count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					tn := argument (i)
					if tn.starts_with ("-") then
						if tn.starts_with ("--testdir") then
							is_using_sub_directory_per_test := True
							if i < n then
								create test_directory.make_from_string (argument (i + 1))
								i := i + 1
							else
								create test_directory.make_current
							end
						end
						-- Ignore for now
					else
						if lst = Void then
							create lst.make (n)
						end
						lst.extend (tn)
					end
					i := i + 1
				end
			end
			if lst = Void then
					-- Default
				tests := default_tests
			else
				tests := lst
			end
			across
				tests as ic
			loop
				tn := ic
				process_test (tn)
			end
		end

feature -- Settings

	is_using_sub_directory_per_test: BOOLEAN

	test_directory: detachable PATH

feature {NONE} -- Implementation				

	pre_test (tn: READABLE_STRING_GENERAL)
		local
			p: PATH
			fut: FILE_UTILITIES
		do
			if is_using_sub_directory_per_test and then attached test_directory as loc then
				p := loc.extended (tn)
				if not fut.directory_path_exists (p) then
					fut.create_directory_path (p)
				end
				execution_environment.change_working_path (p)
			end
		end

	post_test (tn: READABLE_STRING_GENERAL)
		do

		end

feature -- Helper

	is_test_included (a_name: READABLE_STRING_GENERAL; a_pattern: READABLE_STRING_GENERAL): BOOLEAN
			-- Is test `a_name` matching pattern `a_pattern`?
		local
			s: READABLE_STRING_GENERAL
		do
			s := a_pattern.as_lower
			if
				s.starts_with ("test_") and
				not a_name.as_lower.starts_with ("test_")
			then
				s := s.substring (6, s.count) -- remove "test_" prefix
			end
			if
				s.is_empty
				or else s.is_case_insensitive_equal ("*")
				or else s.is_case_insensitive_equal ("all")
			then
				Result := True
			else
				Result := a_name.is_case_insensitive_equal (s)
				-- Todo: maybe add wildcart test such as ("*_assembly")
			end
		end

end
