indexing

	description: 
		"EiffelVision text container, gtk implementation"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_CONTAINER_IMP
	
inherit
	EV_TEXT_CONTAINER_I
	
	EV_PRIMITIVE_IMP

feature -- Access

--	text: STRING is -- defined in WEL_WINDOW (WEL_PUSH_BUTTON)
	
feature -- Status setting

        set_center_alignment is
                        -- Set text alignment of current label to center.
                do
                        check
                                not_yet_implemented: False
                        end
                end

        set_right_alignment is
                -- Set text alignment of current label to right.
                do
			check
                                not_yet_implemented: False
                        end
		end

        set_left_alignment is
                        -- Set text alignment of current label to left.
                do
		        check
                                not_yet_implemented: False
                        end
                end
	
feature -- Element change	
	
	--set_text (a_text: STRING) is  -- defined in WEL_WINDOW (WEL_PUSH_BUTTON)
			-- Set current button text to `a_text'.
	
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
