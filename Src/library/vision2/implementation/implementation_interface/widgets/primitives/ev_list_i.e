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
		redefine
			build
		end

feature {EV_WIDGET} -- Initialization

	build is
			-- Common initializations for Gtk and Windows.
		local
			color: EV_COLOR
		do
			set_expand (True)
			set_vertical_resize (True)
			set_horizontal_resize (True)
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
			list_item: EV_LIST_ITEM
		do
			!! Result.make
			if is_multiple_selection then
				from
					ev_children.start
				until
					ev_children.after
				loop
					if ev_children.item.is_selected then
						list_item ?= (ev_children.item.interface)
						if list_item /= Void then 
							Result.extend (list_item)
						end
					end
					ev_children.forth
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

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature {EV_LIST_ITEM} -- Implementation

	add_item (item: EV_LIST_ITEM) is
			-- Add `item' to the list
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	ev_children: LINKED_LIST [EV_LIST_ITEM_IMP]
			-- List of the children

	clear_ev_children is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		do
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.interface.remove_implementation
				ev_children.forth
			end
			ev_children.wipe_out
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
