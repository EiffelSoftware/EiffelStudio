note
	description: 
		"TEXT_AREA_DEMO_WINDOW, demo window to test multi line%
		% text area widget. Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	TEXT_AREA_DEMO_WINDOW

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

	main_widget: EV_TEXT
			-- The main widget of the demo
		once
			create Result.make (Current)
		end
	

feature -- Status setting
	
	set_widgets
			-- Set the widgets in the demo windows.
		do
		end
	
	set_values
			-- Set the values on the widgets of the window.
		do
			set_title ("Text area demo")
			main_widget.append_text ("edit me")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEXT_AREA_DEMO_WINDOW

