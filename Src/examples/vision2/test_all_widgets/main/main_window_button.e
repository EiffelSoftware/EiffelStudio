indexing
	description: 
		"Main window button for the application.%
		% Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW_BUTTON
	
inherit
	EV_TOGGLE_BUTTON

	EV_COMMAND

creation
	make_button
	
feature {NONE} --Initialization
	
	make_button (main_w: MAIN_WINDOW; button_name, pixmap_file_name: STRING; cmd: DEMO_WINDOW) is
		local
			p: EV_PIXMAP
			arg: EV_ARGUMENT1 [MAIN_WINDOW]
		do
			make (main_w.container)

			set_text (button_name)
			if pixmap_file_name /= Void and then not pixmap_file_name.empty then
--				!! p.make_from_file (Current, pixmap_file_name)
			end
			demo_window := cmd
			demo_window.set_effective_button (Current)
			!! arg.make (main_w)
			add_toggle_command (Current, arg)
		end

feature -- Access

	demo_window: DEMO_WINDOW
			-- Demo window launch by the button

feature -- Command execution

	execute (arg: EV_ARGUMENT1[MAIN_WINDOW]; data: EV_EVENT_DATA) is
			-- Executed when the button is pressed.
		do
			if state then
				demo_window.activate (arg.first)
			end
		end

end -- class MAIN_WINDOW_BUTTON

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

