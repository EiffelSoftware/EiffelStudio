indexing

	description: 
		"EiffelVision single line entry, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_ENTRY_I
	
inherit
	EV_BAR_ITEM_I
	
feature {NONE} -- Initialization

        make (par: EV_CONTAINER) is
		deferred
		end
	
feature -- Access

        text: STRING is
                        -- Text of current label
                require
                        exists: not destroyed
                deferred
                end 

feature -- Status setting
	
	set_text (txt: STRING) is
			-- set text entry to 'txt'
		require
			exist: not destroyed			
			not_void: txt /= Void
		deferred		
		ensure
			text_set: text.is_equal (txt)
		end
	
	append_text (txt: STRING) is
			-- append 'txt' to entry
		require
			exist: not destroyed			
			not_void: txt /= Void
		deferred
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' to text
		require
			exist: not destroyed			
			not_void: txt /= Void
		deferred
		ensure
			text_prepended:
		end
	
	set_position (pos: INTEGER) is
			-- set current insertion position
		require
			exist: not destroyed			
			valid_pos: pos > 0 and pos <= text.count
		deferred
		end
	
	set_maximum_line_length (lenght: INTEGER) is
			-- Maximum number of charachters on line
		require
			exist: not destroyed			
		deferred
		end
	
	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		require
			exist: not destroyed
			valid_start: start_pos > 0 and start_pos <= text.count
			valid_end: end_pos > 0 and end_pos <= text.count
		deferred
		ensure
		end	

end --class EV_ENTRY_I


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
