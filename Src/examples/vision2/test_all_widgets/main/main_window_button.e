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
	
	EV_BUTTON
	
creation
	
	make_button
	
feature {NONE} --Initialization
	
	make_button (main_w: MAIN_WINDOW; button_name, pixmap_file_name: STRING; cmd: DEMO_WINDOW) is
		local
			p: EV_PIXMAP
			a: EV_ARGUMENT1[MAIN_WINDOW]
		do
			make (main_w.container)

			set_text (button_name)
			if pixmap_file_name /= Void and then not pixmap_file_name.empty then
				!! p.make_from_file (pixmap_container, pixmap_file_name)
			end
			!!a.make (main_w)
			add_click_command (cmd, a)
		end
	
end

	
