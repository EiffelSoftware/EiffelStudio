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
			is_initialized := True
		end

feature -- Status report
	
	--destroyed: BOOLEAN is
			-- Is Current object destroyed?  
	--	do
	--		Result := (internal_text = Void) and (internal_pixmaps = void)
	--	end

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

	update is
		do
		end

	destroy is
			-- Destroy actual object.
		local
		do
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

feature -- PND

enable_transport is do check to_be_implemented: False end end

disable_transport is do check to_be_implemented: False end end

draw_rubber_band is do check to_be_implemented: False end end

erase_rubber_band is do check to_be_implemented: False end end

enable_capture is do check to_be_implemented: False end end

disable_capture is do check to_be_implemented: False end end

start_transport (
        a_x, a_y, a_button: INTEGER;
        a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        a_screen_x, a_screen_y: INTEGER) is 
do check to_be_implemented: False end  end

end_transport (a_x, a_y, a_button: INTEGER) is do end

pointed_target: EV_PICK_AND_DROPABLE is do check to_be_implemented: False end end

set_pointer_style (curs: EV_CURSOR) is do end

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

			if column = 1 then
				pix_imp ?= pixmap.implementation
			end

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
		end

	set_pixmap (a_pix: EV_PIXMAP) is
		do
			set_cell_pixmap (1, a_pix)
			pixmap := a_pix
		end

	pixmap: EV_PIXMAP

	remove_pixmap is
		do
			unset_cell_pixmap (1)
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
			txt := interface.i_th (column)
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

feature {EV_ANY_I} -- Implementation

	set_parent_imp (par_imp: EV_MULTI_COLUMN_LIST_IMP) is
		do
			parent_imp := par_imp
		end
	
	parent_imp: EV_MULTI_COLUMN_LIST_IMP

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
--| Revision 1.38  2000/03/23 19:16:59  king
--| Made compilable with new row structure
--|
--| Revision 1.37  2000/03/17 23:23:45  king
--| Added set_pointer_style as it doesnt inherit from widget
--|
--| Revision 1.36  2000/03/15 22:43:09  king
--| check falsed PND features
--|
--| Revision 1.35  2000/03/09 01:16:37  king
--| Added unimplemented pick and drop features
--|
--| Revision 1.34  2000/03/04 00:23:46  king
--| Commented out redundant color features
--|
--| Revision 1.33  2000/03/03 18:17:43  king
--| Fixed bug in set_columns
--|
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
