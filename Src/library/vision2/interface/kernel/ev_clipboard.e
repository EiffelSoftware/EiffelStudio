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
			cloned: Result /= implementation.text
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

