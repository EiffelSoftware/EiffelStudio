indexing
	description: "EiffelVision list, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_I
	
inherit
	EV_PRIMITIVE_I
		export {NONE}
			add_double_click_command, remove_double_click_commands
		redefine
			set_default_colors
		end

feature {EV_WIDGET} -- Initialization

	set_default_colors is
			-- Common initializations for Gtk and Windows.
		local
			color: EV_COLOR
		do
			!! color.make_rgb (255, 255, 255)
			set_background_color (color)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
		end

feature -- Access

	count: INTEGER is
			-- Number of lines
		do
			Result := ev_children.count
		end

	get_item (index: INTEGER): EV_LIST_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: index <= count
		do
			Result ?= (ev_children.i_th (index)).interface
		end

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected
			-- It needs to be in single selection mode
		require
			exists: not destroyed
			single_selection: not is_multiple_selection
		deferred
		end

	selected_items: LINKED_LIST [EV_LIST_ITEM] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
			exists: not destroyed
		local
			litem: EV_LIST_ITEM
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
		do
			!! Result.make
			if is_multiple_selection then
				from
					list := ev_children
					list.start
				until
					list.after
				loop
					if list.item.is_selected then
						litem ?= (list.item.interface)
						if litem /= Void then 
							Result.extend (litem)
						end
					end
					list.forth
				end
			else
				Result.extend (selected_item)
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		deferred
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
			exist: not destroyed
		deferred
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= count
		deferred
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= count
		deferred
		end

	clear_selection is
			-- Clear the selection of the list.
		require
			exists: not destroyed
		deferred
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
			exists: not destroyed
		deferred
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		deferred
		end

	add_item (item: EV_LIST_ITEM_IMP) is
			-- Add `item' to the list
		deferred
		end

feature -- Basic operation

	find_item_by_data (data: ANY): EV_LIST_ITEM is
			-- Find a child with data equal to `data'.
		require
			exists: not destroyed
			valid_data: data /= Void
		local
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			litem: EV_LIST_ITEM
		do
			from
				list := ev_children
				list.start
			until
				list.after or Result /= Void
			loop
				litem ?= list.item.interface
				if litem.data.is_equal (data) then
					Result ?= litem
				end
				list.forth
			end
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			-- List of the children

	clear_ev_children is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		local
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
		do
			from
				list := ev_children
				list.start
			until
				list.after
			loop
				list.item.interface.remove_implementation
				list.forth
			end
			list.wipe_out
		end

end -- class EV_LIST_I

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
