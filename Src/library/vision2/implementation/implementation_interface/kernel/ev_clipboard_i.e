indexing
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CLIPBOARD_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	text: STRING is
		deferred
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		deferred
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CLIPBOARD
		-- Provides a common user interface to possibly dependent
		-- functionality implemented by `Current'.

end -- class EV_CLIPBOARD_I

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

