indexing
	description: 
		"TEXT_FIELD_DEMO_WINDOW, demo window to test%
		% text_field widget. Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	TEXT_FIELD_DEMO_WINDOW

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

	main_widget: EV_VERTICAL_BOX is
			-- The main widget of the demo
		once
			create Result.make (Current)
		end

	TextField: EV_TEXT_FIELD
			-- A text field in the demo

	PasswordField: EV_PASSWORD_FIELD
			-- A password field

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			frame: EV_FRAME
		do
			create frame.make_with_text (main_widget, "A Text Field")
			create textfield.make_with_text (frame, "Edit me")
			create frame.make_with_text (main_widget, "A Password Field")
			create passwordfield.make_with_text (frame, "Me too")
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Text field demo")
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


end -- class TEXT_FIELD_DEMO_WINDOW

