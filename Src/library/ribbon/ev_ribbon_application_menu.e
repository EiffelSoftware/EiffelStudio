note
	description: "[
					The Application Menu is the main menu for an application that implements the Windows Ribbon framework.
																															]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_APPLICATION_MENU

inherit
	EV_COMMAND_HANDLER_OBSERVER

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list
			create recent_items.make_with_command_list (a_list) -- Recent items use the commnand id of ApplicationMenu

			create_interface_objects
			register_observer
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		deferred
		end

feature -- Query

	groups: ARRAYED_LIST [EV_RIBBON_APPLICATION_MENU_GROUP]
			-- All groups in current tab

	recent_items: EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS
			-- Recent items list in right pane

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
