indexing
	description: "Controls used to modify objects of type EV_SELECTABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTABLE_CONTROL

inherit
	EV_FRAME

create
	make
	
feature {NONE} -- Initialization

	make (box: EV_BOX; selectable: EV_SELECTABLE; output: EV_TEXT) is
			-- Create controls to manipulate `selectable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_SELECTABLE")	
			create button.make_with_text ("Enable_select")
			extend (button)
			button.select_actions.extend (agent selectable.enable_select)
			button.select_actions.extend (agent button.disable_sensitive)
			box.extend (Current)
		end
	
feature {NONE} -- Implementation

		-- Widget used to create controls.
	button: EV_BUTTON;

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


end -- class SELECTABLE_CONTROL

