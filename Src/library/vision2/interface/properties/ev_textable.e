indexing
	description: 
		"EiffelVision text container. Common features for widgets%
		% that can contain text (label, button, menu item)."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a text container with, `par' as
			-- parent
		do
			make_with_text (par, "")
		end
	
	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Button with 'par' as parent and 'txt' as 
			-- text label
		deferred
		end

feature -- Access

	text: STRING is
			-- Text of current label
		require
			exists: not destroyed
		do
			Result:= implementation.text
		end 
	

feature -- Status setting

	set_center_alignment is
			-- Set text alignment of current label to center.
		require
			exists: not destroyed
		do
			implementation.set_center_alignment
		end

	set_right_alignment is
			-- Set text alignment of current label to right.
		require
			exists: not destroyed
		do
			implementation.set_right_alignment
		end
        
	set_left_alignment is
			-- Set text alignment of current label to left.
		require
			exists: not destroyed
		do
			implementation.set_left_alignment
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set text of current label to `txt'.
		require
			exists: not destroyed
			valid_text: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end

feature {NONE} -- Implementation

	implementation: EV_TEXTABLE_I
			-- Implementation of text container

end -- class EV_TEXTABLE

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
