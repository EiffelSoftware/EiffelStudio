indexing

	description:
		"EiffelVision implementaiton of a Motif row_column.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	ROW_COLUMN_IMP

inherit

	ROW_COLUMN_I;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_ROW_COLUMN
		rename
			make as mel_rc_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_row_column: ROW_COLUMN; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif row_column.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_rc_make (a_row_column.identifier, mc, man);
		end;

feature -- Status report

	is_row_layout: BOOLEAN is
			-- Is current row column layout items preferably in row ?
		do
			Result := is_horizontal
		end; 

feature -- Status setting

	set_free_size is
			-- Set size of items to be free, in vertical layout mode
			-- only width is set to be the same as the widest one, in
			-- horizontal layout mode only height is set to be the same
			-- as the tallest one.
		do
			set_packing_tight
		end; 

	set_preferred_count (a_number: INTEGER) is
			-- Set preferably count of row or column, according to
			-- row layout mode or column layout mode, to `a_number'.
		do
			set_packing_column;
			set_num_columns (a_number)
		end;

	set_row_layout (flag: BOOLEAN) is
			-- Set row column to layout items preferably in row if `flag',
			-- in column otherwise.
		do
			if flag then
				set_horizontal
			else
				set_vertical
			end
		end; 

	set_same_size is
			-- Set width of items to be the same as the widest one
			-- and height as the tallest one.
		do
			set_packing_column
		end;

end -- class ROW_COLUMN_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

