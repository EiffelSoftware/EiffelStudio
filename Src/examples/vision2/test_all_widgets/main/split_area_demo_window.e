indexing
	description: 
		"SPLIT_AREA_DEMO_WINDOW, demo window to test split_area%
		% widget. Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	SPLIT_AREA_DEMO_WINDOW

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

	main_widget: EV_VERTICAL_SPLIT_AREA is
			-- The main widget of the demo
		once
			create Result.make (Current)
		end
	
	
	h: EV_HORIZONTAL_SPLIT_AREA
		-- A split area for the demo

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			button: EV_BUTTON
			texta: EV_TEXT
		do
			-- The first child of the vertical split area
			-- is a horizontal split area
			create h.make (main_widget)
			-- The first child of the horizontal split
			-- area is a button
			create button.make_with_text (h, "Hello")
			-- There is no second child for the horizontal
			-- split area (this is acceptable)
			
			-- The second child of the vertical split area
			-- is a text area
			create texta.make (main_widget)
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Split area demo")
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


end -- class SPLIT_AREA_DEMO_WINDOW

