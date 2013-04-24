note
	description: "[
					A C compilation
																	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "93/08/30"
	revision: "$Revision$"

class EQA_EW_C_COMPILATION

create
	make

feature {NONE} -- Initialization

	make (a_dir: READABLE_STRING_GENERAL; a_save: STRING; a_freeze_cmd: READABLE_STRING_GENERAL; a_max_procs: INTEGER; a_test_set: EQA_EW_SYSTEM_TEST_SET)
			-- Start a new process to do any necessary
			-- C compilations (freezing) in directory `a_dir',
			-- using at most `a_max_procs' simultaneous processes
			-- to do C compilations.
			-- Write all output from the new process to
			-- file `a_save'.
		require
			directory_not_void: a_dir /= Void
			save_name_not_void: a_save /= Void
			not_void: attached a_test_set
		local
			l_execution: EQA_EXECUTION
			l_processor: EQA_EW_OUTPUT_PROCESSOR [EQA_EW_C_COMPILATION_RESULT]
		do
			create l_execution.make (a_test_set, a_freeze_cmd)
			l_execution.add_argument (a_dir)
			if a_max_procs > 0 then
				l_execution.add_argument ("-nproc")
				l_execution.add_argument (a_max_procs.out)
			end

			create l_processor.make
			l_execution.set_output_processor (l_processor)
			l_execution.set_output_path (<< a_test_set.c_compile_output_name >>)
			l_execution.launch
			l_execution.process_output_until_exit
			a_test_set.set_c_compilation_result (l_processor.current_result)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
