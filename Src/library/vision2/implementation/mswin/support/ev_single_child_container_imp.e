indexing
	description: 
		"A common class for Mswindows containers with one child without%N%
		%commitment to a WEL control."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SINGLE_CHILD_CONTAINER_IMP

inherit
	EV_CONTAINER_IMP
		redefine
			enable_sensitive,
			disable_sensitive,
			propagate_foreground_color,
			propagate_background_color,
			extend,
			propagate_syncpaint,
			update_for_pick_and_drop,
			on_size
		end

feature -- Access

	item: EV_WIDGET
			-- The child of `Current'.

	item_imp: EV_WIDGET_IMP is
			-- `item'.`implementation'.
		do
			if item /= Void then
				Result ?= item.implementation
			end
		end

feature -- Status setting

	enable_sensitive is
			-- Set `item' sensitive to user actions.
		do
			if item_imp /= Void and not item_imp.internal_non_sensitive then
				item_imp.enable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

	disable_sensitive is
			-- Set `item' insensitive to user actions.
		do
			if item_imp /= Void then
				item_imp.disable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end
	
feature -- Element change

	remove is
			-- Remove `item' from `Current' if present.
		local
			v_imp: EV_WIDGET_IMP
		do
			if item /= Void then
				remove_item_actions.call ([item])
				v_imp ?= item_imp
				check
					v_imp_not_void: v_imp /= Void
				end	
				v_imp.set_parent (Void)
				v_imp.on_orphaned
				item := Void
				notify_change (2 + 1, Current)
			end
		end

	insert (v: like item) is
			-- Assign `v' to `item'.
		local
			v_imp: EV_WIDGET_IMP
		do
			if v /= Void then
				check
					has_no_item: item = Void
				end
				v.implementation.on_parented
				v_imp ?= v.implementation
				check
					v_imp_not_void: v_imp /= Void
				end
				item := v
				v_imp.set_parent (interface)
				notify_change (2 + 1, Current)
				new_item_actions.call ([item])
			end
		end

	put, replace (v: like item) is
			-- Replace `item' with `v'.
		do
			remove
			if v /= Void then
				insert (v)
			end
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of `Current'
			-- to the children.
		do
			if item /= Void then
				item.set_background_color (background_color)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of `Current'
			-- to the children.
		do
			if item /= Void then
				item.set_foreground_color (foreground_color)
			end
		end

feature {EV_ANY_I} -- WEL Implementation

	adjust_tab_ordering (ordered_widgets: ARRAYED_LIST [WEL_WINDOW]; widget_depths: ARRAYED_LIST [INTEGER]; depth: INTEGER) is
			-- Adjust tab ordering of children in `Current'.
			-- used when `Current' is a child of an EV_DIALOG_IMP_MODAL
			-- or an EV_DIALOG_IMP_MODELESS.
		local
			widget_imp: EV_WIDGET_IMP
			child: WEL_WINDOW
			container: EV_CONTAINER_IMP
		do
			if item /= Void then
				container ?= item.implementation
				if container /= Void then
						-- Reverse tab order of `widget_list'.
					container.adjust_tab_ordering (ordered_widgets, widget_depths, depth + 1)
				end
					-- Add `child' to `ordered_widgets'.
				widget_imp ?= item.implementation
				child ?= widget_imp
				check
					child_not_void: child /= Void
				end
				ordered_widgets.force (child)
				widget_depths.force (depth)
			end
		end

	propagate_syncpaint is
			-- Propagate `wm_syncpaint' message recevived by `top_level_window_imp' to
			-- child. See "WM_SYNCPAINT" in MSDN for more information.
		do
			if item_imp /= Void then
				item_imp.propagate_syncpaint		
			end
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so notify `item_imp'.
		do
			if item_imp /= Void then
				item_imp.update_for_pick_and_drop (starting)	
			end
		end
		

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		local
			hwnd_current: POINTER
		do
			hwnd_current := wel_item
			if hwnd_control = hwnd_current then
				Result := True
			else
				if item_imp /= Void then
					Result := item_imp.is_control_in_window (hwnd_control)
				else
					Result := False
				end
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when `Current' is resized.
		do
			if size_type /= Wel_window_constants.Size_minimized then
				if item /= Void then
					item_imp.set_move_and_size (client_x, client_y,
						client_width, client_height)
				end
				Precursor {EV_CONTAINER_IMP} (size_type, a_width, a_height)
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if item /= Void then
				item_imp.ev_apply_new_size (client_x, client_y,
					client_width, client_height, True)
			end
		end
		
feature {NONE} -- Implementation

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := a_child = item.implementation
		end

end -- class EV_SINGLE_CHILD_CONTAINER_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

