indexing
	description: "Maintains the pick and drop mechanism %
				%and terminates it when the data is dropped."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_TRANSPORTER_IMP

inherit
	EV_COMMAND

	WEL_COLOR_CONSTANTS

	WEL_ROP2_CONSTANTS

feature {NONE} -- Attributes

	x0, y0, x1, y1: INTEGER

	dropped: BOOLEAN_REF is
		once
			create Result
		end

feature {EV_PND_TARGET_IMP} -- Targets

	targets: LINKED_LIST [EV_PND_TARGET_IMP] is
		once
			create Result.make
		end

feature {EV_PND_TARGET_IMP} -- Access

	register (target: EV_PND_TARGET_IMP) is
			-- Register Current as a target.
		require
			not_in_targets: not targets.has (target)
		do
			targets.put_front (target)
		ensure
			in_targets: targets.has (target)
		end
	
	unregister (target: EV_PND_TARGET_IMP) is
			-- Unregister Current as a target.
		require
			in_targets: targets.has (target)
		do
			targets.start
			targets.prune (target)
		ensure
			not_in_targets: not targets.has (target)
		end

feature -- Transport

	transport (dt_src: EV_PND_SOURCE_IMP; cmd: EV_INTERNAL_COMMAND) is
			-- Start the transport and
			-- draw the line from the point `pt'.
			-- If Void, start the line from the current cursor position. 
		local
			wel_point: WEL_POINT
		do
			default_command := cmd
			if dt_src.initial_point /= Void then
				x0 := dt_src.initial_point.x
				y0 := dt_src.initial_point.y
			else
				create wel_point.make (0, 0)
				wel_point.set_cursor_position
				x0 := wel_point.x
				y0 := wel_point.y
			end
			x1 := x0
			y1 := y0
			if dt_src.data_type.cursor /= Void then
				dt_src.widget_source.set_cursor (dt_src.data_type.cursor)
			end
			dt_src.widget_source.set_capture
			dropped.set_item (False)
		end

feature {EV_PND_SOURCE_IMP} -- Default command

	default_command: EV_INTERNAL_COMMAND

feature {NONE} -- Implementation

	draw_segment (lx1, ly1, lx2, ly2: INTEGER) is
			-- Draw a segment between (`lx1', `ly1') and (`lx2', `ly2').
		local
			screen_dc: WEL_SCREEN_DC
			point_color: WEL_COLOR_REF
		do
			create screen_dc
			create point_color.make_system (color_windowtext)	
			screen_dc.get
			screen_dc.set_rop2 (R2_not)
			screen_dc.line (lx1, ly1, lx2, ly2)
			screen_dc.unselect_all
			screen_dc.release
		end

	pointed_target: EV_PND_TARGET_IMP is
			-- Hole at mouse position
		local
			wel_point: WEL_POINT
			toolbar: EV_TOOL_BAR_IMP
			tbutton: EV_TOOL_BAR_BUTTON_IMP
			mc_list: EV_MULTI_COLUMN_LIST_IMP
			tree: EV_TREE_IMP
			tg: EV_PND_TARGET_IMP
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

	execute (args: EV_ARGUMENT2 [INTEGER, EV_PND_SOURCE_IMP]; data: EV_BUTTON_EVENT_DATA) is
			-- Executed when the user right click.
		local
			target: EV_PND_TARGET_IMP
			wel_point: WEL_POINT
			curs_code: EV_CURSOR_CODE
			curs: EV_CURSOR
		do
			inspect args.first
			when 1 then -- Drag the data.
				if not dropped.item then
					create wel_point.make (0, 0)
					draw_segment (x0, y0, x1, y1)	
					wel_point.set_cursor_position
					x1 := wel_point.x
					y1 := wel_point.y
					draw_segment (x0, y0, x1, y1)
					target := pointed_target
					if target /= Void and then target.accept (args.second.data_type) then
						-- set "authorized" cursor
						if args.second.data_type.cursor /= Void then
							args.second.widget_source.set_cursor (args.second.data_type.cursor)
						else -- set the standard cursor
							create curs_code.make
							create curs.make_by_code (curs_code.standard)
							args.second.widget_source.set_cursor (curs)
						end
					else
						-- set "forbiden" cursor
						create curs_code.make
						create curs.make_by_code (curs_code.no)
						args.second.widget_source.set_cursor (curs)
					end
				end
			when 2 then -- Drop the data in a target.
				dropped.set_item (True)
				target := pointed_target
				args.second.terminate_transport (Current, default_command)
				args.second.widget_source.release_capture
				-- Reset the cursor
				create curs_code.make
				create curs.make_by_code (curs_code.standard)
				args.second.widget_source.set_cursor (curs)
				draw_segment (x0, y0, x1, y1)
				if target /= Void then
					target.receive (args.second.data_type, args.second.transported_data, data)
				end
			when 3 then -- Drag canceled.
				dropped.set_item (True)
				args.second.terminate_transport (Current, default_command)
				args.second.widget_source.release_capture
				-- Reset the cursor
				create curs_code.make
				create curs.make_by_code (curs_code.standard)
				args.second.widget_source.set_cursor (curs)
				draw_segment (x0, y0, x1, y1)
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

