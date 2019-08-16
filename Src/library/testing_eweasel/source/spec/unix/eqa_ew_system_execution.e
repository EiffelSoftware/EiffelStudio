note
	description: "[
			Similar to `Compile_melted'
			Compile_final requests finalizing of the system with assertions discarded
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_SYSTEM_EXECUTION

create
	make

feature {NONE} -- Intialization

	make (a_prog: READABLE_STRING_32; a_args: ARRAYED_LIST [READABLE_STRING_32]; a_execute_cmd, a_dir: READABLE_STRING_32; a_inf: detachable READABLE_STRING_8; a_savef: READABLE_STRING_32; a_test_set: EQA_EW_SYSTEM_TEST_SET)
			-- Start a new process to execute `prog' with
			-- arguments `args' using execution command
			-- `execute_cmd' in directory `dir'.
			-- `inf' is the input file to be fed into the
			-- new process (void to set up pipe).
			-- `outf' is the file where new process is
			-- write its output (void to set up pipe).
			-- Write all output from the new process to
			-- file `savef'.
		require
			program_not_void: a_prog /= Void
			arguments_not_void: a_args /= Void
			directory_not_void: a_dir /= Void
			save_name_not_void: a_savef /= Void
		local
			l_execution: EQA_EXECUTION
			l_processor: EQA_EW_OUTPUT_PROCESSOR [EQA_EW_EXECUTION_RESULT]
		do
			create l_execution.make (a_test_set, a_execute_cmd)

			l_execution.add_argument (a_dir)
			l_execution.add_argument (a_prog)
			from
				a_args.start
			until
				a_args.after
			loop
				l_execution.add_argument (a_test_set.environment.substitute (a_args.item_for_iteration))
				a_args.forth
			end

			create l_processor.make
			l_execution.set_output_processor (l_processor)
			l_execution.set_output_path (<< a_savef >>)

			l_execution.launch
			l_execution.process_output_until_exit
			a_test_set.set_execution_result (l_processor.current_result)
		end

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
