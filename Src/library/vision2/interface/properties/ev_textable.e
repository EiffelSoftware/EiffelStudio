indexing
	description:
		"Abstraction for objects that have a text label."
	status: "See notice at end of class"
	keywords: "text, label, font, name, property"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE

inherit
	EV_ANY
		redefine
			is_in_default_state,
			implementation
		end

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			default_create
			set_text (a_text)
		ensure
			text_assigned: text.is_equal (a_text) and text /= a_text
		end
		
feature -- Access

	text: STRING is
			-- Text displayed in textable.
		require
			not_destroyed: not is_destroyed
		do
			Result:= implementation.text
		ensure
			bridge_ok: equal (Result, implementation.text)
			not_void_implies_cloned: Result /= Void implies
				Result /= implementation.text
		end

	alignment: EV_TEXT_ALIGNMENT is
			-- Current text positioning.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.alignment
		ensure
			alignment_not_void: Result /= Void
		end

feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_center
		ensure
			alignment_set: alignment.is_center_aligned
		end

	align_text_right is
			-- Display `text' right aligned.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_right
		ensure
			alignment_set: alignment.is_right_aligned
		end
        
	align_text_left is
			-- Display `text' left aligned.
		require
			not_destroyed: not is_destroyed
		do
			implementation.align_text_left
		ensure
			alignment_set: alignment.is_left_aligned
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			implementation.set_text (a_text)
		ensure
			text_cloned: text.is_equal (a_text) and then text /= a_text
		end

	remove_text is
			-- Make `text' `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_text
		ensure
			text_removed: text = Void
		end
		
feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and text = Void
		end

	cycle_alignment is
			-- Set another alignment.
		do
			if alignment.is_left_aligned then
				align_text_center
			elseif alignment.is_center_aligned then
				align_text_right
			elseif alignment.is_right_aligned then
				align_text_left
			end
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TEXTABLE_I
			-- Responsible for interaction with native graphics toolkit.
			
invariant
	text_not_void_implies_text_not_empty:
		is_usable and text /= Void implies text.count > 0

end -- class EV_TEXTABLE

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

