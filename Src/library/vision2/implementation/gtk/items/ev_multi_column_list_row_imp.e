--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description:
		"EiffelVision multi-column list row, gtk implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			parent_imp,
			interface
		end

	EV_COMPOSED_ITEM_IMP
		rename
			count as columns,
			set_count as set_columns
		undefine
			parent
		redefine
			parent_imp,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a row with one empty column.
		do
			base_make (an_interface)
		end

	initialize is
			-- Create the linked lists
		do
			-- create the arrayed_list where text will be stored.
			create internal_text.make (0)
			internal_text.extend ("")

			-- create arrayed_list where pixmaps will be stored.
			create internal_pixmaps.make (0)
			internal_pixmaps.extend (Void)
			is_initialized := True
		end

feature -- Access

	columns: INTEGER is
			-- Number of columns in the row
		do
			Result := internal_text.count
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		local
			r, g, b: INTEGER
		do
			C.c_gtk_clist_get_bg_color (
				parent_imp.list_widget,
				index - 1, $r, $g, $b
			)
			create Result.make_with_rgb (r, g, b)
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
			C.c_gtk_clist_get_fg_color (
				parent_imp.list_widget,
				index - 1, $r, $g, $b
			)
			create Result.make_with_rgb (r, g, b)
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

	enable_select is
			-- Select the row in the list.
		do
			C.gtk_clist_select_row (parent_imp.list_widget, index - 1, 0)
		end

	disable_select is
			-- Deselect the row from the list.
		do
			C.gtk_clist_unselect_row (parent_imp.list_widget, index - 1, 0)
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
					internal_text.extend ("")
					internal_pixmaps.extend (Void)
				end
			elseif (value < columns) then
				from
					internal_text.finish
				until
					internal_text.count = value
				loop
					-- Decreasing the number of fields in the 
					-- `internal_text' array.
					internal_text.remove

					-- Decreasing the number of fields in the 
					-- `internal_pixmaps' array.
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
			if (pix_imp /= void and then parent_imp /= Void) then
				C.c_gtk_clist_set_pixtext (
					parent_imp.list_widget,
					index - 1,
					column - 1,
					pix_imp.c_object,
					$txt
				)
			elseif parent_imp /= Void then
				C.c_gtk_clist_set_pixtext (
					parent_imp.list_widget,
					index - 1,
					column - 1,
					default_pointer,
					$txt
				)
			end
			-- Update the `internal_text' and `internal_pixmaps' arrays.
			internal_text.go_i_th (column)
			internal_text.put (a_text)
		end

	set_cell_pixmap (column: INTEGER; pix: EV_PIXMAP) is
			-- Sets the pixmap of the given column of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			txt: STRING
			a: ANY
			pixdata, mask, pixmap_pointer: POINTER
		do
			-- Prepare the pixmap and the text.
			pix_imp ?= pix.implementation
			txt := cell_text (column)
			a := txt.to_c

			-- Set the pixmap and the text in the given column.
			if (pix_imp /= void and then parent_imp /= Void) then
				C.gtk_pixmap_get (pix_imp.c_object, $pixdata, $mask)
				pixmap_pointer := C.gtk_pixmap_new (pixdata, mask)
				C.gtk_widget_show (pixmap_pointer)
				C.c_gtk_clist_set_pixtext (
					parent_imp.list_widget,
					index - 1,
					column - 1,
					pixmap_pointer,
					$a
				)
			elseif parent_imp /= Void then
				C.c_gtk_clist_set_pixtext (
					parent_imp.list_widget,
					index - 1,
					column - 1,
					default_pointer,
					$a
				)
			end
			-- Update the `internal_text' and `internal_pixmaps' arrays.
			internal_pixmaps.go_i_th (column)
			internal_pixmaps.put (pix_imp)
		end

	unset_cell_pixmap (column: INTEGER) is
			-- Unsets pixmap of the given column of `Current'. 
		do
			C.c_gtk_clist_unset_pixmap (
				parent_imp.list_widget,
				index - 1,
				column - 1
			)
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'.
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		do
			--| FIXME IEK External expects integers for colors
			--C.c_gtk_clist_set_bg_color
			--		(parent_imp.list_widget,
			-- index - 1, color.red, color.green, color.blue)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'.
			-- Currently, on windows, we can only set the color
			-- for the whole mclist and not for each row.
			-- Therefore, this feature is not available to the client, yet.
		do
			--| FIXME IEK External expects integers for colors
			--C.c_gtk_clist_set_fg_color
			--	(parent_imp.list_widget,
			--	index - 1, color.red, color.green, color.blue)
		end

feature {EV_ANY_I} -- Implementation

	index: INTEGER is
			-- Index of the row in the list
			-- (starting from 1).
		do
			-- The `ev_children' array has to contain
			-- the same rows in the same order than in the gtk
			-- part.
			Result := parent_imp.ev_children.index_of (Current, 1)
		end

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end	

	interface: EV_MULTI_COLUMN_LIST_ROW

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
		-- Multi-column list that own the current object 

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.32  2000/03/03 00:12:53  king
--| Changed set_selected to enable/disable_select
--|
--| Revision 1.31  2000/03/02 21:56:35  king
--| Removed redundant command association commands
--|
--| Revision 1.30  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.29  2000/02/19 00:35:29  oconnor
--| removed old command stuff
--|
--| Revision 1.28  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.27  2000/02/17 21:47:20  king
--| Added check for parent in set_cell_*
--|
--| Revision 1.26  2000/02/16 23:00:51  king
--| Removed redundant features
--|
--| Revision 1.25  2000/02/16 20:23:46  king
--| Corrected inheritence, add C feature
--|
--| Revision 1.24  2000/02/15 19:21:50  king
--| Made compilable
--|
--| Revision 1.23  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.3  2000/02/02 23:43:27  king
--| Removed definition of parent_imp
--|
--| Revision 1.22.6.2  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
