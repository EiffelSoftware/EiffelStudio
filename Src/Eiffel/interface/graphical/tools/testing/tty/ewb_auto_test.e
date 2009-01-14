note
	description: "[
		TTY menu for launching AutoTest.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_AUTO_TEST

inherit
	EWB_TEST_CMD
		redefine
			check_arguments_and_execute,
			on_processor_proceeded
		end

create
	default_create,
	make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_arguments: LINKED_LIST [STRING])
			-- Initialize `auto_test_arguments' with `a_arguments'.
		require
			a_arguments_attached: a_arguments /= Void
		do
			create {DS_LINKED_LIST [STRING]} auto_test_arguments.make
			a_arguments.do_all (agent auto_test_arguments.force_last)
		ensure
			auto_test_arguments_set: auto_test_arguments /= Void and then auto_test_arguments.count = a_arguments.count
		end

feature -- Properties

	name: STRING
		do
			Result := "AutoTest"
		end

	help_message: STRING_GENERAL
		do
			Result := "AutoTest"
		end

	abbreviation: CHARACTER
		do
			Result := 'a'
		end

feature -- Execution

	execute_with_test_suite (a_test_suite: !TEST_SUITE_S)
			-- Action performed when invoked from the
			-- command line.
		local
			l_ap: AUTO_TEST_COMMAND_LINE_PARSER
			l_args: like auto_test_arguments
			l_error_handler: AUT_ERROR_HANDLER

				-- Using wizard information to create AutoTest configuration
			l_conf: ES_TEST_WIZARD_INFORMATION
			l_type: STRING
			l_root_group: CONF_GROUP
			l_project: E_PROJECT
		do
			l_args := auto_test_arguments
			if l_args /= Void then
				l_project := a_test_suite.eiffel_project
				create l_ap
				create l_error_handler.make (l_project.system.system)
				l_ap.set_error_handler (l_error_handler)
				l_ap.process_arguments (l_args)
				create l_conf.make
				l_conf.set_generated_test_class

					-- Types
				from
					l_ap.class_names.start
				until
					l_ap.class_names.after
				loop
					l_type := l_ap.class_names.item_for_iteration
					if l_type /= Void then
						l_conf.types.force (l_type)
					end
					l_ap.class_names.forth
				end

					-- Timing
				if l_ap.time_out /= Void then
					l_conf.set_time_out (l_ap.time_out.second_count.to_natural_32)
				end
				if l_ap.proxy_time_out > 0 then
					l_conf.set_proxy_time_out (l_ap.proxy_time_out.to_natural_32)
				end

					-- Minimization
				l_conf.set_slicing_enabled (l_ap.is_slicing_enabled)
				l_conf.set_ddmin_enabled (l_ap.is_ddmin_enabled)

					-- Output
				l_conf.set_html_output (l_ap.is_html_statistics_format_enabled)
				l_root_group := l_project.system.system.root_creators.first.cluster

				if l_root_group.is_cluster then
					if {l_cluster: CONF_CLUSTER} l_root_group then
						l_conf.set_cluster (l_cluster)
						l_conf.set_path ("")
					end
				end
				l_conf.set_new_class_name("NEW_AUTO_TEST")
				launch_ewb_processor (a_test_suite, generator_factory_type, l_conf)
			else

			end


		--	create l_auto_test.execute (system.eiffel_project, auto_test_arguments, create {TEST_PROJECT_HELPER})
		end

	auto_test_arguments: ?DS_LIST [STRING]
			-- Arguments for AutoTest

	check_arguments_and_execute
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
			auto_test_arguments := Void
		ensure then
			auto_test_arguments_attached: auto_test_arguments /= Void
		end

feature {NONE} -- Events

	on_processor_proceeded (a_test_suite: !TEST_SUITE_S; a_processor: !TEST_PROCESSOR_I)
			-- <Precursor>
		local
			l_generator: ?TEST_GENERATOR_I
		do
			l_generator := generator_factory_type.attempt (a_processor)
			if l_generator /= Void then

				if l_generator.is_running then
					if l_generator.is_compiling then
						print_string ("Compiling%N")
					elseif l_generator.is_executing then
						print_string ("Executing random tests%N")
					elseif l_generator.is_replaying_log then
						print_string ("Replaying log%N")
					elseif l_generator.is_minimizing_witnesses then
						print_string ("Minimizing witnesses%N")
					elseif l_generator.is_generating_statistics then
						print_string ("Generating statistics%N")
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
