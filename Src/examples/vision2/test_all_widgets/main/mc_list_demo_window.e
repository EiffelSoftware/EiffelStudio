indexing
	description: 
	"MC_LIST_DEMO_WINDOW, demo window to test the multi%
	% column list widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MC_LIST_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end
	
creation
	make

feature -- Access

	main_widget: EV_MULTI_COLUMN_LIST is
			-- The main widget of the demo
		once
			!! Result.make_with_text (Current, <<"colonne 1",
				"colonne 2", "colonne 3", "colonne 4",
				"colonne 5">>)
			Result.set_right_alignment (2)
			Result.set_center_alignment (3)
			Result.set_left_alignment (4)
			Result.set_minimum_size(400,200)
		end

feature -- Access

	row: EV_MULTI_COLUMN_LIST_ROW
		-- Item in the mc-list.

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			!! row.make_with_text (main_widget, <<"This", "is", "a", "row", "item">>)
			row.set_selected (True)
			main_widget.clear_items
			--row.set_selected (True)
			!! row.make (main_widget)
			row.set_text (<<"This", "is", "a", "row", "item">>)
			row.set_selected (True)
			!! row.make_with_text (main_widget, <<"This", "is", "a", "row", "item">>)
			row.set_selected (True)
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		local
			cols: INTEGER
			tmpstr: STRING
		do
			cols := main_widget.columns
			tmpstr := cols.out
			tmpstr.append (" col MC List demo")
			set_title (tmpstr)
		end

end -- EV_MC_LIST_DEMO_WINDOW

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

