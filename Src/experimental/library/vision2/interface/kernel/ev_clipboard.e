note
	description: "Objects that allow access to the OS clipboard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD

inherit
	EV_ANY
		redefine
			implementation
		end

create
	{EV_APPLICATION_I}
		default_create

feature -- Access

	has_text: BOOLEAN
			-- Does the clipboard currently contain text?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_text
		end

	text: STRING_32
			-- `Result' is text of clipboard.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text
		ensure
			Result_not_void: Result /= Void
			cloned: Result /= implementation.text
		end

feature -- Status setting

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to clipboard.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.set_text (a_text)
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

	remove_text
			-- Make `text' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_removed: text.is_empty
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_CLIPBOARD_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CLIPBOARD_IMP} implementation.make
		end

invariant
	not_has_text_implies_text_empty: not has_text implies text.is_empty

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_CLIPBOARD









