indexing
	description: "[
		Widget showing status and control buttons for an {EIFFEL_TEST_FACTORY_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_FACTORY_WIDGET

inherit
	ES_TESTING_TOOL_PROCESSOR_WIDGET
		rename
			processor as factory
		redefine
			build_notebook_widget_interface,
			on_processor_finished
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		local
			l_label: EV_LABEL
		do
			create l_label.make_with_text ("Created tests")
			l_label.align_text_left
			a_widget.extend (l_label)
			a_widget.disable_item_expand (l_label)

			Precursor (a_widget)
		end

feature {NONE} -- Access

	title: !STRING_32
		do
			if generator_factory_type.attempt (factory) /= Void then
				Result := locale_formatter.translation (t_generator_title)
			elseif extractor_factory_type.attempt (factory) /= Void then
				Result := locale_formatter.translation (t_extractor_title)
			else
				Result := locale_formatter.translation (t_creator_title)
			end
		end

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.overlay_new_icon_buffer
		end

	icon_pixmap: !EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.overlay_new_icon
		end

feature {NONE} -- Events

	on_processor_finished
			-- <Precursor>
		local
			l_dir: DIRECTORY_NAME
			l_message: !STRING_32
		do
			if generator_factory_type.attempt (factory) /= Void then
				create l_dir.make_from_string (factory.test_suite.eiffel_project.project_directory.testing_results_path)
				l_dir.extend ("auto_test")
				l_message := locale_formatter.formatted_translation (i_done_message, [l_dir])
				prompts.show_info_prompt (l_message, development_window.window, Void)
			end
		end

feature {NONE} -- Constants

	t_generator_title: !STRING = "Generation"
	t_extractor_title: !STRING = "Extraction"
	t_creator_title: !STRING = "New manual tests"

	i_done_message: !STRING = "AutoTest is finished!%N%NResults can be found in%N$1"

end
