note
	description: "[
						Toggle button for use with SD_TOOL_BAR.
						`is_selected' is mutualy exclusive with respect to other tool bar
						radio buttons in a tool bar.
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_RADIO_BUTTON

inherit
	SD_TOOL_BAR_TOGGLE_BUTTON
		redefine
			enable_select,
			on_pointer_press,
			on_pointer_release
		end

create
	make

feature -- Command

	enable_select
			-- Enable select.

		do
			Precursor {SD_TOOL_BAR_TOGGLE_BUTTON}
			set_other_radio_button (False)
		end

feature {NONE} -- Implementation

	on_pointer_press (a_relative_x, a_relative_y: INTEGER_32)
			-- Handle pointer press actions
		do
			if not is_selected then
				Precursor {SD_TOOL_BAR_TOGGLE_BUTTON}(a_relative_x, a_relative_y)
			end
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER)
			-- Handle pointer release actions
		do
			if not is_selected then
				Precursor {SD_TOOL_BAR_TOGGLE_BUTTON} (a_relative_x, a_relative_y)
				if is_selected then
					set_other_radio_button (False)
				end
			end
		end

	set_other_radio_button (a_select: BOOLEAN)
			-- Set all other radio buttons in `tool_bar' states.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_RADIO_BUTTON
		do
			if tool_bar /= Void then
				l_items := tool_bar.all_items
				from
					l_items.start
				until
					l_items.after
				loop
					l_item ?= l_items.item
					if l_item /= Void and then l_item /= Current then
						if a_select then
							l_item.enable_select
						else
							l_item.disable_select
						end

					end
					l_items.forth
				end
			end
		end

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
