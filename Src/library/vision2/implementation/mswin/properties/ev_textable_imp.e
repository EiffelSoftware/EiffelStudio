indexing
	description: 
		"Eiffel Vision textable. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
	
feature -- Access

	text: STRING is
			-- Text displayed in `Current'.
		do
			if text_length > 0 then
				Result := wel_text
			end
		end

	alignment: EV_TEXT_ALIGNMENT is
			-- Alignment of `text' on `Current'.
		do
			inspect text_alignment
				when text_alignment_left then 
					create Result.make_with_left_alignment
				when text_alignment_right then
					create Result.make_with_right_alignment
				when text_alignment_center then
					create Result.make_with_center_alignment
				end
		end

	text_alignment: INTEGER
			-- Current text alignment. Possible value are
			--	* Text_alignment_left
			--	* Text_alignment_right
			--	* Text_alignment_center

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			wel_set_text (create {STRING}.make (0))
		end

	align_text_center is
			-- Display `text' centered.
		do
			text_alignment := text_alignment_center
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			text_alignment := text_alignment_right
		end
        
	align_text_left is
			-- Display `text' left aligned.
		do
			text_alignment := text_alignment_left 	
		end

feature {NONE} -- Implementation

	Text_alignment_left: INTEGER is 0
			-- Left aligned text.

	Text_alignment_right: INTEGER is 1
			-- Right aligned text.

	Text_alignment_center: INTEGER is 2
			-- Centered text.

	wel_set_text (a_text: STRING) is
			-- Set `a_text' in WEL object.
		deferred
		end

	wel_text: STRING is
			-- Text from WEL object.
		deferred
		ensure
			not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Length of text
		deferred
		ensure
			positive_length: Result >= 0
		end

	line_count: INTEGER is
			-- Number of lines required by `text'.
		do
			if text /= Void then
				Result := text.occurrences ('%N') + 1
			end
		ensure
			non_negative: Result >= 0
		end

feature -- Obsolete

	set_default_minimum_size is
			-- Set to the size of the text.
		obsolete
			"Implement using {EV_FONT_IMP}.text_metrics."
		do
			check
				inapplicable: False
			end
		end

end -- class EV_TEXTABLE_IMP

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

