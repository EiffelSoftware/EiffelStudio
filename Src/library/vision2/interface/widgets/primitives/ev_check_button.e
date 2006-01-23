indexing
	description:
		"[
			Toggle button with state displayed as a check box.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			--------------
			|[X]  text   |
			==============
		]"
	status: "See notice at end of class."
	keywords: "toggle, check, tick, button, box"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_CHECK_BUTTON

inherit
	EV_TOGGLE_BUTTON
		redefine 
			implementation,
			create_implementation
		end

create
	default_create,
	make_with_text

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_CHECK_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			Create {EV_CHECK_BUTTON_IMP} implementation.make (Current)
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




end -- class EV_CHECK_BUTTON

