indexing
	description: "[
		EiffelVision box, deferred class, parent of vertical and
		horizontal boxes. Mswindows implementation.

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
			enable_sensitive,
			disable_sensitive,
			interface,
			initialize
		end
		
	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)is
				-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			create ev_children.make (2)
			is_homogeneous := Default_homogeneous
			padding := Default_spacing
			border_width := Default_border_width
		end

	
	initialize is
			
		do
			Precursor {EV_WIDGET_LIST_IMP}
			remove_item_actions.extend (agent removed_so_update_non_expandable_children (?))
			new_item_actions.extend (agent added_so_update_non_expandable_children (?))
			set_is_initialized (True)
		end
feature -- Access

	client_width: INTEGER is
			-- Width of the client area of `Current'.
		do
			if is_show_requested then
				Result := (client_rect.width - 2 * border_width).max (0)
			else
				Result := (child_cell.width - 2 * border_width).max (0)
			end
		end
	
	client_height: INTEGER is
			-- Height of the client area of `Current'.
		do
			if is_show_requested then
				Result := (client_rect.height  - 2 * border_width).max (0)
			else
				Result := (child_cell.height  - 2 * border_width).max (0)
			end
		end

	is_homogeneous: BOOLEAN
			-- Must the children have the same size ?

	padding: INTEGER
			-- Space between the objects in `Current'.

	border_width: INTEGER
			-- Border width around inside edge of `Current'.

	total_spacing: INTEGER is
			-- Total spacing. One spacing between two consecutive children.
		do
			Result := padding * ((childvisible_nb - 1).max (0))
		end

	childvisible_nb: INTEGER
			-- Number of visible children.
 
	compute_childexpand_nb is
			-- Compute number of visible children which are expanded
			-- and assign to `child_expand_number'.
		local
			l_cursor: CURSOR
		do			
			childexpand_nb := childvisible_nb
			if non_expandable_children /= Void then
				from
					l_cursor := non_expandable_children.cursor
					non_expandable_children.start
				until
					non_expandable_children.off
				loop
					if ev_children.i_th (non_expandable_children.item).is_show_requested then
						childexpand_nb := childexpand_nb - 1
					end
					non_expandable_children.forth
				end
				non_expandable_children.go_to (l_cursor)
			end
		end
		
	childexpand_nb: INTEGER
			-- Number of visible children which are expanded.

	non_expandable_children: ARRAYED_LIST [INTEGER]
			-- Position of the non expandable children in growing order.

feature {EV_ANY, EV_ANY_I}-- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is the `child' expandable. ie: does it
			-- allow the parent to resize or move it.
		local
			child_imp: EV_WIDGET_IMP
		do
			if non_expandable_children = Void then
				Result := True
			else
				child_imp ?= child.implementation
				check
					valid_cast: child_imp /= Void
				end
				Result := not non_expandable_children.has
					(ev_children.index_of (child_imp, 1))
			end
		end

feature {EV_ANY, EV_ANY_I}-- Status setting

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make `child' expandable if `flag',
			-- not expandable otherwise.
		local
			list: ARRAYED_LIST [INTEGER]
			child_imp: EV_WIDGET_IMP
			value, an_index: INTEGER
			placed: BOOLEAN
		do
				-- First, we find the index of the child.
			child_imp ?= child.implementation
			check
				valid_cast: child_imp /= Void
			end
			an_index := ev_children.index_of (child_imp, 1)

				-- Then, we set the information
			if flag then
				if non_expandable_children /= Void then
					non_expandable_children.prune_all (an_index)
					if non_expandable_children.is_empty then
						non_expandable_children := Void
					end
				end
			else
				if non_expandable_children = Void then
					create non_expandable_children.make (1)
					non_expandable_children.extend (an_index)
				else
					from
						list := non_expandable_children
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
			notify_change (Nc_minsize, Current)
		end

feature -- Contract support

  	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN is
			-- `Result' True if `new_child' contained in `ev_children'.
  			-- Used in the postcondition of 'add_child'.
   		local
   			child_imp: EV_WIDGET_IMP
   		do
 			child_imp ?= new_child
 			Result := ev_children.has (child_imp)
 		end
 								
feature {NONE} -- Basic operation

	removed_so_update_non_expandable_children (wid: EV_WIDGET) is
			-- Adjust `non_expandable_children' accordingly
			-- when a child is removed.
		local
			wid_imp: EV_WIDGET_IMP
			an_index: INTEGER
		do
			wid_imp ?= wid.implementation
			check
				child_implementation_not_void: wid_imp /= Void
			end
			an_index := ev_children.index_of (wid_imp, 1)
			if non_expandable_children /= Void then
				non_expandable_children.prune_all (an_index)
				if non_expandable_children.is_empty then
					non_expandable_children := Void
				else
					from
						non_expandable_children.start
					until
						non_expandable_children.off
					loop
						if an_index < non_expandable_children.item then
							non_expandable_children.replace (non_expandable_children.item - 1)
						end
						non_expandable_children.forth
					end
				end
			end
		end

	added_so_update_non_expandable_children (wid: EV_WIDGET) is
			-- Adjust `non_expandable_children' accordingly
			-- when a child is added.
		local
			wid_imp: EV_WIDGET_IMP
			an_index: INTEGER
		do
			wid_imp ?= wid.implementation
			check
				child_implementation_not_void: wid_imp /= Void
			end
			an_index := ev_children.index_of (wid_imp, 1)
			if non_expandable_children /= Void then
				from
					non_expandable_children.start
				until
					non_expandable_children.off
				loop
					if non_expandable_children.item >= an_index then
						non_expandable_children.replace (non_expandable_children.item + 1)
					end
					non_expandable_children.forth
				end
			end
		end
 
	rest (total_rest: INTEGER): INTEGER is
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

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_insensitive (flag: BOOLEAN) is
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

	enable_sensitive is
			-- Make `Current' sensitive to user input.
		do
			set_insensitive (False)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	disable_sensitive is
			-- Make `Current' insensitive to user input.
		do
			set_insensitive (True)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
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

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of `Current'?
		do
			Result := ev_children.has (a_child)
		end

feature {EV_ANY, EV_ANY_I} -- Interface

	interface: EV_BOX;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_BOX_IMP

