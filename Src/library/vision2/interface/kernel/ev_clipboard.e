indexing
	description: "Objects that allow access to the OS clipboard."
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

	text: STRING is
			-- `Result' is text of clipboard.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			implementation.set_text (a_text)
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

	remove_text is
			-- Make `text' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_removed: text.is_empty
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_CLIPBOARD_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_CLIPBOARD_IMP} implementation.make (Current)
		end

end -- class EV_CLIPBOARD

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

