indexing

	description: 
	"main window button for the application. Belongs to EiffelVision example."
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
			a: EV_ARGUMENT1 [MAIN_WINDOW]
		do
			make (main_w.container)

			set_text (button_name)
			if pixmap_file_name /= Void and then not pixmap_file_name.empty then
				!! p.make_from_file (Current, pixmap_file_name)
			end
			demo_window := cmd
			demo_window.set_effective_button (Current)
			!! a.make (main_w)
			add_toggle_command (Current, a)
		end

feature -- Access

	demo_window: DEMO_WINDOW

feature -- Command

	execute (argument: EV_ARGUMENT1[MAIN_WINDOW]) is
		local
			temp_dem: DEMO_WINDOW
		do
			if state then
				demo_window.activate (argument.first)
			end
		end

end

	
