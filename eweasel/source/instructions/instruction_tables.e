indexing
	description: "Tables of Eiffel test instructions"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel testing";
	date: "93/08/30"

class INSTRUCTION_TABLES
inherit
	ANY
	KEYWORD_CONST
		export
			{NONE} all
		end

feature

	test_command_table: HASH_TABLE [TEST_INSTRUCTION, STRING] is
		local
			t: TEST_INSTRUCTION;
		once
			create Result.make (30);
			create {IF_INST} t;
			Result.put (t, If_keyword);
			create {UNKNOWN_INST} t;
			Result.put (t, Unknown_keyword);
			create {INCLUDE_INST} t;
			Result.put (t, Include_keyword);
			create {TEST_NAME_INST} t;
			Result.put (t, Test_name_keyword);
			create {TEST_DESCRIPTION_INST} t;
			Result.put (t, Test_description_keyword);
			create {SYSTEM_INST} t;
			Result.put (t, System_keyword);
			create {ACE_INST} t;
			Result.put (t, Ace_keyword);
			create {DEFINE_INST} t;
			Result.put (t, Define_keyword);
			create {UNDEFINE_INST} t;
			Result.put (t, Undefine_keyword);
			create {DEFINE_DIR_INST} t;
			Result.put (t, Define_directory_keyword);
			create {DEFINE_FILE_INST} t;
			Result.put (t, Define_file_keyword);
			create {SETENV_INST} t;
			Result.put (t, Setenv_keyword);
			Result.put (create {COPY_BIN_INST}, Copy_bin_keyword);
			create {COPY_RAW_INST} t;
			Result.put (t, Copy_raw_keyword);
			create {COPY_SUB_INST} t;
			Result.put (t, Copy_sub_keyword);
			create {DELETE_INST} t;
			Result.put (t, Delete_keyword);
			create {CPU_LIMIT_INST} t;
			Result.put (t, Cpu_limit_keyword);
			create {COMPILE_MELTED_INST} t;
			Result.put (t, Compile_melted_keyword);
			create {COMPILE_QUICK_MELTED_INST} t
			Result.put (t, Compile_quick_melted_keyword)
			create {COMPILE_FROZEN_INST} t;
			Result.put (t, Compile_frozen_keyword);
			create {COMPILE_FINAL_INST} t;
			Result.put (t, Compile_final_keyword);
			create {COMPILE_FINAL_KEEP_INST} t;
			Result.put (t, Compile_final_keep_keyword);
			create {COMPILE_PRECOMPILED_INST} t;
			Result.put (t, Compile_precompiled_keyword);
			create {RESUME_COMPILE_INST} t;
			Result.put (t, Resume_compile_keyword);
			create {CLEANUP_INST} t;
			Result.put (t, Cleanup_compile_keyword);
			create {ABORT_COMPILE_INST} t;
			Result.put (t, Abort_compile_keyword);
			create {EXIT_COMPILE_INST} t;
			Result.put (t, Exit_compile_keyword);
			create {COMPILE_RESULT_INST} t;
			Result.put (t, Compile_result_keyword);
			create {C_COMPILE_WORK_INST} t;
			Result.put (t, C_compile_work_keyword);
			create {C_COMPILE_FINAL_INST} t;
			Result.put (t, C_compile_final_keyword);
			create {C_COMPILE_RESULT_INST} t;
			Result.put (t, C_compile_result_keyword);
			create {EXECUTE_WORK_INST} t;
			Result.put (t, Execute_work_keyword);
			create {EXECUTE_FINAL_INST} t;
			Result.put (t, Execute_final_keyword);
			create {EXECUTE_RESULT_INST} t;
			Result.put (t, Execute_result_keyword);
			create {COMPARE_INST} t;
			Result.put (t, Compare_keyword);
			create {TEST_END_INST} t;
			Result.put (t, Test_end_keyword);
		end;

	test_suite_command_table: HASH_TABLE [TEST_INSTRUCTION, STRING] is
		local
			t: TEST_INSTRUCTION;
		once
			create Result.make (30);
			create {IF_INST} t;
			Result.put (t, If_keyword);
			create {UNKNOWN_INST} t;
			Result.put (t, Unknown_keyword);
			create {INCLUDE_INST} t;
			Result.put (t, Include_keyword);
			create {DEFINE_INST} t;
			Result.put (t, Define_keyword);
			create {UNDEFINE_INST} t;
			Result.put (t, Undefine_keyword);
			create {DEFINE_DIR_INST} t;
			Result.put (t, Define_directory_keyword);
			create {DEFINE_FILE_INST} t;
			Result.put (t, Define_file_keyword);
		end;

	test_catalog_command_table: HASH_TABLE [CATALOG_INSTRUCTION, STRING] is
		local
			t: CATALOG_INSTRUCTION;
		once
			create Result.make (30);
			create {UNKNOWN_CAT_INST} t;
			Result.put (t, Unknown_keyword);
			create {CATALOG_IF_INST} t;
			Result.put (t, If_keyword);
			create {SOURCE_PATH_INST} t;
			Result.put (t, Source_path_keyword);
			create {TEST_INST} t;
			Result.put (t, Test_keyword);
		end;

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"







end
