indexing

	description: 
		"EiffelVision text container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_TEXT_CONTAINER_I

inherit
	EV_PRIMITIVE_I
	
	EV_FONTABLE_I
feature -- Access

        text: STRING is
                        -- Text of current label
                deferred
                end

feature -- Status setting

        set_center_alignment is
                        -- Set text alignment of current label to center.
                deferred
                end

        set_right_alignment is
                -- Set text alignment of current label to right.
                deferred
                end

        set_left_alignment is
                        -- Set text alignment of current label to left.
                deferred
                end


feature -- Element change

        set_text (a_text: STRING) is
                        -- Set text of current label to `a_text'.
                require
                        not_a_text_void: a_text /= Void
                deferred
                ensure
                        set: text.is_equal (a_text)
                end






end

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
