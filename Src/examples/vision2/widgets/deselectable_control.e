indexing
		description: "Controls used to modify objects of type EV_DESELECTABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DESELECTABLE_CONTROL

inherit
	EV_FRAME

create
	make
	
feature {NONE} -- Initialization

	make (box: EV_BOX; deselectable: EV_DESELECTABLE; output: EV_TEXT) is
			-- Create controls to manipulate `deselctable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_DESELECTABLE")
			create vertical_box
			extend (vertical_box)
			create button.make_with_text ("Enable_select")
			create button1.make_with_text ("Disable select")
			vertical_box.extend (button)
			vertical_box.extend (button1)
			if deselectable.is_selected then
				button.disable_sensitive
				button1.enable_sensitive
			else
				button1.disable_sensitive
				button.disable_sensitive
			end
			button.select_actions.extend (agent deselectable.enable_select)
			button.select_actions.extend (agent button.disable_sensitive)
			button.select_actions.extend (agent button1.enable_sensitive)
			button1.select_actions.extend (agent deselectable.disable_select)
			button1.select_actions.extend (agent button1.disable_sensitive)
			button1.select_actions.extend (agent button.enable_sensitive)
			box.extend (Current)
		end
		
feature {NONE} -- Implementation

		-- Widgets used to make controls.
	vertical_box: EV_VERTICAL_BOX
	button1, button: EV_BUTTON;
	
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


end -- class DESELECTABLE_CONTROL

