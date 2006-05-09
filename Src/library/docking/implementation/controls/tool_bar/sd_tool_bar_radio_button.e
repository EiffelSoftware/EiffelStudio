indexing
	description: "[
						Toggle button for use with SD_TOOL_BAR.
						`is_selected' is mutualy exclusive with respect to other tool bar
						radio buttons in a tool bar.
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_RADIO_BUTTON

inherit
	SD_TOOL_BAR_TOGGLE_BUTTON
		redefine
			enable_select,
			on_pointer_release
		end

create
	make
	
feature -- Command

	enable_select is
			-- Enable select.

		do
			Precursor {SD_TOOL_BAR_TOGGLE_BUTTON}
			set_other_radio_button (False)
		end

feature {NONE} -- Implementation

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer release actions
		do
			Precursor {SD_TOOL_BAR_TOGGLE_BUTTON} (a_relative_x, a_relative_y)
			if state = {SD_TOOL_BAR_ITEM_STATE}.checked or state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				set_other_radio_button (False)
			end
		end

	set_other_radio_button (a_select: BOOLEAN) is
			-- Set all other radio buttons in `tool_bar' states.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_RADIO_BUTTON
		do
			if tool_bar /= Void then
				l_items := tool_bar.items
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

end
