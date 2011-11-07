note
	description: "[
					The ApplicationMenu element must contain at least one MenuGroup child element that
					exposes a list of application-level commands. If multiple MenuGroup elements are declared,
					a divider line is drawn between the groups
																												]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_APPLICATION_MENU_GROUP

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list

			create_interface_objects
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		deferred
		end

feature -- Query

	buttons: ARRAYED_LIST [EV_RIBBON_ITEM]
			-- All groups in current tab

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
