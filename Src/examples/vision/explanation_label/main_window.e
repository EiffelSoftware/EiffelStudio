indexing
	description: "Main window of the example"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class MAIN_WINDOW
	
inherit 
	BASE
		rename
			make as base_make,
			realize as base_realize
		end
		
	BASE
		redefine
			make,
			realize
		select
			make,
			realize
		end

	TOOLTIP_INITIALIZER
		-- Inherits from TOOLTIP_INITIALIZER to be able to show tooltips for focusable widgets 
		-- only composite widget can inherit from TOOLTIP_INITIALIZER.
		
	COMMAND

create
	make

feature

	make (a_name: STRING; a_s: SCREEN) is
		do
				--initialize as make
			base_make (a_name, a_s)
				--initialize as tooltip_initializer
			tooltip_initialize (Current)

			create row_col.make ("Row_column", Current)

			create push1.make ("Show", row_col)
				--set explanation text for this focusable
			push1.set_focus_string ("Show second demo window")
			push1.add_activate_action (Current, ShowSecond)

			create push2.make ("Hide", row_col)
				--set explanation text for this focusable
			push2.set_focus_string ("Hide second demo window")
			push2.add_activate_action (Current, HideSecond)
			
		end
	
	realize is
		do
			if not(realized) then
					--realize as base
				base_realize
					--realize as tooltip
				tooltip_realize
			end
		end

	execute (arg: ANY) is
		do
			if not (second_window.realized) then
				second_window.realize
			end
			if arg = HideSecond then
				second_window.hide
			else
				second_window.show
			end
		end

	second_window: MY_TOP is
			-- Another window of the demo
		once
			create Result.make ("Second window", screen)
		end;

	row_col: ROW_COLUMN
	
	push1, push2: FOCUSABLE_B
		-- focusable buttons

	ShowSecond, HideSecond: INTEGER is unique;
		
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


end -- class MAIN_WINDOW


