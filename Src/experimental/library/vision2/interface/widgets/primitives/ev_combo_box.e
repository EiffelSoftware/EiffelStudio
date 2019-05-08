note
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
			is_in_default_state
		end

	EV_COMBO_BOX_ACTION_SEQUENCES

create
	default_create,
	make_with_strings,
	make_with_text

feature -- Status report

	is_list_shown: BOOLEAN
			-- Is drop down list currently shown?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_list_shown
		end

feature -- Access

	list_height_hint: INTEGER
			-- Suggested height of list in pixels which may or may not be used by the underlying platform.
			-- By default it is -1 and the actual height is dependent on the underlying platform.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.list_height_hint
		ensure
			bridge_ok: Result = implementation.list_height_hint
		end

	list_width_hint: INTEGER
			-- Suggested width of list in pixels which may or may not be used by the underlying platform.
			-- By default it is -1 and the actual width is dependent on the underlying platform.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.list_width_hint
		ensure
			bridge_ok: Result = implementation.list_height_hint
		end

feature -- Settings

	set_list_height_hint (v: like list_height_hint)
			-- Set `list_height_hint' with `v'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_list_height_hint (v)
		ensure
			list_height_hint_set: list_height_hint = v
		end

	set_list_width_hint (v: like list_width_hint)
			-- Set `list_width_hint' with `v'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_list_width_hint (v)
		ensure
			list_width_hint_set: list_width_hint = v
		end


feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
			valid_text: not is_editable implies strings.has (a_text.as_string_32)
		local
			l_cursor: like cursor
			l_str: STRING_32
			l_found: BOOLEAN
		do
			if is_editable then
				set_editable_text (a_text)
			end

			-- Update items selection.
			-- In this way, we can make Windows and GTK implementations consistent. See bug#12683.
			-- Default selection of GTK combo box is Void. But default selection of Windows combo box is the first item.
			-- This behavior is what client programmers expected.
			from
				l_cursor := cursor
				start
			until
				after or l_found
			loop
				l_str := item.text
				if l_str /= Void and then l_str.is_equal (a_text.as_string_32) then
					if is_sensitive then
						item.enable_select
					else
						enable_sensitive
						item.enable_select
						disable_sensitive
					end
					l_found := True
				end
				forth
			end
			go_to (l_cursor)
		ensure
			text_set: check_text_modification ({STRING_32} "", a_text.as_string_32)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TEXT_FIELD} and Precursor {EV_LIST_ITEM_LIST}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_COMBO_BOX_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_COMBO_BOX_IMP} implementation.make
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
