indexing
	description: "Maintains the pick and drop mechanism %
				%and terminates it when the data is dropped."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_TRANSPORTER_IMP

inherit
	EV_PND_TRANSPORTER_I

feature {NONE} -- Implementation

	pointed_target: EV_PND_TARGET_I is
			-- Hole at mouse position
		local
			wel_point: WEL_POINT
			toolbar: EV_TOOL_BAR_IMP
			tbutton: EV_TOOL_BAR_BUTTON_IMP
			mc_list: EV_MULTI_COLUMN_LIST_IMP
			tree: EV_TREE_IMP
			tg: EV_PND_TARGET_I
			widget_pointed: EV_WIDGET_IMP
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			widget_pointed ?= wel_point.window_at
			if widget_pointed /= Void then
				toolbar ?= widget_pointed
				if toolbar /= Void then
					wel_point.screen_to_client (toolbar)
					tbutton := toolbar.find_item_at_position (wel_point.x, wel_point.y)
					if tbutton /= Void and then not tbutton.is_insensitive then
						tg := tbutton
					end
				else
					mc_list ?= widget_pointed
					if mc_list /= Void then
						wel_point.screen_to_client (mc_list)
						tg := mc_list.find_item_at_position (wel_point.x, wel_point.y)
					else
						tree ?= widget_pointed
						if tree /= Void then
							wel_point.screen_to_client (tree)
							tg := tree.find_item_at_position (wel_point.x, wel_point.y)
						end
					end
				end
				if tg = Void then
					tg := widget_pointed
				end
				targets.start
				targets.search (tg)
				if not targets.exhausted then
					Result := targets.item
				end
			end
		end

end -- class EV_PND_TRANSPORTER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

