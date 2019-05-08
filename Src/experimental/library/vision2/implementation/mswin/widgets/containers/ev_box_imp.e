note
	description: "[
		EiffelVision box, deferred class, parent of vertical and
		horizontal boxes. MS Windows implementation.

		Note: We use `create with coordinates' to allow the notebook
			as containers. They are wel_windows and not
			wel_composite_windows.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BOX_IMP

inherit
	EV_BOX_I
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color,
			enable_sensitive,
			disable_sensitive,
			client_width,
			client_height
		redefine
			interface,
			make
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		undefine
			on_wm_dropfiles,
			background_brush_gdip
		redefine
			top_level_window_imp
		end

feature -- Initialization

	old_make (an_interface: attached like interface)
				-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
		do
			ev_wel_control_container_make
			create ev_children.make (2)
			is_homogeneous := Default_homogeneous
			padding := Default_spacing
			border_width := Default_border_width
			Precursor {EV_WIDGET_LIST_IMP}
			remove_item_actions.extend (agent removed_so_update_non_expandable_children (?))
			new_item_actions.extend (agent added_so_update_non_expandable_children (?))
			set_is_initialized (True)
		end

feature -- Access

	client_width: INTEGER
			-- Width of the client area of `Current'.
		do
			if is_show_requested then
				Result := (client_rect.width  - 2 * border_width).max (0)
			else
				Result := (child_cell.width   - 2 * border_width).max (0)
			end
		end

	client_height: INTEGER
			-- Height of the client area of `Current'.
		do
			if is_show_requested then
				Result := (client_rect.height  - 2 * border_width).max (0)
			else
				Result := (child_cell.height   - 2 * border_width).max (0)
			end
		end

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	padding: INTEGER
			-- Space between the objects in `Current'.

	border_width: INTEGER
			-- Border width around inside edge of `Current'.

	total_spacing: INTEGER
			-- Total spacing. One spacing between two consecutive children.
		do
			Result := padding * ((childvisible_nb - 1).max (0))
		end

	childvisible_nb: INTEGER
			-- Number of visible children.

	compute_childexpand_nb
			-- Compute number of visible children which are expanded
			-- and assign to `child_expand_number'.
		local
			l_cursor: CURSOR
		do
			childexpand_nb := childvisible_nb
			if attached non_expandable_children as l_non_expandable_children then
				from
					l_cursor := l_non_expandable_children.cursor
					l_non_expandable_children.start
				until
					l_non_expandable_children.off
				loop
					if ev_children.i_th (l_non_expandable_children.item).is_show_requested then
						childexpand_nb := childexpand_nb - 1
					end
					l_non_expandable_children.forth
				end
				l_non_expandable_children.go_to (l_cursor)
			end
		end

	childexpand_nb: INTEGER
			-- Number of visible children which are expanded.

	non_expandable_children: detachable ARRAYED_LIST [INTEGER]
			-- Position of the non expandable children in growing order.

feature {EV_ANY, EV_ANY_I}-- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN
			-- Is the `child' expandable. ie: does it
			-- allow the parent to resize or move it.
		local
			child_imp: detachable EV_WIDGET_IMP
			l_non_expandable_children: like non_expandable_children
		do
			l_non_expandable_children := non_expandable_children
			if l_non_expandable_children = Void then
				Result := True
			else
				child_imp ?= child.implementation
				check
					valid_cast: child_imp /= Void then
				end
				Result := not l_non_expandable_children.has
					(ev_children.index_of (child_imp, 1))
			end
		end

feature {EV_ANY, EV_ANY_I}-- Status setting

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN)
			-- Make `child' expandable if `flag',
			-- not expandable otherwise.
		local
			list: ARRAYED_LIST [INTEGER]
			child_imp: detachable EV_WIDGET_IMP
			value, an_index: INTEGER
			placed: BOOLEAN
			l_non_expandable_children: like non_expandable_children
		do
				-- First, we find the index of the child.
			child_imp ?= child.implementation
			check
				valid_cast: child_imp /= Void then
			end
			an_index := ev_children.index_of (child_imp, 1)

			l_non_expandable_children := non_expandable_children

				-- Then, we set the information
			if flag then
				if l_non_expandable_children /= Void then
					l_non_expandable_children.prune_all (an_index)
					if l_non_expandable_children.is_empty then
						l_non_expandable_children := Void
						non_expandable_children := Void
					end
				end
			else
				if l_non_expandable_children = Void then
					create l_non_expandable_children.make (1)
					non_expandable_children := l_non_expandable_children
					l_non_expandable_children.extend (an_index)
				else
					from
						list := l_non_expandable_children
						placed := False
						list.start
					until
						placed
					loop
						if list.after then
							list.extend (an_index)
							placed := True
						else
							value := list.item
							if an_index < value then
								list.put_left (an_index)
								placed := True
							elseif an_index > value then
								list.forth
							else
								placed := True
							end
						end
					end
				end
			end
			notify_change (Nc_minsize, Current, False)
		end

feature -- Contract support

  	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN
			-- `Result' True if `new_child' contained in `ev_children'.
  			-- Used in the postcondition of 'add_child'.
   		local
   			child_imp: detachable EV_WIDGET_IMP
   		do
 			child_imp ?= new_child
 			check child_imp /= Void then end
 			Result := ev_children.has (child_imp)
 		end

feature {NONE} -- Basic operation

	removed_so_update_non_expandable_children (wid: EV_WIDGET)
			-- Adjust `non_expandable_children' accordingly
			-- when a child is removed.
		local
			wid_imp: detachable EV_WIDGET_IMP
			an_index: INTEGER
		do
			wid_imp ?= wid.implementation
			check
				child_implementation_not_void: wid_imp /= Void then
			end
			an_index := ev_children.index_of (wid_imp, 1)
			if attached non_expandable_children as l_non_expandable_children then
				l_non_expandable_children.prune_all (an_index)
				if l_non_expandable_children.is_empty then
					non_expandable_children := Void
				else
					from
						l_non_expandable_children.start
					until
						l_non_expandable_children.off
					loop
						if an_index < l_non_expandable_children.item then
							l_non_expandable_children.replace (l_non_expandable_children.item - 1)
						end
						l_non_expandable_children.forth
					end
				end
			end
		end

	added_so_update_non_expandable_children (wid: EV_WIDGET)
			-- Adjust `non_expandable_children' accordingly
			-- when a child is added.
		local
			wid_imp: detachable EV_WIDGET_IMP
			an_index: INTEGER
			l_non_expandable_children: like non_expandable_children
		do
			wid_imp ?= wid.implementation
			check
				child_implementation_not_void: wid_imp /= Void then
			end
			an_index := ev_children.index_of (wid_imp, 1)

			l_non_expandable_children := non_expandable_children

			if l_non_expandable_children /= Void then
				from
					l_non_expandable_children.start
				until
					l_non_expandable_children.off
				loop
					if l_non_expandable_children.item >= an_index then
						l_non_expandable_children.replace (l_non_expandable_children.item + 1)
					end
					l_non_expandable_children.forth
				end
			end
		end

	rest (total_rest: INTEGER): INTEGER
				-- `Result' is rest we must add to the current child of
				-- `ev_children' when the size of the parent is not a
				-- multiple of the number of children.
				-- Dependent on `total_rest'.
		do
			if total_rest > 0 then
				Result := 1
			elseif total_rest < 0 then
				Result := -1
			else
				Result := 0
			end
		end

feature -- from EV_INVISIBLE_CONTAINER_IMP FIXME!!!

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- List of the children of the `Current'.

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_insensitive (flag: BOOLEAN)
			-- If `flag' then make `Current' insensitive. Else
			-- make `Current' sensitive.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
			widget_imp: EV_WIDGET_IMP
			cur: CURSOR
		do
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					widget_imp := list.item
					if flag then
						widget_imp.disable_sensitive
					else
						if not widget_imp.internal_non_sensitive then
							widget_imp.enable_sensitive
						end
					end
					list.forth
				end
				list.go_to (cur)
			end
		ensure
			cursor_not_moved: old ev_children.index = ev_children.index
		end

	enable_sensitive
			-- Make `Current' sensitive to user input.
		do
			set_insensitive (False)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	disable_sensitive
			-- Make `Current' insensitive to user input.
		do
			set_insensitive (True)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.is_empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_top_level_window_imp (a_window)
					list.forth
				end
			end
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Is `a_child' a child of `Current'?
		do
			Result := ev_children.has (a_child)
		end

	reversed_sizing_agents: detachable ARRAYED_LIST [PROCEDURE]
			-- When a box is getting larger, we do not want the items on the left or on the top
			-- to overlap the items next to them as it causes Window to misbehave and the drawing
			-- is not proper.

	set_item_size (a_item: EV_WIDGET_IMP; a_x_position, a_y_position, a_width, a_height: INTEGER_32; a_originator: BOOLEAN)
			-- Wrapper to resize a child widget which is used for creating an agent when `reversed_sizing_agents' is required.
		do
			if a_originator then
				a_item.set_move_and_size (a_x_position, a_y_position, a_width, a_height)
			else
				a_item.ev_apply_new_size (a_x_position, a_y_position, a_width, a_height, True)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Interface

	interface: detachable EV_BOX note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
