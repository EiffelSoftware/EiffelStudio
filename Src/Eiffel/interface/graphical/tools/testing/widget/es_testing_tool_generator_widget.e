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
	ES_TESTING_TOOL_FACTORY_WIDGET
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
			if not has_error then
				create l_dir.make_from_string (factory.test_suite.eiffel_project.project_directory.testing_results_path)
				l_dir.extend ("auto_test")
				l_message := locale_formatter.formatted_translation (i_done_message, [l_dir])
				prompts.show_info_prompt (l_message, development_window.window, Void)
			end
		end

feature {NONE} -- Constants

	i_done_message: !STRING = "AutoTest is finished!%N%NResults can be found in%N$1"

end
