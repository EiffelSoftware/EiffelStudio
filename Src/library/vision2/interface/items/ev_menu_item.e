indexing	
	description:
		"Item for use in EV_MENU."
	note:
		"Single ampersands in text are not shown in the actual%N%
		%widget. If you need an ampersand in your text,%N%
		%use && instead. The character following the & may%N%
		%be a shortcut to this widget (combined with Alt)%N%
		%&File -> File (Alt+F = shortcut)%N%
		%Fish && Chips -> Fish & Chips (no shortcut)."
	status: "See notice at end of class"
	keywords: "menu, item, dropdown, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_ITEM

inherit
	EV_ITEM
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_TEXTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_SENSITIVE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_MENU_ITEM_ACTION_SEQUENCES
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

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and Precursor {EV_TEXTABLE} and
				Precursor {EV_SENSITIVE}
		end
		
feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_I	
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_MENU_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

