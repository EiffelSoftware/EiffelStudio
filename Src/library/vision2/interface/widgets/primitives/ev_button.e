indexing
	description:
		"[
			Push button widget that displays text and/or a pixmap.
			(Also base class for other button widgets)
		]"
	legal: "See notice at end of class."
	appearance:
		"[
 			--------------
			|    text    |
			==============
		]"
	status: "See notice at end of class."
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

	EV_TEXT_ALIGNABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_PIXMAPABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_FONTABLE
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
		(a_text: STRING_GENERAL; an_action: PROCEDURE [ANY, TUPLE]) is
			-- Create with 'a_text' as `text' and `an_action' in `select_actions'.
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
			-- Is `Current' a default push button for a container?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_default_push_button
		ensure
			bridge_ok: Result = implementation.is_default_push_button
		end

	enable_default_push_button is
			-- Enable style of `Current' corresponding
			-- to a default push button.
		require
			not_destroyed: not is_destroyed
			is_not_default_push_button: not is_default_push_button
		do
			implementation.enable_default_push_button
		ensure
			is_default_push_button: is_default_push_button
		end

	disable_default_push_button is
			-- Remove style of `Current' corresponding
			-- to a default push button.
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
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_TEXT_ALIGNABLE} and
				Precursor {EV_PIXMAPABLE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_BUTTON_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_BUTTON_IMP} implementation.make (Current)
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




end -- class EV_BUTTON

