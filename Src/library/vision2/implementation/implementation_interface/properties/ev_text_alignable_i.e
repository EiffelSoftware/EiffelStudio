indexing
	description: "Eiffel Vision2 text alignable.%
		%Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_ALIGNABLE_I

inherit
	EV_TEXTABLE_I
	
feature -- Access

	text_alignment: INTEGER is
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
		
feature {NONE} -- Implementation

	default_alignment: INTEGER is
			-- Default alignment used during
			-- creation of real implementation
			-- Center alignment by default as this is the most
			-- common. Descendents need to redefine this if their
			-- default alignment is different.
		do
			Result := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center 
		end
		
end -- class EV_TEXT_ALIGNABLE_I

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


