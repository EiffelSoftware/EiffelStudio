note
	description: "Tables of Eiffel test instructions"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel testing";
	date: "$Date$"
	revision: "$Revision$"

class EW_INSTRUCTION_TABLES

inherit
	ANY
	EW_KEYWORD_CONST
		export
			{NONE} all
		end

feature

	test_command_table: HASH_TABLE [EW_TEST_INSTRUCTION, STRING]
		once
			create Result.make (30)
			Result.put (create {EW_IF_INST}, If_keyword)
			Result.put (create {EW_UNKNOWN_INST}, Unknown_keyword)
			Result.put (create {EW_INCLUDE_INST}, Include_keyword)
			Result.put (create {EW_TEST_NAME_INST}, Test_name_keyword)
			Result.put (create {EW_TEST_DESCRIPTION_INST}, Test_description_keyword)
			Result.put (create {EW_SYSTEM_INST}, System_keyword)
			Result.put (create {EW_ACE_INST}, Ace_keyword)
			Result.put (create {EW_CONFIG_INST}, config_keyword)
			Result.put (create {EW_DEFINE_INST}, Define_keyword)
			Result.put (create {EW_UNDEFINE_INST}, Undefine_keyword)
			Result.put (create {EW_DEFINE_DIR_INST}, Define_directory_keyword)
			Result.put (create {EW_DEFINE_FILE_INST}, Define_file_keyword)
			Result.put (create {EW_SETENV_INST}, Setenv_keyword)
			Result.put (create {EW_COPY_BIN_INST}, Copy_bin_keyword)
			Result.put (create {EW_COPY_FILE_INST}, copy_file_keyword)
			Result.put (create {EW_COPY_RAW_INST}, Copy_raw_keyword)
			Result.put (create {EW_COPY_SUB_INST}, Copy_sub_keyword)
			Result.put (create {EW_DELETE_INST}, Delete_keyword)
			Result.put (create {EW_CPU_LIMIT_INST}, Cpu_limit_keyword)
			Result.put (create {EW_COMPILE_MELTED_INST}, Compile_melted_keyword)
			Result.put (create {EW_COMPILE_QUICK_MELTED_INST}, Compile_quick_melted_keyword)
			Result.put (create {EW_COMPILE_FROZEN_INST}, Compile_frozen_keyword)
			Result.put (create {EW_COMPILE_FINAL_INST}, Compile_final_keyword)
			Result.put (create {EW_COMPILE_FINAL_KEEP_INST}, Compile_final_keep_keyword)
			Result.put (create {EW_COMPILE_PRECOMPILED_INST}, Compile_precompiled_keyword)
			Result.put (create {EW_RESUME_COMPILE_INST}, Resume_compile_keyword)
			Result.put (create {EW_CLEANUP_INST}, Cleanup_compile_keyword)
			Result.put (create {EW_ABORT_COMPILE_INST}, Abort_compile_keyword)
			Result.put (create {EW_EXIT_COMPILE_INST}, Exit_compile_keyword)
			Result.put (create {EW_COMPILE_RESULT_INST}, Compile_result_keyword)
			Result.put (create {EW_C_COMPILE_WORK_INST}, C_compile_work_keyword)
			Result.put (create {EW_C_COMPILE_FINAL_INST}, C_compile_final_keyword)
			Result.put (create {EW_C_COMPILE_RESULT_INST}, C_compile_result_keyword)
			Result.put (create {EW_EXECUTE_WORK_INST}, Execute_work_keyword)
			Result.put (create {EW_EXECUTE_FINAL_INST}, Execute_final_keyword)
			Result.put (create {EW_EXECUTE_RESULT_INST}, Execute_result_keyword)
			Result.put (create {EW_COMPARE_INST}, Compare_keyword)
			Result.put (create {EW_PRETTIFY_INST}, Prettify_keyword)
			Result.put (create {EW_TEST_END_INST}, Test_end_keyword)
		end

	test_suite_command_table: HASH_TABLE [EW_TEST_INSTRUCTION, STRING]
		once
			create Result.make (30)
			Result.put (create {EW_IF_INST}, If_keyword)
			Result.put (create {EW_UNKNOWN_INST}, Unknown_keyword)
			Result.put (create {EW_INCLUDE_INST}, Include_keyword)
			Result.put (create {EW_DEFINE_INST}, Define_keyword)
			Result.put (create {EW_UNDEFINE_INST}, Undefine_keyword)
			Result.put (create {EW_DEFINE_DIR_INST}, Define_directory_keyword)
			Result.put (create {EW_DEFINE_FILE_INST}, Define_file_keyword)
		end

	test_catalog_command_table: HASH_TABLE [EW_CATALOG_INSTRUCTION, STRING]
		once
			create Result.make (30)
			Result.put (create {EW_UNKNOWN_CAT_INST}, Unknown_keyword)
			Result.put (create {EW_CATALOG_IF_INST}, If_keyword)
			Result.put (create {EW_SOURCE_PATH_INST}, Source_path_keyword)
			Result.put (create {EW_TEST_INST}, Test_keyword)
			Result.put (create {EW_EQA_TEST_INST}, Test_63_keyword)
		end

note
	copyright: "[
			Copyright (c) 1984-2011, University of Southern California and contributors.
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
