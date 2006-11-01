indexing
	description: 
		"Main window button for the application.%
		% Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW_BUTTON
	
inherit
	EV_TOGGLE_BUTTON

	EV_COMMAND

create
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
			create arg.make (main_w)
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


end -- class MAIN_WINDOW_BUTTON

