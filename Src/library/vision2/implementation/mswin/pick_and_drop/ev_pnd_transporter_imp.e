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
			!! Result
		end

feature {EV_PND_TARGET_IMP} -- Targets

	targets: LINKED_LIST [EV_PND_TARGET_IMP] is
		once
			!! Result.make
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

	transport (data_source: EV_PND_SOURCE_IMP; pt: EV_POINT) is
			-- Start the transport and
			-- draw the line from the point `pt'.
			-- If Void, start the line from the current cursor position. 
		local
			wel_point: WEL_POINT
		do
			if pt /= Void then
				x0 := pt.x
				y0 := pt.y
			else
				!! wel_point.make (0, 0)
				wel_point.set_cursor_position
				x0 := wel_point.x
				y0 := wel_point.y
			end
			x1 := x0
			y1 := y0
			data_source.set_capture
--			if data_source.data_type.cursor /= Void then
--				set_cursor (data_source.data_type.cursor)
--			end
			dropped.set_item (False)
		end

feature {NONE}

	draw_segment (lx1, ly1, lx2, ly2: INTEGER) is
			-- Draw a segment between (`lx1', `ly1') and (`lx2', `ly2').
		local
			screen_dc: WEL_SCREEN_DC
			point_color: WEL_COLOR_REF
		do
			!! screen_dc
			!! point_color.make_system (color_windowtext)	
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
			widget_pointed: EV_WIDGET_IMP
		do
			!! wel_point.make (0, 0)
			wel_point.set_cursor_position
			widget_pointed ?= wel_point.window_at
			if widget_pointed /= Void then
				from
					targets.start
				until
					targets.after or else Result /= Void
				loop
					if (widget_pointed = targets.item) then
						Result := targets.item
					end
					targets.forth
				end
			end
		end

	execute (args: EV_ARGUMENT3 [INTEGER, EV_PND_SOURCE_IMP, INTEGER]; data: EV_BUTTON_EVENT_DATA) is
		local
			target: EV_PND_TARGET_IMP
			wel_point: WEL_POINT
		do
			if args.first = 1 then
				-- Drag the data.
				if not dropped.item then
					!! wel_point.make (0, 0)
					draw_segment (x0, y0, x1, y1)	
					wel_point.set_cursor_position
					x1 := wel_point.x
					y1 := wel_point.y
					draw_segment (x0, y0, x1, y1)
				end
			elseif args.first = 2 then
				-- Drop the data in a target.
				dropped.set_item (True)
				target := pointed_target
				args.second.terminate_transport (Current, args.third)
				args.second.release_capture
--				unset_cursor
				draw_segment (x0, y0, x1, y1)
				if target /= Void then
					target.receive (args.second.data_type, args.second.transported_data, data)
				end
			elseif args.first = 3 then
				-- Drag canceled.
				dropped.set_item (True)
				args.second.terminate_transport (Current, args.third)
				args.second.release_capture
--				unset cursor
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

