indexing
	description: "[
		Graphical panel for EiffelStudio's testing tool.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_PANEL_63

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]

	SHARED_SERVICE_PROVIDER

create {ES_TESTING_TOOL_63}
	make

feature {NONE} -- Initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX) is
			-- <Precursor>
		do
			service ?= service_provider.service ({EIFFEL_TEST_SUITE_S})
			create tree_view.make (service, "", create {ES_EIFFEL_TEST_GRID_LAYOUT}.make (service.project))
			a_widget.extend (tree_view)
		end

feature -- Access

	service: !EIFFEL_TEST_SUITE_S
			-- Service used to retrieve, run and create tests.

	tree_view: ES_TBT_GRID [EIFFEL_TEST_I]

feature -- Factory

	create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			--create Result.make (0)
		end

end
