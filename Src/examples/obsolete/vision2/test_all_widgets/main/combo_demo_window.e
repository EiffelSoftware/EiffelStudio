indexing
	description: 
		"COMBO_DEMO_WINDOW, demo window to test combo widget.%
		% Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	COMBO_DEMO_WINDOW

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

	main_widget: EV_COMBO_BOX is
			-- The main widget of the demo
		once
			create Result.make (Current)
		end

	item1, item2, item3: EV_LIST_ITEM
			-- Items to add in the combo-box

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			create item1.make_with_text (main_widget, "item1")
			create item2.make_with_text (main_widget, "item2")
			create item3.make_with_text (main_widget, "item3")
			main_widget.set_text ("edit me")
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Combo box demo")
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


end -- class COMBO_DEMO_WINDOW

