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
	
	destroyed: BOOLEAN is
		deferred
		end

feature -- Inapplicable

	set_default_size is
			-- Set to the size of the text
		do
		end

feature -- Element change	
	
	set_text (str: STRING) is
		do
	--		{WEL_WINDOW} Precursor (t)
			wel_set_text (str)
			set_default_size
		end

feature {NONE} -- Implementation : the wel values, are deferred here, but
			   -- they need to be define by the heir

	wel_set_text (str: STRING) is
		deferred
		end

end -- class EV_TEXT_CONTAINER_IMP

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
