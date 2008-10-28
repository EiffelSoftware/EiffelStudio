indexing
	description: "Tables of Eiffel test instructions"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel testing";
	date: "93/08/30"

class EW_INSTRUCTION_TABLES
inherit
	ANY
	EW_KEYWORD_CONST
		export
			{NONE} all
		end

feature

	test_command_table: HASH_TABLE [EW_TEST_INSTRUCTION, STRING] is
		local
			t: EW_TEST_INSTRUCTION;
		once
			create Result.make (30);
			create {EW_IF_INST} t;
			Result.put (t, If_keyword);
			create {EW_UNKNOWN_INST} t;
			Result.put (t, Unknown_keyword);
			create {EW_INCLUDE_INST} t;
			Result.put (t, Include_keyword);
			create {EW_TEST_NAME_INST} t;
			Result.put (t, Test_name_keyword);
			create {EW_TEST_DESCRIPTION_INST} t;
			Result.put (t, Test_description_keyword);
			create {EW_SYSTEM_INST} t;
			Result.put (t, System_keyword);
			create {EW_ACE_INST} t;
			Result.put (t, Ace_keyword);
			create {EW_DEFINE_INST} t;
			Result.put (t, Define_keyword);
			create {EW_UNDEFINE_INST} t;
			Result.put (t, Undefine_keyword);
			create {EW_DEFINE_DIR_INST} t;
			Result.put (t, Define_directory_keyword);
			create {EW_DEFINE_FILE_INST} t;
			Result.put (t, Define_file_keyword);
			create {EW_SETENV_INST} t;
			Result.put (t, Setenv_keyword);
			Result.put (create {EW_COPY_BIN_INST}, Copy_bin_keyword);
			create {EW_COPY_RAW_INST} t;
			Result.put (t, Copy_raw_keyword);
			create {EW_COPY_SUB_INST} t;
			Result.put (t, Copy_sub_keyword);
			create {EW_DELETE_INST} t;
			Result.put (t, Delete_keyword);
			create {EW_CPU_LIMIT_INST} t;
			Result.put (t, Cpu_limit_keyword);
			create {EW_COMPILE_MELTED_INST} t;
			Result.put (t, Compile_melted_keyword);
			create {EW_COMPILE_QUICK_MELTED_INST} t
			Result.put (t, Compile_quick_melted_keyword)
			create {EW_COMPILE_FROZEN_INST} t;
			Result.put (t, Compile_frozen_keyword);
			create {EW_COMPILE_FINAL_INST} t;
			Result.put (t, Compile_final_keyword);
			create {EW_COMPILE_FINAL_KEEP_INST} t;
			Result.put (t, Compile_final_keep_keyword);
			create {EW_COMPILE_PRECOMPILED_INST} t;
			Result.put (t, Compile_precompiled_keyword);
			create {EW_RESUME_COMPILE_INST} t;
			Result.put (t, Resume_compile_keyword);
			create {EW_CLEANUP_INST} t;
			Result.put (t, Cleanup_compile_keyword);
			create {EW_ABORT_COMPILE_INST} t;
			Result.put (t, Abort_compile_keyword);
			create {EW_EXIT_COMPILE_INST} t;
			Result.put (t, Exit_compile_keyword);
			create {EW_COMPILE_RESULT_INST} t;
			Result.put (t, Compile_result_keyword);
			create {EW_C_COMPILE_WORK_INST} t;
			Result.put (t, C_compile_work_keyword);
			create {EW_C_COMPILE_FINAL_INST} t;
			Result.put (t, C_compile_final_keyword);
			create {EW_C_COMPILE_RESULT_INST} t;
			Result.put (t, C_compile_result_keyword);
			create {EW_EXECUTE_WORK_INST} t;
			Result.put (t, Execute_work_keyword);
			create {EW_EXECUTE_FINAL_INST} t;
			Result.put (t, Execute_final_keyword);
			create {EW_EXECUTE_RESULT_INST} t;
			Result.put (t, Execute_result_keyword);
			create {EW_COMPARE_INST} t;
			Result.put (t, Compare_keyword);
			create {EW_TEST_END_INST} t;
			Result.put (t, Test_end_keyword);
		end;

	test_suite_command_table: HASH_TABLE [EW_TEST_INSTRUCTION, STRING] is
		local
			t: EW_TEST_INSTRUCTION;
		once
			create Result.make (30);
			create {EW_IF_INST} t;
			Result.put (t, If_keyword);
			create {EW_UNKNOWN_INST} t;
			Result.put (t, Unknown_keyword);
			create {EW_INCLUDE_INST} t;
			Result.put (t, Include_keyword);
			create {EW_DEFINE_INST} t;
			Result.put (t, Define_keyword);
			create {EW_UNDEFINE_INST} t;
			Result.put (t, Undefine_keyword);
			create {EW_DEFINE_DIR_INST} t;
			Result.put (t, Define_directory_keyword);
			create {EW_DEFINE_FILE_INST} t;
			Result.put (t, Define_file_keyword);
		end;

	test_catalog_command_table: HASH_TABLE [EW_CATALOG_INSTRUCTION, STRING] is
		local
			t: EW_CATALOG_INSTRUCTION;
		once
			create Result.make (30);
			create {EW_UNKNOWN_CAT_INST} t;
			Result.put (t, Unknown_keyword);
			create {EW_CATALOG_IF_INST} t;
			Result.put (t, If_keyword);
			create {EW_SOURCE_PATH_INST} t;
			Result.put (t, Source_path_keyword);
			create {EW_TEST_INST} t;
			Result.put (t, Test_keyword);

			create {EW_EQA_TEST_INST} t;
			Result.put (t, Test_63_keyword);
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
