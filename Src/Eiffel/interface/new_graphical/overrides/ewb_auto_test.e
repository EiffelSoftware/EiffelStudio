indexing
	description: "Summary description for {EWB_AUTO_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_AUTO_TEST

inherit
	EWB_CMD
		redefine
			check_arguments_and_execute
		end

feature -- Properties

	name: STRING is
		do
			Result := "AutoTest"
		end

	help_message: STRING_GENERAL is
		do
			Result := "AutoTest"
		end

	abbreviation: CHARACTER is
		do
			Result := 'e'
		end

feature -- Execution

	execute is
			-- Action performed when invoked from the
			-- command line.
		local
			l_auto_test: AUTO_TEST
		do
			create l_auto_test.execute (system.eiffel_project, auto_test_arguments, create {EIFFEL_TEST_PROJECT_HELPER})
		end

	auto_test_arguments: DS_LIST [STRING]
			-- Arguments for AutoTest

	check_arguments_and_execute is
			-- Check the arguments and then perform then
			-- command line action.
		local
			i: INTEGER
			l_args: DS_LINKED_LIST [STRING]
		do
				-- Retrieve all arguments for AutoTest.
			create l_args.make
			from
				i := 2
			until
				i > command_line_io.command_arguments.count
			loop
				if command_line_io.command_arguments.item (i) /= Void then
					l_args.force_last (command_line_io.command_arguments.item (i))
				end
				i := i + 1
			end

			auto_test_arguments := l_args

			if not command_line_io.abort then
				if Workbench.is_already_compiled then
					execute
				else
					output_window.put_string (Warning_messages.w_Must_compile_first)
					output_window.put_new_line
				end
			else
				command_line_io.reset_abort
			end
		ensure then
			auto_test_arguments_attached: auto_test_arguments /= Void
		end

end
