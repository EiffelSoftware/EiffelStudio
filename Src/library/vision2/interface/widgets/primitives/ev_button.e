indexing
	description:
		"Push button widget that displays text and/or a pixmap.%N%
		%(Also base class for other button widgets)"
	appearance:
		" ------------ %N%
		%|   `text'   |%N%
		% ============"
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_BUTTON

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_PIXMAPABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_BUTTON_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action
	
feature {NONE} -- Initialization
	
	make_with_text_and_action
		(a_text: STRING; an_action: PROCEDURE [ANY, TUPLE []]) is
			-- Create with 'a_text' and `an_action' in `select_actions'.
		require
			text_not_void: a_text /= Void
			an_action_not_void: an_action /= Void
		do
			default_create
			set_text (a_text)
			select_actions.extend (an_action)
		ensure
			text_assigned: text.is_equal (a_text)
			select_actions_has_an_action: select_actions.has (an_action)
		end
	
feature {EV_DIALOG_I, EV_WINDOW} -- Default push button handling

	is_default_push_button: BOOLEAN is
			-- Is this button currently a default push button 
			-- for a particular container?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_default_push_button
		end

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
		require
			not_destroyed: not is_destroyed
			is_not_default_push_button: not is_default_push_button
		do
			implementation.enable_default_push_button
		ensure
			is_default_push_button: is_default_push_button
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
		require
			not_destroyed: not is_destroyed
			is_default_push_button: is_default_push_button
		do
			implementation.disable_default_push_button
		ensure
			is_not_default_push_button: not is_default_push_button
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_TEXTABLE} and
				Precursor {EV_PIXMAPABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_BUTTON_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_BUTTON_IMP} implementation.make (Current)
		end

end -- class EV_BUTTON

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
