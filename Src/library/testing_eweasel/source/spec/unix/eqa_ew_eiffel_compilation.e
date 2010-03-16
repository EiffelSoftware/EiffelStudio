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
	make

feature {NONE} -- Creation method

	make (a_cmd: STRING; a_args: LIST [STRING]; a_save: STRING; a_test_set: EQA_EW_SYSTEM_TEST_SET)
			-- Start a new Eiffel compilation process to
			-- run command `a_cmd' with arguments `a_args'.
			-- Write all output from the new process to
			-- file `a_save'.
		require
			command_not_void: a_cmd /= Void
			arguments_not_void: a_args /= Void
			save_name_not_void: a_save /= Void
			not_void: attached a_test_set
		local
			l_args: ARRAY [STRING]
			l_processor: EQA_EW_COMPILATION_OUTPUT_PROCESSOR
		do
			a_test_set.environment.put (a_cmd, "EQA_EXECUTABLE") -- How to get {EQA_SYSTEM_EXECUTION}.executable_env ?

			from
				create l_args.make (0, a_args.count - 1)
				a_args.start
			until
				a_args.after
			loop
				l_args.put (a_args.item, a_args.index - 1)

				a_args.forth
			end

			savefile_name := a_save

			create l_processor.make (a_test_set)
			a_test_set.set_output_processor (l_processor)
			a_test_set.set_output_path (a_save)

			a_test_set.run_system (l_args)

			l_processor.write_output_to_file
			a_test_set.set_e_compilation_result (l_processor.compilation_result)
		end

feature -- Query

	suspended: BOOLEAN
			-- Is process suspended awaiting user input?

	savefile_name: STRING
			-- Name of file to which output read from process
			-- is written, if not Void

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
