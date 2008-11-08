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
			on_processor_changed
		end

create
	make

feature {NONE} -- Initialization

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		do
			create status_label
			status_label.align_text_right
			a_widget.extend (status_label)
			a_widget.disable_item_expand (status_label)
			Precursor (a_widget)
		end

feature -- Access

	factory: !TEST_GENERATOR_I
			-- <Precursor>

feature {NONE} -- Access

	status_label: !EV_LABEL
			-- Label showing status of generator

feature {NONE} -- Events

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

end
