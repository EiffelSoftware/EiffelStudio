indexing	
	description:
		"[
			Item for use in EV_MENU.

			Note:
			Single ampersands in text are not shown in the actual
			widget. If you need an ampersand in your text,
			use && instead. The character following the & may
			be a shortcut to this widget (combined with Alt)
			&File -> File (Alt+F = shortcut)
			Fish && Chips -> Fish & Chips (no shortcut).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		(a_text: STRING; an_action: PROCEDURE [ANY, TUPLE]) is
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
		
feature -- Obsolete

	align_text_left is
			-- Display text left aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end
	
	align_text_center is
			-- Display text center aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end
		
	align_text_right is
			-- Display text right aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and Precursor {EV_TEXTABLE} and
				Precursor {EV_SENSITIVE}
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_ITEM_I	
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_ITEM_IMP} implementation.make (Current)
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




end -- class EV_MENU_ITEM

