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
		once
			!!Result.make_with_size (Current, 5)

			Result.set_column_title ("colonne 1", 1)
			Result.set_column_width (80, 1)
			Result.set_column_title ("colonne 2", 2)
			Result.set_column_width (80, 2) 
			Result.set_column_title ("colonne 3", 3)
			Result.set_column_width (80, 3)
			Result.set_column_title ("colonne 4", 4)
			Result.set_column_width (80, 4)
			Result.set_column_title ("colonne 5", 5)
			Result.set_column_width (80, 5)

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
	
feature -- Status setting
	
	set_values is
		local
			cols: INTEGER
			tmpstr: STRING
		do
			cols := main_widget.columns
			tmpstr := cols.out
			tmpstr.append (" col MC List demo")
			set_title (tmpstr)
		end


	set_commands is
		local
		do
		end
	
end -- EV_MULTI_COLUMN_LIST

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
