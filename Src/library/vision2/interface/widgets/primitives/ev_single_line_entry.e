indexing

	description: 
	"EiffelVision single line entry. To query a single line of text from the user"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_SINGLE_LINE_ENTRY

inherit

	EV_ENTRY
		redefine
			make, implementation
		end
	
	EV_BAR_ITEM
	
creation
	
	make
	
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
                        -- Create a push button with, `par' as
                        -- parent
		do
			!EV_SINGLE_LINE_ENTRY_IMP!implementation.make (par)
			Precursor (par)
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
	
	set_text (txt: STRING) is
			-- set text entry to 'txt'
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
		ensure
			text_set: text.is_equal (txt)
		end
	
	set_text (txt: STRING) is
			-- set text entry to 'txt'
		require
			exist: not destroyed			
			not_void: txt /= Void		
		do
		ensure
                        text_set: text.is_equal (txt)
		end
	
	append_text (txt: STRING) is
			-- append 'txt' to entry
		require
			exist: not destroyed			
			not_void: txt /= Voiddo
		do
		ensure
			text_appended: text.is_equal (text.append (txt))
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' to text
		require
			exist: not destroyed			
			not_void: txt /= Void
		do
		ensure
			text_prepended: text.is_equal (text.append (txt))
		end
	
	set_position (pos: INTEGER) is
			-- set current insertion position
		require
			exist: not destroyed			
			valid_pos: pos > 0 and pos <= text.count
		do
		end
	
	set_maximum_line_length (lenght: INTEGER) is
			-- Maximum number of charachters on line
		require
			exist: not destroyed			
		do
		end
	
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		require
			exist: not destroyed
			valid_start: start_pos > 0 and start_pos <= text.count
			valid_end: end_pos > 0 and end_pos <= text.count
		do
		ensure
		end
	
feature {NONE} -- Implementation

	implementation: EV_SINGLE_LINE_ENTRY_I
			-- Implementation of button
			
end -- class EV_SINGLE_LINE_ENTRY

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

