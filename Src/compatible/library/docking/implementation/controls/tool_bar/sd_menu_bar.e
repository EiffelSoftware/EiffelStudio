note
	description: "Menu bar for Smart Docking libarry"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_BAR

inherit
	SD_TOOL_BAR
		redefine
			make,
			item_type,
			internal_items,
			on_pointer_press,
			on_pointer_release
		end

create
	make

feature {NONE} -- Initlization

	make
			-- <Precursor>
		do
			Precursor {SD_TOOL_BAR}
		end

feature -- Acces

	item_type: SD_TOOL_BAR_MENU_ITEM
			-- <Precursor>
		do
		end

feature {NONE} -- Agents

	on_pointer_press (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
			-- <Precursor>
		do
			enable_capture
			from
				internal_items.start
			until
				internal_items.after
			loop
				if internal_items.item.has_position (a_x, a_y) then
					if internal_items.item.menu /= Void then
						internal_items.item.menu.show_at (Current, a_x, height)
					end
				end
				internal_items.forth
			end
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
			-- <Precursor>
		do
			disable_capture
		end

feature {NONE} -- Implementations

	internal_items: ARRAYED_SET [SD_TOOL_BAR_MENU_ITEM];
			-- <Precursor>

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
