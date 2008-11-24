indexing
	description: "[
		Widgets showing differents states and controls for {TEST_GENERATOR_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_GENERATOR_WIDGET

inherit
	ES_TESTING_TOOL_CREATOR_WIDGET
		redefine
			build_notebook_widget_interface,
			factory,
			on_processor_launched,
			on_processor_changed,
			on_processor_error,
			on_processor_finished
		end

create
	make

feature {NONE} -- Initialization

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		do
			Precursor (a_widget)

			create status_label
			status_label.align_text_right

			progress_widget.extend (status_label)
			progress_widget.disable_item_expand (status_label)
		end

feature -- Access

	factory: !TEST_GENERATOR_I
			-- <Precursor>

feature {NONE} -- Access

	status_label: !EV_LABEL
			-- Label showing status of generator

	busy_dialog: ?ES_POPUP_TRANSITION_WINDOW
			-- Dialog telling use to be patient

feature {NONE} -- Status report

	has_error: BOOLEAN

feature {NONE} -- Events

	on_processor_launched
			-- <Precursor>
		do
			has_error := False
		end

	on_processor_changed
			-- <Precursor>
		do
			if factory.is_running then
				if factory.is_compiling then
					status_label.set_text ("Compiling")
				elseif factory.is_executing then
					status_label.set_text ("Executing random tests")
				elseif factory.is_replaying_log then
					status_label.set_text ("Replaying log")
				elseif factory.is_minimizing_witnesses then
					status_label.set_text ("Minimizing witnesses")
				elseif factory.is_generating_statistics then
					status_label.set_text ("Generating statistics")
					if busy_dialog = Void then
						create busy_dialog.make (locale_formatter.translation (i_please_be_patient))
						busy_dialog.show_relative_to_window (development_window.window)
					end
				else
					status_label.set_text ("hmmmmm...")
				end
			else
				status_label.set_text ("")
			end
		end

	on_processor_error (a_error: !STRING_8; a_tokens: !TUPLE)
			-- <Precursor>
		do
			has_error := True
		end

	on_processor_finished
			-- <Precursor>
		local
			l_dir: DIRECTORY_NAME
			l_message: !STRING_32
		do
			if busy_dialog /= Void then
				busy_dialog.hide
				busy_dialog := Void
			end
			if not has_error then
				create l_dir.make_from_string (factory.test_suite.eiffel_project.project_directory.testing_results_path)
				l_dir.extend ("auto_test")
				l_message := locale_formatter.formatted_translation (i_done_message, [l_dir])
				prompts.show_info_prompt (l_message, development_window.window, Void)
			end
		end

feature {NONE} -- Internationalization

	i_done_message: !STRING = "AutoTest is finished!%N%NResults can be found in: $1"
	i_please_be_patient: !STRING = "Please be patient while AutoTest generates results.%N(The window might become unresponsive during that time)"

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
