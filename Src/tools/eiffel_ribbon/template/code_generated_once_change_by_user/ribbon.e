note
	description: "Summary description for {ER_TOOL_BAR}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	RIBBON

inherit
	RIBBON_IMP

	EV_ANY_HANDLER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create_interface_objects
		end

	create_interface_objects
			--
		do
$TAB_CREATION
			create tabs.make (1)
$TAB_REGISTRY
		end

feature -- Query
$TAB_DECLARATION

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
