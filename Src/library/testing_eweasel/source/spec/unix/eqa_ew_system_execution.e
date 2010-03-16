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

	make (a_prog: STRING; a_args: ARRAYED_LIST [STRING]; a_execute_cmd, a_dir: STRING; a_inf, a_outf: detachable STRING; a_savef: STRING; a_test_set: EQA_EW_SYSTEM_TEST_SET)
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
			l_real_args: ARRAYED_LIST [STRING]
			l_processor: EQA_EW_EXECUTION_OUTPUT_PROCESSOR
			l_path: EQA_SYSTEM_PATH
		do
			a_test_set.environment.put (a_execute_cmd, "EQA_EXECUTABLE") -- How to get {EQA_SYSTEM_EXECUTION}.executable_env ?

			create l_real_args.make (a_args.count + 2)
			l_real_args.extend (a_dir)
			l_real_args.extend (a_prog)
			l_real_args.finish
			l_real_args.merge_right (a_args)

			create l_processor.make (a_test_set, a_savef)


			-- When {EQA_SYSTEM_EXECUTION}.launch, Testing library would open and write `set_output_path'
			-- FIXME: what is following `set_output_path' really used for...?
			if attached a_savef then
--				a_test_set.set_output_path (a_savef)
				create l_path.make (<<a_savef>>)
			else
--				a_test_set.set_output_path (a_test_set.execution_output_name)
				create l_path.make (<<a_test_set.execution_output_name>>)
			end
			a_test_set.prepare_system (l_path)
			a_test_set.set_output_processor (l_processor)

			a_test_set.run_system (l_real_args.to_array)

			l_processor.write_output_to_file
			a_test_set.set_execution_result (l_processor.execution_result)
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
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
