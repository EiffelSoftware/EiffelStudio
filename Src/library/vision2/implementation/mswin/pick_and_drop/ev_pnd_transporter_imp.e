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

	drop_command (args: EV_ARGUMENT2 [EV_PND_SOURCE_I, EV_INTERNAL_COMMAND]; ev_data: EV_PND_EVENT_DATA) is
			-- Drop the data in a target.
		local
			target: EV_PND_TARGET_I
			widget: EV_WIDGET
			data_imp : EV_BUTTON_EVENT_DATA_IMP
			current_widget: EV_WIDGET
			w: EV_UNTITLED_WINDOW_IMP
			sx, sy: INTEGER
			widget_imp: EV_UNTITLED_WINDOW
			tool_bar_button: EV_TOOL_BAR_BUTTON
			tool_bar_button_imp: EV_TOOL_BAR_BUTTON_IMP
			tool_bar_imp: EV_TOOL_BAR_IMP
			multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW
			tree_item: EV_TREE_ITEM
			tree_imp: EV_TREE_IMP
			offsets: TUPLE [INTEGER, INTEGER]
		do
			target := pointed_target
			cancel_command (args, ev_data)
			if target /= Void then
				widget ?= target.interface

				tool_bar_button ?= target.interface
				if tool_bar_button /= Void then
						-- If the target is a tool bar button then calculate relative coordinates
						-- to its parent.
					offsets := offset_for_tool_bar_button (tool_bar_button)
					sx := offsets.integer_arrayed @ 1
					sy := offsets.integer_arrayed @ 2
					sy := ev_data.implementation.absolute_y - sy
					widget := tool_bar_button.parent
				end

				multi_column_list_row ?= target.interface
				if multi_column_list_row /= Void then
						-- If the target is a multi column list row then calculate relative coordinates
						-- to its parent.
					offsets := offset_for_multi_column_list_row (multi_column_list_row)
					sx := offsets.integer_arrayed @ 1
					sy := offsets.integer_arrayed @ 2
					widget := multi_column_list_row.parent	
				end
		

				tree_item ?= target.interface
				if tree_item /= Void then
						-- If the target is a tree item then calculate relative coordinates
						-- to its parent.
					offsets := offset_for_tree_item (tree_item)
					sx := offsets.integer_arrayed @ 1
					sy := offsets.integer_arrayed @ 2
					from
					until
						widget /= Void
					loop
						widget ?= tree_item.parent
						if widget = Void then 
							tree_item ?= tree_item.parent
						end
					end
					tree_imp ?= widget.implementation
					sy := (ev_data.implementation.absolute_y - tree_imp.absolute_y)
					end


					-- We only know relative x and y coordinates of widgets, so to find
					-- absolute coordinates, repeatedly add relative coordinates.
				from
					current_widget := widget
				until
					widget_imp /= Void
				loop
					sx := sx + current_widget.x
					if tool_bar_button = Void then
						-- For a tool bar, sy is not relative to the parent, i.e. absolute.
						-- For all others, sy is relative to the parent.
						sy := sy + current_widget.y
					end
					current_widget ?= current_widget.parent
					widget_imp ?= current_widget
				end

				w ?= widget_imp.implementation
				data_imp ?= ev_data.implementation
				
					-- Now set the coordinates in the data so they relate to the target.
				data_imp.set_x (data_imp.absolute_x - w.absolute_x + w.border_width - w.frame_width - 1 - sx)
				data_imp.set_y (data_imp.absolute_y - w.absolute_y - w.title_height - w.frame_height - 1 - sy)
				if tool_bar_button /= Void then
					data_imp.set_y (sy)
				end
		
				target.receive (args.first.data_type, args.first.transported_data, ev_data)
			end
		end

	offset_for_tool_bar_button (button: EV_TOOL_BAR_BUTTON):TUPLE [INTEGER, INTEGER] is
			-- `Result' is [Relative xcoor `button' to its parent,
			-- Absolute ycoor of `button'] 
		local
			tool_bar_imp: EV_TOOL_BAR_IMP
		do
				tool_bar_imp ?= button.parent.implementation
				create Result.make
				Result.put (tool_bar_imp.child_x (button), 1)
				Result.put (tool_bar_imp.child_y_absolute (button), 2)
		end

	offset_for_multi_column_list_row (row: EV_MULTI_COLUMN_LIST_ROW):TUPLE [INTEGER, INTEGER] is
			-- `Result' is [Relative xcoor of `row' to its parent,
			-- Relative ycoor of `row' to its parent].
		local
			row_imp: EV_MULTI_COLUMN_LIST_ROW_IMP	
			list_imp: EV_MULTI_COLUMN_LIST_IMP
		do
			row_imp ?= row.implementation
			list_imp ?= row_imp.parent.implementation
			create Result.make
			Result.put (list_imp.child_x, 1)
			Result.put (- list_imp.child_y (row_imp), 2)
		end

	offset_for_tree_item (tree_item: EV_TREE_ITEM):TUPLE [INTEGER, INTEGER] is
			-- `Result' is [Relative xcoor of `tree_item' to its parent,
			-- Relative ycoor of `tree_item' to its parent]
		local
			tree_item_imp: EV_TREE_ITEM_IMP
			root_parent: EV_TREE_IMP
			parent: EV_TREE_ITEM_IMP
			counter: INTEGER
			sx: INTEGER
			sy: INTEGER
		do
			tree_item_imp ?= tree_item.implementation
			from
				root_parent := Void
				counter := 0
			until
				root_parent /= Void
			loop
				root_parent ?= tree_item_imp.parent_imp
				if root_parent = Void then	
					tree_item_imp ?= tree_item_imp.parent_imp
				end
				counter := counter + 1
			end
			sx := root_parent.indent * counter + 1 
			root_parent ?= tree_item_imp.parent_imp
			create Result.make
			Result.put (sx, 1)
			Result.put (sy, 2)
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
