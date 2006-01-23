indexing
	description: 
	"MC_LIST_DEMO_WINDOW, demo window to test the multi%
	% column list widget. Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
create
	make

feature -- Access

	main_widget: EV_MULTI_COLUMN_LIST is
			-- The main widget of the demo
		once
			create Result.make_with_text (Current, <<"colonne 1",
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
			create row.make_with_text (main_widget, <<"This", "is", "a", "row", "item">>)
			row.set_selected (True)
			main_widget.clear_items
			--row.set_selected (True)
			create row.make (main_widget)
			row.set_text (<<"This", "is", "a", "row", "item">>)
			row.set_selected (True)
			create row.make_with_text (main_widget, <<"This", "is", "a", "row", "item">>)
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


end -- EV_MC_LIST_DEMO_WINDOW

