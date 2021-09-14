note
	description: "Eiffel Vision fixed. MS Windows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I
		redefine
			interface,
			extend_with_position_and_size,
			set_item_position_and_size
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			on_size,
			insert_i_th,
			notify_change,
			make
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		undefine
			on_wm_dropfiles,
			background_brush_gdip
		redefine
			top_level_window_imp,
			on_erase_background,
			default_style
		end

	WEL_RGN_CONSTANTS
		export {NONE}
			all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create the fixed container.
		do
			assign_interface (an_interface)
		end

	make
		do
			ev_wel_control_container_make
			create ev_children.make (2)
			Precursor
		end

feature -- Status setting

	extend_with_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Add `a_widget' to `Current' with a position of `a_x', a_y' and a dimension of `a_width' and `a_height'.
		local
			v_imp: detachable EV_WIDGET_IMP
			wel_win: detachable WEL_WINDOW
		do
				-- Add `a_widget' to `Current'.
			a_widget.implementation.on_parented
			v_imp ?= a_widget.implementation
			check v_imp /= Void then end
			ev_children.go_i_th (count + 1)
			ev_children.put_left (v_imp)
			wel_win ?= Current
			v_imp.wel_set_parent (wel_win)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([a_widget])
			if index = count then
				index := index + 1
			end

				-- Set size and position.
			v_imp.ev_move (a_x, a_y)
			v_imp.parent_ask_resize (a_width, a_height)
			v_imp.invalidate
			notify_change (nc_minsize, Current, False)
		end

	set_item_position_and_size (a_widget: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			-- Assign `a_widget' with a position of `a_x' and a_y', and a dimension of `a_width' and `a_height'.
		local
			wel_win: detachable EV_WIDGET_IMP
		do
			wel_win ?= a_widget.implementation
			check wel_win /= Void then end
			wel_win.ev_move (a_x, a_y)
			wel_win.parent_ask_resize (a_width, a_height)
			wel_win.invalidate
			notify_change (Nc_minsize, wel_win, False)
		end

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER)
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			wel_win: detachable EV_WIDGET_IMP
		do
			application_implementation.erase_rubber_band
			wel_win ?= a_widget.implementation
			check
				wel_win_not_void: wel_win /= Void then
			end
			wel_win.ev_move (an_x, a_y)
			wel_win.invalidate
			notify_change (Nc_minsize, wel_win, False)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			wel_win: detachable EV_WIDGET_IMP
		do
			wel_win ?= a_widget.implementation
			check
				wel_win_not_void: wel_win /= Void then
			end
			wel_win.parent_ask_resize (a_width, a_height)
			notify_change (Nc_minsize, wel_win, False)
		end

feature {EV_ANY_I} -- Implementation

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Child widgets in z-order starting with farthest away.

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Assign `a_window' to `top_level_window_imp'.
		do
			top_level_window_imp := a_window
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.set_top_level_window_imp (a_window)
				ev_children.forth
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FIXED note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature {NONE} -- Implementation

	compute_minimum_width (a_is_size_forced: BOOLEAN)
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width: INTEGER
			cur: INTEGER
		do
			if not child_cell.is_user_min_width_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_width := new_min_width.max (v_imp.x_position + v_imp.width)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				ev_set_minimum_width (new_min_width, a_is_size_forced)
			end
		end

	compute_minimum_height (a_is_size_forced: BOOLEAN)
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_height: INTEGER
			cur: INTEGER
		do
			if not child_cell.is_user_min_height_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_height := new_min_height.max (v_imp.y_position + v_imp.height)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				ev_set_minimum_height (new_min_height, a_is_size_forced)
			end
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum size of the object.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width, new_min_height: INTEGER
			cur: INTEGER
		do
			if not child_cell.is_user_min_height_set or else not child_cell.is_user_min_width_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_width := new_min_width.max (v_imp.x_position + v_imp.width)
					new_min_height := new_min_height.max (v_imp.y_position + v_imp.height)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				ev_set_minimum_size (new_min_width, new_min_height, a_is_size_forced)
			end
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			Precursor {EV_WIDGET_LIST_IMP} (v, i)
			if child_cell.is_user_min_height_set or else child_cell.is_user_min_width_set then
				set_item_size (v, v.minimum_width, v.minimum_height)
			end
		end

	notify_change (type: INTEGER; child: detachable EV_ANY_I; a_is_size_forced: BOOLEAN)
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown,
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		do
			if not child_cell.is_user_min_height_set or else not child_cell.is_user_min_width_set then
				Precursor {EV_WIDGET_LIST_IMP} (type, child, a_is_size_forced)
			elseif attached {EV_SIZEABLE_IMP} child as l_child then
				l_child.parent_ask_resize (l_child.child_cell.width, l_child.child_cell.height)
			end
		end

feature {NONE} -- WEL Implementation

	on_size (size_type: INTEGER; a_width, a_height: INTEGER)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- And we reajust size of all children.
		local
			v_imp: EV_WIDGET_IMP
			cur: INTEGER
		do
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				v_imp.set_move_and_size (v_imp.x_position,
						v_imp.y_position, v_imp.width, v_imp.height)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
			Precursor {EV_WIDGET_LIST_IMP} (size_type, a_width, a_height)
		end

	ev_apply_new_size (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- And we reajust size of all children.
		local
			v_imp: EV_WIDGET_IMP
			cur: INTEGER
		do
			ev_move_and_resize (a_x, a_y, a_width, a_height, repaint)
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				v_imp.ev_apply_new_size (v_imp.x_position,
						v_imp.y_position, v_imp.width, v_imp.height, repaint)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
		local
			main_region: WEL_REGION
			tmp_region, new_region: WEL_REGION
			original_index: INTEGER
			temp_children: ARRAYED_LIST [EV_WIDGET_IMP]
			current_child: EV_WIDGET_IMP
			bk_brush: detachable WEL_BRUSH
			l_x, l_y, l_width, l_height: INTEGER
			l_gdip_brush: detachable WEL_GDIP_BRUSH
			l_gdip_graphics: WEL_GDIP_GRAPHICS
			l_region: WEL_RECT
			l_background_color: WEL_GDIP_COLOR
		do
				-- Disable default windows processing which would re-draw the
				-- complete background of `Current'. This is not nice behaviour
				-- as some widgets such as EV_LIST_IMP re-draw themselves as
				-- required and will be hidden by `Current' if they are inside.
				-- This will solve that problem.
			disable_default_processing
			set_message_return_value (to_lresult (1))
				-- Quick access to `ev_children'.
			temp_children := ev_children
				-- Retrieve original index of `ev_children'.
			original_index := temp_children.index
				-- Create the region as the invalid area of `Current' that
				-- needs to be redrawn.
			create main_region.make_rect_indirect (invalid_rect)
				-- We now need to subtract the area of every child held in
				-- `Current' from the invalid area.
			from
				temp_children.start
			until
				temp_children.off
			loop
				current_child := temp_children.item
					-- Create a temporary region the size of the current child.
				if current_child.is_show_requested then
					create tmp_region.make_rect
						(current_child.x_position, current_child.y_position,
						current_child.x_position + current_child.width,
						current_child.y_position + current_child.height)
						-- Subtract this temporary region from the `main_region'
						-- and store in `main_region'.
					new_region := main_region.combine (tmp_region, Rgn_diff)
					tmp_region.delete
					main_region.delete
					main_region := new_region
				end
					-- Point to the next child if there is one.
				temp_children.forth
			end
				-- Fill the remaining region, `main_region'.
			l_gdip_brush := background_brush_gdip
			if l_gdip_brush /= Void then
				-- GDI+ is available
				l_region := main_region.get_region_box

				l_x := l_region.x
				l_y := l_region.y
				l_width := l_region.width
				l_height := l_region.height
				create l_gdip_graphics.make_from_dc (paint_dc)
				create l_background_color.make_from_argb (255, background_color.red_8_bit, background_color.green_8_bit, background_color.blue_8_bit)
				l_gdip_graphics.clear (l_background_color)
				l_gdip_graphics.fill_rectangle (l_gdip_brush, create {WEL_GDIP_RECT}.make_with_size (l_x, l_y, l_width, l_height))

				l_gdip_graphics.destroy_item
			else
				-- Using GDI instead of GDI+
				bk_brush := background_brush
				check bk_brush /= Void then end
				paint_dc.fill_region (main_region, bk_brush)

					-- Clean up GDI objects
				bk_brush.delete
			end

				-- Restore our index in the children.
			temp_children.go_i_th (original_index)
			main_region.delete
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Is `a_child' currently contained in `Current'.
		do
			Result := a_child = item.implementation
		end

	default_style: INTEGER
			-- Default style used by windows at creation.
		do
			Result := Ws_child | Ws_visible | Ws_clipsiblings
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
