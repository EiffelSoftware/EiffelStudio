indexing

	description: 
	"EiffelVision text component. Common ancestor for text classes like% 
	%text field and text area."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	
	EV_TEXT_COMPONENT

inherit

	EV_PRIMITIVE
		redefine
			implementation
		end
	
	EV_BAR_ITEM
	
	
feature -- Access

        text: STRING is
                        -- Text in component
                require
                        exists: not destroyed
                do
                        Result:= implementation.text
                end 
	
feature -- Status setting
	
	set_text (txt: STRING) is
			-- set text in component to 'txt'
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into component
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
			implementation.append_text (txt)
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
			implementation.prepend_text (txt)
		ensure
			text_prepended: 
		end
	
	set_position (pos: INTEGER) is
			-- set current insertion position
		require
			exist: not destroyed			
			valid_pos: pos > 0 and pos <= text.count
		do
			implementation.set_position (pos)
		end
	
	set_maximum_line_lenght (len: INTEGER) is
			-- Maximum number of charachters on line
			-- If len < text.cout then the text is truncated
		require
			exist: not destroyed			
		do
			implementation.set_maximum_line_lenght (len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		require
			exist: not destroyed
			valid_start: start_pos > 0 and start_pos <= text.count
			valid_end: end_pos > 0 and end_pos <= text.count
		do
			implementation.select_region (start_pos, end_pos)
		ensure
			-- region selected
		end
	
feature {NONE} -- Implementation

	implementation: EV_TEXT_COMPONENT_I
			-- Implementation
			
end -- class EV_TEXT_COMPONENT

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

