note
	description: "Summary description for {ER_TOOL_BAR}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ER_TOOL_BAR

inherit
	ER_TOOL_BAR_IMP

	EV_ANY_HANDLER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create_interface_objects
		end

	create_interface_objects
			--
		do
			create tab_1.make_with_command_list (<<{ER_C_CONSTANTS}.Idc_cmd_tab1.as_natural_32>>)

			create tabs.make (1)
			tabs.extend (tab_1)
		end

feature -- Query

	tab_1: ER_TOOL_BAR_TAB
			--

	tabs: ARRAYED_LIST [ER_TOOL_BAR_TAB]
			-- All tabs in current tool bar

feature -- Command

	init_with_window (a_window: EV_WINDOW)
			-- Creation method
		local
			l_result: INTEGER
		do
			if attached {EV_WINDOW_IMP} a_window.implementation as l_imp then
				com_initialize
				l_result := create_ribbon_com_framework (l_imp.wel_item)
			end
		end
		
	destroy
			-- Clean up all ribbon related COM objects and resources
		do
			destroy_ribbon_com_framwork
			com_uninitialize
		end

end
