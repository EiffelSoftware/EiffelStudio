indexing

	description:
		"EiffelVision multi-column list row, gtk implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I

	EV_COMPOSED_ITEM_IMP
		rename
			count as columns,
			set_count as set_columns
		undefine
			destroy,
			destroyed
		redefine
			set_foreground_color,
			set_background_color,
			foreground_color,
			background_color
		end

creation
	make,
	make_with_text,
	make_with_index,
	make_with_all

feature {NONE} -- Initialization

	make is
			-- Create an row with one empty column.
		do
			-- create the arrayed_list where the text will be stored.
			create internal_text.make (0)
			internal_text.extend ("")

			-- create the arrayed_list where the pixmaps will be stored.
			create internal_pixmaps.make (0)
			internal_pixmaps.extend (Void)
		end

	make_with_text (txt: ARRAY [STRING]) is
			-- Create a row with text in it.
		local
			i: INTEGER
		do
			-- create the arrayed_lists where the text and
			-- the pixmaps will be stored.
			from
				create internal_text.make (0)
				create internal_pixmaps.make (0)
				i := txt.lower
			until
				i > txt.upper
			loop
				internal_text.extend (txt @ i)
				internal_pixmaps.extend (Void)
				i := i + 1
			end

 		end

	make_with_index (par:EV_MULTI_COLUMN_LIST; value: INTEGER) is
			-- Create a row at the given `value' index in the list.
		do
			make

			if par /= Void then
				set_columns (par.columns)
			end

			-- set `par' as parent and put the row at the given position
			set_parent (par)
			set_index (value)
		end

	make_with_all (par:EV_MULTI_COLUMN_LIST; txt: ARRAY [STRING]; value: INTEGER) is
			-- Create a row with `txt' as text at the given
			-- `value' index in the list.
		local
			i: INTEGER
		do
			-- set the text of the row
			from
				create internal_text.make (0)
				create internal_pixmaps.make (0)
				i := txt.lower
			until
				i > txt.upper
			loop
				internal_text.extend (txt @ i)
				internal_pixmaps.extend (Void)
				i := i + 1
			end

			-- set `par' as parent and put the row at the given position
			set_parent (par)
			set_index (value)
		end

feature -- Access

	parent: EV_MULTI_COLUMN_LIST is
		do
			if parent_imp /= void then
				Result ?= parent_imp.interface
			else
				Result := Void
			end
		end

	columns: INTEGER is
			-- Number of columns in the row
		do
			Result := internal_text.count
		end

	index: INTEGER is
			-- Index of the row in the list
			-- (starting from 1).
		do
			-- The `ev_children' array has to contain
			-- the same rows in the same order than in the gtk
			-- part.
			result := parent_imp.ev_children.index_of (Current, 1)
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		local
			r, g, b: INTEGER
		do
			c_gtk_clist_get_bg_color (parent_imp.widget, index - 1, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget,
			-- usually the text.
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		local
			r, g, b: INTEGER
		do
			c_gtk_clist_get_fg_color (parent_imp.widget, index - 1, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
		end

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := (internal_text = Void) and (internal_pixmaps = void)
		end

	is_selected: BOOLEAN is
			-- Is the item selected
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			row ?= Current.interface			
			Result := (parent_imp.selected_items.has (row))
			 or (parent_imp.selected_item = row)
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		local
		do
			internal_text := Void
			internal_pixmaps := Void
			parent_imp := Void	
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item.
		local
			local_array: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
		do
			-- moving the gtk row
			gtk_clist_row_move (parent_imp.widget, index - 1, value - 1)

			-- updating the parent `ev_children' array
			local_array := parent_imp.ev_children
			local_array.search (Current)
			local_array.remove

			local_array.go_i_th (value)
			local_array.put_left (Current)
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				gtk_clist_select_row (parent_imp.widget, index - 1, 0)
			else
				gtk_clist_unselect_row (parent_imp.widget, index - 1, 0)
			end
		end

	set_columns (value: INTEGER) is
			-- if value > number of columns, add empty columns 
			-- if value < number of columns, remove the last columns
			-- does nothing if equal.
		do
			if (value > columns) then
				from
					internal_text.finish
				until
					internal_text.count = value
				loop
					-- Increasing the number of fields in the `internal_text' array.
					internal_text.extend ("")
					-- Increasing the number of fields in the `internal_pixmaps' array.
					internal_pixmaps.extend (Void)
				end
			elseif (value < columns) then
				from
					internal_text.finish
				until
					internal_text.count = value
				loop
					-- Decreasing the number of fields in the `internal_text' array.
					internal_text.remove

					-- Decreasing the number of fields in the `internal_pixmaps' array.
					internal_pixmaps.remove
				
					internal_text.finish
					internal_pixmaps.finish
				end
			end
				
		end

feature -- Element Change

	set_cell_text (column: INTEGER; a_text: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		local
			txt: ANY
			pix_imp: EV_PIXMAP_IMP
		do
			-- Prepare the pixmap and the text.
			txt := a_text.to_c
			pix_imp := (internal_pixmaps @ column)

			-- Set the pixmap and the text in the given column.
			if (pix_imp /= void) then
				c_gtk_clist_set_pixtext (parent_imp.widget, index - 1, column - 1, pix_imp.widget, $txt)
			else
				c_gtk_clist_set_pixtext (parent_imp.widget, index - 1, column - 1, default_pointer, $txt)
			end
			-- Update the `internal_text' and `internal_pixmaps' arrays.
			internal_text.go_i_th (column)
			internal_text.put (a_text)
		end

	set_cell_pixmap (column: INTEGER; pix: EV_PIXMAP) is
			-- Sets the pixmap of the given column of the current row to `pixmap'.
		local
			pix_imp: EV_PIXMAP_IMP
			txt: STRING
			a: ANY
		do
			-- Prepare the pixmap and the text.
			pix_imp ?= pix.implementation
			txt := cell_text (column)
			a := txt.to_c

			-- Set the pixmap and the text in the given column.
			if (pix_imp /= void) then
				c_gtk_clist_set_pixtext (parent_imp.widget, index - 1, column - 1, pix_imp.widget, $a)
			else
				c_gtk_clist_set_pixtext (parent_imp.widget, index - 1, column - 1, default_pointer, $a)
			end
			-- Update the `internal_text' and `internal_pixmaps' arrays.
			internal_pixmaps.go_i_th (column)
			internal_pixmaps.put (pix_imp)
		end

	unset_cell_pixmap (column: INTEGER) is
			-- Sets the pixmap of the given column of the current row to `pixmap'.
		do
			c_gtk_clist_unset_pixmap (parent_imp.widget, index - 1, column - 1)
		end

	set_parent (par: EV_MULTI_COLUMN_LIST) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if (par /= void) then
				parent_imp ?= par.implementation
				check
					parent_not_void: parent_imp /= Void
				end
				parent_imp.add_item (Current)
			end					
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'.
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		do
			c_gtk_clist_set_bg_color (parent_imp.widget, index - 1, color.red, color.green, color.blue)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'.
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		do
			c_gtk_clist_set_fg_color (parent_imp.widget, index - 1, color.red, color.green, color.blue)
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX

			-- We need the index so we pass it as the mouse button (Temporary: Alex.) XXXX.
			add_command_with_event_data (parent_imp.widget, "select_row", cmd, arg, ev_data, index - 1, False)
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX

			-- We need the index so we pass it as the mouse button (Temporary: Alex.) XXXX.
			add_command_with_event_data (parent_imp.widget, "unselect_row", cmd, arg, ev_data, index - 1, False)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed
			-- when the item is selected.
		local
			list: LINKED_LIST [EV_COMMAND]
		do
			-- list of the commands to be executed for "select_row" signal.
			list := (event_command_array @ select_row_id).command_list

			from
				list.start
			until
				list.after
			loop
				remove_single_command (parent_imp.widget, select_row_id, list.item)
				-- we do not need to do "list.forth" as an item has been removed
				-- that list.
			end
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed
			-- when the item is unselected.
		local
			list: LINKED_LIST [EV_COMMAND]
		do
			-- list of the commands to be executed for "unselect_row" signal.
			list := (event_command_array @ unselect_row_id).command_list

			from
				list.start
			until
				list.after
			loop
				remove_single_command (parent_imp.widget, unselect_row_id, list.item)
				-- we do not need to do "list.forth" as an item has been removed
				-- that list.
			end
		end	

feature {NONE} -- Implementation

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
		-- Multi-column list that own the current object 

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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
