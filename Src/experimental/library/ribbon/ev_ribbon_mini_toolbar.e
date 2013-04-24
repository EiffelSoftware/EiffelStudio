note
	description: "[
					The MiniToolbar exposes a floating toolbar of various Commands, galleries, 
					and complex controls such as the Font Control and the Combo Box.
																										]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_MINI_TOOLBAR

inherit
	EV_COMMAND_HANDLER_OBSERVER

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list

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

feature -- Command

	show (a_point: EV_COORDINATE)
			-- Show current on screen
		require
			not_void: a_point /= Void
		local
			l_command_id: NATURAL
		do
			if attached ribbon as l_ribbon then
				check valid: command_list.count >= 1 end
				l_command_id := command_list.item (1)
				l_ribbon.show_contextual_ui (a_point, l_command_id)
			end
		end

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
