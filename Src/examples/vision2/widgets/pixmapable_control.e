indexing
	description: "Controls used to modify objects of type EV_PIXMAPABLE"
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAPABLE_CONTROL

inherit
	EV_FRAME

create
	make
	
feature {NONE} -- Initialization

	make (box: EV_BOX; pixmapable: EV_PIXMAPABLE; output: EV_TEXT) is
			-- Create controls to manipulate `pixmapable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_PIXMAPABLE")
			create vertical_box
			extend (vertical_box)
			create pixmap
			pixmap.set_with_named_file ("eiffel_wizard.bmp")
			create button.make_with_text ("Set_pixmap")
			create button1.make_with_text ("Remove_pixmap")
			button.select_actions.extend (agent pixmapable.set_pixmap (pixmap))
			button.select_actions.extend (agent button.disable_sensitive)
			button.select_actions.extend (agent button1.enable_sensitive)
			vertical_box.extend (button)
			button1.select_actions.extend (agent pixmapable.remove_pixmap)
			button1.select_actions.extend (agent button1.disable_sensitive)
			button1.select_actions.extend (agent button.enable_sensitive)
			vertical_box.extend (button1)
			box.extend (Current)
		end
	

feature {NONE} -- Implementation

		-- Widgets used to create controls.
	vertical_box: EV_VERTICAL_BOX
	button, button1: EV_BUTTON
	pixmap: EV_PIXMAP

end -- class PIXMAPABLE_CONTROL
