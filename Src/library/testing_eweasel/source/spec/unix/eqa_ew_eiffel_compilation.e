note
	description: "[
						An Eiffel compilation
						
						For old version, please check {EW_EIFFEL_COMPILATION}
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_EIFFEL_COMPILATION

create
	make_and_launch

feature {NONE} -- Creation method

	make_and_launch (a_args: LIST [STRING_32]; an_output_file_name: STRING; a_test_set: EQA_EW_SYSTEM_TEST_SET)
			-- Start a new Eiffel compilation process to
			-- run command system with arguments `a_args'.
			-- Write all output from the new process to
			-- file `an_output_file_name'.
		require
			arguments_not_void: a_args /= Void
			an_output_file_name_attached: an_output_file_name /= Void
			an_output_file_name_not_empty: not an_output_file_name.is_empty
			a_test_set_attached: a_test_set /= Void
		do
			create output_processor.make
			create execution.make (a_test_set)
			execution.set_output_path (<< an_output_file_name >>)
			execution.set_output_processor (output_processor)

			from
				a_args.start
			until
				a_args.after
			loop
				execution.add_argument (a_args.item_for_iteration)
				a_args.forth
			end

			execution.launch
			run
		end

feature -- Access

	last_result: EQA_EW_EIFFEL_COMPILATION_RESULT
			-- Last compilation result
		do
			Result := output_processor.current_result
		end

feature {NONE} -- Access

	execution: EQA_SYSTEM_EXECUTION
			-- Execution for launching compiler executable

	output_processor: EQA_EW_OUTPUT_PROCESSOR [EQA_EW_EIFFEL_COMPILATION_RESULT]
			-- Output processor handling output of `execution'

feature -- Query

	suspended: BOOLEAN
			-- Is process suspended awaiting user input?
		do
			Result := output_processor.current_result.compilation_paused
		ensure
			result_implies_launched: Result implies execution.is_launched
		end

feature -- Basic operations

	resume
			-- Resume currently suspended compilation
		require
			suspended: suspended
		do
			output_processor.reset_result
			execution.put_string ("%N")
			run
		end

	abort
			-- Abort currently suspended compilation
		require
			suspended: suspended
		local
			l_precompile: BOOLEAN
		do
			l_precompile := last_result.missing_precompile
			output_processor.reset_result
			if l_precompile then
				execution.put_string ("n%N")
			end
			execution.put_string ("q%N")
			execution.process_output_until_exit
		end

feature {NONE} -- Implementation

	run
			-- Process compilation output until execution is finished or suspended.
		require
			launched: execution.is_launched
		do
			from until
				execution.has_exited or suspended
			loop
				execution.process_output
			end
		ensure
			exited_or_suspended: execution.has_exited or suspended
		end

invariant
	output_processor_attached_to_execution: execution.output_processor = output_processor

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
