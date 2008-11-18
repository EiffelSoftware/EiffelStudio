indexing
	description: "[
		Objects representing notebook widgets displayed in testing tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TESTING_TOOL_NOTEBOOK_WIDGET

inherit
	ES_NOTEBOOK_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_notebook_widget
		end

	ES_SHARED_TEST_SERVICE
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_window: like development_window)
			-- Initialize `Current'.
		require
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			development_window := a_window
			make_notebook_widget
		end

feature {NONE} -- Access

	development_window: !EB_DEVELOPMENT_WINDOW
			-- Window in which `Current' is shown

feature {NONE} -- Helpers

	icon_provider: !ES_TOOL_ICONS_PROVIDER [ES_TESTING_TOOL_63_ICONS, ES_TESTING_TOOL_63]
			-- Access to the icons provided by the testing tool.
		once
			create Result.make (development_window)
		end

feature {NONE} -- Factory

	create_notebook_widget: !EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
			Result.set_data (Current)
		ensure then
			data_set: Result.data = Current
		end

end
