note
	description:
		"A common class for Vision/Cocoa containers with one child without%N%
		%commitment to a Cocoa control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			on_size
--			next_tabstop_widget
		end

feature -- Access

	item: detachable EV_WIDGET
			-- The child of `Current'.

feature -- Status setting

	enable_sensitive
			-- Set `item' sensitive to user actions.
		do
			if attached item_imp as l_item_imp and then not l_item_imp.internal_non_sensitive then
				l_item_imp.enable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

	disable_sensitive
			-- Set `item' insensitive to user actions.
		do
			if attached item_imp as l_item_imp then
				l_item_imp.disable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

feature -- Element change

	remove
			-- Remove `item' from `Current' if present.
		local
			v_imp: detachable EV_WIDGET_IMP
		do
			if attached item as l_item then
				remove_item_actions.call ([l_item])
				v_imp ?= item_imp
				check
					v_imp_not_void: v_imp /= Void
				end
				item := Void
				v_imp.set_parent_imp (Void)
				v_imp.on_orphaned
				notify_change (nc_minsize, Current)
				v_imp.attached_view.remove_from_superview
			end
		end

	insert (v: like item)
			-- Assign `v' to `item'.
		local
			v_imp: detachable EV_WIDGET_IMP
		do
			if attached v then
				check
					has_no_item: item = Void
				end
				v.implementation.on_parented
				v_imp ?= v.implementation
				check
					v_imp_not_void: v_imp /= Void
				end
				v_imp.set_parent_imp (current)
				item := v
				notify_change (nc_minsize, Current)
				new_item_actions.call ([v])
				attached_view.add_subview (v_imp.attached_view)
			end
		end

	put, replace (v: like item)
			-- Replace `item' with `v'.
		do
			remove
			if v /= Void then
				insert (v)
			end
		end

feature -- Basic operations

	propagate_background_color
			-- Propagate the current background color of `Current'
			-- to the children.
		do
			if attached item as l_item then
				l_item.set_background_color (background_color)
				if attached {EV_CONTAINER} l_item as c then
					c.propagate_background_color
				end
			end
		end

	propagate_foreground_color
			-- Propagate the current foreground color of `Current'
			-- to the children.
		do
			if attached item as l_item then
				l_item.set_foreground_color (foreground_color)
				if attached {EV_CONTAINER} l_item as c then
					c.propagate_foreground_color
				end
			end
		end

feature {EV_ANY_I} -- WEL Implementation

	index_of_child (child: EV_WIDGET_IMP): INTEGER
			-- `Result' is 1 based index of `child' within `Current'.
		do
			Result := 1
		end

--	next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
--			-- Return the next widget that may by tabbed to as a result of pressing the tab key from `start_widget'.
--			-- `search_pos' is the index where searching must start from for containers, and `forwards' determines the
--			-- tabbing direction. If `search_pos' is less then 1 or more than `count' for containers, the parent of the
--			-- container must be searched next.
--		require else
--			valid_search_pos: search_pos >= 0 and search_pos <= interface.count + 1
--		local
--			w: EV_WIDGET_IMP
--			container: EV_CONTAINER
--		do
--			Result := return_current_if_next_tabstop_widget (start_widget, search_pos, forwards)
--			if Result = Void and search_pos = 1 and item /= Void and is_sensitive then
--					-- Otherwise search the child.
--				w := item_imp
--				if forwards then
--					Result := w.next_tabstop_widget (start_widget, 1, forwards)
--				else
--					container ?= w.interface
--					if container /= Void then
--						Result := w.next_tabstop_widget (start_widget, container.count, forwards)
--					else
--						Result := w.next_tabstop_widget (start_widget, 1, forwards)
--					end
--				end
--			end
--			if Result = Void then
--				Result := next_tabstop_widget_from_parent (start_widget, search_pos, forwards)
--			end
--		end

--	is_control_in_window (hwnd_control: POINTER): BOOLEAN
--			-- Is the control of handle `hwnd_control'
--			-- located inside the current window?
--		local
--			hwnd_current: POINTER
--		do
--			hwnd_current := wel_item
--			if hwnd_control = hwnd_current then
--				Result := True
--			else
--				if item_imp /= Void then
--					Result := item_imp.is_control_in_window (hwnd_control)
--				else
--					Result := False
--				end
--			end
--		end

	on_size (a_width, a_height: INTEGER)
			-- Called when `Current' is resized.
		do
--			if size_type /= ({WEL_WINDOW_CONSTANTS}.Size_minimized) then
				if attached item_imp as l_item_imp then
					l_item_imp.set_move_and_size (0, 0, client_width, client_height)
				end
				Precursor {EV_CONTAINER_IMP} (a_width, a_height)
--			end
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if attached item_imp as l_item_imp then
				l_item_imp.ev_apply_new_size (0, 0, client_width, client_height, True)
				-- was: client_x, client_y
			end
		end

feature {NONE} -- Implementation

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Is `a_child' a child of the container?
		do
			Result := a_child.interface = item
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class EV_SINGLE_CHILD_CONTAINER_IMP
