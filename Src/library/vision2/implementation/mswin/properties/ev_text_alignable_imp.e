indexing
	description: "Eiffel Vision2 text alignable. Ms Windows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_ALIGNABLE_IMP
	
inherit
	
	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP

feature

	alignment: INTEGER is
			-- Alignment of `text' on `Current'.
		do
			Result := text_alignment
		end

	text_alignment: INTEGER
			-- Current text alignment. Possible value are
			--	* Text_alignment_left
			--	* Text_alignment_right
			--	* Text_alignment_center
			
	align_text_center is
			-- Display `text' centered.
		do
			text_alignment := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			text_alignment := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			text_alignment := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		end

end -- class EV_TEXT_ALIGNABLE_IMP

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

