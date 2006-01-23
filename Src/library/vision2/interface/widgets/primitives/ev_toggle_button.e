indexing
	description: 
		"[
			Button that toggles between states each time it is pressed.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			-------------
			|   text    |
			-------------
		]"
	status: "See notice at end of class."
	keywords: "toggle, button"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_TOGGLE_BUTTON

inherit
	EV_BUTTON
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_DESELECTABLE
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_DESELECTABLE} and Precursor {EV_BUTTON}
		end

feature {EV_ANY, EV_ANY_I}

	implementation: EV_TOGGLE_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			Create {EV_TOGGLE_BUTTON_IMP} implementation.make (Current)
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




end -- class EV_TOGGLE_BUTTON

