indexing
	description: "Objects that may have their text aligned to the%
		%left, center or right."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_ALIGNABLE


inherit
	EV_TEXTABLE
		redefine
			implementation
		end
	
feature -- Access

	text_alignment: INTEGER is
			-- Current alignment.
			-- See class EV_TEXT_ALIGNABLE_CONSTANTS for
			-- possible values.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_alignment
		ensure
			bridge_ok: Result = implementation.text_alignment
		end

feature -- Status report

	is_left_aligned: BOOLEAN is
			-- Is `Current' left aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		end
		
	is_center_aligned: BOOLEAN is
			-- Is `Current' center aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
		end

	is_right_aligned: BOOLEAN is
			-- Is `Current' right aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
		end

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_center
		ensure
			alignment_set: is_center_aligned
		end

	align_text_right is
			-- Display `text' right aligned.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_right
		ensure
			alignment_set: is_right_aligned
		end
        
	align_text_left is
			-- Display `text' left aligned.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_left
		ensure
			alignment_set: is_left_aligned
		end

feature {NONE} -- Implementation

	implementation: EV_TEXT_ALIGNABLE_I
	
invariant

	valid_alignment: (create {EV_TEXT_ALIGNMENT_CONSTANTS}).valid_alignment (text_alignment)

end -- class EV_TEXT_ALIGNABLE

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


