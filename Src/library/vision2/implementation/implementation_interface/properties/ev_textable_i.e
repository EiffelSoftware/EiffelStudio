indexing
	description: 
		"EiffelVision textable. Implementation interface."
	status: "See notice at end of class"
	keywords: "text, label, font, name, property"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	text: STRING is
			-- Text displayed in label.
		deferred
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		deferred
		ensure
			text_assigned: text.is_equal (a_text)
		end

feature {NONE} -- Implementation

	interface: EV_TEXTABLE
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_TEXTABLE_I

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

