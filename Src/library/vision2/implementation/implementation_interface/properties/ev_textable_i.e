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

	alignment: EV_TEXT_ALIGNMENT is
			-- Current text positioning.
		deferred
		end

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		deferred
		end

	align_text_left is
			-- Display `text' left aligned.
		deferred
		end

	align_text_right is
			-- Display `text' right aligned.
		deferred
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		deferred
		ensure
			text_assigned: text.is_equal (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		deferred
		ensure
			text_removed: text = Void
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

