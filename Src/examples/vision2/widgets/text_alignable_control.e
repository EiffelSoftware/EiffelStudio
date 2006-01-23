indexing
	description: "Controls used to modify objects of type EV_TEXT_ALIGNABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_ALIGNABLE_CONTROL

inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; text_alignable: EV_TEXT_ALIGNABLE; output: EV_TEXT) is
			-- Create controls to manipulate `text_alignable', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("EV_TEXT_ALIGNABLE")
			create vertical_box
			extend (vertical_box)
			create button.make_with_text ("Align text left")
			button.select_actions.extend (agent text_alignable.align_text_left)
			vertical_box.extend (button)
			create button.make_with_text ("Align text center")
			button.select_actions.extend (agent text_alignable.align_text_center)
			vertical_box.extend (button)
			create button.make_with_text ("Align text right")
			button.select_actions.extend (agent text_alignable.align_text_right)
			vertical_box.extend (button)
			box.extend (Current)
		end

feature {NONE} -- Implementation

		-- Widgets used to build controls.
	vertical_box: EV_VERTICAL_BOX
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


end -- class TEXTABLE_CONTROL

