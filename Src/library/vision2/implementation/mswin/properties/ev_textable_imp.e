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
	
	EV_FONTABLE_IMP
	     
feature -- Access

	text: STRING is 
		do
			Result := wel_window.text
		end
		
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
	
	set_text (t: STRING) is
		do
			wel_window.set_text (t)
			set_default_size
		end
	
	wel_font: WEL_FONT is
		do
			Result := wel_window.font
		end

	wel_set_font (f:WEL_FONT) is
		do
			wel_window.set_font (f)
		end
	
feature -- Implementation
	
	set_default_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			set_minimum_width (fw.string_width (Current, text) + Extra_width)
			set_minimum_height (7 * fw.string_height (Current, text) // 4 - 2)
			set_size (minimum_width, minimum_height)
		end
	
	Extra_width: INTEGER is 10

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
