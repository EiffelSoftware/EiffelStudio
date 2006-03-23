indexing
	description:
		"[
			A text field with a button. When the button is pressed, a list of
			text strings is displayed. Selecting one causes it to be copied into
			the text field.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+-----------+-+
			|  text     |V|
			+-----------+-+
			 | first      |
			 | ...        |
			 | last       |
			 +------------+
		]"
	status: "See notice at end of class."
	keywords: "combo, box, button, option, menu"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX

inherit
	EV_TEXT_FIELD
		rename
			set_text as set_editable_text
		export
			{NONE} set_editable_text
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state,
			create_implementation
		end

	EV_LIST_ITEM_LIST
		redefine
			implementation,
			is_in_default_state,
			create_implementation
		end

	EV_COMBO_BOX_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

create
	default_create,
	make_with_strings,
	make_with_text

feature -- Status report

	is_list_shown: BOOLEAN is
			-- Is drop down list currently shown?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_list_shown
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
			combo_box_is_editable: is_editable
		do
			set_editable_text (a_text)
		ensure
			text_set: check_text_modification ("", a_text)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TEXT_FIELD} and Precursor {EV_LIST_ITEM_LIST}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_COMBO_BOX_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COMBO_BOX_IMP} implementation.make (Current)
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




end -- class EV_COMBO_BOX

